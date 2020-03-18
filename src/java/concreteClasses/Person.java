package concreteClasses;

import interfaces.Persistable;
import java.sql.Date;

public abstract class Person implements Persistable{    
    protected Integer id;
    protected String firstName;
    protected String lastName;
    protected Character sex;
    protected String email;
    protected String password;
    protected String profilePicture;
    protected Integer schoolId;
    protected String phoneNummber;
    protected Date registerDate;

    public Person(Integer id, String firstName, String lastName, Character sex, String email , String password, String profilePicture, Integer schoolId, String phoneNumber, Date registerDate)
    {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex  = sex;
        this.email = email;
        this.password = password;
        this.profilePicture = profilePicture;
        this.schoolId = schoolId;
        this.phoneNummber = phoneNumber;
        this.registerDate = registerDate;
    }
    
    
    public Date getRegisterDate() {
        return registerDate;
    }
    
    public Integer getId() {
        return id;
    }
    
    public String getPhoneNummber() {
        return phoneNummber;
    }

    public void setPhoneNummber(String phoneNummber) {
        this.phoneNummber = phoneNummber;
    }
    
    public Integer getSchool() {
        return schoolId;
    }

    public void setSchool(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() throws Exception{
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }
    
    public Character getSex()
    {
        return this.sex;
    }
    
    public void setSex(Character sex)
    {
        this.sex = sex;
    }
    
    public Integer getSchoolId() {
        return this.schoolId;
    }
}