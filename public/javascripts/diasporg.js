$(document).ready(function()
{
$('.expand').tipsy({live: true,html:true,fallback:'Getting Data, rehover on URL to refresh!'});
   $('.expand').live('mouseover',function()
   {
     $.ajax({
     url: "/shorten/show/?url="+this.href,
       success: function(data) {
       $(this).addClass("done");
       $(this).attr('title',data);
       }
     });

   });

});


