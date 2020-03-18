<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Question page</title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/jquery.mCustomScrollbar.css"/>
        <link rel="stylesheet" type="text/css" href="css/header_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/footer_style.css"/>
        <link rel="stylesheet" type="text/css" href="css/training.css"/>
        <link rel="stylesheet" type="text/css" href="css/sidebar.css"/>
        <link rel="stylesheet" type="text/css" href="css/images_side_nav.css"/>
        <script src="js/jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css"/>       

    </head>
    <body class="menu">
        <%
            String jsonContent = (String) request.getAttribute("jsonContent");
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
                                generatedHTML += "<li class='option'> <input type='radio' value='A' class ='pull-left' name='option" + i + "'/>A. " + currentElement + "</li>";
                                break;
                            case 2:
                                generatedHTML += "<li class='option'> <input type='radio' value='B' class ='pull-left' name='option" + i + "'/>B. " + currentElement + "</li>";
                                break;
                            case 3:
                                generatedHTML += "<li class='option'> <input type='radio' value='C' class ='pull-left' name='option" + i + "'/>C. " + currentElement + "</li>"
                                break;
                            case 4:
                                generatedHTML += "<li class='option'> <input type='radio' value='D' class ='pull-left' name='option" + i + "'/>D. " + currentElement + "</li><li class='correct_message text-center text-success'><hr/>You are correct <i class='fa fa-check'></i> <hr/></li><li class='text-center description'><hr/>Incorrect Answer <i class='fa fa-times'></i><hr/></li></ul></div><hr>";
                                break;
                        }
                    }
                    ;
                }
            }
            ;
        </script>


        <%@include file="WEB-INF/header.jsp" %>

        <div class="container-fluid">


            <%  if (user != null) {%>
            <%@include file="WEB-INF/sidebar.jsp" %>
            <% }%>
            <div class="row" id="whole_row">
                <div class="row" id = "material_info_wrapper">

                    <div class="col-md-8">
                        <h3 id = "material_name"><%= request.getAttribute("materialHeader")%></h3> 
                    </div>

                    <div class="col-md-4 text-center">
                        <button id="showImages" class="btn btn-success" onclick="openNav();">Show Figures</button>
                    </div>

                </div>

                <div class="row">
                    <div class="col-xs-12" id="loaded_material_wrapper">
                        <!--Questions go here-->
                    </div>
                </div>

            </div>
        </div>

        <%@include file="WEB-INF/footer.jsp" %>
        <script>
            document.getElementById('loaded_material_wrapper').innerHTML = generatedHTML;

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
            loadCorrectAnswers();

            $(document).ready(function () {
                openNav();
            });

        </script>
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/training.js"></script>
        <script src="js/sidebar.js"></script>    
    </body>
</html>
