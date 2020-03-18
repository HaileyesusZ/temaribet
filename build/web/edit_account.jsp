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
        <title>Edit account</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>
        <link rel="stylesheet" type="text/css" href="./css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/sidebar.css"/>
        <link rel="stylesheet" type="text/css" href="./css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/edit_account.css"/>
        <style>

            *
            {
                margin:0;
                padding:0;
            }

        </style>
    </head>
    
    <%
        User loggedUser = ServletOperation.getLoggedInUser(request);
        Character sex = (Character) loggedUser.getSex();
        Integer userGrade = (Integer) loggedUser.getGrade();
        String userStream = (String) loggedUser.getStream();
    %>
    <body class="menu">           
        <%@include file="./WEB-INF/header.jsp" %>
        <!-- Wrapper for the whole page -->
        <div class="container-fluid">
<%@include file="WEB-INF/sidebar.jsp" %>
            <div class="row title_wrapper">
                <h3 id="title">Edit account</h3>
            </div>

            <!-- Contains short description and sign in form-->
            <div class="row" id="hero_container_wrapper_for_signup">

                <div class="row" id="whole_wrapper">
                    <div class="row static_values">
                        <div class="col-md-1">
                            <img class="profile_picture" src="${currentUser.getProfilePicture()}">
                        </div>
                        <div class="col-md-3">
                            
                            <div class="row">
<!--                                <div class="col-xs-1">
                                    <label class="control-label">Name: </label>
                                </div>-->
                                <div class="col-sm-11">
                                    <p class="form-control-static"><%= user.getFirstName()+" "+user.getLastName() %></p>
                                </div>
                            </div>
                            <div class="row">
<!--                                <div class="col-xs-1">
                                    <label class="control-label">Sex </label>
                                </div>-->
                                <div class="col-sm-11">
                                    <p class="form-control-static">Grade <%= user.getGrade()%></p>
                                </div>
                            </div>
                            
                            <div class="row">
<!--                                <div class="col-xs-1">
                                    <label class="control-label">E-mail </label>
                                </div>-->
                                <div class="col-sm-11">
                                    <p class="form-control-static"><%= user.getEmail() %></p>
                                </div>
                            </div>
                             
                        </div>
                        <div class="col-md-7 col-xs-12">
                                    <h2>Why we should know you</h2>
                                    <p>By providing your grade level and stream, you help us bring you the materials you need right to your dashboard even before you ask for them.
                                    We only use your phone number to stay in touch and collect your feedback.</p>
                        </div>
                        
                       
                    </div><hr>
                    
                    <form role="form" method="POST" action="/Temaribet/EditProfile">
                    <label>Change your avatar : </label><br/>
                        <div class ="col-sm-4 col-md-3 main_wrappers" id="profile_picture_wrapper">

                            <input type="radio" id="avatar1" name="avatar" value="avatar_1"/>
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
                            
                              
                        </div>

                        <div class ="form_wrapper col-sm-6 col-md-7 col-md-offset-1">
                            
                            <div class="row form-group form-inline has-feedback">
                                <div class="col-md-2">
                                    <label class ="label-control" for="password">Password:</label>
                                </div>
                                <div class="col-md-10">
                                    <input type="password" class="form-control new" id="password" name = "password" placeholder="New Password">
                                    <input type="password" class="form-control new" id="password_confirmation" name = "password_confirmation" placeholder="Re-enter new password">
                                    <p class="hidden help-block">Passwords must be at least 6 digits and match each other.</p>
                                </div>
                                
                            </div>
                            <div class="row form-group form-inline">

                                <div class="col-md-2">
                                    <label class = "label-control" for="grade">Grade:</label>
                                </div>
                                <div class="col-md-10 row">
                                    <div class ="col-md-3">
                                        <select class="form-control form-group" id="grade" name="grade">
                                            <option >9</option>
                                            <option <% if(userGrade != null && userGrade == 10) { %> <%="selected"%> <% } %> >10</option>
                                            <option <% if(userGrade != null && userGrade == 11) { %> <%="selected"%> <% } %> >11</option>
                                            <option <% if(userGrade != null && userGrade == 12) { %> <%="selected"%> <% } %> >12</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label class = "label-control" for="stream">Stream:</label>
                                    </div>
                                    <div class="col-md-7 text-left">
                                        <select <% if(userGrade == null || (userGrade == 9 || userGrade == 10)) { %> <%="disabled"%> <% } %> class="form-control form-group" id="stream" name="stream">
                                            <option value = "Social" >Social science</option>
                                            <option value = "Natural" <% if(userStream != null && userStream.equals("Natural")) { %> <%="selected"%> <% } %> >Natural science</option>

                                        </select> 
                                    </div>
                                </div>   


                            </div>

                            <hr/>
                                <div class="row form-group form-inline has-feedback phone_wrapper">
                                    <div class="col-md-2">
                                        <label class ="label-control" for="password">Phone .no :</label>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="input-group">
                                            <span class="input-group-addon">09</span>                                        
                                            <input type="tel" class="form-control" id="phone" name = "phone_number" placeholder="Not set" minLength="8" maxlength="8" value="${oldCellNumber}">                                       
                                        </div>
                                        <p class="hidden help-block">Phone number must be at least 10 digits.</p>
                                    </div>
                                    
                                </div>
                            <hr/>
                            <div class="row save_wrapper">
                                  
                                <div class="col-sm-8 current_password">     
                                    <p>Enter your current password to save changes</p> 
                                    <div class="input-group">
                                        <span class="input-group-addon glyphicon glyphicon-floppy-disk"></span>
                                        <input class="form-control" name="old_password" type="password" placeholder="Current password">
                                        <span class="input-group-btn">
                                            <button type="submit" class="btn btn-success">Save changes</button>
                                            
                                        </span>                                        
                                    </div>
                                    
                                </div>
                                <div class="col-sm-2">
                                    
                                </div>                            
                                
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <%@include file = "./WEB-INF/footer.jsp" %>
        <script src="js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/edit_account.js"></script>
        <script src="js/sidebar.js"></script>    

    </body>
</html>