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
