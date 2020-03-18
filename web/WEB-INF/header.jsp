<%@page import="concreteClasses.User"%>
<%@page import="utilityClasses.ServletOperation"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta name="viewport" content="width = device-width, initial-scale=1.0">

<%
    User user = ServletOperation.getLoggedInUser(request);
    String username = "";
    if (user == null) {  //if user is not logged in %> 

<style>
    .fa-bars, #header_profile_wrapper{
        display: none;
    }
</style>
<%    } else {
        username = user.getFirstName() + " " + user.getLastName();
    } //if logged in   %>

<!-- Header wrapper -->
<div class="row" id="logo_wrapper">
    <div class="col-xs-12 col-sm-8 col-md-10 text-left">
        <h3 id="logo"><i class="fa fa-bars menu-toggle"> </i>
            <span class="static_word" id = "temaribet">TemariBet</span>
        </h3>
    </div>

    <div class="hidden-xs col-sm-4 col-md-2" id="header_profile_wrapper">
        <img class="img img-circle img-responsive pull-left" height="30px" width="30px" id="header_profile_picture"  src="${currentUser.getProfilePicture()}">
        <h5><b> <%= username %> </b></h5>
    </div>
</div>
