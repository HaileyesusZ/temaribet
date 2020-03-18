package Servlets;

import concreteClasses.ExamMaterial;
import concreteClasses.OpenedMaterial;
import concreteClasses.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import utilityClasses.ServletOperation;

/**
 *
 * @author Henok G
 */
@WebServlet(name = "ExamResult", urlPatterns = {"/ExamResult"})
public class ExamResult extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            User user = ServletOperation.getLoggedInUser(req);
            String materialId =req.getParameter("id");
            
            ExamMaterial material = ExamMaterial.fetch(Integer.valueOf(materialId));
            String materialHeader = material.getSubjectName() + " " + material.getYear().toString().substring(0, 4) + " " + material.getType();
                    
            HashMap parameters = new HashMap<>();
            parameters.put("materialId", materialId);
            parameters.put("userId", String.valueOf(user.getId()));
            OpenedMaterial finishedMaterial = (OpenedMaterial) OpenedMaterial.fetch(parameters).get(0);
            
            String jsonContent = "";
            File jsonFile = new File(getServletContext().getRealPath("/WEB-INF/materials/" + material.getPath()));
            Scanner scanner = new Scanner(jsonFile);
            while (scanner.hasNext()) {
                jsonContent += scanner.nextLine();
            }
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray) parser.parse(jsonContent);
            JSONArray correctAnswer = ((JSONArray)((JSONObject) jsonArray.get(0)).get("correct_answers"));
            
            req.setAttribute("remainingTime", finishedMaterial.getRemainingTime());
            req.setAttribute("allowedTime", finishedMaterial.getAllowedTime());
            req.setAttribute("materialHeader", materialHeader);
            req.setAttribute("numberOfQuestions", material.getNumberOfQuestions());
            req.setAttribute("finalAnswer", finishedMaterial.getWorkingStatus());
            req.setAttribute("correctAnswer", correctAnswer);
            req.setAttribute("scr", Integer.valueOf(req.getParameter("scr")));
            
            req.getRequestDispatcher("exam_result.jsp").forward(req, resp);
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}