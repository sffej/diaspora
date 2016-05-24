$(document).ready(function() {
$("#status_message_fake_text").on('mouseout blur', function() {
var text = $('#status_message_fake_text').val();
urls = text.match(/(https?:\/\/(?:www\.|(?!www))(?!dia\.so)[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/gi);
if (urls) {
$( ".markdownIndications" ).html("").css("color","#000000");
oldurls = urls;
        for(var i=0; i < oldurls.length; i++) {
	$( ".markdownIndications" ).append("<span id="+[i]+" onclick=shorten(\'"+oldurls[i]+"\','"+[i]+"')>URL detected "+oldurls[i]+" click to shorten this URL</span><br>");
        //oldurls[i] = oldurls[i].replace(/\/\//ig, "///");
        }
}
});
$('body').on('mouseenter',"a[href*='//dia.so'][class!='expanded'],a[href*='//t.co'][class!='expanded'],a[href*='//bit.ly'][class!='expanded'],a[href*='//goo.gl'][class!='expanded'],a[href*='//j.mp'][class!='expanded'],a[href*='//is.gd'][class!='expanded']", function() {
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
});
    function progress(percent, $element) {
        var progressBarWidth = percent * $element.width() / 100;
        $element.find('div').animate({ width: progressBarWidth }, 2500).html(percent + "% ");
    }

function shorten(url,id) {
$('#'+id).html("working");
var text = $('#status_message_fake_text').val();
    $.ajax({
      url: '/shorten/?url='+url,
        success: function(data) {
		newdata = data.trim();
		newtext = text.replace(url, newdata);
		$('#status_message_fake_text').val(newtext);
		$('#'+id).html("Link Shortened above");
		setTimeout(function(){
			$('#'+id).remove();
		}, 2000);
        }
    });
}
