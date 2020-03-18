<%-- 
    Document   : sidebar
    Created on : Oct 12, 2016, 10:44:45 AM
    Author     : Henok G
--%>

<%@page import="concreteClasses.User"%>
<%@page import="utilityClasses.ServletOperation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
                User currentUser = ServletOperation.getLoggedInUser(request);
                String stream = currentUser.getStream();
                int grade = currentUser.getGrade();
                if (grade == 9 || grade == 10) {
                    stream = "High School";
                }
            %>
<div class="menu-side">
    <div class="text-center" id="sidebar_profile_wrapper">
        <img class="img img-circle img-responsive" id="sidebar_profile_picture" src="${currentUser.getProfilePicture()}">
        <h5 class="text-uppercase" style="font-family: 'roboto'">${currentUser.getFirstName()} ${currentUser.getLastName()}</h5>
        <h6 style="font-weight: bold">Grade ${currentUser.getGrade()} , 
            
            <%=stream%>
        </h6>
        <br/>

    </div>
    <ul id="sidebar_ul">
        <a href="/Temaribet/Dashboard"><li class="active"><span class="glyphicon glyphicon-dashboard"> </span> Dashboard </li></a>
        <a href="/Temaribet/EditProfile"><li><span class="glyphicon glyphicon-cog"> </span> Account Details </li></a>
        <li><span class="glyphicon glyphicon-question-sign"> </span> Help </li>
        <a href="/Temaribet/SignOut" id="sign_out">
            <span class="glyphicon glyphicon-off"> </span> Sign Out 
        </a> 
    </ul>
</div>
