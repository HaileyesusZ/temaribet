package concreteClasses;

import interfaces.Persistable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilityClasses.DBOperation;

public class Subject implements Persistable{
    private static final String TABLE_NAME = "subjects";
    private static final String VIEW_NAME = "subjectsview";
    
    private final Integer id;
    private String name;
    private String level;
    private String stream;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public Subject(Integer id, String name, String level, String stream) {
        this.id = id;
        this.name = name;
        this.level = level;
        this.stream = stream;
    }
    
   
    
    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getStream() {
        return stream;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    @Override
    public Boolean persist(boolean active) throws Exception {
         ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add(this.name);
        columns.add(this.level);
        columns.add(this.stream);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("name", this.name);
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public static Subject fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }
    
    public static Subject fetch(String subjectName){
        HashMap<String, String> conditions = new HashMap<>();
        conditions.put("name", subjectName);
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            subjects = fetch(conditions);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subjects.get(0);
    }

    public static ArrayList<Subject> fetch(HashMap<String, String> parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
       
        return fetchData();
    }
    
    
    public static ArrayList<Subject> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<Subject> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<Subject> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        ArrayList<Subject> subjects = new ArrayList<>();
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                String tempName = result.getString("name");
                String tempLevel = result.getString("level");
                String tempStream = result.getString("stream");

                Subject subject = new Subject(tempId, tempName, tempLevel, tempStream);
                subjects.add(subject);
            }
            return subjects;
            
        } catch(Exception ex){
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
         try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception {
         try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

   
    public static int count(HashMap<String, String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
 
}
