/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilityClasses;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author haileyesus
 */
public class SqlConstructor {
    
    
    public static String construct(String sql, int numberOfIteration) throws Exception{
         
        for (int i=1; i<=numberOfIteration; i++) {
            if(i == numberOfIteration){
                sql += "?)";
                break;
            }
            sql += "?, ";
        }
        
        return sql;
    }
    
    public static String construct(String sql, HashMap<String,String> conditions, ArrayList<String> possibleValues) throws Exception {
        return construct(sql, conditions, possibleValues, "AND");
    }
    
    /*
    
    */
    public static String construct(String sql, HashMap<String,String> conditions, ArrayList<String> possibleValues,String logicalCondition) throws Exception{
        
        int count = 1;
        
        if(sql.startsWith("UPDATE")){
            logicalCondition = ", ";
        }
            
        
        for (Map.Entry<String, String> entrySet : conditions.entrySet()) {
            // add possible values to a single arraylist
            possibleValues.add(entrySet.getValue());
            
            String key = entrySet.getKey();
            
            if(count == conditions.size()){
                sql += key+"=?";
                break;
            }
            sql += key +"=? "+ logicalCondition + " ";
            count++;
        }
        
        return sql;
    }
    
    public static String addMoreOptionsToSql(String sql, String [] moreOptions) throws Exception {
        // add options in the last section of sql query
        if(moreOptions != null){
            if(moreOptions[0] != null){
                sql += " ORDER BY " + moreOptions[0];
            }

            if(moreOptions[1] != null){
                sql += " "+ moreOptions[1] + " ";
            }

            sql += " Limit " + moreOptions[2] + " , " + moreOptions[3];
        }

        return sql;

    }
    
    /*
    
    */
    
    public static String extendConstruct(String sql, HashMap<String, ArrayList<String>> conditions, ArrayList<String> allPossibleValues) throws Exception{
       
        int containerHashMapkeyCounter = 1;
        
        // construct a query with 'And' and 'Or'
        for(Map.Entry<String, ArrayList<String>> entrySet : conditions.entrySet()){
            String key = entrySet.getKey();
            
            ArrayList<String> valuesList = entrySet.getValue();

            if(containerHashMapkeyCounter ==1 ){
                sql += " (" + key + "= ";
            }
            else {
                sql += " AND (" + key + "= ";
            }
            for(int i=0; i<valuesList.size(); i++){
                
                // add all values to a single arraylist for preparing the query later on.
                allPossibleValues.add(valuesList.get(i));
                
                if(i==0){
                    sql += "?";
                    continue;
                }
                sql += " or " + key + "= ?";
                
            }
            
            
            sql += " )";
            
            containerHashMapkeyCounter ++;
        }
        
        return sql;
    }
    
    /*
    
    */
    public static PreparedStatement setValues(PreparedStatement statement, Collection<Object> values) throws SQLException{
        int count = 1;
        
        for(Object value : values){
            if(value == null){
                statement.setNull(count, Types.NULL);
                count ++;
                continue;
            }
            statement.setString(count, String.valueOf(value));
            count ++;
        }

        return statement;
    }
    
    /*
    
    */
    public static PreparedStatement setValues(PreparedStatement statement, ArrayList<String> values) throws Exception {
        int count = 1;
        
        for(String value : values){
            
            statement.setString(count, value);
            count ++;
        }

        return statement;
        
    }
}
