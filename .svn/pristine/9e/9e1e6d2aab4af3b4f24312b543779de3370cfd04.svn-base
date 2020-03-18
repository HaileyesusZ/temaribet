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

public class Admin extends Person{
    private static final String TABLE_NAME = "admins";
    private static final String VIEW_NAME = "adminsview";
    private final Integer contribution;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;
      
    public Admin(Integer id, String firstName, String lastName, Character sex, String email, String password, String profilePicture, Integer schoolId, String phoneNumber, Date registerDate, Integer contribution){
        super(id, firstName , lastName ,sex, email , password, profilePicture, schoolId, phoneNumber, registerDate);
        this.contribution = contribution;
    }
       
    public Integer getContribution(){
        return this.contribution;
    }

    @Override
    public String getFirstName() {
        return this.firstName; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getLastName() {
        return this.lastName; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Character getSex() {
        return this.sex; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getEmail() {
        return this.email; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getPassword() {
        return this.password; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getProfilePicture() {
        return this.profilePicture; //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Override
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Override
    public Boolean persist(boolean active) throws Exception{
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); // for the auto incrementing id
        columns.add(this.getFirstName());
        columns.add(this.getLastName());
        columns.add(this.sex);
        columns.add(this.getEmail());
        columns.add(this.getPassword());
        columns.add(this.getProfilePicture());
        columns.add(this.schoolId);
        columns.add(this.getPhoneNummber());
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("email", this.email);
        
        try {
            return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public static Admin fetch(Integer id) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null){
            return fetchData().get(0);
        }
        
        return null;
    }

    public static ArrayList<Admin> fetch(HashMap parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<Admin> fetchOR(HashMap parameters) throws Exception{
        result = DBOperation.fetchOR(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<Admin> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }

    public static ArrayList<Admin> fetchData() throws Exception{
        if(result == null){
            return null;
        }
        
        ArrayList<Admin> admins = new ArrayList<Admin>();

        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                String tempFirstName = result.getString("firstName");
                String tempLastName = result.getString("lastName");
                Character tempSex = result.getString("sex").charAt(0);
                String tempEmail = result.getString("email");
                String tempPassword = result.getString("password");
                String tempProfilePicture = result.getString("profilePicture");
                Integer tempSchoolID = result.getInt("schoolID");
                String tempPhoneNumber = result.getString("phoneNumber");
                Date tempRegisterDate = result.getDate("registerDate");
                Integer tempContribution = result.getInt("contribution");

                Admin admin = new Admin(tempId, tempFirstName, tempLastName, tempSex, tempEmail, tempPassword, tempProfilePicture, tempSchoolID, tempPhoneNumber, tempRegisterDate, tempContribution);
                admins.add(admin);
            }
            return admins;
            
            
        }catch(Exception ex){
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception{
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String,String> attributes) throws Exception{
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

   
    public static int count(HashMap<String,String> paramters) throws Exception{
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
}