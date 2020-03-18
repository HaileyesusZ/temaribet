package Servlets;

import com.lambdaworks.crypto.SCryptUtil;
import concreteClasses.User;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilityClasses.ErrorReporter;
import utilityClasses.ServletOperation;

/**
 *
 * @author Henok G
 */
@WebServlet(name = "EditProfile", urlPatterns = {"/EditProfile"})
public class EditProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loggedInUser = ServletOperation.getLoggedInUser(req);
        if(loggedInUser.getPhoneNummber() != null){
            req.setAttribute("oldCellNumber", loggedInUser.getPhoneNummber());
        }
        req.getRequestDispatcher("edit_account.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String oldPassword = req.getParameter("old_password");
        String password = req.getParameter("password");
        String passwordConfirmation = req.getParameter("password_confirmation");
        Integer grade = Integer.valueOf((req.getParameter("grade") == null) ? "0": req.getParameter("grade"));
        String stream = req.getParameter("stream");
        String phoneNumber = req.getParameter("phone_number");
        String avatar = req.getParameter("avatar");
        String avatarPath = "images/avatars/";
        
        User loggedInUser = ServletOperation.getLoggedInUser(req);
        HashMap<String, String> attributesToUpdate = new HashMap<>();
        
        try {
            if (oldPassword != null && password != null && passwordConfirmation != null) {
                if(password.length() >=5 && passwordConfirmation.length() >= 5){
                    if (SCryptUtil.check(oldPassword, loggedInUser.getPassword())) {
                        if (password.equals(passwordConfirmation)) {
                            attributesToUpdate.put("password", ServletOperation.getHash(password));
                        }
                    }
                }
            }
            
              if(avatar != null){
                avatarPath += avatar + ".png";
                attributesToUpdate.put("profilePicture", avatarPath);
                ServletOperation.getLoggedInUser(req).setProfilePicture(avatarPath);
              }
            
            if (grade != 0) {
                if(grade != loggedInUser.getGrade()){
                    attributesToUpdate.put("grade", grade.toString());
                    ServletOperation.getLoggedInUser(req).setGrade(grade);
                }
            }
            
            if (stream != null) {
                if(grade >= 11)
                    attributesToUpdate.put("stream", stream);
                    ServletOperation.getLoggedInUser(req).setStream(stream);
            }
            
            if (phoneNumber != null) {
                attributesToUpdate.put("phoneNumber", phoneNumber);
                ServletOperation.getLoggedInUser(req).setPhoneNummber(phoneNumber);
            }

            loggedInUser.updateAttributes(attributesToUpdate);
            resp.sendRedirect("/Temaribet/Dashboard");
        } catch (Exception ex) {
            req.setAttribute("badRequest", ErrorReporter.BAD_REQUEST);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
            Logger.getLogger(EditProfile.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}