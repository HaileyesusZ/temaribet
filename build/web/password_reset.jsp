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
        <title>Password Reset</title>
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
                <h3 id="title"> Password Reset Possible Now</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row " id="whole_wrapper">
                   
                    <div class ="col-xs-8 col-xs-offset-3">
                            <h2>We hope you will have better memory next time.</h2>
                            <p class="text-warning" style = 'font-size:20px'>A good password is easy to remember but hard to guess!</p>   
                    </div>
                    <div class ='col-xs-4 col-xs-offset-3'>
                        <form role="form" method="post" action="/Temaribet/Reset-Password">

                            <div class = 'form-group'>
                                <input type="password" class="form-control" placeholder="easy to remember" name="password" required="true">
                                
                            </div>
                            <div class = 'form-group'>
                                <input type="password" class="form-control" placeholder="hard to guess" name="confirmed_password" required="true">
                                <input  type="hidden" name='urid' value='${urid}'/>
                                <input type="hidden" name ='urkey' value='${urkey}'/>
                            </div>
                            <div classs='form-group' style="margin-bottom:15px">
                                <button style = 'border-radius: 0' class='btn btn-danger'> Reset Now</button>
                            </div>
                            <div>
                                <span class="text-danger">${passwordError}</span>
                                <span class="text-danger">${confirmedPasswordError} </span>
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
