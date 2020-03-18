package utilityClasses;

import com.lambdaworks.crypto.SCryptUtil;
import concreteClasses.ForgottenPassword;
import concreteClasses.InactiveUser;
import concreteClasses.RememberedUser;
import concreteClasses.User;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.FieldPosition;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

public class ServletOperation {
    
    public static User getLoggedInUser(HttpServletRequest request){
        HttpSession session  = request.getSession(false);
        if(session == null) {
            return null;
        }
        User loggedIn = (User) session.getAttribute("currentUser");
        return loggedIn;
    }
    
    public static void SignInUser(Object goUser, HttpServletRequest request, HttpServletResponse response, String url){
        try {
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", goUser);
            response.sendRedirect(url);
        } catch (IOException ex) {
            Logger.getLogger(ServletOperation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void signOut(HttpServletRequest request, HttpServletResponse response){
        try {
            HttpSession session = request.getSession(false);
            session.removeAttribute("currentUser");
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(ServletOperation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static String[] RememberUser(int userId) throws Exception{
        SecureRandom newRandomSeriesIdentifier = new SecureRandom();
        Long seriesIdentifier = newRandomSeriesIdentifier.nextLong();
        Long token = newRandomSeriesIdentifier.nextLong();
        String hashedToken = getHash(String.valueOf(token));
        
        // first check if another entry is already set
        HashMap<String,String> condition = new HashMap<>();
        condition.put("userId", String.valueOf(userId));
        
        ArrayList<RememberedUser> allRememberedUsers = RememberedUser.fetch(condition);
        if(allRememberedUsers == null){
            RememberedUser rememberedUser = new RememberedUser(null, userId, seriesIdentifier, hashedToken, null);
            rememberedUser.persist(true);
        }else {
            RememberedUser alreadyRememberedUser = allRememberedUsers.get(0);
            HashMap<String,String> parameters = new HashMap<>();
            parameters.put("seriesIdentifier", String.valueOf(seriesIdentifier));
            parameters.put("token", hashedToken);
            alreadyRememberedUser.updateAttributes(parameters);
        }
        return new String [] {String.valueOf(seriesIdentifier), String.valueOf(token)};
        
         
    }
    
    public static void addRememberMeCookie(HttpServletRequest request, HttpServletResponse response, String [] cookieData){
        Cookie userCookie = new Cookie("utkn", cookieData[1]);
        userCookie.setMaxAge(15552000);
        userCookie.setPath("/");
        // check if series identifier cookie is already issued
        Cookie[] cookies = request.getCookies();
        Cookie anotherUserCookie = new Cookie("usi", cookieData[0]);
        anotherUserCookie.setMaxAge(15552000);
        anotherUserCookie.setPath("/");
        response.addCookie(anotherUserCookie);
        
        response.addCookie(userCookie);
        
    }
    
    public static String getHash(String key){
        return SCryptUtil.scrypt(key, (int) Math.pow(2, 14),8,1);
    }
    
    public static String [] setupEmailActivation( int inactiveUserId) throws Exception{
        SecureRandom random = new SecureRandom();
        String hashedActivationId = ServletOperation.getHash(String.valueOf(random.nextLong()));
        String hashedActivationKey = ServletOperation.getHash(String.valueOf(random.nextLong()));
        HashMap<String,String> condition = new HashMap<>();
        condition.put("userId", String.valueOf(inactiveUserId));
        ArrayList<InactiveUser> pendingUsers = InactiveUser.fetch(condition);
         
        // add expiration length to the current time
        Timestamp expirationDate = new Timestamp(Calendar.getInstance().getTimeInMillis() + Data.EXPIRATION_LENGTH );
            
        if(pendingUsers == null){
           
            InactiveUser inactiveUser = new InactiveUser(null, inactiveUserId, hashedActivationId, hashedActivationKey, expirationDate);
            inactiveUser.persist(true);
        }else {
            InactiveUser pendingUser = pendingUsers.get(0);
            condition.clear();
            condition.put("activationID", hashedActivationId);
            condition.put("activationKey", hashedActivationKey);
            condition.put("expirationDate", expirationDate.toString());
            pendingUser.updateAttributes(condition);
        }

        return new String[] {hashedActivationId, hashedActivationKey};
    }
    
    public static String [] setupPasswordReseter(int userId) throws Exception{
         SecureRandom random = new SecureRandom();
        String hashedResetId = ServletOperation.getHash(String.valueOf(random.nextLong()));
        String hashedResetKey = ServletOperation.getHash(String.valueOf(random.nextLong()));
        HashMap<String,String> condition = new HashMap<>();
        
        condition.put("userId", String.valueOf(userId));
        ArrayList<ForgottenPassword> forgottenPasswords = ForgottenPassword.fetch(condition);
        
        // add expiration length to the current time
        Timestamp expirationDate = new Timestamp(Calendar.getInstance().getTimeInMillis() + Data.EXPIRATION_LENGTH );
            
        if(forgottenPasswords == null){
            ForgottenPassword forgottenPassword = new ForgottenPassword(null, userId, hashedResetId, hashedResetKey, expirationDate);
            if(!forgottenPassword.persist(true)){
                //this is due to previous password reset requests, so the record can just be updated
                ArrayList<ForgottenPassword> expiredForgottenPasswords = ForgottenPassword.fetchExpiredForgottenPasswords(condition);
                ForgottenPassword expiredForgottenPassword = expiredForgottenPasswords.get(0);
                // update the expired request for the new one
                condition.clear();
                condition.put("resetId", hashedResetId);
                condition.put("resetKey", hashedResetKey);
                condition.put("expirationDate", expirationDate.toString());
                condition.put("active", "1");
                expiredForgottenPassword.updateAttributes(condition);
            }
            
        }else {
            ForgottenPassword forgottenPassword = forgottenPasswords.get(0);
            condition.clear();
            condition.put("resetId", hashedResetId);
            condition.put("resetKey", hashedResetKey);
            condition.put("expirationDate", expirationDate.toString());
            forgottenPassword.updateAttributes(condition);
        }

        return new String[] {hashedResetId, hashedResetKey};

    }
}