package Servlets;

import concreteClasses.InactiveUser;
import concreteClasses.Progress;
import concreteClasses.User;
import java.io.File;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import utilityClasses.Data;
import utilityClasses.EmailSender;
import utilityClasses.ErrorReporter;
import utilityClasses.ServletOperation;

@WebServlet(name = "SignUp", urlPatterns = {"/Sign-up"})
public class SignUp extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher signupDispatch =  req.getRequestDispatcher("/signup.jsp");
        signupDispatch.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        RequestDispatcher rd = req.getRequestDispatcher("signup.jsp");

        //accept all the parameters of the sign-up form
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String passwordConfirmation = req.getParameter("password_confirmation");
        String grade = req.getParameter("grade");
        String stream  = req.getParameter("stream");
        String userSex = req.getParameter("sex");
        String avatar = req.getParameter("avatar");
        String terms = req.getParameter("terms");
        

        /*
            validation of input user data begins here
            each parameter is checked for validity
        */
        
        
        //first check if the user agrees to the terms and conditions
        
        if(terms == null){
            req.setAttribute("termsError", ErrorReporter.TERMS_ERROR);
            rd.forward(req, resp);
            return;
        }
        
        // check if the user's sex is acceptable
        if(userSex == null){
            req.setAttribute("sexError", ErrorReporter.SEX_ERROR);
            rd.forward(req, resp);
            return;
        }
        Character sex = userSex.charAt(0);
        
        // remember this input in case signing up fails
        req.setAttribute("sex", sex);
       
        /*
            Grade validation starts here
            it's expected to be an intenger and between 9 and 12 inclusive
        */
        
        if(grade == null){
            req.setAttribute("gradeError", ErrorReporter.GRADE_ERROR);
            rd.forward(req, resp);
            return;
        }
        
        Integer realGrade;
        // check if the input is an integer
        try {
            realGrade = Integer.parseInt(grade);
        }catch(NumberFormatException ex){
            req.setAttribute("gradeError", ErrorReporter.GRADE_ERROR);
            return;
        }
        
        // check for the validity of the grade 
        switch(realGrade){
            case 9 :
            case 10 :
                if(stream != null){
                    req.setAttribute("invalidStreamError", ErrorReporter.INVALID_STREAM_ERROR);
                    rd.forward(req, resp);
                    return;
                }
                break;
            case 11 :
            case 12 :
                stream = req.getParameter("stream");
                if(stream == null || !(stream.equals("Natural") || stream.equals("Social"))){
                    req.setAttribute("mustChooseStreamError", ErrorReporter.MUST_CHOOSE_STREAM_ERROR); 
                    rd.forward(req, resp);
                    return;
                }
                break;
            default : 
                req.setAttribute("gradeDeceptionError", ErrorReporter.GRADE_DECEPTION_ERROR);
                return;
        }
        
        
        // remember this input in case signing up fails
        req.setAttribute("grade", realGrade);
        req.setAttribute("stream", stream);
        
        //remove white spaces from both sides
        firstName = firstName.trim();
        lastName = lastName.trim();
        
        /*
            assure that the first name and the last name are acceptable data
            check if they are either empty or contain a blank space
        */
        if(firstName == null || firstName.isEmpty() ||  firstName.contains(" ") ){ // a regex to match anything but white space character
            req.setAttribute("firstNameError", ErrorReporter.FIRST_NAME_ERROR);
            rd.forward(req, resp);
            return;
        }
        // remember this input in case signing up fails
        req.setAttribute("firstName", firstName);
        
        if(lastName == null || lastName.isEmpty() || lastName.contains(" ")){
            req.setAttribute("lastNameError", ErrorReporter.LAST_NAME_ERROR);
            rd.forward(req, resp);
            return;
        }
        // remember this input in case signing up fails
        req.setAttribute("lastName", lastName);
        
        /*
            confirm if input email has a valid email format
            a regular expression is used
        */
        if(email == null || ! Pattern.matches(Data.EMAIL_REGEX, email)){
            req.setAttribute("emailError", ErrorReporter.EMAIL_ERROR);
            rd.forward(req, resp);
            return;
        }
        // remember this input in case signing up fails
        req.setAttribute("email", email);
        
        /*
            make sure the password is not less than 6 characters and
            the confirmed password matches with the one already given
        */
        if(password.trim().length() < Data.PASSWORD_LENGTH){
            req.setAttribute("passwordError", ErrorReporter.PASSWORD_ERROR);
            rd.forward(req,resp);
            return;
        }
        
        if(! passwordConfirmation.equals(password)){
            req.setAttribute("confirmedPasswordError", ErrorReporter.CONFIRMED_PASSWORD_ERROR);
            rd.forward(req, resp);
            return;
        }
        
        // hash the given password 
        String hashedPassword = ServletOperation.getHash(password);
        
        /*
            setup the already chose avatar,
            if no avatar was chosen, a default one is used
        */
        String avatarPath = "images/avatars/";
        if(avatar == null || !Pattern.matches("^avatar_[1-9]$", avatar)){
            req.setAttribute("weirdAvatarChoice", ErrorReporter.WEIRD_AVATAR_CHOICE);
            rd.forward(req, resp);
            return;
        }
        avatarPath += avatar + ".png";
        
        /*
            Prepare the user and add it to the pending user conditionally
            Email is checked if it has been used, and if not, a verification
            link will be sent to the email
        */
        
        User pendingUser = new User(null, firstName, lastName, sex, email, hashedPassword, avatarPath, null, null, null, realGrade, stream);
        
        // check if the email given is either registered or unactivated
        try {
           
            HashMap<String,String> condition = new HashMap<>();
            condition.put("email", email);
            // first check for the registration of the same email
            if(User.fetch(condition) != null){
                req.setAttribute("emailExistsError", ErrorReporter.EMAIL_EXISTS_ERROR);
                rd.forward(req,resp);
                return;
            }
            // then check if the email is used but has not yet been activated
            ArrayList<User> unactivatedAccount =  User.fetchPendingUserInfo(condition);
            if( unactivatedAccount!= null){
                User unactivatedUser = unactivatedAccount.get(0);
                req.setAttribute("userId", unactivatedUser.getId());
                req.setAttribute("avatar", unactivatedUser.getProfilePicture());
                req.setAttribute("unactivatedEmailUsageError", ErrorReporter.UNACTIVATED_EMAIL_USAGE_ERROR);
                
                req.getRequestDispatcher("activate.jsp").forward(req,resp);
                return;
            }
            
            /*
                Add the user to the pending users list until the user confirms his/her email
                An activation logic will be implemented
            */
            pendingUser.persist(false);
            
            // reload the pending users table so the new user can be fetched
            unactivatedAccount = User.fetchPendingUserInfo(condition);
            String[] hashedData = ServletOperation.setupEmailActivation(unactivatedAccount.get(0).getId());
            // send activation link to email
            EmailSender.sendEmailActivation(new String[] {email, hashedData[0], hashedData[1]});
            
        } catch (Exception ex) {
            req.setAttribute("signUpError", ErrorReporter.SIGN_UP_ERROR);
            rd.forward(req, resp);
        }
        
        // send a notice to the user that their link has just been sent
        req.setAttribute("name", firstName);
        req.setAttribute("avatar", avatarPath);
        req.getRequestDispatcher("activate.jsp").forward(req,resp);
        
    }

   

    private void addToDatabase(int[] subjects, int userId) throws Exception {
        try {
            Progress progress;
            for(int subjectId : subjects){
                progress = new Progress(null,userId, subjectId, null, 0,null);
                progress.persist(true);
            }
        }catch(Exception ex){
            throw new Exception (ex.getMessage());
        }
    }
}
