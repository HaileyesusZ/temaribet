/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilityClasses;

import com.lambdaworks.crypto.SCryptUtil;
import concreteClasses.ExamMaterial;
import concreteClasses.Material;
import concreteClasses.OpenedMaterial;
import concreteClasses.RememberedUser;
import concreteClasses.User;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author haileyesus
 */
public class DashboardHelper {
    
    // prepare material to respond with data
    private static final JSONObject JSONOBJECT = new JSONObject();
    private static final JSONArray JSONARRAY = new JSONArray();
    
    
    public static void search(HttpServletResponse response, String keyword, User currentUser, int baseLimit, String sortMechanism) throws IOException {

        if(currentUser == null){
            return;
        }
        HashMap<String,String> searchFor = new HashMap<>();
        searchFor.put("subjectName", keyword);
        searchFor.put("grade", String.valueOf(currentUser.getGrade()));
        searchFor.put("stream", String.valueOf(currentUser.getStream()));
        
        try {
            // calculate the offset of limit for the filtered materials
            int offset = baseLimit * Data.MATERIALS_TO_SHOW_AT_ONCE;
            
            // all required materials that satisfy the condition
            ArrayList<ExamMaterial> filteredMaterials = ExamMaterial.fetch(searchFor, new String [] {"year",sortMechanism,String.valueOf(offset),String.valueOf(Data.MATERIALS_TO_SHOW_AT_ONCE)});
            // completed materials that satisfy the condition
            ArrayList<OpenedMaterial> completedMaterials = OpenedMaterial.fetchCompletedMaterials(searchFor);
            // opened materials that satisfy the condition
            ArrayList<OpenedMaterial> openedMaterials = OpenedMaterial.fetch(searchFor);
            // retrieve the constructed material haystack
            JSONObject requiredMaterials = constructMaterialResult(baseLimit, sortMechanism, filteredMaterials, openedMaterials, completedMaterials);
            response.getWriter().println(requiredMaterials);
        }catch(Exception ex){
            response.sendError(baseLimit, ErrorReporter.INTERNAL_SERVER_ERROR);
        }
    }
    
    
    public static void preFilter(HttpServletRequest request, HttpServletResponse response, User currentUser, int baseLimit, String sortCondition) throws IOException {
            // extract the input requirements and pass
            // convert each into array list 
            // because level always has multiple possible values
            ArrayList<String> subject = new ArrayList<>(); 
            subject.add(request.getParameter("subject"));
            
            ArrayList<String> examType = new ArrayList<>();
            examType.add(request.getParameter("examType"));
            
            ArrayList<String> year = new ArrayList<>();
            year.add(request.getParameter("year"));
            
            ArrayList<String> level = new ArrayList<>();

            ArrayList<String> stream = new ArrayList<>();
            
            // level and stream are computed differently for a guest and a user
            switch(request.getMethod()){
                case "GET" : 
                    String requestedLevel = request.getParameter("level");
                    // check whether a stream exists
                    if(requestedLevel.equals("Preparatory")){

                        level.add("11");
                        level.add("12");
                        switch(request.getParameter("stream")){
                            case "Natural Science" : stream.add("Natural");break;
                            case "Social Science"  : stream.add("Social"); break;
                            default : stream.add(String.valueOf((Object) null));
                        }

                    }else if(requestedLevel.equals("HighSchool")){
                        level.add("9");
                        level.add("10");
                        stream.add(String.valueOf((Object) null));
                    }
                    
                    break;
                case "POST" :
                    level.add(String.valueOf(currentUser.getGrade()));
                    stream.add(currentUser.getStream());
                    break;
                    
            }
            

            if (examType.get(0).equals("any")) {
                examType.set(0,null);
            }
            if (year.get(0).equals("any")) {
                year.set(0,null);
            }

            Integer subjectId;

            try {
                subjectId = Integer.parseInt(subject.get(0));
                if (subjectId == 0) {
                    subject.set(0, null);
                }
                /*
                 Year may be converted into date if neccessary
                 */
            } catch (Exception ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ErrorReporter.INTERNAL_SERVER_ERROR);
                
            }

