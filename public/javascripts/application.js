$(document).ready(function() {
  $('#main_stream').infinitescroll({
    navSelector  : ".pagination",
                   // selector for the paged navigation (it will be hidden)
    nextSelector : ".pagination a.next_page",
                   // selector for the NEXT link (to page 2)
    itemSelector : "#main_stream .stream_element",
                   // selector for all items you'll retrieve
    bufferPx: 300,
    debug: true,
    donetext: "no more.",
    loadingText: "",
    loadingImg: '/images/ajax-loader.gif'
  }, function() {
    $("a.paginate")
      .detach()
      .appendTo("#main_stream")
      .css("display", "block");
      $("abbr.timeago").timeago();
  });

  $(window).unbind('.infscr');
  $('#main_stream + .pagination').hide();
  
  $("a.paginate").live("click", function() {
    $(document).trigger("retrieve.infscr");
  });
  $('span#shorten').qtip({
   content: 'Shorten your URL by adding an extra / in it!<br>E.g. http:<b>///</b>www.com or https:<b>///</b>www.com',
   style: { 
      width: 400,
      padding: 5,
      background: '#444',
      color: 'white',
      textAlign: 'center',
      border: {
         width: 7,
         radius: 5,
         color: '#000'
      },
      tip: 'topLeft',
      name: 'dark' // Inherit the rest of the attributes from the preset dark style
   }
  })
   $(".expand").each(function() {
   $(this).qtip({ 
   content: { url: "/shorten/show/?url="+this.id },
   style: {
      // width: 600,
      padding: 5,
      background: '#444',
      color: 'white',
      textAlign: 'center',
      border: {
         width: 7,
         radius: 5,
         color: '#000'
      },
      tip: 'topLeft'
   }
   });
   });
   $(".qtipimage").each(function() {
   $(this).qtip({
   content:  '<img style="max-width:150px;max-height:150px;"src='+ this.href +'>' ,
   style: {
      // width: 600,
      padding: 1,
      background: '#fff',
      color: 'white',
      textAlign: 'center',
      border: {
         width: 1,
         radius: 5,
         color: '#444'
      },
      tip: 'bottomLeft'
   },
   position: {
      corner: {
         target: 'bottomRight',
         tooltip: 'bottomLeft'
      }
   }

   });
   });

});

