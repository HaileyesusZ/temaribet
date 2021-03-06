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
        <title>Sign up</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="./css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="./css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/signup_style.css"/>
        <style>

            *
            {
                margin:0;
                padding:0;
            }

        </style>
    </head>
    
    <%
        Character sex = (Character) request.getAttribute("sex");
        Integer grade = (Integer) request.getAttribute("realGrade");
        String stream = (String) request.getAttribute("stream");
    %>
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
                <h3 id="title">Registration form</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row" id="whole_wrapper">
                    <form role="form" method="post" action="/Temaribet/Sign-up">
                    <label>Choose your avatar : </label><br/>
                        <div class ="col-sm-5 col-md-4 main_wrappers" id="profile_picture_wrapper">

                            <input type="radio" id="avatar1" name="avatar" value="avatar_1" checked/>
                            <label for="avatar1"><img src="/Temaribet/images/avatars/avatar_1.png"/></label>
                            <input type="radio" id="avatar2" name="avatar"  value="avatar_2"/>
                            <label for="avatar2"><img src="/Temaribet/images/avatars/avatar_2.png"/></label>
                            <input type="radio" id="avatar3" name="avatar"  value="avatar_3"/>
                            <label for="avatar3"><img src="/Temaribet/images/avatars/avatar_3.png"></label>
                            <input type="radio" id="avatar4" name="avatar" value="avatar_4"/>
                            <label for="avatar4"><img src="/Temaribet/images/avatars/avatar_4.png" /></label>
                            <input type="radio" id="avatar5" name="avatar" value="avatar_5"/>
                            <label for="avatar5"><img src="/Temaribet/images/avatars/avatar_5.png" /></label>
                            <input type="radio" id="avatar6" name="avatar" value="avatar_6"/>
                            <label for="avatar6"><img src="/Temaribet/images/avatars/avatar_6.png" /></label>
                            <input type="radio" id="avatar7" name="avatar" value="avatar_7"/>
                            <label for="avatar7"><img src="/Temaribet/images/avatars/avatar_7.png" /></label>
                            <input type="radio" id="avatar8" name="avatar" value="avatar_8"/>
                            <label for="avatar8"><img src="/Temaribet/images/avatars/avatar_8.png" /></label>
                            <input type="radio" id="avatar9" name="avatar" value="avatar_9"/>
                            <label for="avatar9"><img src="/Temaribet/images/avatars/avatar_9.png" /></label>
                            
                            <p class="help-block">${weirdAvatarChoice}</p>
                              
                        </div>

                        <div class ="form_wrapper col-sm-6 col-md-7 ">
                            <div class="row form-group form-inline has-feedback ">
                                <div class="col-md-2">
                                    <label class = "control-label">Name:</label>
                                </div>  
                                <div class="col-md-10">
                                    <input type="text" class="form-group form-control" id="first_name" name="first_name" placeholder="First name" required="true" value="${firstName}">
                                    <input type="text" class="form-group form-control" id="last_name" name="last_name" placeholder = "Last name" required="true" value="${lastName}">
                                    <p class = "help-block">${firstNameError}<br/> ${lastNameError}</p>
                                </div>  

                            </div>
                            <div class="row form-group form-inline has-feedback ">

                                <div class="col-md-2">
                                    <label class ="label-control" for="sex">Sex: </label>
                                </div>
                                <div class="col-md-10">
                                    <select class="form-control" name="sex" >
                                        <option >M</option>
                                        <option <% if(sex != null && sex.equals('F')) { %> <%="selected"%> <% } %> >F</option>
                                    </select>
                                    <p class = "help-block">${sexError}</p>
                                </div>
                            </div>
                            <div class="row form-group form-inline has-feedback ">

                                <div class="col-md-2">
                                    <label class ="label-control" for="email">Email:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="email" class="form-group form-control" id="email" name="email" placeholder="Email" required="true" value="${email}">
                                    <p class = " help-block"> ${emailError}</p>
                                </div>
                            </div>
                            <div class="row form-group form-inline has-feedback ">
                                <div class="col-md-2">
                                    <label class ="label-control" for="password">Password:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="password" class="form-control" id="password" name = "password" placeholder="Password"  required="true" minLength="6">
                                    <input type="password" class="form-control" id="password_confirmation" name = "password_confirmation" placeholder="Re-enter password" minLength="6" required="true">
                                    <p class="help-block">${passwordError} ${confirmedPasswordError}</p>
                                </div>
                            </div>
                            <div class="row form-group form-inline ">

                                <div class="col-md-2">
                                    <label class = "label-control" for="grade">Grade:</label>
                                </div>
                                <div class="col-md-10 row">
                                    <div class ="col-md-3">
                                        <select class="form-control form-group" id="grade" name="grade">
                                            <option >9</option>
                                            <option <% if(grade != null && grade == 10) { %> <%="selected"%> <% } %> >10</option>
                                            <option <% if(grade != null && grade == 11) { %> <%="selected"%> <% } %> >11</option>
                                            <option <% if(grade != null && grade == 12) { %> <%="selected"%> <% } %> >12</option>
                                        </select>
                                        <p class = "help-block">${gradeError} ${gradeDeceptionError}</p>
                                    </div>
                                    <div class="col-md-2">
                                        <label class = "label-control" for="stream">Stream:</label>
                                    </div>
                                    <div class="col-md-7 text-left">
                                        <select <% if(grade == null || (grade == 9 || grade == 10)) { %> <%="disabled"%> <% } %> class="form-control form-group" id="stream" name="stream">
                                            <option value = "Social" >Social science</option>
                                            <option value = "Natural" <% if(stream != null && stream.equals("Natural")) { %> <%="selected"%> <% } %> >Natural science</option>
                                        </select> 
                                        <p class = "help-block">${invalidStreamError} ${mustChooseStreamError}</p>
                                    </div>
                                </div>   


                            </div>

                            <hr/> 
                            <div class="pull-right  ">
                                <div class="checkbox">
                                    <label><input name = "terms" type="checkbox" id="agreement_confirmation" unchecked>I have read and accepted the <a href="#">terms and conditions</a></label>
                                    <div class="">
                                        <p class = " help-block">${termsError}</p>
                                    </div>
                                    
                                </div>
                                <button type="submit" class="btn btn-lg btn-success" disabled>Register</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <%@include file = "./WEB-INF/footer.jsp" %>
        <script src="js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/signup.js"></script>


    </body>

</html>
