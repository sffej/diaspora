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
//fullscreen
  var temp = readCookie('fullscreen');
  if (temp) {
    var fullscreen = temp;
  } else {
    var fullscreen = "off";
  }

  $("#fullscreen").click(function() {
  if (fullscreen == "off") 
  {
    fullscreen = "on";
    document.cookie = 'fullscreen=on; path=/'
    Diaspora.page.flashMessages.render({success: true, notice: "Fullscreen mode on for this session"});
  } 
  else if (fullscreen == "on") 
  { 
    fullscreen = "off";
    document.cookie = 'fullscreen=off; path=/'
    Diaspora.page.flashMessages.render({success: true, notice: "Fullscreen mode off"});
  }
  });

  $(window).scroll(function(){
    if ($(window).scrollTop() == 0) {
      $(".leftNavBar").css('opacity','1.0');
      $("header").css('margin-top','0px');
      $(".diaspora_header_logo").css('margin-top','-6px');
    } else if (fullscreen == "on") {
      $(".leftNavBar").css('opacity','0.5');
      $("header").css('margin-top','-39px');
      $(".diaspora_header_logo").css('margin-top','33px').css('border-radius','0 0 10px 10px');
    }
  })
});
function readCookie(name) { 
        var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
