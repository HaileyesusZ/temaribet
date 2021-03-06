package utilityClasses;

import concreteClasses.DBConnection;
import interfaces.Persistable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBOperation {

    //Properties used for database operations
    private static String sql; // stores sql query statements
    private static PreparedStatement statement;// stores prepared statments
    private static ResultSet result;//stores result set returned from query execution
    private static Connection conn;// sotres database connection
    
    
    /*
        
    */
    public static void getConnection() throws Exception {
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
    }
    
    /*
        persists or inserts a single record to a table of the database
        
    */
    public static Boolean persist(String tableName, ArrayList<Object> columns, HashMap<String, String> condition , boolean active) throws Exception{
        getConnection();
        
        try {
            int exist = count(tableName, condition);
            if(exist > 0 ){
                return false;
            }
        }catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, null, ex);
            throw new Exception(ex.getMessage());
        }
        
        /*
            for every new table record, set the active flag, either 0 or 1
        */
        if(active) {
            columns.add(String.valueOf(Persistable.ACTIVE));
        }else {
            columns.add(String.valueOf(Persistable.INACTIVE));
        }
        
        sql = "INSERT INTO "+tableName+" VALUES(";
        sql = SqlConstructor.construct(sql, columns.size());
        
        try{
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, columns);
            
            statement.executeUpdate();
            return true;
        }
        catch(SQLException ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    /* 
        fetchets or selects a single record form the database as a result set
        using a primary key 'id'
    */
    
    public static ResultSet fetch(String tableName, int id) throws Exception{
        getConnection();
        
        sql = "SELECT * FROM "+tableName+" WHERE id=? LIMIT 1";
        
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            result = statement.executeQuery();
            if(!result.isBeforeFirst()){
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
        
        return result;
    }
     /* 
        fetches or selects a single or set of records from the database as 
        a result set using preconditions passed with a Hashmap
    */
    
    public static ResultSet fetch(String tableName, HashMap<String, String> columns) throws Exception{
        return fetch(tableName, columns, null, "AND");
    }
    /* 
        uses 'OR' condition to fetch from database
    */
    public static ResultSet fetchOR(String tableName, HashMap<String, String> columns) throws Exception{
        return fetch(tableName, columns, null, "OR");
    }
    
    public static ResultSet fetch(String tableName, HashMap<String, String> columns, String [] moreOptions) throws Exception{
        return fetch(tableName, columns, moreOptions, "AND");
    }
    
    public static ResultSet fetchOR(String tableName, HashMap<String, String> columns, String [] moreOptions) throws Exception{
        return fetch(tableName, columns, moreOptions, "OR");
    }
    
    public static ResultSet fetch(String tableName, HashMap<String, String> columns, String [] moreOptions, String logicalCondition) throws Exception{
        getConnection();
        
        sql = "SELECT * FROM "+tableName+" WHERE ";
        
        ArrayList<String> possibleValues = new ArrayList<>();
        sql = SqlConstructor.construct(sql, columns, possibleValues,logicalCondition);
        // add more options to the query
        sql = SqlConstructor.addMoreOptionsToSql(sql, moreOptions);
            
        try{
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, possibleValues);
            result = statement.executeQuery();
            if(! result.isBeforeFirst()){
                return null;
            }
        }
        catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
        
        return result;
    }
    
    
    public static ResultSet extendFetch(String tableName, HashMap<String, ArrayList<String>> columns) throws Exception{
        return extendFetch(tableName,columns,null);
        
    }
    
    /* 
        an overloaded method of fetch that uses combination of 'or' and 'and' sql query
    */
    
    public static ResultSet extendFetch(String tableName, HashMap<String, ArrayList<String>> conditions, String [] moreOptions) throws Exception{
        getConnection();
        
        sql = "SELECT * FROM "+tableName+" WHERE ";
        
        ArrayList<String> possibleValues = new ArrayList<>();
        
        sql = SqlConstructor.extendConstruct(sql, conditions, possibleValues);
        sql = SqlConstructor.addMoreOptionsToSql(sql, moreOptions);
        
        try {
            
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, possibleValues);
            
                result = statement.executeQuery();
            if(! result.isBeforeFirst()){
                return null;
            }
            return result;
        }catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
        
    }
    
    /* 
        fetches all the rows from the table
    */
    public static ResultSet fetchAll(String tableName) throws Exception{
        return fetchAll(tableName,null);
    }
    
    /* 
        fetches database records by sorting the values with the specified column name and 
        limiting the result to the given count
    */
    public static ResultSet fetchAll(String tableName, String [] moreOptions) throws Exception{
        getConnection();
        
        sql = "SELECT * FROM "+tableName;
        sql = SqlConstructor.addMoreOptionsToSql(sql, moreOptions);
        
        try{
            statement = conn.prepareStatement(sql);
            result = statement.executeQuery();
            if(! result.isBeforeFirst()){
                return null;
            }
        }
        catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
        
        return result;
    }
    
     /*
        checks the existence of a record using its active flags and
        either persists a new record or activates the existing record
    */
    public static boolean persistOrActivate(String tableName, ArrayList<Object> columns, HashMap<String,String> condition) throws Exception {
        
        try{
            
            boolean added = DBOperation.persist(tableName, columns, condition,true);
            if(added){
                return true;
            }
            
            condition.put("active", String.valueOf(0));

            int count = DBOperation.count(tableName, condition);
            if(count > 0){
                condition.remove("active");
                try {

                    DBOperation.activate(tableName, condition);
                    return true;
                    
                }catch(Exception ex){
                    Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
                    throw new Exception(ex.getMessage());
                }
            }
            return false;
            
        }catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    /*
        activates a deleted or removed record or records by setting the active flag on
    */
    public static boolean activate(String tableName, HashMap<String,String> conditions) throws Exception{
        getConnection();
        
        sql = "UPDATE " + tableName + " SET active = 1 WHERE active = 0 AND ";
        
        ArrayList<String> possibleValues = new ArrayList<>();
        sql = SqlConstructor.construct(sql, conditions, possibleValues);
        
        try {
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, possibleValues);
            statement.execute();
            return true;
        }catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
       
        
    }
    
    /* 
        virtually deletes or removes a record or set of records from a table by setting 
        the active flag off using conditions passed with a hashmap
    */
    public static void delete(String tableName, HashMap<String, String> conditions) throws Exception{
        if(conn == null){
            conn = DBConnection.getConnection();
        }
        
        sql = "UPDATE "+tableName+" SET active=0 WHERE ";
        ArrayList<String> allValues = new ArrayList<>();
        sql = SqlConstructor.construct(sql, conditions, allValues);
        
        try {
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, allValues);
            statement.execute();
        } catch (Exception ex) {
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    /* 
        updates a single record of a table from the database 
    */
    public static void updateAttribute(String tableName, int id, String attributeName, String attributeValue) throws Exception{
        getConnection();
        
        sql = "UPDATE "+tableName+" SET "+attributeName+"=? WHERE id=?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, attributeValue);
            statement.setInt(2, id);
            statement.execute();
        } catch (SQLException ex) {
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
    }
    
    /* 
        updates a record or set of records of a table using the hashmap passed to it 
    */
    public static void updateAttributes(String tableName, int id, HashMap<String, String> conditions) throws Exception{
        getConnection();
        
        sql = "UPDATE "+tableName+" SET ";
        
        ArrayList<String> allValues = new ArrayList<>();
            
        sql = SqlConstructor.construct(sql, conditions, allValues);
        
        try {
            sql += " WHERE id=?";
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, allValues);
            statement.setInt(conditions.size()+1, id);
            statement.execute();
        } catch (Exception ex) {
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
    }
    /* 
        counts and returns the number of records that a table has with the specified
        conditions passed with a hashmap
    */
    public static int count(String tableName, HashMap<String, String> conditions) throws Exception{
        getConnection();
        
        if(conditions.isEmpty()){
            sql = "SELECT COUNT(*) FROM "+tableName;
            statement = conn.prepareStatement(sql);
            result = statement.executeQuery();
            
        }
        else {
            sql = "SELECT COUNT(*) FROM "+tableName+" WHERE ";
            ArrayList<String> allValues = new ArrayList<>();
            sql = SqlConstructor.construct(sql, conditions, allValues);
            
            try {
                statement = conn.prepareStatement(sql);
                statement = SqlConstructor.setValues(statement, allValues);
                result = statement.executeQuery();
            } catch (Exception ex) {
                Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
                throw new Exception(ex.getMessage());
            }
        
        }
        result.next();
        int counted = result.getInt(1);
        return counted;
    }
    
    /* 
        an overloaded method of count that uses combination of 'or' and 'and' sql query
    */
    
    public static int extendCount(String tableName, HashMap<String, ArrayList<String>> conditions) throws Exception{
        getConnection();
        
        sql = "SELECT COUNT(*) FROM "+tableName+" WHERE ";
        ArrayList<String> allValues = new ArrayList<>();
        sql = SqlConstructor.extendConstruct(sql, conditions, allValues);
        
        try {
            statement = conn.prepareStatement(sql);
            statement = SqlConstructor.setValues(statement, allValues);
            result = statement.executeQuery();
        }catch(Exception ex){
            Logger.getLogger(tableName).log(Level.SEVERE, ex.getMessage(), ex);
            throw new Exception(ex.getMessage());
        }
        
        result.next();
        int counted = result.getInt(1);
        return counted;
    
    }

}

