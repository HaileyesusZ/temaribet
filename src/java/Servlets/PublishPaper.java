/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import concreteClasses.ExamMaterial;
import concreteClasses.Subject;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import utilityClasses.ErrorReporter;

/**
 *
 * @author Henok G
 */
@WebServlet(name = "PublishPaper", urlPatterns = {"/PublishPaper"})
public class PublishPaper extends HttpServlet {

    String uploadPath;
    int subjectId;
    String year;
    String type;
    String subjectName;

    File wholeJsonFile;
    BufferedWriter bufferedWriter;

    int questionNumber;
    String question;
    String choiceA;
    String choiceB;
    String choiceC;
    String choiceD;
    int correctAnswer;

    JSONArray currentlyPlayingJSONArray;

    HashMap<String, ArrayList<Object>> correctAnswersHashMap;
    ArrayList<Object> correctAnswersList;

    HashMap<String, ArrayList<JSONObject>> fullQuestionHashMap;
    ArrayList<JSONObject> fullQuestionList;

    HashMap<String, Integer> labelLibrary = new HashMap<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        uploadPath = getServletContext().getRealPath("/Materials/");
        //System.out.println(uploadPath);
        //uploadPath = "C:/Users/Henok G/Documents/NetBeansProjects/temaribet/web/Materials/";
        req.getRequestDispatcher("addMaterials.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestType = (req.getParameter("requestType") == null) ? "writeToFile" : req.getParameter("requestType");

        switch (requestType) {
            case "initializeMaterial":
                type = req.getParameter("type");
                year = req.getParameter("year");
                subjectName = req.getParameter("subject");
                subjectId = Subject.fetch(req.getParameter("subject")).getId();
                HashMap<String, String> parameters = new HashMap<String, String>();
                parameters.put("year", year);
                parameters.put("subjectId", String.valueOf(subjectId));
                 {
                    try {
                        if (ExamMaterial.fetch(parameters) == null) {
                            initializeMaterial(req);
                        } else {
                            resumePublishing(req, resp);
                        }
                    } catch (Exception ex) {
                        resp.sendRedirect("activate.jsp");
                    }
                }
                break;
            case "writeToFile":
                labelLibrary.put("A", 1);
                labelLibrary.put("B", 2);
                labelLibrary.put("C", 3);
                labelLibrary.put("D", 4);
                AppendOnFile(req, resp);
                break;
            case "saveForLater":
                saveForLater();
                break;
            case "done":
                generateNow();
                break;
        }
    }

    public void initializeMaterial(HttpServletRequest request) throws Exception {
        String subjectName = request.getParameter("subject");
        Subject subject = Subject.fetch(subjectName);

        int numberOfQuestions = Integer.valueOf(request.getParameter("numberOfQuestions"));
        year = request.getParameter("year");
        subjectId = subject.getId();
        String stream;
        int grade = Integer.valueOf(request.getParameter("grade"));
        switch (grade) {
            case 9:
            case 10:
                stream = null;
                break;
            case 11:
            case 12:
                stream = subject.getStream();
                break;
            default:
                throw new Exception(ErrorReporter.INVALID_STREAM_ERROR);
        }

        String allowedTime = request.getParameter("allowedTime");
        String path = "" + subjectName + year + type + "/question.json";
        //Give uploader id = 1 and give uploaddate null

        ExamMaterial newExamMaterial = new ExamMaterial(null, type, numberOfQuestions, Integer.parseInt(year), subjectId, stream, grade, subjectName, allowedTime, null, path, 1);

        newExamMaterial.persist(true);
        //After Database Initilazation
        //Json Initilazation Follows
        File jsonFile = new File(uploadPath + subjectName + year + type);
        jsonFile.mkdir();   //create directory
        jsonFile = new File(uploadPath + subjectName + year + type + "/Images");
        jsonFile.mkdir();   //create Image Directory

    }

