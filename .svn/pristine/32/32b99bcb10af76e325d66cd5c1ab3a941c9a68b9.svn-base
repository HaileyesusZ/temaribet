/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$question_number = 1;
$_question = $("[name = question_input]").val();
$_optiona = $("[name = optiona_input]").val();
$_optionb = $("[name = optionb_input]").val();
$_optionc = $("[name = optionc_input]").val();
$_optiond = $("[name = optiond_input]").val();
$_description = $("[name = description_textarea]").val();

$_level = $("[name = level]").val();
$_number_of_question = $("[name=number_of_question]").val();


$whole_page = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"></head><body>";

$("#create_button").click(function () {
    if ($("[name=number_of_question]").val() < 10)
    {
        alert("Number of question must be greater then 10");
    }
    else
    {
        $_exam_type = $("[name=examType]").val();
        $_year = $("[name=year]").val();
        $_subject = $("[name=subject]").val();
        $("#start_area").animate({left: '-100%'}, 200, function () {
            $(this).hide();
            $("[name=number_of_question]").val("");
        });

        $("#main_area").show().animate({left: ''}, 300);
    }

});

$("#back_button").click(function () {
    $("#main_area").animate({left: '80%'}, 200, function () {
        $(this).hide();
        $("#start_area").show().animate({left: ''}, 100, function () {
        });
    });
});

// During typing
$("[name = question_input]").keyup(function () {
    $_question = $(this).val();
    setText();
});

$("[name = optiona_input]").keyup(function () {
    $_optiona = $(this).val();
    setText();
});

$("[name = optionb_input]").keyup(function () {
    $_optionb = $(this).val();
    setText();
});

$("[name = optionc_input]").keyup(function () {
    $_optionc = $(this).val();
    setText();
});

$("[name = optiond_input]").keyup(function () {
    $_optiond = $(this).val();
    setText();
});

$("[name=description_textarea]").keyup(function () {
    $_description = $(this).val();
    setText();
});

//buttons
$("#save_button").click(function ()
{
//    $("[name = display_textarea]").val("");
    $whole_page += generateText();
    $("[name=display_textarea]").val(generateText());
    $("[name = question_input]").val("");
    $("[name = optiona_input]").val("");
    $("[name = optionb_input]").val("");
    $("[name = optionc_input]").val("");
    $("[name = optiond_input]").val("");
    $("[name = description_textarea").val("");
    $_question = "";
    $_optiona = "";
    $_optionb = "";
    $_optionc = "";
    $_optiond = "";
    $_description = "";
    $question_number++;
});

$("#submit_button").click(function () {
    generatePage();
    
    $.ajax({url: "PublishPaper",
        type: "POST",
        data: {
            "requestType": "generateHTML",
            "wholePage": $whole_page,
            "subject" : $_subject,
            "year" : $_year,
            "examType" : $_exam_type
        },
        success: function (result) {
            alert(result);
        },
        error: function (xhr) {
        }
    });
});

$("#main_area select").change(function () {
    setText();
});

//functions

// To display text during typing
function setText()
{
    $answer_value = $("#main_area select").val();
    $text_to_be_appended = $question_number + ") \t" + $_question + "\n\n\t A) \t" + $_optiona
            + "\n\n\t B) \t" + $_optionb + "\n\n\t C) \t" + $_optionc + "\n\n\t D) \t" + $_optiond + "\n\n\n\t Correct answer :  \t" + $answer_value + "\n\n\t Description :  \t" + $_description;
    $("[name=display_textarea]").val($text_to_be_appended);
}

// To generate for each questio 
function generateText()
{
    $a_answer = "";
    $b_answer = "";
    $c_answer = "";
    $d_answer = "";
    $answer_value = $("#main_area select").val();

    if ($answer_value === "A")
    {
        $a_answer += "correct_answer";
    }

    else if ($answer_value === "B")
    {
        $b_answer += "correct_answer";
    }

    else if ($answer_value === "C")
    {
        $c_answer += "correct_answer";
    }

    else if ($answer_value === "D")
    {
        $d_answer += "correct_answer";
    }

    $_correct_answer = "<li class=\"correct_message text-center text-success\"><hr/>You are correct <i class=\"fa fa-check\"></i> <hr/></li>";
    $d_description = "<li class=\"text-center description\"><hr/>" + $_description + "<hr/></li>";

    $text_to_be_appended = "<div class = \"question_wrapper\">\n <ul id=\"question_" + $question_number +
            "\">\n<li class=\"question_text\">\n<span class=\"number pull-left\">" + $question_number + ")"
            + "</span><p class=\"question\">" + $_question + "</p></li>\n<li class=\"diagram\"></li>\n\n\
               <li class=\"option " + $a_answer + "\"><input type=\"radio\" value=\"A\" class =\"hidden-lg hidden-md pull-left\" name=\"option" + $question_number + "\"/> A."
            + $_optiona + "</li>\n\n\
               <li class=\"option " + $b_answer + "\"><input type=\"radio\" value=\"B\" class = \"hidden-lg hidden-md pull-left\" name\"option" + $question_number + "\"/> B."
            + $_optionb + "</li>\n\n\
                <li class=\"option " + $c_answer + "\"><input type=\"radio\" value=\"C\" class = \"hidden-lg hidden-md pull-left\" name\"option" + $question_number + "\"/> C."
            + $_optionc + "</li>\n\n\
            <li class=\"option " + $d_answer + "\"><input type=\"radio\" value=\"D\" class = \"hidden-lg hidden-md pull-left\" name\"option" + $question_number + "\"/> D."
            + $_optiond + "</li>\n" + $_correct_answer + $d_description + "</ul></div>";

    return $text_to_be_appended;
}

// To generate whole page
function generatePage()
{
    $("[name=display_textarea]").val($whole_page + "\n</body></html>");
}