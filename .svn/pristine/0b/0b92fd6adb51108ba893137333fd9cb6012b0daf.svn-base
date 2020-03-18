package concreteClasses;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilityClasses.DBOperation;

public class OpenedMaterial extends Material{
    private static final String TABLE_NAME = "openedmaterials";
    private static final String VIEW_NAME = "openedmaterialsview";
    private static final String COMPLETED_MATERIALS_VIEW_NAME = "completedmaterialsview";

    
    private final Date openedDate;
    private final Integer userId;
    private final Integer materialId;
    private final String remainingTime;
    private final String workingStatus;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public OpenedMaterial(Integer id, Integer userId, Integer materialId, Date openedDate, String remainingTime, String workingStatus){
        super(id);
        this.userId = userId;
        this.materialId = materialId;
        this.openedDate = openedDate;
        this.remainingTime = remainingTime;
        this.workingStatus = workingStatus;
    }
    
    public OpenedMaterial(Integer id, Integer materialId, String type , Integer numberOfQuestions , Integer year , Integer subjectId , String stream , Integer grade, String subjectName, String allowedTime, Date uploadDate, String path , Integer uploaderId, Integer userId, Date openedDate, String remainingTime, String workingStatus)
    {
       super ( id, type ,numberOfQuestions ,year ,subjectId , stream, grade, subjectName, allowedTime, uploadDate, path ,uploaderId);
       this.userId = userId;
       this.materialId = materialId;
       this.openedDate = openedDate;
       this.remainingTime = remainingTime;
       this.workingStatus = workingStatus;
    }
    
     public Date getOpenedDate() {
        return openedDate;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getMaterialId() {
        return materialId;
    }
    
    public String getRemainingTime() {
        return this.remainingTime;
    }
    
    public String getWorkingStatus() {
        return workingStatus;
    }
    
    @Override
    public Boolean persist(boolean active) throws Exception {
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add((this.userId));
        columns.add(this.materialId);
        columns.add(null); // for the opened date (timestamp)
        columns.add(remainingTime);
        columns.add(workingStatus);
//        columns.add(Persistable.active);
//        columns.add(Persistable.active);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("materialId", this.materialId.toString());
        condition.put("userId", this.userId.toString());
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition,active);
        } catch (Exception ex) {
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
    }

    public static OpenedMaterial fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }
    
    public static ArrayList<OpenedMaterial> fetch(HashMap<String, String> parameters) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<OpenedMaterial> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<OpenedMaterial> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<OpenedMaterial> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        ArrayList<OpenedMaterial> openedMaterials = new ArrayList<>();
        
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                Integer tempMaterialId = result.getInt("materialId");
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
                Integer tempUserId = result.getInt("userId");
                Date tempOpenedDate = result.getDate("openedDate");
                String tempRemainingTime = result.getString("remainingTime");
                String tempWorkingStatus = result.getString("workingStatus");
                

                OpenedMaterial openMaterial = new OpenedMaterial(tempId, tempMaterialId, tempType, tempNumberOfQuestions,tempYear, 
                        tempSubjectId, tempStream, tempGrade, tempSubjectName, tempAllowedTime, tempUploadDate, tempPath, tempUploaderId, tempUserId, tempOpenedDate, tempRemainingTime, tempWorkingStatus);
                openedMaterials.add(openMaterial);
            }
            return openedMaterials;
            
        }catch(Exception ex){
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    @Override
    public void delete() throws Exception {
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE "+TABLE_NAME+" SET active=0 WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, this.id);
            statement.execute();
        }catch(Exception ex){
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    public static void delete(int id) throws Exception {
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE "+TABLE_NAME+" SET active=0 WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.execute();
        }catch(Exception ex){
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception {
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String, String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(OpenedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    
    public static ArrayList<OpenedMaterial> fetchAllCompletedMaterials() throws Exception{
        result = DBOperation.fetchAll(COMPLETED_MATERIALS_VIEW_NAME);
        return fetchData();
    }
    public static ArrayList<OpenedMaterial> fetchAllCompletedMaterials(String[] moreOptions) throws Exception{
        result = DBOperation.fetchAll(COMPLETED_MATERIALS_VIEW_NAME, moreOptions);
        return fetchData();
    }
    public static ArrayList<OpenedMaterial> fetchCompletedMaterials(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetch(COMPLETED_MATERIALS_VIEW_NAME, parameters);
        return fetchData();
    }
    public static ArrayList<OpenedMaterial> fetchCompletedMaterials(HashMap<String,String> parameters, String[] moreOptions) throws Exception{
        result = DBOperation.fetch(COMPLETED_MATERIALS_VIEW_NAME, parameters,moreOptions);
        return fetchData();
    }
    public static ArrayList<OpenedMaterial> extendFetchCompletedMaterials(HashMap<String,ArrayList<String>> parameters) throws Exception{
        result = DBOperation.extendFetch(COMPLETED_MATERIALS_VIEW_NAME, parameters);
        return fetchData();
    }
    public static ArrayList<OpenedMaterial> extendFetchCompletedMaterials(HashMap <String,ArrayList<String>> parameters, String[] moreOptions) throws Exception{
        result = DBOperation.extendFetch(COMPLETED_MATERIALS_VIEW_NAME, parameters,moreOptions);
        return fetchData();
    }
}
