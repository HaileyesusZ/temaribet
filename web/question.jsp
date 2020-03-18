<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Question page</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.mCustomScrollbar.css"/>
        <link rel="stylesheet" type="text/css" href="css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/question_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/sidebar.css"/>
        <link rel="stylesheet" type="text/css" href="css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/images_side_nav.css"/>
        <script src="js/jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>       
    </head>

    <%
        String jsonContent = request.getAttribute("jsonContent").toString();
        boolean isNew = Boolean.valueOf(request.getAttribute("newMaterial").toString());
        String numberOfQuestions = request.getAttribute("numberOfQuestions").toString();
        String remainingTime;
        String workingStatus = "";

        if (isNew) {
            remainingTime = request.getAttribute("allowedTime").toString();
        } else {
            remainingTime = request.getAttribute("remainingTime").toString();
            workingStatus = request.getAttribute("workingStatus").toString();
            workingStatus = workingStatus.replace("'", "\"");
        }

        String[] time = remainingTime.split(":", 3);
    %>

    <!--The images will go here-->
    <div id="mySidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    </div>

    <!-- when image is clicked This Modal will openup -->
    <div id="myModal" class="modal">

        <!-- The Close Button -->
        <span class="close" onclick="document.getElementById('myModal').style.display = 'none'">&times;</span>

        <!-- Modal Content (The Image) -->
        <img class="modal-content" id="img01">

        <!-- Modal Caption (Image Text) -->
        <div id="caption"></div>
    </div>

    <script>

        var jsonText = <%= jsonContent%>; //Copy the content of the json file to a string variable
        var generatedHTML = ""; //hold the generated html file
        var labelLibrary = ["Question", "A", "B", "C", "D"];
        var correct_answers;    //load correct answers to this object

        for (var i = 0; i < jsonText.length; i++) {
            if (i === 0) {
                correct_answers = jsonText[i]["correct_answers"];
//                for (var x = 1; x < correct_answers.length; x++) {
//                    console.log(correct_answers[x][""+x]);
//                }
            }
            else {
                for (var j = 0; j < 5; j++) {
                    var currentElement = jsonText[i]["qn" + i][j]["c" + j];
                    if (currentElement.indexOf(".png") >= 0 || currentElement.indexOf(".jpg") >= 0) {
                        var imageLabel = "Fig. #" + i + " " + labelLibrary[j];
                        var newImages = $("<a href='#'>" + imageLabel + " <img onclick='showModal(this);' id='modalImage' class='img-responsive' src='Materials/"+"<%= request.getAttribute("materialHeader").toString().replace(" ", "") %>"+ "/"  + currentElement.substring(currentElement.indexOf("@") + 1, currentElement.lastIndexOf("@")) + "' alt='Henok G' /></a>");
                        $("#mySidenav").append(newImages);
                        currentElement = currentElement.substring(0, currentElement.indexOf("@"));
                    }
                    switch (j) {
                        case 0:
                            generatedHTML += "<div class='row question_wrapper'><ul id='question_" + i + "'><li class='question_text'><span class ='number pull-left'>" + i + ".</span> <p class='question'> " + currentElement + "</p></li>";
                            break;
                        case 1:
                            generatedHTML += "<li class='option'> <input type='radio' value='A' class ='hidden-lg hidden-md pull-left' name='option" + i + "'/>A. " + currentElement + "</li>";
                            break;
                        case 2:
                            generatedHTML += "<li class='option'> <input type='radio' value='B' class ='hidden-lg hidden-md pull-left' name='option" + i + "'/>B. " + currentElement + "</li>";
                            break;
                        case 3:
                            generatedHTML += "<li class='option'> <input type='radio' value='C' class ='hidden-lg hidden-md pull-left' name='option" + i + "'/>C. " + currentElement + "</li>"
                            break;
                        case 4:
                            generatedHTML += "<li class='option'> <input type='radio' value='D' class ='hidden-lg hidden-md pull-left' name='option" + i + "'/>D. " + currentElement + "</li><li class='correct_message text-center text-success'><hr/>You are correct <i class='fa fa-check'></i> <hr/></li><li class='text-center description'><hr/>Incorrect Answer <i class='fa fa-times'></i><hr/></li></ul></div><hr>";
                            break;
                    }
                }
                ;
            }
        }
        ;
    </script>

    <body class="menu">

        <div class="text-center" id="start">
            <button type="button" id = "start_button" class="btn btn btn-lg">READY</button>
            <div class="text-center" id="finish_window">
                <h1 class="text-danger">Time is over</h1>
                <h2 id="scoreOnTimeOver"></h2>                
                <hr/>
                <div class="row">
                    <div class="col-xs-12 col-md-4 text-right">
                        <a  href="/Temaribet/Dashboard"><button type="button" id="back_to_dashboard" class="btn btn-warning btn-lg">
                            <span class="glyphicon glyphicon-circle-arrow-left"></span> Go To Dashboard
                            </button></a>
                    </div>
                    <div class="col-xs-12 col-md-4 text-center">
                        <button type="button" id="start_over" class="btn btn-success btn-lg">
                            <span class="glyphicon glyphicon-refresh"></span> Start Over
                        </button>                        
                    </div>
                    <div class="col-xs-12 col-md-4 text-left">
                        <button type="button" id="detail_result" class="btn btn-success btn-lg">
                            <span class="glyphicon glyphicon-triangle-bottom"></span> Detail Result
                        </button>                        
                    </div>
                </div>
            </div>
        </div>

        <%@include file="WEB-INF/header.jsp" %>
        <div class="container-fluid">
            <%@include file="WEB-INF/sidebar.jsp" %>
            <div class="row" id="whole_row" isNew="<%= isNew%>" numberOfQuestions="<%= Integer.valueOf(numberOfQuestions)%>">
                <div class="row" id = "material_info_wrapper">

                    <div class="col-xs-12 col-md-6">                        
                        <h3 id = "material_name"><%= request.getAttribute("materialHeader")%>
                        <button id="showImages" class="btn btn-success" onclick="openNav();">Show Figures</button>
                        <button id="distractionFree" class="kc_fab_main_btn" onclick="toggleFullScreen();"><span style="font-size: 20px" class="glyphicon glyphicon-resize-full"></span></button>
                        </h3>                         
                    </div>
                    <div class="col-xs-12 col-md-3">
                        <button id ="save_button" class="btn btn-default action_buttons"><span class="glyphicon glyphicon-floppy-disk"> </span> Save</button>
                        <button id="submit_button" class="btn btn-default action_buttons"><span class="glyphicon glyphicon-ok-sign"></span> Submit</button>
                    </div>

                    <div class="col-xs-12 col-md-3" id="timer">   
                        <div>
                            <h2><span class="glyphicon glyphicon-time pull-left"></span>
                                <span id="time" hour="<%= time[0]%>" minute = "<%= time[1]%>" second="<%= time[2]%>">
                                    <span id="hour">00 </span>
                                    : <span id="minute"> 00 </span>
                                    : <span id="second"> 00 </span> 
                                </span> 
                            </h2> 
                        </div>

                    </div>

                </div>

                <div class="row" id="question_choice_container">
                    <div class="col-xs-12 col-md-9" numberOfQuestions="<%= numberOfQuestions%>" id="loaded_material_wrapper">

                    </div>

                    <div class="col-md-3 hidden-sm hidden-xs text-center wrappers" id="answer_sheet_wrapper">

                        <ul id="letters">
                            <li>A</li>
                            <li>B</li>
                            <li>C</li>
                            <li>D</li>
                        </ul>

                        <%
                            for (int i = 1; i <= Integer.valueOf(numberOfQuestions); i++) {
                        %>

                        <div> 
                            <p class ="text-center pull-left"><%= i%></p>     <!-- Roll number -->

                            <ul>
                                <li class="text-center answer_option"><input type="radio" value="A" name="<%= i%>"/></li>
                                <li class="text-center answer_option"><input type="radio" value="B" name="<%= i%>"/></li>
                                <li class="text-center answer_option"><input type="radio" value="C" name="<%= i%>"/></li>
                                <li class="text-center answer_option"><input type="radio" value="D" name="<%= i%>"/></li>
                            </ul>
                        </div>
                        <% }%>                     

                    </div>
                </div>
            </div>
        </div>

        <%@include file="WEB-INF/footer.jsp" %>
        <script>
            document.getElementById('loaded_material_wrapper').innerHTML = generatedHTML;

            function toggleFullScreen() {
                if ((document.fullScreenElement && document.fullScreenElement !== null) ||    
                 (!document.mozFullScreen && !document.webkitIsFullScreen)) {
                  if (document.documentElement.requestFullScreen) {  
                    document.documentElement.requestFullScreen();  
                    } else if (document.documentElement.mozRequestFullScreen) {  
                    document.documentElement.mozRequestFullScreen();  
                  } else if (document.documentElement.webkitRequestFullScreen) {  
                    document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);  
                  } 
                  $("#logo_wrapper").hide();
                  $("#question_choice_container").css("padding-top", "2.5em");
                        $("#material_info_wrapper").css({"position": "fixed", "top": "0", "left": "0", "margin-left": "0", "width": "100%", "z-index": "100"})
                 
                } else {  
                  if (document.cancelFullScreen) {  
                    document.cancelFullScreen();  
                  } else if (document.mozCancelFullScreen) {  
                    document.mozCancelFullScreen();  
                  } else if (document.webkitCancelFullScreen) {  
                    document.webkitCancelFullScreen();  
                  }  
                  $("#logo_wrapper").show();
                  $("#question_choice_container").css("padding-top", "");
                  $("#material_info_wrapper").css({"position": "", "top": "", "margin-left": "" , "width": "", "z-index": ""})
                 
            }  
            
          }

             
            //Load Correct Answers
            function loadCorrectAnswers() {
                for (var y = 1; y < correct_answers.length; y++) {
                    $("ul#question_" + y + " li:eq(" + correct_answers[y] + ")").addClass("correct_answer");
                }
            }

            // ################### FOR THE IMAGE SIDE NAV #########################
            /* Set the width of the side navigation to 250px */
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
            }

            /* Set the width of the side navigation to 0 */
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
            // ################### FOR THE MODAL WINDOW WHEN IMAGE IS CLICKED ##############
            // Get the modal
            var modal = document.getElementById('myModal');
            var img = document.getElementById('modalImage');
            var modalImg = document.getElementById("img01");
            var captionText = document.getElementById("caption");

            function showModal(clickedImage) {
                modal.style.display = "block";
                modalImg.src = clickedImage.src;
                modalImg.alt = clickedImage.alt;
                captionText.innerHTML = clickedImage.alt;
                // Get the <span> element that closes the modal
                var span = document.getElementsByClassName("close")[0];

                // When the user clicks on <span> (x), close the modal
                span.onclick = function () {
                    modal.style.display = "none";
                }
            }
            var numberOfQuestion = '<%= Integer.valueOf(numberOfQuestions)%>';
            var workingStatus = '<%= workingStatus.substring(1, workingStatus.length()-1) %>';
            loadCorrectAnswers();
        </script>
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/question.js"></script>
        <script src="js/sidebar.js"></script>    
    </body>
</html>