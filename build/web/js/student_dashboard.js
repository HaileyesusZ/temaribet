/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var body = $('body');
var sortWay = "DESC";
var latestRequest = "";

$(".dropdown-toggle").attr("onclick",'');

// initialize pop-overs
$('.radial_progress').popover({html:true , trigger:"hover" , placement: "bottom"});
$('.dropdown').popover({html:true , trigger:"hover" , placement: "top"});

//navigation drwer toggle
$('.menu-toggle').bind('click',function(){
   body.toggleClass('menu-open');
   $(this).toggleClass('fa-bars').toggleClass('fa-arrow-left');
});

// collapse toggle
$('.toggle').bind('click',function(){
    $(this).parent().siblings('.content').slideToggle();
    $(this).toggleClass('glyphicon-resize-small').toggleClass('glyphicon-resize-full');
});

$("#search_form").bind('submit',function(event){
    event.preventDefault() ; 
    search(0, true);
    $("#year_sort_asc").show(200).css("border-top", "");
    $("#year_sort_desc").show(200).css("border-bottom", "1px solid black");
});

$("#filter_button").click(function() {
    filter(0, true);
    if($("select[name='year']").val() !== "any"){
        $("#year_sort_asc").hide(200);
        $("#year_sort_desc").hide(200);
    }else {
        $("#year_sort_asc").show(200).css("border-top", "");
        $("#year_sort_desc").show(200).css("border-bottom", "1px solid black");
    }
    
});

$(".material_icon_wrapper .glyphicon-pushpin").bind('click',function(){
    var wrapper = $(this).parents(".material_wrapper");
    pin(wrapper);
});

// sort by year animations
$("#year_sort_asc").mouseover(function(){
});
$("#year_sort_asc").mouseout(function(){
});
$("#year_sort_desc").mouseover(function(){
});
$("#year_sort_desc").mouseout(function(){
});

// sort by year functionalities
$("#year_sort_asc").click(function(){
    sortWay = "ASC";
    sortResult();
    $(this).css("border-top","1px solid black");
    $("#year_sort_desc").css("border-bottom", "");
});

$("#year_sort_desc").click(function(){
    sortWay = "DESC";
    sortResult();
    $(this).css("border-bottom","1px solid black");
    $("#year_sort_asc").css("border-top", "");
});

//$(".material_icon_wrapper .glyphicon-pushpin , .material_icon_wrapper .glyphicon-remove-circle, .material_icon_wrapper .glyphicon-remove").hover(
//                    function()
//                        {
//                            var wrapper = $(this).parents(".material_icon_wrapper");
//                            wrapper.removeClass("dropdown-toggle").attr({'data-toggle':''});
//                        },
//                     function()
//                        {
//                            var wrapper = $(this).parents(".material_icon_wrapper");
//                            wrapper.addClass("dropdown-toggle").attr({'data-toggle':'dropdown'});;
//                        }
//
//);
    
   
$(".material_icon_wrapper .glyphicon-remove-circle").bind('click',function(){
    var wrapper = $(this).parents(".material_wrapper");
    unpin(wrapper);
});

$(".material_icon_wrapper .glyphicon-remove").bind('click',function(){
    var wrapper = $(this).parents(".material_wrapper");
    closeMaterial(wrapper);
});


function sortResult(){
    if(latestRequest === "search"){
        search(0, true, sortWay);
    }else{
        filter(0, true, sortWay);
    }
}

function search(lowerLimit, reloadPagination, sortMechanism)
{
    latestRequest = "search";
    
    if(parseInt(lowerLimit)){
        lowerLimit = parseInt(lowerLimit);
    }else {
        lowerLimit = 0;
    }
    // check validity of sort condition
    if(sortMechanism !== "ASC" && sortMechanism !== "DESC"){
        sortMechanism = "DESC";
    }
    
    $(".loading_indicator_wrapper").fadeIn();
    $.ajax({
        url:"/Temaribet/Dashboard",
        type :"post",
        data : {"requestType":"search", "keyword":$(".search-input").val(), "lowerLimit":lowerLimit, "sortMechanism":sortMechanism},
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
                    
                }else{
                    constructResultsTable(materials, lowerLimit);
                    if(reloadPagination) constructPagination(materials.size,"search");
                }
            }
    });
}
   
function filter(lowerLimit, reloadPagination, sortMechanism)
{
    latestRequest = "filter";
    
    if(parseInt(lowerLimit)){
        lowerLimit = parseInt(lowerLimit);
    }else {
        lowerLimit = 0;
    }
    // check validity of sort mechanism
    if(sortMechanism !== "ASC" && sortMechanism !== "DESC"){
        sortMechanism = "DESC";
    }
    
    $(".loading_indicator_wrapper").fadeIn();
    $.ajax({
        url:"/Temaribet/Dashboard",
        type :"post",
        data : {"requestType":"filter", "subject":$("[name='subject']").val() , "examType":$("[name='exam_type']").val(), "year":$("[name='year']").val(),
                "lowerLimit" : lowerLimit, "sortMechanism": sortMechanism},
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
                    constructResultsTable(materials, lowerLimit);
                    if(reloadPagination) constructPagination(materials.size, "filter");
                }
                
            }
    });
}
   
