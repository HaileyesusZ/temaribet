package Servlets;

import concreteClasses.ExamMaterial;
import concreteClasses.OpenedMaterial;
import concreteClasses.Progress;
import concreteClasses.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Scanner;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilityClasses.ServletOperation;

/**
 *
 * @author Henok G
 */
@WebServlet(name = "Question", urlPatterns = {"/Question"})
public class Question extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestType = req.getParameter("requestType");
        String materialPath = null;
        int materialId = 0;
        String materialHeader = "";
        
        try {
            User user = ServletOperation.getLoggedInUser(req);
            String remainingTime;
            String workingStatus;
            
            switch (requestType) {
                case "saveOpenedMaterial":
                    {
                        remainingTime = req.getParameter("remainingTime");
                        workingStatus = req.getParameter("workingStatus");
                        materialId = Integer.valueOf(req.getParameter("materialId"));
                        HashMap parameters = new HashMap<>();
                        parameters.put("materialId", String.valueOf(materialId));
                        parameters.put("userId", String.valueOf(user.getId()));
                        OpenedMaterial existingOpenedMaterial = (OpenedMaterial) OpenedMaterial.fetch(parameters).get(0);
                        HashMap attributes = new HashMap<>();
                        attributes.put("remainingTime", remainingTime);
                        attributes.put("workingStatus", workingStatus);
                        existingOpenedMaterial.updateAttributes(attributes);
                        break;
                    }
                case "finishedOpenedMaterial":
                    {
                        remainingTime = req.getParameter("remainingTime");
                        workingStatus = req.getParameter("workingStatus");
                        materialId = Integer.valueOf(req.getParameter("materialId"));
                        int score = Integer.valueOf(req.getParameter("score"));
                        HashMap parameters = new HashMap<>();
                        parameters.put("materialId", String.valueOf(materialId));
                        parameters.put("userId", String.valueOf(user.getId()));
                        OpenedMaterial existingOpenedMaterial = (OpenedMaterial) OpenedMaterial.fetch(parameters).get(0);
                        HashMap attributes = new HashMap<>();
                        attributes.put("remainingTime", remainingTime);
                        attributes.put("workingStatus", workingStatus);
                        existingOpenedMaterial.updateAttributes(attributes);
//                        OpenedMaterial.delete(existingOpenedMaterial.getId());
                        parameters.remove("materialId");
                        parameters.put("subjectId", existingOpenedMaterial.getSubjectId().toString());
                        Progress progress = (Progress) Progress.fetch(parameters).get(0);
                        progress.updateAttribute("points", String.valueOf(score));
                        break;
                    }
                case "exam":
                    {
                        materialId = Integer.valueOf(req.getParameter("id"));
                        ExamMaterial material = ExamMaterial.fetch(materialId);
                        materialPath = material.getPath();
                        OpenedMaterial openedMaterial = new OpenedMaterial(null, user.getId(), materialId, null, material.getAllowedTime(), "");
                        boolean persisted = openedMaterial.persist(true);
                        if (!persisted) {
                            HashMap parameters = new HashMap<>();
                            parameters.put("materialId", String.valueOf(materialId));
                            parameters.put("userId", String.valueOf(user.getId()));
                            OpenedMaterial existingOpenedMaterial = (OpenedMaterial) OpenedMaterial.fetch(parameters).get(0);
                            
                            openedMaterial = new OpenedMaterial(existingOpenedMaterial.getId(), user.getId(), materialId, null, null, null);
                            
                            openedMaterial.updateAttribute("openedDate", null);
                            req.setAttribute("newMaterial", false);
                            req.setAttribute("remainingTime", existingOpenedMaterial.getRemainingTime());
                            req.setAttribute("workingStatus", "{" + existingOpenedMaterial.getWorkingStatus() + "}");
                        } else {
                            req.setAttribute("newMaterial", true);
                            req.setAttribute("allowedTime", material.getAllowedTime());
                        }       
                        materialHeader = material.getSubjectName() + " " + material.getYear().toString().substring(0, 4) + " " + material.getType();
                        String jsonContent = "";
                        File jsonFile = new File(getServletContext().getRealPath("/Materials/" + material.getPath()));
                        Scanner scanner = new Scanner(jsonFile);
                        while (scanner.hasNext()) {
                            jsonContent += scanner.nextLine();
                        }
                        req.setAttribute("jsonContent", jsonContent);
                        req.setAttribute("materialHeader", materialHeader);
                        req.setAttribute("numberOfQuestions", material.getNumberOfQuestions());
                        req.getRequestDispatcher("question.jsp").forward(req, resp);
                        break;
                    }
                case "training":
                {
                    materialId = Integer.valueOf(req.getParameter("id"));
                    ExamMaterial material = ExamMaterial.fetch(materialId);
                    materialHeader = material.getSubjectName() + " " + material.getYear().toString().substring(0, 4) + " " + material.getType();
                    String jsonContent = "";
                    File jsonFile = new File(getServletContext().getRealPath("/Materials/" + material.getPath()));
                    Scanner scanner = new Scanner(jsonFile);
                        while (scanner.hasNext()) {
                            jsonContent += scanner.nextLine();
                        }       req.setAttribute("jsonContent", jsonContent);
                        req.setAttribute("materialHeader", materialHeader);
                        RequestDispatcher a = req.getRequestDispatcher("training_question.jsp");
                        a.forward(req,resp);
                        break;
                    }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}