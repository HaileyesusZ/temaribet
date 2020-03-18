/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$("select[name=grade]").change(function()
{
    var grade = parseInt($(this).val());
    if(! grade){
        location = "/Temaribet";
    }
    
    if(grade === 11 || grade === 12)
    {
        $("#stream").attr("disabled", false);
    }
    else
    {
        $("#stream").attr("disabled", true);
    }
});

//$("input[type=file]").change(function()
//{
//    if(typeof this.files !== undefined){
//         //$(this).after(this.files[0].name);
//        $("[for=file]").html(this.files[0].name);
//        $("#profile_picture_img").attr("src", URL.createObjectURL(this.files[0]));
//    }
//   
//});

// JavaSript validation
// Validate the first name and last name
//$("input[type=text").bind("keyup",function()
//{
//    var name = $(this).val().trim();
//    var regex = /^[a-zA-Z'-]+$/;
//    if(regex.test(name))
//    {
//        $(this).parent().removeClass("has-error").addClass("has-success");
//        $(this).siblings(".help-block").addClass("hidden");
//    }
//    else
//    {
//        $(this).parent().removeClass("has-sucess").addClass("has-error");
//        $(this).siblings(".help-block").removeClass("hidden");
//    }
//});
//
//// Validate the email
//$("input[type=email").bind("keyup",function()
//{
//    var email = $(this).val().trim();
//    var regex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;
//    if(regex.test(email))
//    {
//        $(this).parent().removeClass("has-error").addClass("has-success");
//        $(this).siblings(".help-block").addClass("hidden");
//    }
//    else
//    {
//        $(this).parent().removeClass("has-sucess").addClass("has-error");
//        $(this).siblings(".help-block").removeClass("hidden");
//    }
//});

// Validate the password
$("input[type=password].new").bind("keyup",function()
{
    var password = $(this).val().trim();
    var password_confirmation = $("#password_confirmation").val().trim();
    var regex = /^([a-zA-Z0-9@*#]{6,15})$/;
    if((regex.test(password) && password.length>=6 && password===password_confirmation) || (password.length===0 && password_confirmation.length===0))
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

$(".menu-toggle").click(function ()
{
    $("body").toggleClass("menu-open");
    $(this).toggleClass("fa-bars").toggleClass("fa-arrow-left");

});
//
//$("#agreement_confirmation").bind("change",function()
//{
//   if($(this).is(":checked"))
//   {
//       $(":submit").removeAttr("disabled");
//   }
//   else
//   {
//       $(":submit").attr("disabled",true);
//   }
//});