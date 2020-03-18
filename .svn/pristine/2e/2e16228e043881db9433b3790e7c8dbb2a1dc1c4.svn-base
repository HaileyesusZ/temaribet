/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
 * @author haileyesus
 */
public class RememberedUser implements Persistable {
    private static final String TABLE_NAME = "rememberedusers";
    private static final String VIEW_NAME = "rememberedusersview";
    
    private Integer id;
    private Integer userId;
    private Long seriesIdentifier;

    
    private String token;
    private Date issuedDate;
    
    //Properties used for database operations
    private static String sql;
    private static PreparedStatement statement;
    private static ResultSet result;
    private static Connection conn;
    
  

    public RememberedUser(Integer id, Integer userId, Long seriesIdentifier, String token, Date issuedDate) {
        this.id = id;
        this.userId = userId;
        this.seriesIdentifier = seriesIdentifier;
        this.token = token;
        this.issuedDate = issuedDate;
    }
    
    public Integer getUserId() {
        return userId;
    }

    public Long getSeriesIdentifier() {
        return seriesIdentifier;
    }

    public String getToken() {
        return token;
    }

    public Date getIssuedDate() {
        return issuedDate;
    }
    
    public void setSeriesIdentifier(Long seriesIdentifier) {
        this.seriesIdentifier = seriesIdentifier;
    }

    public void setToken(String token) {
        this.token = token;
    }
    
    @Override
    public Boolean persist(boolean active) throws Exception {
        ArrayList<Object> columns = new ArrayList<>();
        
        columns.add(null); //for the auto-incrementing id
        columns.add((this.userId));
        columns.add(this.seriesIdentifier);
        columns.add(this.token);
        columns.add(this.issuedDate);
        
        HashMap<String, String> condition = new HashMap<>();
        condition.put("userId", this.userId.toString());
        
        try {
             return DBOperation.persist(TABLE_NAME, columns, condition, active);
        } catch (Exception ex) {
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
    }

    public static RememberedUser fetch(Integer id) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, id);
        
        if(result != null) {
            return fetchData().get(0);
        }
        return null;
    }
    
    public static ArrayList<RememberedUser> fetch(HashMap<String, String> parameters) throws Exception {
        result = DBOperation.fetch(VIEW_NAME, parameters);
        
        return fetchData();
    }
    
    public static ArrayList<RememberedUser> fetchAll() throws Exception{
        result = DBOperation.fetchAll(VIEW_NAME);
        return fetchData();
    }
    
    public static ArrayList<RememberedUser> extendFetch(HashMap<String, ArrayList<String>> parameters) throws Exception {
        result = DBOperation.extendFetch(VIEW_NAME, parameters);
        return fetchData();
    }
    
    public static ArrayList<RememberedUser> fetchData() throws Exception {
        if(result == null){
            return null;
        }
        ArrayList<RememberedUser> rememberedusers = new ArrayList<>();
        
        try {
            while(result.next()){
                Integer tempId = result.getInt("id");
                Integer tempUserId = result.getInt("userId");
                Long tempseriesIdentifier = result.getLong("seriesIdentifier");
                String tempToken = result.getString("token");
                Date tempIssuedDate = result.getDate("issuedDate");
                
                

                RememberedUser rememberedUser = new RememberedUser(tempId, tempUserId, tempseriesIdentifier, tempToken, tempIssuedDate);
                rememberedusers.add(rememberedUser);
            }
            return rememberedusers;
            
        }catch(Exception ex){
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttribute(String attributeName, String attributeValue) throws Exception {
        try {
            DBOperation.updateAttribute(TABLE_NAME, this.id, attributeName, attributeValue);
        } catch (Exception ex) {
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    @Override
    public void updateAttributes(HashMap<String, String> attributes) throws Exception {
        try{
            DBOperation.updateAttributes(TABLE_NAME, this.id, attributes);
        }
        catch(Exception ex){
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }

    
    public static int count(HashMap<String, String> paramters) throws Exception {
        try{
            return DBOperation.count(VIEW_NAME, paramters);
        }
        catch(Exception ex){
            Logger.getLogger(RememberedUser.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    
}
