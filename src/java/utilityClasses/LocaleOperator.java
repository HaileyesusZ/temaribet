/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilityClasses;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.net.URL;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
/**
 *
 * @author haileyesus
 */
public  class LocaleOperator {

    public static JSONObject loadLocale(String path){
        JSONParser parser = new JSONParser();
        
        try {
            Object obj = parser.parse(new FileReader(path));
            
            return (JSONObject) obj;
        }catch(IOException | ParseException ex){
            return null;
        }
    }
}