function pin(material)
{
    $.ajax({
        url:"/Temaribet/Dashboard",
        type :"post",
        data : {"requestType":"pin", "materialId":material.attr("id").substr(1)},
        error:  function(errorData)
            {
               $(".loading_indicator_wrapper").fadeOut();
               $(".feedback_modal .modal-title h2").text(errorData.statusText);
               $(".feedback_modal").addClass("error_wrapper").removeClass("success_wrapper").modal();               
            },
        success: function(data)
            {   
                        
                $("#pinned_materials_wrapper .empty_list").hide();
                var wrapper = material.clone();
                var icon = $("<span class='glyphicon glyphicon-remove-circle'></span>");
                wrapper.attr({'id':'p'+ wrapper.attr("id").substr(1)});
                wrapper.find(".glyphicon").remove();
                wrapper.find(".material_icon_wrapper").append(icon);
                console.log(wrapper);                              
                     
                icon.bind("click",function(){unpin(wrapper)});
                
                $("#pinned_materials_wrapper .content").append(wrapper);                                
            }
        });
}

function unpin(material)
{
        $.ajax({
        url:"/Temaribet/Dashboard",
        type :"post",
        data : {"requestType":"unpin", "materialId":material.attr("id").substr(1)},
        error:  function(errorData)
            {
                
               $(".loading_indicator_wrapper").fadeOut();
               $(".feedback_modal .modal-title h2").text($(errorData.responseText).find("u").first().text());
               $(".feedback_modal").addClass("error_wrapper").removeClass("success_wrapper").modal();               
            },
        success: function(data)
            {   
                
                var numberOfRemainingPinnedMaterials = JSON.parse(data).numberOfRemainingPinnedMaterials;
                if(numberOfRemainingPinnedMaterials === 0)
                {
                    $("#pinned_materials_wrapper").append("<div class='empty_list text-center'> <h2>You haven't pinned any materials yet.</h2><a>What pin a material?</a></div> ");

                }
                material.remove();
                material.popover();
            }
       });
}

function closeMaterial(material)
{
    $.ajax({
        url:"/Temaribet/Dashboard",
        type :"post",
        data : {"requestType":"close", "materialId":material.attr("id").substr(1)},
        error:  function(errorData)
            {
               $(".loading_indicator_wrapper").fadeOut();
               $(".feedback_modal .modal-title h2").text($(errorData.responseText).find("u").first().text());
               $(".feedback_modal").addClass("error_wrapper").removeClass("success_wrapper").modal();               
            },
        success: function(data)
            {   
                var numberOfRemainingOpenedMaterials = JSON.parse(data).numberOfRemainingOpenedMaterials;
                if(numberOfRemainingOpenedMaterials === 0)
                {
                    $("#opened_materials_wrapper").append("<div class='empty_list text-center'> <h2>You haven't opened any materials yet.</h2><a>What are opened materials?</a></div> ");
                }
                material.remove();
            }
    });   
}

function constructResultsTable(materials, lowerLimit)
{                
    // get the number of materials filtered
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
       var order = materialsToShowAtOnce * lowerLimit + i + 1;
       // show notices if material is opened or completed
       var row = $("<tr></tr>").addClass("filtered_material").attr({'id':"m" + materials.materials[i].materialID});
       // opened material and completed material make some changes to the row
       if(materials.materials[i].opened === true) {
           var row = $("<tr class='opened_material_result_info' title = 'Opened Material' data-content='Last opened on " + materials.materials[i].openedOn +"'> </tr>").addClass("filtered_material").attr({'id':"m" + materials.materials[i].materialID});
            row.append($("<td style='padding-right:0px'></td>").append(" <span class='fa fa-paint-brush '</span>"));

            row.append($("<td></td>").html(order ));
           
       }else if(materials.materials[i].completed === true) {
           var row = $("<tr class = 'completed_material_result_info' title = 'Completed Material' data-content='Completed on "+ materials.materials[i].completedOn +"'> </tr>").addClass("filtered_material").attr({'id':"m" + materials.materials[i].materialID});
            row.append($("<td style='padding-right:0px'></td>").append(" <span class='fa fa-check-circle fa-lg '</span>"));
            row.append($("<td></td>").html(order));

       }else {
           row.append("<td></td>");
          row.append($("<td></td>").text((materialsToShowAtOnce*lowerLimit)+i+1)); 
       }
       row.append($("<td></td>").text(materials.materials[i].subject));
       row.append($("<td></td>").text(materials.materials[i].examType));
       row.append($("<td></td>").text(materials.materials[i].year));
       row.append($("<td></td>").text(materials.materials[i].numberOfQuestions));
       row.append($("<td></td>").append($("<a target='_blank' href='Question?requestType=training&id="+ materials.materials[i].materialID +"'></a>").text("Practice mode")).append("<b> | </b>").append($("<a target='_blank' href='Question?requestType=exam&id="+ materials.materials[i].materialID +"'></a>").text(" Exam mode")));
       table.append(row);
       
    }
    
    // register hover action events
    $('.opened_material_result_info, .completed_material_result_info ').popover({html:true , trigger:"hover" , placement: "left"});
    
    
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
            search(elementId.substr(elementId.lastIndexOf("_")+1),false, sortWay);
            break;
        case "filter" :
            filter(elementId.substr(elementId.lastIndexOf("_")+1), false, sortWay);
            break;
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

function bindOpenedMaterialResultInfo(){
    
}

