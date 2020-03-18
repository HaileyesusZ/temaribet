<%-- 
    Document   : index
    Created on : Mar 3, 2016, 5:38:48 PM
    Author     : Mikias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width = device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
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
                <h3 id="title"> Password Reset Assistance</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row " id="whole_wrapper">
                   
                    <div class ="col-xs-4 col-xs-offset-4 form_wrapper">
                            <h2>Don't Worry! It happens.</h2>
                            <p class="text-warning" style = 'font-size:20px'>Type your email below and click reset</p>   
                    </div>
                    <div class ='col-xs-5 col-xs-offset-4'>
                        <form role="form" method="post" action="/Temaribet/Forgot-Password">

                            <div class = 'input-group '>
                                <input type="" class="form-control" placeholder="someone@somewhere.com" name="email" required="true">
                                <span class="input-group-btn"><button type = 'submit' class="btn btn-danger">reset</button></span>
                            </div>

                        </form>
                        <div style ='margin-top:10px'>
                            <span style ='font-size:18px' class="text-danger">${emailError}</span>
                        </div>
                        
                    </div>
                    
                </div>
            </div>
        </div>


        <%@include file = "./WEB-INF/footer.jsp" %>
        
    </body>

</html>
