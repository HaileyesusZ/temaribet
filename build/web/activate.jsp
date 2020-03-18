<%-- 
    Document   : index
    Created on : Mar 3, 2016, 5:38:48 PM
    Author     : Mikias
--%>

<%@page import="utilityClasses.ServletOperation"%>
<%@page import="concreteClasses.InactiveUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilityClasses.EmailSender"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width = device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Activate account</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="./css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="./css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/activate_style.css"/>
        <style>

            *
            {
                margin:0;
                padding:0;
            }

        </style>
    </head>
    
    <body>
        <!-- Wrapper for the whole page -->
        <div class="container-fluid">

            <!-- Header wrapper -->
            
            <!-- Header wrapper -->
            <div class="row" id="logo_wrapper">
                <div class="col-xs-9 text-left">
                    <h3 id="logo" class="">TemariBet</h3>
                </div>
            </div>

            <div class="row title_wrapper">
                <h3 id="title">Account Activation</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row" id="whole_wrapper">
                    <div class ="form_wrapper col-sm-12">
                            
                            <% 
                                String emailExistsError = (String) request.getAttribute("emailExistsError");
                                String unactivatedEmailUsageError = (String) request.getAttribute("unactivatedEmailUsageError");
                                
                                %>
                                    <img class="img img-circle img-responsive icon" src="${avatar}" />
                                <%
                                if(emailExistsError == null && unactivatedEmailUsageError == null) {
                                    %>
                                        
                                        <h2>Almost there ${firstName}, Now, Activate your account</h2>
                                        <h4>A link has been sent to <b>${email}</b>, Please check your email and follow the link to 
                                            activate your TemariBet account.</h4>
                                    <%
                                }else if(unactivatedEmailUsageError != null){
                                    String email = (String) request.getAttribute("email");
                                    Integer userId = (Integer) request.getAttribute("userId");
                                    /*
                                        update to new hash values in the database and resend activation link
                                    */
                                    String[] hashedData = ServletOperation.setupEmailActivation(userId);

                                    EmailSender.sendEmailActivation(new String[] {email, hashedData[0], hashedData[1]});
                                    
                                    %>
                                       
                                        <h2>${unactivatedEmailUsageError}</h2>
                                        <h4>An activation link was sent to <b>${email}</b>, But if haven't received it yet, don't worry.
                                        </h4>
                                            <h4 class="text-info"> A new activation link has been sent. Now check again.</h4>
                                    <%
                               }
                            %>
                          
                        </div>
                </div>
            </div>
        </div>


        <%@include file = "./WEB-INF/footer.jsp" %>
        <script src="js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/activate.js"></script>


    </body>

</html>
