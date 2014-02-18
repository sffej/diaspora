$(".diaspora_header_logo").live("mouseover", function() {
  $("header").css('margin-top','0px');
  $(".diaspora_header_logo").css('margin-top','-6px');
  $(".leftNavBar").css('opacity','1.0');
});

$(document).ready(function() {
//dia.so
$("#status_message_fake_text").blur(function() {
var text = $('#status_message_fake_text').val();
  if (text.match(/:\/\//ig)) {
     Diaspora.page.flashMessages.render({success: true, notice: "Protip: Auto-Shorten a url with dia.so by adding a extra / to it in your post, eg http:///domain.com"});
  }
});
