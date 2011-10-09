$("a[href*='dia.so'][class!='expanded'],a[href*='t.co'][class!='expanded'],a[href*='bit.ly'][class!='expanded'],a[href*='goo.gl'][class!='expanded']").live('mouseenter', function() {
  var $self = $(this)
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").append("<span class='via'> "+data+" </span>");
        }
    });
});


