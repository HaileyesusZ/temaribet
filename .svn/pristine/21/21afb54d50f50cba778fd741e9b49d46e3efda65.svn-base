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

/**
 *
 * @author Haileyesus Z
 */
public class Progress implements Persistable {
    private static final String TABLE_NAME = "progress";
    private static final String VIEW_NAME = "progressview";
    
    private final Integer id;
    private final Integer userId;
    private final Integer subjectId;
    private final String subjectName;

    private final Integer points;
    private final Date date;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public Progress(Integer id, Integer userId, Integer subjectId, String subjectName,Integer points, Date date){
        this.id = id;
        this.userId  = userId;
        this.subjectId  = subjectId;
        this.points = points;
        this.date = date;
        this.subjectName  = subjectName;
    }
    
    public Integer getId() {
        return id;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getSubjectId() {
        return subjectId;
    }

    public Integer getPoints() {
        return points;
    }
    
    public Date getDate() {
        return date;
    }
    
    public String getSubjectName() {
        return subjectName;
    }
   
    @Override
    public Boolean persist(boolean active) throws Exception {
         ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add(this.userId);
        columns.add(this.subjectId);
        columns.add(this.points);
        columns.add(this.date);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("userId", this.userId.toString());
        condition.put("subjectId", this.subjectId.toString());
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    public static Progress fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }

    public static ArrayList<Progress> fetch(HashMap<String, String> parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
       
        return fetchData();
    }
    
    public static ArrayList<Progress> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<Progress> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<Progress> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        ArrayList<Progress> progresses = new ArrayList<>();
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                Integer tempUserId = result.getInt("userId");
                Integer tempSubjectId = result.getInt("subjectId");
                String tempSubjectName = result.getString("subjectName");
                Integer tempPoints = result.getInt("points");
                Date tempDate = result.getDate("date");

                Progress progress = new Progress(tempId, tempUserId, tempSubjectId, tempSubjectName, tempPoints, tempDate);
                progresses.add(progress);
            }
            return progresses;
            
        } catch(Exception ex){
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    

    @Override
    public void delete() throws Exception {
        if (conn == null) {
            conn = DBConnection.getConnection();
        }

        sql = "UPDATE '"+TABLE_NAME+"' SET active=0 WHERE id=?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, this.id);
            statement.execute();
        } catch (Exception ex) {
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
         try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception {
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String, String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(Progress.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
}
