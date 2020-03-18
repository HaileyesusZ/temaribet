//height of question and answer wrapper
$(window).resize(function ()
{
    setHeight();
});

$score = 0;
$numberOfTried = 0;
var last_working_status = "{";

$(window).load(function ()
{
    for ($i = 1; $i <= numberOfQuestion; $i++)
    {
        $input_val = $("input:radio[name=" + $i + "]:checked");
        if ($input_val.val() !== undefined)
        {
            last_working_status = last_working_status + "'" + $i + "'" + ":" + "'" + $input_val.val() + "'" + ",";
        }
    }
});
function setHeight()
{
    if ($("#answer_sheet_wrapper").height() > 0)
    {
        $(".wrappers").height($("#answer_sheet_wrapper").height());
    }
}
setHeight();

$isNew = $("#whole_row").attr("isNew");

if ($isNew == "false") {
    if (workingStatus.length >= 2) {
        setRadioButtons(workingStatus);
    }
}
$my_hour = $("#time").attr("hour");
$my_minute = $("#time").attr("minute");
$my_second = $("#time").attr("second");
$no_of_question = $("#loaded_material_wrapper").attr("numberOfQuestions");

$.urlParam = function (name) {
    var results = new RegExp("[\?&]" + name + "=([^&#]*)").exec(window.location.href);
    if (results == null) {
        return null;
    }
    else {
        return results[1] || 0;
    }
}
$material_id = $.urlParam("id");


$("input:radio").click(function ()
{
    $name_of_radio = $(this).attr("name");
    $value_of_radio = $(this).val();

    if ($name_of_radio.indexOf("option") === -1) {   //current radio buttons are on answersheet
        $temp_name = "option" + $name_of_radio;
    }

    else
    {
        $temp_name = $name_of_radio.charAt(6);
    }
    select_radio($temp_name, $value_of_radio);
});


$("#save_button").click(function ()
{
    var current_working_status = "{";
    for ($i = 1; $i <= $no_of_question; $i++)
    {
        $input_val = $("input:radio[name=" + $i + "]:checked");
        if ($input_val.val() !== undefined)
        {
            current_working_status = current_working_status + "'" + $i + "'" + ":" + "'" + $input_val.val() + "'" + ",";
        }
    }
    current_working_status += "}";
    current_working_status = current_working_status.replace(",}", "}");
    var remaining_time = $my_hour + ":" + $my_minute + ":" + $my_second;

    $.ajax({url: "Question",
        type: "GET",
        data: {
            "requestType": "saveOpenedMaterial",
            "remainingTime": remaining_time,
            "materialId": $material_id,
            "workingStatus": current_working_status
        },
        success: function (result) {
            
        },
        error: function (xhr) {
        }
    });

});

function competeCurrentScore(){
    $score = 0;
    for ($i = 1; $i <= $no_of_question; $i++)
        {
            $selected_answer_value = $("input:radio[name=" + $i + "]:checked").val();
            $question_id = "#question_" + $i + " > .correct_answer > input:radio";
            $correct_answer_val = $($question_id).val();
            if ($selected_answer_value === $correct_answer_val)
            {
                $score++;
            }
        }
}

function competeTried(){
    $numberOfTried = 0;
    for ($i = 1; $i <= $no_of_question; $i++)
        {
            $selected_answer_value = $("input:radio[name=" + $i + "]:checked").val();
            if ($selected_answer_value.length > 0)
            {
                $numberOfTried++;
            }
        }
}

$("#submit_button").click(function ()
{
    if ($("input:radio:checked").length <= $no_of_question)
    {
        alert("Please answer all questions");
    }
    else
    {
        competeCurrentScore();
        var final_answer = "{";
        for ($i = 1; $i <= $no_of_question; $i++)
        {
            $input_val = $("input:radio[name=" + $i + "]:checked");
            if ($input_val.val() !== undefined)
            {
                final_answer = final_answer + "'" + $i + "'" + ":" + "'" + $input_val.val() + "'" + ",";
            }
        }
        final_answer += "}";
        final_answer = final_answer.replace(",}", "}");
        var remaining_time = $my_hour + ":" + $my_minute + ":" + $my_second;
        
        $.ajax({url: "Question",
            type: "GET",
            data: {
                "score": $score,
                "requestType": "finishedOpenedMaterial",
                "remainingTime": remaining_time,
                "workingStatus": final_answer,
                "materialId": $material_id,
            },
            success: function (result) {
                window.location.assign("ExamResult?id="+$material_id+"&sit_code=1"+"&scr="+$score);
            },
            error: function (xhr) {
            }
        });
    }

});