    public void generateNow() throws IOException {
        currentlyPlayingJSONArray = new JSONArray();
        File jsonFile = new File(uploadPath + subjectName + year + type + "/question.json");
        jsonFile.createNewFile();   //file Created

        JSONObject correctAnswersJSONObject = new JSONObject(correctAnswersHashMap);
        currentlyPlayingJSONArray.add(correctAnswersJSONObject);
//        for (Map.Entry<String, ArrayList<JSONObject>> entry : fullQuestionHashMap.entrySet()) {
//            HashMap<String, ArrayList<JSONObject>> tempHash = new HashMap<>();
//            tempHash.put(entry.getKey(), entry.getValue());
//            JSONObject fullQuestionJsonObject = new JSONObject(tempHash);
//            currentlyPlayingJSONArray.add(fullQuestionJsonObject);
//        }

        for (int i = 1; i <= fullQuestionHashMap.size(); i++) {
            HashMap<String, ArrayList<JSONObject>> tempHash = new HashMap<>();
            tempHash.put("qn" + i, fullQuestionHashMap.get("qn" + i));
            JSONObject fullQuestionJsonObject = new JSONObject(tempHash);
            currentlyPlayingJSONArray.add(fullQuestionJsonObject);
        }

        bufferedWriter = new BufferedWriter(new FileWriter(jsonFile));
        bufferedWriter.write(currentlyPlayingJSONArray.toJSONString());
        bufferedWriter.close();
    }

    public void AppendOnFile(HttpServletRequest req, HttpServletResponse resp) {
        questionNumber = Integer.valueOf(req.getParameter("questionNumber"));
        question = req.getParameter("question");
        choiceA = req.getParameter("choiceA");
        choiceB = req.getParameter("choiceB");
        choiceC = req.getParameter("choiceC");
        choiceD = req.getParameter("choiceD");
        correctAnswer = Integer.valueOf(req.getParameter("correctAnswer"));

        if (questionNumber == 1) {
            fullQuestionHashMap = new HashMap<>();

            writeFirstQuestion(resp);
        } else {
            continueWriting(req);
        }

    }

    public void continueWriting(HttpServletRequest req) {
        correctAnswersList.add(correctAnswer);
        correctAnswersHashMap.put("correct_answers", correctAnswersList);
        prepareQuestion();
//        JSONObject correctAnswersJSONObject = new JSONObject(correctAnswersHashMap);
//        JSONObject fullQuestionJsonObject = prepareQuestion();
//        currentlyPlayingJSONArray.add(correctAnswersJSONObject);
//        currentlyPlayingJSONArray.add(fullQuestionJsonObject);

    }

