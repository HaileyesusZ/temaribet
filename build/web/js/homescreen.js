/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// Sign in validation starts here
// Validate the email (username)
$("input[type=email").bind("keyup",function()
{
    var email = $(this).val().trim();
    var regex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
    if(regex.test(email))
    {
        $(this).parent().removeClass("has-error").addClass("has-success");
        $(this).siblings(".help-block").addClass("hidden");
        $(this).siblings(".form-control-feedback").removeClass("glyphicon-remove-sign");
    }
    else
    {
        $(this).parent().removeClass("has-sucess").addClass("has-error");
        $(this).siblings(".help-block").removeClass("hidden");
        $(this).siblings(".form-control-feedback").addClass("glyphicon-remove-sign");
    }
});

// Validate the password
$("input[type=password").bind("keyup",function()
{
    var password = $(this).val().trim();
    var regex = /^([a-zA-Z0-9@*#]{6,15})$/;
    if(regex.test(password) && password.length>=6)
    {
        $(this).parent().removeClass("has-error").addClass("has-success");
        $(this).siblings(".help-block").addClass("hidden");
    }
    else
    {
        $(this).parent().removeClass("has-sucess").addClass("has-error");
        $(this).siblings(".help-block").removeClass("hidden");
    }
});


//Sign in validation ends here

var HighSchool = {English: 1, Maths: 2, Amharic: 3, Civics: 4, Biology: 5, Chemistry: 6, Physics: 7, History: 9, Geography: 10};
var Natural = {English: 1, Maths: 2, Civics: 4, Biology: 5, Chemistry: 6, Physics: 7, Apptitude: 8};
var Social = {English: 1, Maths: 2, Civics: 4, History: 9, Geography: 10, Economics: 11};

$("#guest_button").click(function ()
{

    $("#top").animate({left: '-80%'}, 200, function () {
        $(this).hide();
        $(".features").hide();
    });

    $("#filter_wrapper").show().animate({left: ''}, 300);


});

$("#back_to_home_button").click(function ()
{
    $("#filter_wrapper").animate({left: '80%'}, 200, function () {
        $(this).hide();
        $("#top").show().animate({left: ''}, 100, function () {
            $(".features").show();
        });
    });


});

$(".start_now_button").click(function () {
    $(window).scrollTop($('#top').offset().top);
});

$('#level').change(function () {
    var selected = $(this).val();

    switch (selected) {
        case "HighSchool" :
            $('#stream').attr({"disabled": true});
            changeSubject(HighSchool);
            break;
        case "Preparatory" :
            $('#stream').attr({"disabled": false});
            changeSubject(Natural);
            break;
    }
});

$('#stream').change(function () {
    switch ($(this).val()) {
        case "Natural Science" :
            changeSubject(Natural);
            break;
        case "Social Science" :
            changeSubject(Social);
            break;
    }
});

function changeSubject(subjects) {
    $('#subject').empty();
    var count = 0;
    var subjectsBox = document.getElementById("subject");
    for (var subject in subjects) {
        if (count === 0) {
            subjectsBox.options[count++] = new Option("Any Subject", 0);
            continue;
        }
        subjectsBox.options[count++] = new Option(subject, subjects[subject]);
    }
}

$('#filter_form').submit(function (event) {
    event.preventDefault();
    // request filter results
    filter(0,true);
});



function filter(lowerLimit, reloadPagination)
{
    if(parseInt(lowerLimit)){
        lowerLimit = parseInt(lowerLimit);
    }else {
        lowerLimit = 0;
    }
    
    $(".loading_indicator_wrapper").fadeIn();
    
    $.ajax({
        url:"/Temaribet/Dashboard",
        type: "get",
        data: {"requestType": "filter", "subject": $("select[name='subject']").val(), "examType": $("select[name='exam_type']").val(), "year": $("select[name='year']").val(),
               "level":$("select[name='level']").val(), "stream":$("select[name='stream']").val(), "lowerLimit":lowerLimit},
        error:  function(errorData)
            {
               $(".loading_indicator_wrapper").fadeOut();
               $(".feedback_modal .modal-title h2").text($(errorData.responseText).find("u").first().text());
               $(".feedback_modal").addClass("error_wrapper").removeClass("success_wrapper").modal();               
            },
        success: function(data)
            {
                var materials = JSON.parse(data);
                var materialsLength = materials.materials.length;
                if(materialsLength === 0)
                {   
                    $("table.filter_results tr:not(:first-child)").remove();
                    $("table.filter_results caption span.badge").text(0);
                    
                    $(".loading_indicator_wrapper").fadeOut();
                    
                    $(".feedback_modal .modal-title h2").text("No matching results!");
                    $(".feedback_modal").addClass("error_wrapper").removeClass("success_wrapper").modal();  
                    $("#materials_navigation").empty();
                    
                }else {
                    constructResultsTable(materials,lowerLimit);
                    if(reloadPagination) constructPagination(materials.size, "filter");
                }
                
            }
    });
}

function constructResultsTable(materials,lowerLimit)
{                   
    // filtered number of materials
    var materialsLength = materials.materials.length;
    if(lowerLimit === undefined){
        lowerLimit = 0;
    }
    var materialsToShowAtOnce = 0;

    if(parseInt(materials.materialsToShowAtOnce)){
        materialsToShowAtOnce = parseInt(materials.materialsToShowAtOnce);
    }
    var table = $("table.filter_results");
    
    $("table.filter_results tr:not(:first-child)").remove();
    $("table.filter_results caption span.badge").text(materials.size);
    
    for(i=0; i<materialsLength; i++)
    {
       var row = $("<tr></tr>").addClass("filtered_material").attr({'id':"m" + materials.materials[i].materialID});
       row.append($("<td></td>").text((materialsToShowAtOnce*lowerLimit)+i+1));
       row.append($("<td></td>").text(materials.materials[i].subject));
       row.append($("<td></td>").text(materials.materials[i].examType));
       row.append($("<td></td>").text(materials.materials[i].year));
       row.append($("<td></td>").text(materials.materials[i].numberOfQuestions));
       row.append($("<td></td>").append($("<a target='_blank' href='Question?requestType=training&id="+ materials.materials[i].materialID +"'></a>").text("Open")));
       table.append(row);
       
    }
    
    $("#filter_results_wrapper").show();
    $(".loading_indicator_wrapper").fadeOut() ;
    $(".content:not(#filter_results_wrapper .content)").slideUp();
    $(".toggle:not(#filter_results_wrapper .toggle)").addClass("glyphicon-resize-full").removeClass("glyphicon-resize-small");
  

}

function constructPagination(materialSize, searchOrFilter){
    
    
    if(searchOrFilter === undefined){
        searchOrFilter = "filter";
    }
    // get how many materials to show at once from server
    getMaterialsToShow(function (materialsToShow){
        
        // construct the pagination navigation
        
        var remainingToShow = materialSize;
        
        $('#materials_navigation').empty();
        // calculate how many paginations are needed to display all results
        if( remainingToShow > materialsToShow && materialsToShow > 0){
            var count = 0;
            // default for search or filter id
            var id = searchOrFilter+"_navigate_to_";
            
            while(remainingToShow > 0){
                $('#materials_navigation').append("<li><a href ='#' id ='"+id+""+count+"'>"+ ++count +"</a> </li>");
                remainingToShow -= materialsToShow;
            }
            bindMassEvent("a",id,"pag_nav");
        }
    });
}

function bindMassEvent(element, id, eventType){
    $(""+element+"[id^='"+id+"']").bind("click", function (){
       
       switch(eventType) {
           case "pag_nav" : pagNav($(this).attr("id"));
       }
           
    });
}

function pagNav(elementId){
    var firstPos = elementId.indexOf("_");
    switch(elementId.substring(0,firstPos)){
        
        case "search": 
            search(elementId.substr(elementId.lastIndexOf("_")+1));
            break;
        case "filter" :
            filter(elementId.substr(elementId.lastIndexOf("_")+1));
    }
}

function getMaterialsToShow(giveData) {
     $.ajax({
        url : "/Temaribet/Data",
        type : "post",
        
        data : {"requestData" : "materialsToShowAtOnce"},
        
        success : function(data){
           giveData(data);
        },
        error : function(){
           giveData(0);
        }
    });
    
}