            filter(response, subject, examType, year, level, stream, baseLimit,sortCondition);
    }
    
    public static void filter(HttpServletResponse response, ArrayList<String> subject, ArrayList<String> examType, ArrayList<String> year,
                        ArrayList<String> level, ArrayList<String> stream, int baseLimit, String sortCondition) throws IOException {

        
        HashMap<String,ArrayList<String>> filterRequirements = new HashMap<>();
        if (subject.get(0) != null) {
            filterRequirements.put("subjectId", subject);
        }
        if (examType.get(0) != null) {
            filterRequirements.put("type", examType);
        }
        if (year.get(0) != null) {
            filterRequirements.put("year", year);
        }
        if(level != null) {
            filterRequirements.put("grade", level);
        }
        
        // null value for stream exists for highschool, so it can not be ignored
        //filterRequirements.put("stream", stream); // this is commented out because null causes problem for high school


        try {
            // calculate the offset of limit for the filtered materials
            int offset = baseLimit * Data.MATERIALS_TO_SHOW_AT_ONCE;
            
            // all required materials that satisfy the condition
            ArrayList<ExamMaterial> filteredMaterials = ExamMaterial.extendFetch(filterRequirements, new String [] {"year",sortCondition,String.valueOf(offset),String.valueOf(Data.MATERIALS_TO_SHOW_AT_ONCE)});
            // completed materials that satisfy the condition
            ArrayList<OpenedMaterial> completedMaterials = OpenedMaterial.extendFetchCompletedMaterials(filterRequirements);
            // opened materials that satisfy the condition
                ArrayList<OpenedMaterial> openedMaterials = OpenedMaterial.extendFetch(filterRequirements);
            // retrieve the constructed material haystack
            JSONObject requiredMaterials = constructMaterialResult(baseLimit, sortCondition, filteredMaterials, openedMaterials, completedMaterials);
            response.getWriter().println(requiredMaterials);
        }catch(Exception ex){
            response.sendError(baseLimit, ErrorReporter.INTERNAL_SERVER_ERROR);
        }

        
    }
    
    public static Integer getRememberedUser(HttpServletRequest request, HttpServletResponse response){
        try {
        Cookie[] cookies = request.getCookies();
        String usi = null;
        boolean usiExists = false;
        if (cookies != null) {
          for(int i=0; i<cookies.length; i++) {
            Cookie c = cookies[i];
            if (c.getName().equals("usi")) {
              usiExists = true;
              usi = c.getValue();
              break;
            }
          }
        }
        
        if(usiExists){
            for(int i=0; i<cookies.length; i++){
                Cookie c = cookies[i];
                if(c.getName().equals("utkn")){
                    HashMap<String,String> condition = new HashMap<>();
                    condition.put("seriesIdentifier", usi);
                    ArrayList<RememberedUser> user = RememberedUser.fetch(condition);
                    
                    if(user!= null){
                        boolean tokenMatches = SCryptUtil.check(c.getValue(), user.get(0).getToken());
                        if(!tokenMatches){
                            // log out of all sessions and cookies
                            ServletOperation.signOut(request, response);
                            request.setAttribute("CookieTheftAttemptMessage", ErrorReporter.COOKIE_THEFT_ATTEMPT_MESSAGE);
                            request.getRequestDispatcher("index.jsp").forward(request,response);
                        }else {
                        
                            return user.get(0).getUserId();
                        }
                        
                    }
                }
            }
        }
        
        return null;
        }catch(Exception ex){
            return null;
        }
    }
    
    private static String getReadableDate(Date date){
        Calendar dateInstance = Calendar.getInstance();
        dateInstance.setTime(date);
        String month = "";
       
        switch(dateInstance.get(Calendar.MONTH)){
            case 0 : month = "January";break;
            case 1 : month = "February"; break;
            case 2 : month = "March"; break;
            case 3 : month = "April"; break;
            case 4 : month = "May"; break;
            case 5 : month = "June"; break;
            case 6 : month = "July"; break;
            case 7 : month = "August"; break;
            case 8 : month = "September"; break;
            case 9 : month = "October"; break;
            case 10 : month = "November"; break;
            case 11: month = "December"; break;
        }
        
        String readableDate = month + " " + dateInstance.get(Calendar.DATE) + ", " + dateInstance.get(Calendar.YEAR);
        return readableDate;
    }
   
    /*
        constructs results using json
    */
    private static JSONObject constructMaterialResult(int baseLimit, String sortCondition, ArrayList<ExamMaterial> filteredMaterials, 
            ArrayList<OpenedMaterial> openedMaterials, ArrayList<OpenedMaterial> completedMaterials) throws Exception{
        // sweep all json data 
        JSONOBJECT.clear();
        JSONARRAY.clear();
        
        
            
           
            //add to material and respond
            if (filteredMaterials == null) {
                JSONOBJECT.put("materials", JSONARRAY);
                JSONOBJECT.put("size", 0);
            } else {
                
                // the number of all materials that satisfy the condition
                int possibleMaterials = filteredMaterials.size();
                
                for (ExamMaterial filteredMaterial : filteredMaterials) {
                    JSONObject material = new JSONObject();
                    int filteredMaterialId = filteredMaterial.getId();
                    material.put("materialID", filteredMaterialId);
                    material.put("subject", filteredMaterial.getSubjectName());
                    material.put("examType", filteredMaterial.getType());
                    material.put("year", Integer.parseInt(filteredMaterial.getYear().toString().substring(0, 4)));
                    material.put("numberOfQuestions", filteredMaterial.getNumberOfQuestions());
                    // check if the material is opened or completed
                    /*
                        First lets assume the material is neither opened nor completed.
                        Then check in opened material, and if found, the material is excluded from the arraylist
                        further checks,and there is also no need to check in completed materials. if not, it will 
                        be searched in completed materials, and if found, it is excluded from the arraylist, but 
                        if not, it means the material has never been opened before, thus, not completed.
                    */
                    material.put("opened", false);
                    material.put("completed", false);
                    boolean found = false;
                    // first search phase
                    if(openedMaterials != null){
                        for(OpenedMaterial openedMaterial : openedMaterials){
                            if(openedMaterial.getMaterialId() == filteredMaterialId){
                                material.put("opened", true);
                                material.put("openedOn", getReadableDate(openedMaterial.getOpenedDate()));
                                openedMaterials.remove(openedMaterial);
                                found = true;
                                break;
                            }
                        }
                    }
                    // second search phase
                    if(!found && completedMaterials != null){
                        for(OpenedMaterial completedMaterial : completedMaterials){
                            if(completedMaterial.getMaterialId() == filteredMaterialId){
                                material.put("completed", true);
                                material.put("completedOn", getReadableDate(completedMaterial.getOpenedDate()));
                                completedMaterials.remove(completedMaterial);
                                break;
                            }
                        }
                    }
                    // finally add the material to results
                    JSONARRAY.add(material);
                }
                
                JSONOBJECT.put("materials", JSONARRAY);
                JSONOBJECT.put("size", possibleMaterials);
                JSONOBJECT.put("materialsToShowAtOnce", Data.MATERIALS_TO_SHOW_AT_ONCE);

            }

            return JSONOBJECT;
            
    }
}
