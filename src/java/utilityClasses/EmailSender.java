/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilityClasses;

import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author Haileyesus Z
 */
public class EmailSender {
    
    // configuration properties
    private static final String SMTPHOST = "localhost";
    private static final String SMTPUSER = "haile@gmail.com";
    private static final String SMTPPASSWORD = "haile";
    private static final String SMTPPORT = "25";
   
            
    
    
    /*
        sends an email
    */
    private static void sendEmail(String [] emailDetails) throws Exception {
        // configure system properties and session
        Properties props = System.getProperties();
        Session session = Session.getInstance(props,null);
        MimeMessage message = new MimeMessage(session);
        
        // setup smtp server settings like port and authentication
        
        //props.put("mail.smtp.starttls.enable", true); 
        //props.put("mail.smtp.ssl.trust", SMTPHOST);
        props.put("mail.smtp.host", SMTPHOST);
        //props.put("mail.smtp.user", SMTPUSER);
        //props.put("mail.smtp.password", SMTPPASSWORD);
        props.put("mail.smtp.port", SMTPPORT);
        props.put("mail.smtp.auth", true);
        
        
        InternetAddress from = new InternetAddress(SMTPUSER);
        message.addRecipients(Message.RecipientType.TO, "haileyesus@localhost");
        message.setSubject(emailDetails[1]);
        message.setFrom(from);

        // Create a multi-part to combine the parts
        Multipart multipart = new MimeMultipart("alternative");
        
        // Create the message body
        BodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(emailDetails[2], "text/html");


        // Add html part to multi part
        multipart.addBodyPart(messageBodyPart);

        // Associate multi-part with message
        message.setContent(multipart);

        // Send message
        Transport transport = session.getTransport("smtp");
        try {
            transport.connect(SMTPHOST, SMTPUSER, SMTPPASSWORD);

            transport.sendMessage(message, message.getAllRecipients());
            System.out.println("SUCCESS!!!!");
        }catch(Exception ex){
            System.out.println(" check email info \n" + ex.getMessage());
        }
    }
    
    public static void sendEmailActivation( String [] recepientInfo) throws Exception{
        // message properties
        final String EMAIL_ACTIVATION_SUBJECT = "Temaribet - Email Activation";
        final String EMAIL_ACTIVATION_CONTENT= "<div style = 'font-family:Calibri;background-color:#f8f8f8; padding:40px'> <div style='box-shadow:2px 2px 1px #ccc;background-color:white; padding:20px'>"
                                                         + "<h2> Temaribet - Your virtual tutor </h2>"
                                                         + "<p> You just used this email for signing up and requested an activation link to complete the process</p> "
                                                         + "<p> If it wasn't you, Please make sure nobody else uses this Email address. </p> <p> Notice: This link expires in 24 hours </p>"
                                                         + " <a style='text-decoration:none; opacity:.65;padding:20px 26px; font-size:18px; line-height:1.3333333; color:white; background-color:#5cb85c; border-color:#5cb85c; display:inline-block;'"
                                                         + " href='http://localhost:8080/Temaribet/Account-Activation?uaid=" + URLEncoder.encode(recepientInfo[1],"UTF-8") + "&uakey=" + URLEncoder.encode(recepientInfo[2],"UTF-8") +"' > Activate Now </a>"
                                                         + " </div></div>";
        
        sendEmail(new String [] {recepientInfo[0], EMAIL_ACTIVATION_SUBJECT, EMAIL_ACTIVATION_CONTENT});

    }
    
   public static void sendPasswordResetLink( String [] recepientInfo) throws Exception{
        // message properties
        final String EMAIL_ACTIVATION_SUBJECT = "Temaribet - Password Reset Link";
        final String EMAIL_ACTIVATION_CONTENT= "<div style = 'font-family:Calibri;background-color:#f8f8f8; padding:40px'> <div style='box-shadow:2px 2px 1px #ccc;background-color:white; padding:20px'>"
                                                         + "<h2> Temaribet - Your virtual tutor </h2>"
                                                         + "<p> You just said you forgot your password, and requested a password reset link for this email address</p> "
                                                         + "<p> If it wasn't you, Please make sure nobody else uses this Email address. </p> <p> Notice: This link expires in 24 hours </p>"
                                                         + " <a style='text-decoration:none; opacity:.65;padding:20px 26px; font-size:18px; line-height:1.3333333; color:white; background-color:#d9534f; border-color:#5cb85c; display:inline-block;'"
                                                         + " href='http://localhost:8084/Temaribet/Reset-Password?urid=" + URLEncoder.encode(recepientInfo[1],"UTF-8") + "&urkey=" + URLEncoder.encode(recepientInfo[2],"UTF-8") +"' > Reset Now </a>"
                                                         + " </div></div>";
        
        sendEmail(new String [] {recepientInfo[0], EMAIL_ACTIVATION_SUBJECT, EMAIL_ACTIVATION_CONTENT});

    }
}
