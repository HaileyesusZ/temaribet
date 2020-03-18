package concreteClasses;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import utilityClasses.DBOperation;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User extends Person{
    private static final String TABLE_NAME = "users";
    private static final String VIEW_NAME= "usersview";
    private static final String PENDING_USERS_VIEW_NAME = "pendingusersview";

    
    private Integer grade;
    private String stream;

    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public User(Integer id, String firstName, String lastName, Character sex, String email , String password, String profilePicture, Integer schoolId, String phoneNumber, Date registerDate, Integer grade, String stream)
    {
        super(id,firstName,lastName,sex,email,password,profilePicture,schoolId,phoneNumber, registerDate);
        this.grade = grade;
        this.stream = stream;
    }
    
    
    public Integer getGrade() {
        return grade;
    }

    public String getStream() {
        return stream;
    }
    // gets the real password of the user
    @Override
    public String getPassword()throws Exception {
        try {
            ResultSet userResult = DBOperation.fetch(VIEW_NAME, this.id);
            if(userResult == null) return null;
            userResult.next();
            return userResult.getString("password");
            
        }catch(Exception ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }
    
    @Override
    public Boolean persist(boolean active) throws Exception{
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null);
        columns.add(this.firstName);
        columns.add(this.lastName);
        columns.add(this.getSex()); 
        columns.add(this.email);
        columns.add(this.password);
        columns.add(this.profilePicture);
        columns.add(null); //for school Id
        columns.add(this.phoneNummber);
        columns.add(null);
        columns.add(this.grade);
        columns.add(this.stream);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("email", this.email);
        
        try {
            return DBOperation.persist(TABLE_NAME, columns, condition,active);
        }catch(Exception ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
        
    }
    

    public static User fetch(Integer id) throws Exception{
         result = DBOperation.fetch(VIEW_NAME, id) ;
        
        if(result != null){
            return fetchData().get(0);
        }
        return null;
        
    }

    public static ArrayList<User> fetch(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<User> fetchOR(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetchOR(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<User> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<User> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<User> fetchData() throws Exception {
         if(result == null){
            return null;
        }
        ArrayList<User> users = new ArrayList<>();
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                String tempFirstName = result.getString("firstName");
                String tempLastName = result.getString("lastName");
                Character tempSex = result.getString("id").charAt(0);
                String tempEmail = result.getString("email");
                String tempPassword = null;
                String tempProfilePicture = result.getString("profilePicture");
                Integer tempSchoolId = result.getInt("schoolId");
                String tempPhoneNumber = result.getString("phoneNumber");
                Date tempRegisterDate = result.getDate("registerDate");
                Integer tempGrade = result.getInt("grade");
                String tempStream = result.getString("stream");

                User user = new User(tempId, tempFirstName, tempLastName, tempSex, tempEmail, tempPassword,tempProfilePicture, tempSchoolId, tempPhoneNumber, tempRegisterDate, tempGrade, tempStream);
                users.add(user);
            }
            return users;
            
        }catch(SQLException ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void delete() throws Exception{
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE '"+TABLE_NAME+"' SET active = 0 WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, this.id);
            statement.execute();
        }catch(SQLException ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.getId(), attributeName, attributeValue);
        }catch(Exception ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String,String> attributes) throws Exception {
         try{
            DBOperation.updateAttributes(TABLE_NAME, this.getId(), attributes);
        }
        catch(Exception ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String,String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        } 
    }   
    
    /*
        all the below methods are used to fetch full info of the inactive users
    */
    public static User fetchPendingUserInfo(Integer id) throws Exception{
        result = DBOperation.fetch(PENDING_USERS_VIEW_NAME, id);
       
        return fetchData().get(0);
        
    }

    public static ArrayList<User> fetchPendingUserInfo(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetch(PENDING_USERS_VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<User> fetchAllPendingUsersInfo() throws Exception{
        result = DBOperation.fetchAll(PENDING_USERS_VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<User> extendFetchPendingUserInfo(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(PENDING_USERS_VIEW_NAME, parameters);
        return fetchData();
    }
}