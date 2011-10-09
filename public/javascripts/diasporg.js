$("a[href*='http://dia.so'][class!='expanded'],a[href*='http://t.co'][class!='expanded'],a[href*='http://bit.ly'][class!='expanded'],a[href*='http://goo.gl'][class!='expanded']").live('mouseenter', function() {
$(this).css('cursor','wait');
  var $self = $(this)
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").append("<span class='via'> "+data+" </span>");
        $self.css('cursor','alias');
        }
    });
});


$("a[href*='youtube.com'],a[href*='youtu.be']").live({
      mouseenter: function() { 
        var $self = $(this);
        if (this.href.indexOf("youtu.be") > 0) {
       	   id =	this.href.split("/");
           check = "http://www.youtube.com/watch?v="+id[3];
        } else {
           check = this.href
        }
        url = $.jYoutube(check);
          $self.append("<span id='youtubeimg'><br><img src="+url+"></span>");
      },
      mouseleave: function() { 
          $("span#youtubeimg").delay(633).remove();
      }
});

