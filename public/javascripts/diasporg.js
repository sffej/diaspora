$('.expanded').tipsy({live: true,html:true,title: 'ex'});
$('.expand').live('mouseenter', function() {
  $(this).append("<div class='urlnote' style='diasplay:inline;'><img src='/images/ajax-loader.gif'>Expanding URL</div>")
  var $self = $(this)
    $.ajax({
      url: '/shorten/show?url='+this.href,
        success: function(data) {
        $self.addClass("expanded").removeClass('expand').attr('ex',data).css('color','green');
        }
    });

$('.urlnote').html('URL Expanded - Rehover for info').fadeOut(2000);
});


