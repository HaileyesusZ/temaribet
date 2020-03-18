/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$type = "";
$year = "";
$grade = 0;
$subject = "";
$no = 0;
$hour = 0;
$minute = 0;
$second = 0;
$isGradeEnabled = false;
$current_number = 1;

$("#type_wrapper li").click(function () {
    $type = $(this).text();
    if ($type === "Matric" || $type === "Entrance") {
        $("#grade_wrapper").css("display", "block");
        $isGradeEnabled = true;
//        $grade = "";
    }
    else {
        $("#grade_wrapper").css("display", "block");
        $isGradeEnabled = true;
        if ($subject !== "") {
            $("#grade_wrapper").removeClass("not_active_ul").addClass("active_ul");
        }
    }
    $("#type_wrapper").children().removeClass("active_li");
    $(this).addClass("active_li");
    $("#year_wrapper").removeClass("not_active_ul").addClass("active_ul");
});

$("#year_wrapper li").click(function () {

    if ($type !== "") {
        $year = $(this).text();
        $("#year_wrapper").children().removeClass("active_li");
        $(this).addClass("active_li");
        if ($isGradeEnabled) {
            $("#grade_wrapper").removeClass("not_active_ul").addClass("active_ul");
        }
        else {
            $("#subjects_wrapper").removeClass("not_active_ul").addClass("active_ul");
        }
    }

});

$("#grade_wrapper li").click(function () {
    if ($year !== "") {
        $grade = $(this).text();
        $("#grade_wrapper").children().removeClass("active_li");
        $(this).addClass("active_li");
        $("#subjects_wrapper").removeClass("not_active_ul").addClass("active_ul");
    }


});

$("#subjects_wrapper li").click(function () {
    if (($isGradeEnabled && $grade !== 0) || (!$isGradeEnabled && $year !== "")) {
        $subject = $(this).text();
        $("#subjects_wrapper").children().removeClass("active_li");
        $(this).addClass("active_li");
    }

});
 

$("#start_btn").click(function () {
    $no = $("#no").val();
    $hour = $("#hr").val();
    $minute = ($("#mn").val().length <= 0) ? "0" : $("#mn").val();
    $second = ($("#sc").val().length <= 0) ? "0" : $("#sc").val();

    if (($subject === "") || ($hour < 1 && $minute < 1 && $second < 1) || ($no === "")) {
        alert("Please select all requirements");
    }

    else {
        $("#type_selection_wrapper").animate({left: '-80%'}, 200, function () {
            $(this).hide();
        });

        $("#inputs_wrapper").show().animate({left: ''}, 300);
        
        //Added By Henok G
        console.log($type, $year, $grade, $subject);
        $.ajax({
            type: 'POST',
            url: "PublishPaper",
            data: {requestType: "initializeMaterial", type: $type, year: $year, grade: $grade, subject: $subject,
            numberOfQuestions: $no, allowedTime: $hour+":"+$minute+":"+$second},
            success: function (response) {
                console.log(response);
               if(response !== ""){
                    $current_number =  response.charAt(0);
                }
            }
        });
    }
});


// Question js
setNumber();


$("#question_textarea").keyup(function () {
    writeOnPreview();
});

$("#choice_a_textarea").keyup(function () {
    writeOnPreview();
});
$("#choice_b_textarea").keyup(function () {
    writeOnPreview();
});
$("#choice_c_textarea").keyup(function () {
    writeOnPreview();
});
$("#choice_d_textarea").keyup(function () {
    writeOnPreview();
});

function writeOnPreview() {
    $txt = $current_number + ") " + $("#question_textarea").val() + "\n\n A) " + $("#choice_a_textarea").val() + "\n\n B) " + $("#choice_b_textarea").val()
            + "\n\n C) " + $("#choice_c_textarea").val() + "\n\n D) " + $("#choice_d_textarea").val();
    $("#preview_textarea").val($txt);
};

function setNumber(){
    $("#question_number").text($current_number);
}
$("#save_btn").click(function () {
        //Added By Henok G

    sendQuestionUsingAjax($current_number);
    $current_number++;    
    $("textarea").val("");
    
    setNumber();
});

$("#save_for_later").click(function() {
    $.ajax({
            type: 'POST',
            url: "PublishPaper",
            data: {requestType: "saveForLater"},
            success: function (response) {
            }
        });
});

$("#done").click(function() {
    $.ajax({
            type: 'POST',
            url: "PublishPaper",
            data: {requestType: "done"},
            success: function (response) {
            }
        });
});

function sendQuestionUsingAjax(questionNumber){
    
        $pending_question = $("#question_textarea").val();
        $pending_a = $("#choice_a_textarea").val();
        $pending_b = $("#choice_b_textarea").val();
        $pending_c = $("#choice_c_textarea").val();
        $pending_d = $("#choice_d_textarea").val();
        
        if($("#imageForQ").val().length > 2){
            $pending_question += "@Images/"+$("#imageForQ").val().substr(12, $("#imageForQ").val().length)+"@";
        }
        if($("#imageForA").val().length > 2){
            $pending_a += "@Images/"+$("#imageForA").val().substr(12, $("#imageForA").val().length)+"@";
        }
        if($("#imageForB").val().length > 2){
            $pending_b += "@Images/"+$("#imageForB").val().substr(12, $("#imageForB").val().length)+"@";
        }
        if($("#imageForC").val().length > 2){
            $pending_c += "@Images/"+$("#imageForC").val().substr(12, $("#imageForC").val().length)+"@";
        }
        if($("#imageForD").val().length > 2){
            $pending_d += "@Images/"+$("#imageForD").val().substr(12, $("#imageForD").val().length)+"@";
        }
    
        clearImageUploads();
    
        $.ajax({
            type: 'POST',
            url: "PublishPaper",
            data: {requestType: "writeToFile", questionNumber: questionNumber, question: $pending_question,
                choiceA: $pending_a, choiceB: $pending_b,
                choiceC: $pending_c, choiceD: $pending_d,
                correctAnswer: $("#correct_answer").val()},
            success: function (response) {
            }
        });
}

function clearImageUploads(){
    $("#imageForQ").val("");
    $("#imageForA").val("");
    $("#imageForB").val("");
    $("#imageForC").val("");
    $("#imageForD").val("");
}