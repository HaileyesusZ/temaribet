/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import concreteClasses.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilityClasses.Data;
import utilityClasses.EmailSender;
import utilityClasses.ErrorReporter;
import utilityClasses.ServletOperation;

/**
 *
 * @author Haileyesus Z
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/Forgot-Password"})
public class ForgotPassword extends HttpServlet {

    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("forgot_password.jsp");
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
        
        String email = request.getParameter("email");
        if(email == null || ! Pattern.matches(Data.EMAIL_REGEX, email)){
            request.setAttribute("emailError", ErrorReporter.EMAIL_ERROR);
            request.getRequestDispatcher("forgot_password.jsp").forward(request,response);
            return;
        }
        
        HashMap<String,String> condition = new HashMap<>();
        condition.put("email", email);
        
        try {
            ArrayList<User> fetchedUsers = User.fetch(condition);
            if(fetchedUsers == null){
                request.setAttribute("emailError", ErrorReporter.EMAIL_INVALID_ERROR);
                request.getRequestDispatcher("forgot_password.jsp").forward(request,response);
                return;
            }
            
            User fetchedUser = fetchedUsers.get(0);
            String [] hashedData = ServletOperation.setupPasswordReseter(fetchedUser.getId());
            EmailSender.sendPasswordResetLink(new String[] {email, hashedData[0], hashedData[1]});
            // for some confirmation
            request.setAttribute("avatar", fetchedUser.getProfilePicture());
            request.setAttribute("email", fetchedUser.getEmail());
            request.getRequestDispatcher("forgot_password_link_sent.jsp").forward(request, response);
        }catch(Exception ex){
            
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return " forgotten password";
    }// </editor-fold>

}
