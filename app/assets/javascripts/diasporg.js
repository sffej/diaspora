$("a[href*='http://dia.so'][class!='expanded'],a[href*='http://t.co'][class!='expanded'],a[href*='http://bit.ly'][class!='expanded'],a[href*='http://goo.gl'][class!='expanded'],a[href*='http://j.mp'][class!='expanded'],a[href*='http://is.gd'][class!='expanded']").live('mouseenter', function() {
$(this).css('cursor','wait');
  var $self = $(this)
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").after("<span class='via'> URL Expanded: <a href='"+data+"'>"+data+"</a></span>");
        $self.css('cursor','alias');
        }
    });
});
$("#shorteninvite:not(.done)").live("mousedown", function() {
  var $url = $('#invite_code').val();
    $.ajax({
      url: '/shorten/?url='+$url,
        success: function(data) {
        $('#invite_code').val(data).addClass("done");
        }
    });
});
//$("header").live("mouseover", function() {
    //$("header").css('opacity','1.0');
//});
//$(document).ready(function() {
//$(window).scroll(function(){
    //$("header").css('opacity','0.86');
//})
//});
$(document).ready(function() {
  $("#aspect_nav").mouseover(function() {
    $("#hiddenaspects").removeClass("hidden");
  });
  $("#aspect_nav").mouseout(function() {
    $("#hiddenaspects").addClass("hidden");
  });
  $("#followed_tags_listing").mouseover(function() {
    $("#hiddentags").removeClass("hidden");
  });
  $("#followed_tags_listing").mouseout(function() {
    $("#hiddentags").addClass("hidden");
  });
});

$(".dropdown_list").live('click', function() {
  if ($('.public.radio.selected:contains("Public")').length > 0) {
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
  }
});
$("#aspect_ids_public").live('click', function() {
  if ("#aspect_ids_public option:selected") {
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
  }
});