    public void writeFirstQuestion(HttpServletResponse resp) {
        correctAnswersHashMap = new HashMap<>();
        correctAnswersList = new ArrayList<>();
        correctAnswersList.add("");
        correctAnswersList.add(correctAnswer);
        correctAnswersHashMap.put("correct_answers", correctAnswersList);
        prepareQuestion();
//        JSONObject correctAnswersJSONObject = new JSONObject(correctAnswersHashMap);
//        JSONObject fullQuestionJsonObject = prepareQuestion();
//        currentlyPlayingJSONArray.add(correctAnswersJSONObject);
//        currentlyPlayingJSONArray.add(fullQuestionJsonObject);

//        try {
////            bufferedWriter.write(currentlyPlayingJSONArray.toJSONString());
////            bufferedWriter.close();
//        } catch (IOException ex) {
//            Logger.getLogger(PublishPaper.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }

    public void prepareQuestion() {
        HashMap<String, String> singleChoice = new HashMap<>();
        fullQuestionList = new ArrayList<>();

        singleChoice.put("c0", question);
        fullQuestionList.add(new JSONObject(singleChoice));
        singleChoice.clear();
        singleChoice.put("c1", choiceA);
        fullQuestionList.add(new JSONObject(singleChoice));
        singleChoice.clear();
        singleChoice.put("c2", choiceB);
        fullQuestionList.add(new JSONObject(singleChoice));
        singleChoice.clear();
        singleChoice.put("c3", choiceC);
        fullQuestionList.add(new JSONObject(singleChoice));
        singleChoice.clear();
        singleChoice.put("c4", choiceD);
        fullQuestionList.add(new JSONObject(singleChoice));
        singleChoice.clear();

        fullQuestionHashMap.put("qn" + questionNumber, fullQuestionList);
    }

    public void saveForLater() {
        try {
//            File file = new File(uploadPath+subjectName+year+type+"/mainJsonArraySerialized");
//            FileOutputStream f = new FileOutputStream(file);
//            ObjectOutputStream s = new ObjectOutputStream(f);
//            s.writeObject(currentlyPlayingJSONArray);
//            s.close();
//            f.close();

            File file2 = new File(uploadPath + subjectName + year + type + "/correctAnswersHashMap.serial");
            FileOutputStream f2 = new FileOutputStream(file2);
            ObjectOutputStream s2 = new ObjectOutputStream(f2);
            s2.writeObject(correctAnswersHashMap);
            s2.close();
            f2.close();

            File file3 = new File(uploadPath + subjectName + year + type + "/correctAnswersList.serial");
            FileOutputStream f3 = new FileOutputStream(file3);
            ObjectOutputStream s3 = new ObjectOutputStream(f3);
            s3.writeObject(correctAnswersList);
            s3.close();
            f3.close();

            File file5 = new File(uploadPath + subjectName + year + type + "/fullQuestionHashMap.serial");
            FileOutputStream f5 = new FileOutputStream(file5);
            ObjectOutputStream s5 = new ObjectOutputStream(f5);
            s5.writeObject(fullQuestionHashMap);
            s5.close();
            f5.close();

            File file4 = new File(uploadPath + subjectName + year + type + "/fullQuestionList.serial");
            FileOutputStream f4 = new FileOutputStream(file4);
            ObjectOutputStream s4 = new ObjectOutputStream(f4);
            s4.writeObject(fullQuestionList);
            s4.close();
            f4.close();
        } catch (Exception ex) {
        }
    }

    public void resumePublishing(HttpServletRequest req, HttpServletResponse resp) throws Exception {
//        File file = new File(uploadPath+subjectName+year+type+"/mainJsonArraySerialized");
//        FileInputStream f = new FileInputStream(file);
//        ObjectInputStream s = new ObjectInputStream(f);
//        JSONArray jsonfilecontent = (JSONArray) s.readObject();
//        currentlyPlayingJSONArray = jsonfilecontent;
//        s.close();
//        f.close();

        File file2 = new File(uploadPath + subjectName + year + type + "/correctAnswersHashMap.serial");
        FileInputStream f2 = new FileInputStream(file2);
        ObjectInputStream s2 = new ObjectInputStream(f2);
        correctAnswersHashMap = (HashMap<String, ArrayList<Object>>) s2.readObject();
        s2.close();
        f2.close();

        File file3 = new File(uploadPath + subjectName + year + type + "/correctAnswersList.serial");
        FileInputStream f3 = new FileInputStream(file3);
        ObjectInputStream s3 = new ObjectInputStream(f3);
        correctAnswersList = (ArrayList<Object>) s3.readObject();
        s3.close();
        f3.close();

        File file4 = new File(uploadPath + subjectName + year + type + "/fullQuestionHashMap.serial");
        FileInputStream f4 = new FileInputStream(file4);
        ObjectInputStream s4 = new ObjectInputStream(f4);
        fullQuestionHashMap = (HashMap<String, ArrayList<JSONObject>>) s4.readObject();
        s4.close();
        f4.close();

        File file5 = new File(uploadPath + subjectName + year + type + "/fullQuestionList.serial");
        FileInputStream f5 = new FileInputStream(file5);
        ObjectInputStream s5 = new ObjectInputStream(f5);
        fullQuestionList = (ArrayList<JSONObject>) s5.readObject();
        s5.close();
        f5.close();

        resp.getWriter().println(correctAnswersList.size());
    }

//    public void saveImage(HttpServletRequest request, String parameter, String path){
//        try {
//            Part filePart = request.getPart(parameter);
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            File uploads = new File(path);
//            File file = new File(uploads, fileName);
//            InputStream fileContent = filePart.getInputStream(); 
//            Files.copy(fileContent, file.toPath());
//        } catch (Exception ex) {
//            Logger.getLogger(PublishPaper.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
}
