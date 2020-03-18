<%-- 
    Document   : exam_result
    Created on : Oct 13, 2016, 7:49:23 AM
    Author     : Henok G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/> 
        <link rel="stylesheet" type="text/css" href="css/exam_result.css"/>     
        <link rel="stylesheet" type="text/css" href="css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/sidebar.css"/>
        <link rel="stylesheet" type="text/css" href="css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>  
    </head>

    <body class="menu">
        <%
            String remainingTime = request.getAttribute("remainingTime").toString();
            String allowedTime = request.getAttribute("allowedTime").toString();
            String materialHeader = request.getAttribute("materialHeader").toString();
            String finalAnswer = request.getAttribute("finalAnswer").toString();
            String correctAnswer = request.getAttribute("correctAnswer").toString();
            int numberOfQuestions = (Integer) request.getAttribute("numberOfQuestions");
            int sitCode = Integer.valueOf(request.getParameter("sit_code"));
            int numberOfTried = numberOfQuestions;
            int answeredCorrect = 0;
            if(request.getAttribute("scr") != null){
               answeredCorrect = (Integer) request.getAttribute("scr");
            }
        %>
        <%@include file="WEB-INF/header.jsp" %>
        <div class="container-fluid">
<%@include file="WEB-INF/sidebar.jsp" %>
            <div class="row" id="main_wrapper">

                <div class="col-xs-12 col-md-offset-1 col-md-6" id="information_wrapper">

                    <table class="table table-striped">
                        <h3><span class="glyphicon glyphicon-stats"></span><%= materialHeader %></h3>  
                        <tbody>

                            <tr>
                                <td>Total Number Of Questions</td>
                                <td><%= numberOfQuestions %></td>
                            </tr>
                            <tr>
                                <td>Allowed Time</td>
                                <td><%= allowedTime %></td>
                            </tr>
                            
                            <% 
                                if(sitCode == 2){   //Means user came from time over
                                    remainingTime = "You Couldn't Finish In Time";
                                    numberOfTried = Integer.valueOf(request.getParameter("tried"));
                                    answeredCorrect = Integer.valueOf(request.getParameter("scr"));
                                }
                            %>
                            
                            <tr>
                                <td>Remaining Time</td>
                                <td><%= remainingTime %></td>
                            </tr>
                            
                            <tr>
                                <td>Tried Questions</td>
                                <td><%= numberOfTried %></td>
                            </tr>
                            
                            <tr>
                                <td>Correct Answers</td>
                                <td><%= answeredCorrect %></td>
                            </tr>                                
                            <tr>
                                <td>Your Final Answer</td>
                                <td><%= finalAnswer %></td>
                            </tr>
                            <tr>
                                <td>The Correct Answers</td>
                                <td><%= correctAnswer %></td>
                            </tr>
                            <tr>
                                <td>Not Tried Questions</td>
                                <td><%= numberOfQuestions - numberOfTried %></td>
                            </tr>

                        </tbody>

                    </table>

                    <div class='row' id="decision_btns_wrapper">
                        <button class="btn btn-default" id="restart_button"><span class="glyphicon glyphicon-repeat"></span> Restart</button>
                        <h5 id="share"><i class="fa fa-facebook"></i> <a id="share">Share my result on facebook</a></h5>
                    </div>

                </div>

                <div class="col-xs-offset-1 col-xs-11 col-md-offset-1 col-md-3" id="material_wrapper">
                    <div class="row" id="opened_materials_wrapper">
                        <h5><b>Materials you opened</b></h5>
                        <h6>English 2005 <a href=""> Open</a></h6>
                        <h6>Biology 2005 <a href=""> Open</a></h6>
                        <h6>Civics and ethical education 2005 <a href=""> Open</a></h6>
                        <h6>Chemistry 2005 <a href=""> Open</a></h6>
                        <h6>Mathematics 2005 <a href=""> Open</a></h6>                        
                    </div>

                    <div class="row" id="recommended_material_wrapper">
                        <h5><b>Recommended materials for you</b></h5>
                        <h6>English 2005 <a href=""> Open</a></h6>
                        <h6>Biology 2005 <a href=""> Open</a></h6>
                        <h6>Civics and ethical education 2005 <a href=""> Open</a></h6>
                        <h6>Chemistry 2005 <a href=""> Open</a></h6>
                        <h6>Mathematics 2005 <a href=""> Open</a></h6>
                    </div>

                    <button class="btn btn-default" id="back_to_dashboard_button"><span class="glyphicon glyphicon-dashboard"></span> Save and go to dashboard</button>

                </div>

            </div>



        </div>    
    </body>

    <script src="js/jquery.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script>
        
        $(".menu-toggle").click(function ()
{
    $("body").toggleClass("menu-open");
    $(this).toggleClass("fa-bars").toggleClass("fa-arrow-left");

});
    </script>
</html>