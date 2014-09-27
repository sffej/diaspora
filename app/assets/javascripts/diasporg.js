$(document).ready(function() {
//dia.so notify
$("#status_message_fake_text").blur(function() {
var text = $('#status_message_fake_text').val();
  if (text.match(/:\/\//ig)) {
     Diaspora.page.flashMessages.render({success: true, notice: "Protip: Auto-Shorten a url with dia.so by adding a extra / to it in your post, eg http:///domain.com"});
  }
});

$('body').on('mouseenter',"a[href*='http://dia.so'][class!='expanded'],a[href*='http://t.co'][class!='expanded'],a[href*='http://bit.ly'][class!='expanded'],a[href*='http://goo.gl'][class!='expanded'],a[href*='http://j.mp'][class!='expanded'],a[href*='http://is.gd'][class!='expanded']", function() {
$(this).css('cursor','wait');
  var $self = $(this);
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").after("<span class='via'> URL Expanded: <a href='"+data+"'>"+data+"</a></span>");
        $self.css('cursor','alias');
        }
    });
});
$('body').on('click', '.dropdown_list', function() {
  if ($('.public.radio.selected:contains("Public")').length > 0) {
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
  }
});
$('body').on('click', '#aspect_ids_public', function() {
  if ("#aspect_ids_public option:selected") {
    Diaspora.page.flashMessages.render({success: true, notice: "Public post mode on, post will be public internet wide."});
  } else {
  }
});
});
