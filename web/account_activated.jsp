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
        <title>Account Activation</title>
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
                <h3 id="title">Successful Account activation</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row" id="whole_wrapper">
                    <div class ="form_wrapper col-sm-12">
                           
                        <img class="img img-circle img-responsive icon" src="${avatar}" />
                        <h3>Well done <b> ${firstName}</b>, Temaribet is, now, yours.</h3>
                        <h3>Go to your <a href="/Temaribet/Dashboard" style='text-decoration: none'>Dashboard</a></h3>

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
