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

public class PinnedMaterial extends Material{
    private static final String TABLE_NAME = "pinnedmaterials";
    private static final String VIEW_NAME = "pinnedmaterialsview";
    
    private final Integer userId;
    private final Integer materialId;

     //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

     public PinnedMaterial(Integer id, Integer userId, Integer materialId){
        super(id);
        this.userId = userId;
        this.materialId = materialId;
    }
     
    public PinnedMaterial (Integer id, Integer materialId, String type , Integer numberOfQuestions , Integer year , Integer subjectId , String stream , Integer grade , String subjectName, String allowedTime, Date uploadDate, String path , Integer uploaderId, Integer userId)
    {
        super ( id, type ,numberOfQuestions ,year ,subjectId , stream ,grade , subjectName,allowedTime, uploadDate, path ,uploaderId);
        this.userId = userId;
        this.materialId = materialId;
    }
    
    public Integer getUserId(){
        return this.userId;
    }
    public Integer getMaterialId(){
        return this.materialId;
    }

    @Override
    public Boolean persist(boolean active) throws Exception {
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add(this.userId);
        columns.add(this.materialId);
        
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("userId", String.valueOf(this.userId));
        condition.put("materialId", String.valueOf(this.materialId));
        
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

     public static PinnedMaterial fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }
    
    public static ArrayList<PinnedMaterial> fetch(HashMap<String, String> parameters) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<PinnedMaterial> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<PinnedMaterial> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<PinnedMaterial> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        ArrayList<PinnedMaterial> pinnedMaterials = new ArrayList<>();
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

                PinnedMaterial pinnedMaterial = new PinnedMaterial(tempId, tempMaterialId, tempType, tempNumberOfQuestions,tempYear, 
                        tempSubjectId, tempStream, tempGrade, tempSubjectName, tempAllowedTime, tempUploadDate, tempPath, tempUploaderId, tempUserId);
                
                pinnedMaterials.add(pinnedMaterial);
            }
            return pinnedMaterials;
            
        }catch(Exception ex){
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
         try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception {
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String, String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(PinnedMaterial.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    
    public boolean pin() throws Exception{
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add(this.userId);
        columns.add(this.materialId);
        
        HashMap<String,String> condition = new HashMap<>();
        
        condition.put("userId", String.valueOf(this.userId));
        condition.put("materialId", String.valueOf(this.materialId));
        
        try {
            return DBOperation.persistOrActivate(TABLE_NAME, columns, condition);
        }catch(Exception ex){
            throw new Exception(ex.getMessage());
        }
        

    }
}
