$('.expanded').tipsy({live: true,html:true});
$('.expand').live('mouseenter', function() {
  $(this).append("<div class='urlnote'>Short URL Expanded</div>")
  var $self = $(this)
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").removeClass('expand').attr('title',data).css('color','green');
        }
    });
$('.urlnote').hide(1500);
});


