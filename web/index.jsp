<%-- 
    Document   : index
    Created on : Mar 3, 2016, 5:38:48 PM
    Author     : Mikias
--%>

<%@page import="utilityClasses.ServletOperation"%>
<%@page import="concreteClasses.RememberedUser"%>
<%@page import="concreteClasses.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="utilityClasses.DashboardHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
//        Integer userId = DashboardHelper.getRememberedUser(request, response);
//        try {
//            if(userId != null) {
//            HashMap<String,String> condition = new HashMap<>();
//            condition.put("id", String.valueOf(userId));
//            User toLogin = User.fetch(condition).get(0);
//            session.setAttribute("currentUser", toLogin);
//            response.sendRedirect("/Temaribet/Dashboard");
//        }
//        }catch(Exception ex){
//            // do something
//        }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TemariBet</title>

        <meta name="viewport" content="width = device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="./css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="./css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="./css/homepage_style.css"/>

        <style>

            body
            {
                margin:0;
                padding:0;
            }


        </style>

    </head>
    <body>
        

        <!-- loading indicator for queries -->
        <div class="loading_indicator_wrapper text-center">
            <img class="loading_indicator" src="images/ajax-loader.gif"/>
        </div>
        <!-- Multi-purpose modal window -->
        <div class="modal fade feedback_modal">
            <div class="modal-dialog">
                <div class="modal-content text-center">
                    <div class="modal-title">
                        <h2></h2>
                        <br>
                    </div>
                </div>
            </div>
        </div>  


        <!-- Wrapper for the whole page -->
        <div class="container-fluid">
            
            <div class="row text-center" id="top">
                <div class="row" id="top_wrapper">
                   
                    <div class="col-md-5 text-right"><h1 id="title">TemariBet</h1>
                        <h5>From Any Place, Any Time, and Any Device</strong> </h5>
                        <button class="btn btn-lg btn-warning" id="guest_button">Proceed as a guest</button>
                    </div>

                    <div class="col-md-4">
                        <h4><mark class="text-danger bg-error pull-left">${noSuchUserError}${loginError}</mark></h4>
                        <form role="form" method="post" action="Sign-in">                            
                            <div class="form-group  has-feedback">
                                <h4><mark class="text-danger bg-error pull-left">${emailError}</mark></h4>
                                <!--<p class = "hidden help-block">Invalid e-mail format</p>-->                              
                                <input type="email" class="form-control" placeholder="User name" name="email" required="true" value="${email}">
                                <!--<span class="form-control-feedback glyphicon"></span>-->
                            </div>
                            <div class="form-group has-feedback">
                                <h4><mark class="text-danger bg-error pull-left">${passwordError}</mark></h4>
                                <input type="password" class = "form-control" placeholder="Password" name="password" required="true" minlength="6">
                                <!--<p class = "hidden help-block">Password too short</p>-->
                                <!--<span class="form-control-feedback glyphicon"></span>-->
                            </div>


                            <div id = "user_options" class="row">

                                <div class="col-md-6 text-left">
                                    <div>
                                        <label for = "remember me">
                                            <input type ="checkbox" id = "remember_me" name="rememberMe"/>
                                            Remember Me (This is my private computer)
                                        </label>
                                    </div>
                                    <a href="/Temaribet/Forgot-Password" id="forget_password">Forget password</a><br>
                                    <a href="Sign-up" id="create_new_link">Create new account</a>
                                </div>
                                <div class="col-md-6 text-right">
                                    <button type="submit" id="submit_button" class="btn btn-lg">Sign in</button>
                                </div>


                            </div>

                        </form>
                    </div>


                </div>
            </div> 

            <div class="row" id="filter_wrapper">

                <div class="row text-left">
                    <button class="btn btn-sm btn-warning" id="back_to_home_button"><span class="glyphicon glyphicon-home"></span></button>
                </div>
                <!-- Filter form wrapper -->
                <div class="col-md-3" id="filter_form_wrapper">
                    <form id="filter_form">
                        <h4 id="filter_header"><span class="glyphicon glyphicon-filter"> </span>   Advanced filter </h4>
                        <div class ="form-group">
                            <select id = "level" name = "level" class="form-control">
                                <option>HighSchool</option>
                                <option>Preparatory</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <select id = "stream" name = "stream" class ="form-control" disabled>
                                <option selected>Natural Science</option>
                                <option>Social Science</option>
                            </select>
                        </div>
                        <div class ="form-group">
                            <select name = "exam_type" class="form-control">
                                <option value = "any">Any Exam Type</option>
                                <option>Matric</option>

                            </select>
                        </div>
                        <div class ="form-group">
                            <select name = "year" class="form-control">
                                <option value = "any">Any Year</option>
                                <option>2007</option>
                                <option>2008</option>
                            </select>
                        </div>
                        <div class ="form-group">
                            <select id = "subject" name="subject"class="form-control">
                                <option value="0">Any Subject</option>
                                <option value="3">Amharic</option>
                                <option value="5">Biology</option>
                                <option value="4">Civic</option>
                                <option value="6">Chemistry</option>
                                <option value="1">English</option>
                                <option value="2">Maths</option>
                                <option value="7">Physics</option>
                                <option value="9">History</option>
                                <option value="10">Geography</option>
                            </select>   
                        </div>

                        <div class="form-group">
                            <button class="btn col-xs-offset-5 col-xs-7 enhanced_border" id ="filter_button">Filter</button>
                        </div>    
                    </form>    

                </div>



                <!-- Categories wrapper -->
                <div class="col-md-8 col-md-offset-1">
                    <!--     filter results wrapper   -->


                    <div class="table-responsive" id="filter_results_wrapper">                  
                        <h4 id="filter_header"><span class="glyphicon glyphicon-ok"> </span>   Matching materials</h4>
                        <div class="content">
                            <table class="table table-hover table-striped filter_results">
                                <caption><span class="badge"> </span> Total  Materials match your search</caption>
                                <tr>
                                    <th>No.</th>
                                    <th>Subject</th>
                                    <th>Exam type</th>
                                    <th>Year</th>
                                    <th>Number of questions</th>
                                    <th>Actions</th>
                                </tr>
                            </table>
                        </div>                    
                        <hr/>
                    </div>
                    <div class = "text-center">
                        <ul class = "pagination" id="materials_navigation">

                        </ul>
                    </div>

                </div>

            </div>

            <div class="row features text-center">

                <div class="row">
                    <div class="col-md-offset-1">
                        <img class="img img-responsive center-block circle_icon pull-left"  src="./images/matric.png"/>
                    </div>
                    <div class="description text-center col-md-offset-1 col-md-7">
                        <h2>Matric questions</h2>
                        <h4 class="text-left">Matric questions of recent years are on your hands now!
                            you don't need to carry all sheets with you we give you want you need 
                            just sign up and go for it Welcome to Adobe Creative Suite 5 Master Collection. This document contains late-breaking product information, updates, 
                            and troubleshooting tips not covered in the Master Collection documentation
                        </h4>

                    </div>
                </div>
                <button class="start_now_button btn btn-lg">Start now</button>

            </div>

            <div class="row features text-center">

                <div class="row">
                    <div class="description col-md-offset-1 col-md-7">
                        <h2>Model questions</h2>
                        <h4 class="text-left">Model questions of recent years are on your hands now!
                            you don't need to carry all sheets with you we give you want you need 
                            just sign up and go for it ll sheets with you we give you want you need 
                            just sign up and go for it Welcome to Adobe Creative Suite 5 Master Collection. This document contains late-breaking product information, updates,
                        </h4>                            
                    </div>
                    <div class="col-md-offset-1">
                        <img class="img img-responsive circle_icon"  src="./images/model.png"/>
                    </div>
                </div>
                <button class="start_now_button btn btn-lg">Start now</button>
            </div>

            <div class="row features text-center">

                <div class="row">
                    <div class="col-md-offset-1">
                        <img class="img img-responsive center-block circle_icon pull-left"  src="./images/progressIcon.png"/>
                    </div>
                    <div class="description text-center col-md-offset-1 col-md-7">
                        <h2>Keep track of your progress</h2>
                        <h4 class="text-left">Matric questions of recent years are on your hands now!
                            you don't need to carry all sheets with you we give you want you need 
                            just sign up and go for it Welcome to Adobe Creative Suite 5 Master Collection. This document contains late-breaking product information, updates, 
                            and troubleshooting tips not covered in the Master Collection documentation
                        </h4>

                    </div>
                </div>
                <button class="start_now_button btn btn-lg">Start now</button>
            </div>
            <%@include file = "./WEB-INF/footer.jsp" %>
        </div>
        <script src="js/jquery.js"></script>
        <script src="js/homescreen.js"></script>
        <script src="./bootstrap/js/bootstrap.min.js"></script>
    </body>

</html>
