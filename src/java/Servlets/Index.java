/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import concreteClasses.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utilityClasses.DashboardHelper;
import utilityClasses.ServletOperation;

/**
 *
 * @author Haileyesus Z
 */
@WebServlet(name = "Index", urlPatterns = {"/a"})
public class Index extends HttpServlet {

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
        // first try to get the current session
        User currentUser = ServletOperation.getLoggedInUser(request);
        if(currentUser != null){
            response.sendRedirect("/Temaribet/Dashboard");
            
        }else {
           Integer userId = DashboardHelper.getRememberedUser(request, response);
           try {
               if(userId != null) {
                   HashMap<String,String> condition = new HashMap<>();
                   condition.put("id", String.valueOf(userId));
                   User toLogin = User.fetch(condition).get(0);
                   // create a new session for the user
                   HttpSession session = request.getSession(true);
                   session.setAttribute("currentUser", toLogin);
                   response.sendRedirect("/Temaribet/Dashboard");
               }else {
                   request.getRequestDispatcher("home.jsp").forward(request, response);
               }
           }catch(Exception ex){
               // do something
               // send to error page
           }
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

}
