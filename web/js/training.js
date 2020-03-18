/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(".option > :radio").click(function ()
{
    $(".correct_message").slideUp("slow");
    $(".description").slideUp("slow");

    $name = $(this).attr("name");
    if ($(this).parent().hasClass("correct_answer"))
    {
        $(this).parent().parent().find(".correct_message").slideDown("slow");
    }
    else
    {
        $(this).parent().parent().find(".description").slideDown("slow");
    }
});

$(".menu-toggle").click(function ()
{
    $("body").toggleClass("menu-open");
    $(this).toggleClass("fa-bars").toggleClass("fa-arrow-left");

});
