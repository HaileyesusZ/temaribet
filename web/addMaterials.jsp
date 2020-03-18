<%-- 
    Document   : addMaterials
    Created on : Oct 17, 2016, 7:47:40 PM
    Author     : Tsige
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Add materials </title>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/addMaterials.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">

            <div class="row" id="type_selection_wrapper">
                <div class="col-md-offset-1 col-md-7" id="selection_area_wrapper">
                    <div class="row" id="inner_selection_wrapper">
                        <ul class="col-xs-12 col-md-2 list-group active_ul" id="type_wrapper">
                            <h5><b class="header">Type of exam</b></h5>
                            <li id="matric">Matric</li>                            
                            <li id="other">Other</li>
                        </ul>
                        <ul class="col-xs-12 col-md-2 list-group not_active_ul" id="year_wrapper">
                            <h5><b>Year</b></h5>
                            <li>2006</li>
                            <li>2007</li>
                            <li>2008</li>
                        </ul>
                        <ul class="col-xs-12 col-md-2 list-group not_active_ul" id="grade_wrapper">
                            <h5><b>Grade</b></h5>
                            <li id="grade_10">10</li>
                            <li id="grade_12">12</li>
                        </ul> 
                        <ul class="col-xs-12 col-md-4 list-group not_active_ul" id="subjects_wrapper">
                            <h5><b>Subject</b></h5>
                            <li class="highschool">Amharic</li>
                            <li class="preparatory">Apptitude</li>
                            <li class="both">Biology</li>
                            <li class="both">Chemistry</li>
                            <li class="both">Civics</li>
                            <li class="preparatory">Economics</li>
                            <li class="both">English</li>
                            <li class="both">Physics</li>
                            <li class="both">Maths</li>
                            <li class="both">Maths[Social]</li>
                            <li class="preparatory">Business</li>
                            <li class="highschool">History</li>
                            <li class="highschool">Geography</li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3" id="right_wrapper">

                    <div class="form-group form-inline" id="no_of_question_wrapper">
                        <label for="no_of_question">Number of questions : </label>
                        <input type="number" class="form-control input-sm" min="1" max="60" id="no" placeholder="60">
                    </div>
                    <div class="form-group form-inline" id="time_wrapper">
                        <label>Allowed time : </label>
                        <input type="number" class="form-control input-sm" min="0" max="12" id="hr" placeholder="00"> :
                        <input type="number" class="form-control input-sm" min="0" max="60" id="mn" placeholder="00"> :
                        <input type="number" class="form-control input-sm" min="0" max="60" id="sc" placeholder="00">
                    </div>

                    <div class="text-center">
                        <button class="btn btn-success" id="start_btn"> Start </button>
                    </div>

                </div>
            </div>  

            <div class="row" id="inputs_wrapper" style="display: none">
                <div class="col-md-8" id="editing_wrapper">
                    <div class="form-inline">
                        <span id="question_number"></span>. <textarea class="form-control" rows="4" placeholder="Enter question here" id="question_textarea"></textarea>
                        <input type="file" id="imageForQ" name="imageForQ"/><span class="glyphicon glyphicon-file"></span>
                    </div>
                    <div class="form-inline">
                        A. <textarea class="form-control" rows="2" placeholder="Enter choice A here" id="choice_a_textarea"></textarea>
                        <input type="file" id="imageForA" name="imageForA"/><span class="glyphicon glyphicon-file"></span>
                    </div>
                    <div class="form-inline">
                        B. <textarea class="form-control" rows="2" placeholder="Enter choice B here" id="choice_b_textarea"></textarea>
                        <input type="file" id="imageForB" name="imageForB"/><span class="glyphicon glyphicon-file"></span>
                    </div>
                    <div class="form-inline">
                        C. <textarea class="form-control" rows="2" placeholder="Enter choice C here" id="choice_c_textarea"></textarea>
                        <input type="file" id="imageForC" name="imageForC"/><span class="glyphicon glyphicon-file"></span>
                    </div>
                    <div class="form-inline">
                        D. <textarea class="form-control" rows="2" placeholder="Enter choice D here" id="choice_d_textarea"></textarea>
                        <input type="file" id="imageForD" name="imageForD"/><span class="glyphicon glyphicon-file"></span>
                    </div> 

                    <div class="text-center">
                        <label for="correct_answer">Correct answer : </label>
                        <select id="correct_answer">
                            <option value="1">A</option>
                            <option value="2">B</option>
                            <option value="3">C</option>
                            <option value="4">D</option>
                        </select>
                        <button class="btn" id="save_btn">Save</button>
                        <button class="btn" id="save_for_later">Save For Later</button>
                        <button class="btn" id="done">I'm Done[Generate Now]</button>
                    </div>

                </div>
                <div class="col-md-4" id="textarea_wrapper"> 
                    <textarea class="form-control" readonly id="preview_textarea" ></textarea>
                </div>
            </div>
        </div>

        <script src="js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="js/addMaterials.js"></script>       
    </body>
</html>