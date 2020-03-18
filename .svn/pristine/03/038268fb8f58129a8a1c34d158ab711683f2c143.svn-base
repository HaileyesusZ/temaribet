/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package concreteClasses;

import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilityClasses.DBOperation;

/**
 *
 * @author Haileyesus Z
 */
public class ForgottenPassword {
    private static final String TABLE_NAME = "forgottenpassword";
    private static final String VIEW_NAME= "forgottenpasswordview";
    private static final String EXPIRED_FORGOTTEN_PASSWORD_VIEW_NAME = "expiredforgottenpasswordview";
    
    // private attributes of an inactive user
    private final Integer id;
    private final Integer userId;
    private String resetId;
    private String resetKey;
    private Timestamp expirationDate;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;

    public ForgottenPassword(Integer id, Integer userId, String resetId, String resetKey, Timestamp expirationDate)
    {
        this.id = id;
        this.userId = userId;
        this.resetId = resetId;
        this.resetKey = resetKey;
        this.expirationDate = expirationDate;
    }

    public Integer getId() {
        return id;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getResetId() {
        return resetId;
    }

    public String getResetKey() {
        return resetKey;
    }
    
    public Timestamp getExpirationDate(){
        return expirationDate;
    }

    public void setResetId(String resetId) {
        this.resetId = resetId;
    }

    public void setResetKey(String resetKey) {
        this.resetKey = resetKey;
    }
   
    public void setExpirationDate(Timestamp expirationDate){
        this.expirationDate = expirationDate;
    }
    
    public Boolean persist(boolean active) throws Exception{
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null);
        columns.add(this.userId);
        columns.add(this.resetId);
        columns.add(this.resetKey);
        columns.add(this.expirationDate);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("userId", String.valueOf(this.userId));
        
        try {
            return DBOperation.persist(TABLE_NAME, columns, condition,active);
        }catch(Exception ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
        
    }

    public static ForgottenPassword fetch(Integer id) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, id);
       
        if(result != null){
            return fetchData().get(0);
        }
        return null;
        
    }

    public static ArrayList<ForgottenPassword> fetch(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<ForgottenPassword> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<ForgottenPassword> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<ForgottenPassword> fetchData() throws Exception {
         if(result == null){
            return null;
        }
        ArrayList<ForgottenPassword> inactiveUsers = new ArrayList<>();
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                Integer tempUserId = result.getInt("userId");
                String tempActivationId = result.getString("resetId");
                String tempActivationKey = result.getString("resetKey");
                Timestamp tempExpirationDate = result.getTimestamp("expirationDate");

                ForgottenPassword inactiveUser = new ForgottenPassword(tempId, tempUserId, tempActivationId, tempActivationKey, tempExpirationDate);
                inactiveUsers.add(inactiveUser);
            }
            return inactiveUsers;
            
        }catch(SQLException ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public void delete() throws Exception{
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE "+TABLE_NAME +" SET active = 0 WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, this.id);
            statement.execute();
        }catch(SQLException ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.getId(), attributeName, attributeValue);
        }catch(Exception ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public void updateAttributes(HashMap<String,String> attributes) throws Exception {
         try{
            DBOperation.updateAttributes(TABLE_NAME, this.getId(), attributes);
        }
        catch(Exception ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    public static int count(HashMap<String,String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(ForgottenPassword.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        } 
    }
    
    public static ArrayList<ForgottenPassword> fetchExpiredForgottenPasswords(HashMap<String,String> parameters) throws Exception{
        result = DBOperation.fetch(EXPIRED_FORGOTTEN_PASSWORD_VIEW_NAME, parameters);
        
        return fetchData();
    }
}
