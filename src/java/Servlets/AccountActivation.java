/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import concreteClasses.InactiveUser;
import concreteClasses.Progress;
import concreteClasses.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.logging.Logger;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utilityClasses.ErrorReporter;
import utilityClasses.ServletOperation;

/**
 *
 * @author Haileyesus Z
 */
@WebServlet(name = "AccountActivation", urlPatterns = {"/Account-Activation"})
public class AccountActivation extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String activationId = request.getParameter("uaid");
        String activationKey = request.getParameter("uakey");
        
        if(activationId == null || activationKey == null){
            response.sendRedirect("/Temaribet");
            return;
        }
        HashMap<String,String> condition = new HashMap<>();
        condition.put("activationId", activationId);
        condition.put("activationKey", activationKey);
        
        try {
            ArrayList<InactiveUser> pendingUser = InactiveUser.fetch(condition);
            if(pendingUser == null){
                response.sendRedirect("invalid_account_activation.jsp");
                return;
            }else if(pendingUser.size() > 1){
                Logger.getLogger("account-activation-duplication").log(Level.SEVERE, "Duplicate Accounts found with the same id and key", new Throwable());
                response.getWriter().println("A fatal problem occured, Please sign up again");
                return;
            }
            // get the user to be activated
            InactiveUser nowUser = pendingUser.get(0);
            /*
                Since activation email might expire, it's a must to check against expiration date
            */
            Timestamp expirationDate = nowUser.getExpirationDate();
            Timestamp inquiryDate = new Timestamp(Calendar.getInstance().getTimeInMillis());
            // check expiration date 
            if(inquiryDate.compareTo(expirationDate) >= 0){
                // this means the link already expired
                response.sendRedirect("invalid_account_activation.jsp");
                return;
            }
            // Expiration date is not due yet and now it is possible to activate the account
            int nowUserId = nowUser.getUserId();
            User almostActive  = User.fetchPendingUserInfo(nowUserId);
            almostActive.updateAttribute("active", "1");
            // remove the user from pending line
            nowUser.delete();
            // redirect to success page
            //User toLogin = User.fetch(nowUserId);
            
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", almostActive);
            // start the user's progress
            startProgress(User.fetch(nowUserId).getStream(), nowUserId);
            
            request.setAttribute("firstName", almostActive.getFirstName());
            request.setAttribute("avatar", almostActive.getProfilePicture());
            request.getRequestDispatcher("account_activated.jsp").forward(request,response);
            
        }catch(Exception ex){
            // send to error page
            response.getWriter().println("Error while activaing your account, Please try again or sign up again");
        }
        
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Activates a user account";
    }// </editor-fold>

    // starts the user's progress from scratch
     private void startProgress(String stream, int userId) throws Exception {
        try {
            
            if(stream == null){
                int  [] subjects= {1,2,3,4,5,6,7,9,10};
                addToDatabase(subjects, userId);
            }else if(stream.equals("Natural")){
                int [] subjects = {1,2,4,5,6,7,8};
                addToDatabase(subjects, userId);
            }else if(stream.equals("Social")){
                int [] subjects = {1,2,4,9,10,11};
                addToDatabase(subjects, userId);
            }
            
        }catch(Exception ex){
            throw new Exception(ErrorReporter.STARTING_PROGRESS_ERROR);
        }
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
