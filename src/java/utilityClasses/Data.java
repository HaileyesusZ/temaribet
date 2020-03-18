/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilityClasses;

/**
 *
 * @author haileyesus
 */
public class Data {
    // the number of materials to display at a single time
    public static final int MATERIALS_TO_SHOW_AT_ONCE = 10;
    // data related to input validation
    public static final String EMAIL_REGEX = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
    public static final String NAME_REGEX = "^[a-z]{1,}$";
    public static final int PASSWORD_LENGTH = 6;
    // the length of expiration for emails  
    public static final long EXPIRATION_LENGTH = 24*3600*1000;
    
    
}
