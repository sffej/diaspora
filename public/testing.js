$(".dropdown_list").live('click', function() {
if ($('.public.radio.selected:contains("Public")').length > 0) {
$("#publicwarn").show();
} else {
$("#publicwarn").hide();
}
});


$("header").live("mouseover", function() {
$("header").css('margin-top','0px');
$(".diaspora_header_logo").css('margin-top','-6px');
$(".leftNavBar").css('display','block');
});
var fullscreen = "off";
$(document).ready(function() {
$("#fullscreen").click(function() {
if (fullscreen == "off") 
{
  fullscreen = "on";
  $("#fullscreen").append("<div id='fson' class='badge'>fullscreen on</div>");  
} 
else if (fullscreen == "on") 
{ 
  fullscreen = "off";
  $("#fson").remove();
}
  //alert("Fullscreen mode toggled " + fullscreen);
});
$(window).scroll(function(){
if ($(window).scrollTop() == 0) {
$(".leftNavBar").css('display','block');
$("header").css('margin-top','0px');
$(".diaspora_header_logo").css('margin-top','-6px');
} else if (fullscreen == "on") {
$(".leftNavBar").css('display','none');
$("header").css('margin-top','-39px');
$(".diaspora_header_logo").css('margin-top','33px');
}
})
});
