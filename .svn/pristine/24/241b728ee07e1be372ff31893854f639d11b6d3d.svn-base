package concreteClasses;

import static concreteClasses.ExamMaterial.fetchData;
import interfaces.Persistable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import utilityClasses.DBOperation;
import java.util.logging.Level;
import java.util.logging.Logger;

public class School implements Persistable{
    private static final String TABLE_NAME = "schools";
    private static final String VIEW_NAME = "schoolsview";
    
    private final Integer id;
    private String name;
    private String email;
    private String password;
    private String logo;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public School(Integer id, String name, String email, String password, String logo) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.logo = logo;
    }

    public String getName() {
        return name;
    }
    
    public void setName(String name){
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public Integer getId() {
        return id;
    }

    @Override
    public Boolean persist(boolean active) throws Exception{
        
        ArrayList<Object> columns = new ArrayList<Object>();
        
        columns.add(null); // for the auto-incrementing id
        columns.add(this.getName());
        columns.add(this.getEmail());
        columns.add(this.getPassword());
        columns.add(this.getLogo());
        
        HashMap<String, String> condition = new HashMap<String, String>();
        condition.put("name", this.name);
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public static School fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }

    public static ArrayList<School> fetch(HashMap<String, String> parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
       
        return fetchData();
    }
    
    public static ArrayList<School> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<School> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static  ArrayList<School> fetchData() throws Exception {
        if(result == null){
            return null;
        }
         ArrayList<School> schools = new  ArrayList<School>();
        try {
            while(result.next()){
            Integer tempId = result.getInt("id");
            String tempName = result.getString("name");
            String tempEmail = result.getString("email");
            String tempPassword = null;
            String tempLogo = result.getString("logo");

            School school = new School(tempId, tempName, tempEmail, tempPassword, tempLogo);
            schools.add(school);
            }
            return schools;
            
        } catch(Exception ex){
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception{
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception{
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String, String> paramters) throws Exception{
       
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(School.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
}