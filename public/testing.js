$(".dropdown_list").live('click', function() {
  if ($('.public.radio.selected:contains("Public")').length > 0) {
    $("#publicwarn").show();
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
    $("#publicwarn").hide();
  }
});
$("#aspect_ids_public").live('click', function() {
  if ("#aspect_ids_public option:selected") {
    $("#publicwarn").show();
    console.log("h");
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
    $("#publicwarn").hide();
  }
});

$("header").live("mouseover", function() {
  $("header").css('margin-top','0px');
  $(".diaspora_header_logo").css('margin-top','-6px');
  $(".leftNavBar").css('display','block');
});

$(document).ready(function() {
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
      $(".leftNavBar").css('display','block');
      $("header").css('margin-top','0px');
      $(".diaspora_header_logo").css('margin-top','-6px');
    } else if (fullscreen == "on") {
      $(".leftNavBar").css('display','none');
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