$(".menu-toggle").click(function ()
{
    $("body").toggleClass("menu-open");
    $(this).toggleClass("fa-bars").toggleClass("fa-arrow-left");

});

$("#start_button").click(function ()
{
    $("#start").css("display", "none");
    $("body").css("overflow-y", "visible");
    $("#finish_window").css("display", "block");
    $("#start_button").css("display", "none");
//    timer
    $(function ()
    {
        if ($my_second == 0)
        {
            $my_second = 59;

            if ($my_minute == 0)
            {
                $my_minute = 59;
                if ($my_hour != 0)
                {
                    --$my_hour;
                }
            }
            else
            {
                $my_minute = --$my_minute;
            }

        }

        $my_interval = setInterval(function ()
        {
            second($my_hour, $my_minute, $my_second);
            if ($my_second == 0 && $my_minute == 0 && $my_hour == 0)
            {
                clearInterval($my_interval);
                competeCurrentScore();
                $("#scoreOnTimeOver").text("Your Score Is "+$score+"/"+numberOfQuestion);
                $("#start").css("display", "block");
                $("#start").css("background", "rgba(247, 246, 227, 0.61)");
                $("body").css("overflow-y", "hidden");
            }
        }, 1000);
    });
});

$("#start_over").click(function ()
{
    location.reload();
});


$("#detail_result").click(function(){
    competeTried();
    window.location.assign("ExamResult?id="+$material_id+"&sit_code=2"+"&tried="+$numberOfTried+"&scr="+$score);
});
//functions

function add_zero(number)
{
    if (number < 10)
    {
        number = "0" + number;
    }
    return number;
}

function convert_letter(letter)
{
    switch (letter)
    {
        case "A":
            return 0;
        case "B":
            return 1;
        case "C":
            return 2;
        case "D":
            return 3;
    }
}

function setRadioButtons(workingStatus)  // To set radio buttons when material opens
{
    if(workingStatus.length <=3){
        return;
    }
    else{
        var obj = JSON.parse(workingStatus);
        for (var key in obj)
        {

            if (obj.hasOwnProperty(key))
            {
                var value = obj[key];
                var answersheet_radioname = key;
                var option_radioname = "option" + key;
                select_radio(answersheet_radioname, value);
                select_radio(option_radioname, value);
            }
    }
    }
}

function select_radio(name, letter)  // Sets value of radio group
{
    var letter_value = convert_letter(letter);
    $option_radio_choice = "input:radio[name=" + name + "]:nth(" + letter_value + ")";
    $($option_radio_choice).attr('checked', true);
}
function second(shour, sminute, ssecond)
{

    if (second.counter === undefined)
    {
        second.counter = ssecond;
        minute(sminute);
        hour(shour);
    }

    else if (second.counter <= 0) {
        minute(sminute);
        second.counter = 59;
    }

    else
    {
        second.counter = --second.counter;
    }

    $("#second").text(add_zero(second.counter));
    $my_second = second.counter;

}

function minute(mminute)
{

    if (minute.counter === undefined)
    {
        minute.counter = mminute;
    }
    else
    {
        if (minute.counter <= 0) {
            minute.counter = 59;
            hour();
        }
        minute.counter = --minute.counter;
    }

    $("#minute").text(add_zero(minute.counter));
    $my_minute = minute.counter;
}

function hour(mhour)
{

    if (hour.counter === undefined)
    {
        hour.counter = mhour;
    }
    else if (hour.counter > 0)
    {
        hour.counter = --hour.counter;
    }

    $("#hour").text(add_zero(hour.counter));
    $my_hour = hour.counter;
}