package concreteClasses;

import interfaces.Persistable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilityClasses.DBOperation;


public class ExamMaterial extends Material {
    private static final String TABLE_NAME = "materials";
    private static final String VIEW_NAME = "materialsview";
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;
    
    public ExamMaterial(Integer id, String type , Integer numberOfQuestions , Integer year , Integer subjectId , String stream , Integer grade , String subjectName, String allowedTime, Date uploadDate, String path , Integer uploaderId)
    {
        super(id, type, numberOfQuestions, year, subjectId, stream, grade, subjectName, allowedTime, uploadDate, path, uploaderId);
    }
    
    public void setType(String type) {
        this.type = type;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setNumberOfQuestions(Integer numberOfQuestions) {
        this.numberOfQuestions = numberOfQuestions;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public void setSubject(Integer subjectId) {
        this.subjectId = subjectId;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Override
    public Boolean persist(boolean active) throws Exception{
        
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); // for the auto-incrementing id
        columns.add(this.getType());
        columns.add(this.numberOfQuestions);
        columns.add(this.year.toString());
        columns.add(this.subjectId);
        columns.add(this.getStream());
        columns.add(this.grade);
        columns.add(this.allowedTime);
        columns.add(null);//for upload Date
        columns.add(this.getPath());
        columns.add(1);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("path", this.path);
        
        try {
            return DBOperation.persist(TABLE_NAME, columns, condition,active);
        } catch (Exception ex) {
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public static ExamMaterial fetch(Integer id) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, id);
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }

    public static ArrayList<ExamMaterial> fetch(HashMap parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<ExamMaterial> fetch(HashMap parameters , String [] options) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters, options);
        return fetchData();
    }
    
    public static ArrayList<ExamMaterial> fetchAll() throws Exception {
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static final ArrayList<ExamMaterial> fetchAll(String [] moreOptions) throws Exception{
        try {
            result =  DBOperation.fetchAll(ExamMaterial.VIEW_NAME, moreOptions);
            return fetchData();
            
        }catch(Exception ex){
            throw new Exception(ex.getMessage());
        }
    }
    
    public static ArrayList<ExamMaterial> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<ExamMaterial> extendFetch(HashMap<String, ArrayList<String>> parameters, String [] options) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters, options);
        return fetchData();
    }
   
    public static ArrayList<ExamMaterial> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        
        ArrayList<ExamMaterial> examMaterials = new ArrayList<>();
        
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                String tempType = result.getString("type");
                Integer tempNumberOfQuestions = result.getInt("numberOfQuestions");
                Integer tempYear = result.getInt("year");
                Integer tempSubjectId = result.getInt("subjectId");
                String tempStream = result.getString("stream");
                Integer tempGrade = result.getInt("grade");
                String tempSubjectName = result.getString("subjectName");
                String tempAllowedTime = result.getString("allowedTime");
                Date tempUploadDate = result.getDate("uploadDate");
                String tempPath = result.getString("path");
                Integer tempUploaderId = result.getInt("uploaderId");
                

                ExamMaterial examMaterial = new ExamMaterial(tempId, tempType, tempNumberOfQuestions, tempYear, tempSubjectId, tempStream, tempGrade, tempSubjectName, tempAllowedTime, tempUploadDate, tempPath, tempUploaderId);
                examMaterials.add(examMaterial);
            }
            return examMaterials;
            
        }catch(Exception ex){
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void delete() throws Exception{
        if (conn == null) {
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE '"+TABLE_NAME+"' SET active=0 WHERE id=?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, this.id);
            statement.execute();
        } catch (Exception ex) {
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception{
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String,String> attributes) throws Exception{
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String,String> paramters) throws Exception{
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
    }
    
     
    public static int extendCount(HashMap<String,ArrayList<String>> conditions) throws Exception {
        try{
            return DBOperation.extendCount(VIEW_NAME, conditions);
        }
        catch(Exception ex){
            Logger.getLogger(ExamMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
}
