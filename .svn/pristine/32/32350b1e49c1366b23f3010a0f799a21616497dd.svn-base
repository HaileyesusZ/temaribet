package concreteClasses;

import interfaces.Persistable;
import java.sql.Date;

public abstract class Material implements Persistable{
    private static final String MATERIALS_PATH = "/materials/";
    
    protected Integer id;
    protected String type;
    protected Integer numberOfQuestions;
    protected Integer year;
    protected Integer subjectId;
    protected String stream;
    protected Integer grade;
    protected String allowedTime;
    protected Date uploadDate;
    protected String path;
    protected Integer uploaderId;
    protected String subjectName;
    
    

    
    public Material(Integer id){
        this.id = id;
    }

    public Material(Integer id,String type , Integer numberOfQuestions , Integer year , Integer subjectId , String stream , Integer grade, String subjectName, String allowedTime, Date uploadDate, String path , Integer uploaderId)
    {
        this.id = id;
        this.type = type;
        this.numberOfQuestions = numberOfQuestions;
        this.year = year;
        this.subjectId = subjectId;
        this.stream = stream;
        this.grade = grade;
        this.allowedTime = allowedTime;
        this.uploadDate = uploadDate;
        this.path = path;
        this.uploaderId = uploaderId;
        this.subjectName = subjectName;
    }

    public Integer getId(){
        return this.id;
    }
    public Integer getUploaderId() {
        return uploaderId;
    }

    public String getType() {
        return type;
    }

    public String getPath() {
        return path;
    }
    
    public Integer getNumberOfQuestions() {
        return numberOfQuestions;
    }


    public Integer getYear() {
        return year;
    }

    public Integer getSubjectId() {
        return subjectId;
    }



    public String getStream() {
        return stream;
    }


    public Integer getGrade() {
        return grade;
    }
    
    public String getAllowedTime() {
        return allowedTime;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public Date getUploadDate() {
        return uploadDate;
    }
    

}
