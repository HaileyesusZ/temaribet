package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import concreteClasses.*;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import utilityClasses.ErrorReporter;
import org.json.simple.*;
import utilityClasses.DBOperation;
import utilityClasses.DashboardHelper;
import utilityClasses.Data;
import utilityClasses.ServletOperation;

/**
 *
 * @author haileyesus
 */
@WebServlet(name = "Dashboard", urlPatterns = {"/Dashboard"})
public class Dashboard extends HttpServlet {

    // id of the user that logged in
    private Integer loggedInId;
    

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

        String requestType = request.getParameter("requestType");
        
        if (requestType == null) {
            User loggedIn = ServletOperation.getLoggedInUser(request);
            if (loggedIn == null) {
                // get remember me cookie
                try {
                    Integer userId = DashboardHelper.getRememberedUser(request, response);
                    HttpSession session = request.getSession(true);
                    HashMap<String,String> condition = new HashMap<>();
                    condition.put("id", String.valueOf(userId));
                    User toLogin = User.fetch(condition).get(0);
                    session.setAttribute("currentUser", toLogin);
                    response.sendRedirect("/Temaribet/Dashboard");
                }catch(Exception ex ){
                    response.sendRedirect("/Temaribet");
                }
                
                return;
            }

            loggedInId = loggedIn.getId();
            
            try {
                // fetch pinned materials from the database
                setupDashboard(request, loggedIn);
                request.getRequestDispatcher("studentDashboard.jsp").forward(request, response);
                
            } catch (Exception ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ErrorReporter.INTERNAL_SERVER_ERROR);
            }
            
        } else {
            switch (requestType) {
                
                case "filter":
                    
                    String baseLimit = request.getParameter("lowerLimit");
                    // sort condition
                    String sortCondition = request.getParameter("sortMechanism");
                    if(sortCondition == null){
                        sortCondition = "DESC";
                    }
                    int baseLimitId;
                    try {
                        baseLimitId = Integer.parseInt(baseLimit);
                    }catch(NumberFormatException ex){
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    
                    DashboardHelper.preFilter(request,response,null,baseLimitId,sortCondition);
                    
                    break;
                
                
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("studentDashboard.jsp");

        String requestType = request.getParameter("requestType");

        User loggedIn = ServletOperation.getLoggedInUser(request);

        if (loggedIn == null) {
            response.sendRedirect("/Temaribet");
            return;
        }

        loggedInId = loggedIn.getId();

        if (requestType != null) {
            // decide the request type and call the corresponding methods
            switch (requestType) {
                case "search":
                    // extract the keyword
                    String keyword = request.getParameter("keyword");
                    // extract the base limit
                    String lowerLimit = request.getParameter("lowerLimit");
                    // sort mechanism
                    String sortMechanism = request.getParameter("sortMechanism");
                    if(sortMechanism == null){
                        sortMechanism = "DESC";
                    }
                    int lowerLimitId;
                    try {
                        lowerLimitId = Integer.parseInt(lowerLimit);
                    }catch(NumberFormatException ex){
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    
                    DashboardHelper.search(response, keyword, loggedIn,lowerLimitId,sortMechanism);
                    
                    break;
                    
                case "filter":
                    String baseLimit = request.getParameter("lowerLimit");
                    // sort condition
                    String sortCondition = request.getParameter("sortMechanism");
                    if(sortCondition == null){
                        sortCondition = "DESC";
                    }
                    int baseLimitId;
                    try {
                        baseLimitId = Integer.parseInt(baseLimit);
                    }catch(NumberFormatException ex){
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    
                    DashboardHelper.preFilter(request,response,loggedIn,baseLimitId,sortCondition);
                  
                    break;
                   
                case "pin":
                    // pin the material passed with this id
                    String pinned = request.getParameter("materialId");

                    int pinnedId;
                    try {
                        pinnedId = Integer.parseInt(pinned);
                    } catch (NumberFormatException ex) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    pin(response, pinnedId);
                    break;

                case "unpin":
                    // unpin the meterial passed with this id
                    String unpinned = request.getParameter("materialId");
                    int unpinnedId;
                    try {
                        unpinnedId = Integer.parseInt(unpinned);
                    } catch (NumberFormatException ex) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    unpin(response, unpinnedId);
                    break;
                    
                case "close" :
                    // close an opened material
                    String closed = request.getParameter("materialId");
                    int closedId;
                    try {
                        closedId = Integer.parseInt(closed);
                    }catch(NumberFormatException ex){
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.BAD_REQUEST);
                        return;
                    }
                    close(response, closedId);
                    break;
                  
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Handles all the requests in the dashboard";
    }// </editor-fold>


    private void pin(HttpServletResponse response, int pinnedId) throws IOException {
        try {
            PinnedMaterial pinnedMaterial = new PinnedMaterial(null, loggedInId, pinnedId);
            Boolean added = pinnedMaterial.pin();
            if (!added) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, ErrorReporter.ALREADY_PINNED);
            }

        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ErrorReporter.INTERNAL_SERVER_ERROR);
        }
    }

    private void unpin(HttpServletResponse response, int unpinnedId) throws IOException {
        try {
            HashMap<String, String> condition = new HashMap<>();
            condition.put("userId", String.valueOf(loggedInId));
            condition.put("materialId", String.valueOf(unpinnedId));

            PinnedMaterial unpinnedMaterial = PinnedMaterial.fetch(condition).get(0);
            unpinnedMaterial.delete();

            condition.remove("materialId");
            int numberOfRemainingPinnedMaterials = PinnedMaterial.count(condition);
            JSONObject json = new JSONObject();
            json.put("numberOfRemainingPinnedMaterials", numberOfRemainingPinnedMaterials);
            response.getWriter().println(json);
            // send some json response

        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }
    
    private void close(HttpServletResponse response, int closedId) throws IOException {
        try {
            HashMap<String,String> condition = new HashMap<>();
            condition.put("userId", String.valueOf(loggedInId));
            condition.put("materialId", String.valueOf(closedId));
            
            OpenedMaterial openedMaterial = OpenedMaterial.fetch(condition).get(0);
            openedMaterial.delete();
            
            condition.remove("materialId");
            int numberOfRemainingOpenedMaterials = OpenedMaterial.count(condition);
            JSONObject json = new JSONObject();
            json.put("numberOfRemainingOpenedMaterials", numberOfRemainingOpenedMaterials);
            response.getWriter().println(json);
            
        }catch(Exception ex){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ErrorReporter.INTERNAL_SERVER_ERROR);
        }
    }
    
    
    private void setupDashboard(HttpServletRequest request, User loggedIn) throws Exception{
         // fetch subjects appropriate for the logged in user
        String userStream = loggedIn.getStream();
        int userGrade = loggedIn.getGrade();

        String level = "Preparatory";
        
        ArrayList<String> grade = new ArrayList<>();
        if (userGrade == 9 || userGrade == 10) {
            level = "HighSchool";
            grade.add("9");
            grade.add("10");
        }else {
            grade.add("11");
            grade.add("12");
        }

        ArrayList<String> levelPossibleValues = new ArrayList<>();
        HashMap<String, ArrayList<String>> condition = new HashMap<>();

        levelPossibleValues.add(level);
        levelPossibleValues.add("Both");

        condition.put("level", levelPossibleValues);

        if (userStream != null) {
            ArrayList<String> streamPossibleValues = new ArrayList<>();
            streamPossibleValues.add(userStream);
            streamPossibleValues.add("Both");
            condition.put("stream", streamPossibleValues);
        }

        ArrayList<Subject> userSubjects = Subject.extendFetch(condition);
        request.setAttribute("subjects", userSubjects);

        // user id to extract user related materials
        String userId = String.valueOf(loggedInId);
        // condition of fetching materials
        HashMap<String, String> fetchingCondtion = new HashMap<>();
        fetchingCondtion.put("userId", userId);

        // for the pinnned materials
        ArrayList<PinnedMaterial> allPinnedMaterials = PinnedMaterial.fetch(fetchingCondtion);
        request.setAttribute("pinnedMaterials", allPinnedMaterials);

        // for the opened materials
        ArrayList<OpenedMaterial> allOpenedMaterials = OpenedMaterial.fetch(fetchingCondtion);
        request.setAttribute("openedMaterials", allOpenedMaterials);

        // for the recent materials
        condition.remove("level");
        condition.put("grade", grade);
        ArrayList<ExamMaterial> recentMaterials = ExamMaterial.extendFetch(condition, new String [] {"uploadDate","DESC", "0","5"});
        request.setAttribute("recentMaterials", recentMaterials);
        // for user progress
        ArrayList<Progress> allProgresses = Progress.fetch(fetchingCondtion);
        request.setAttribute("progresses", allProgresses);

    }

    
    

}
