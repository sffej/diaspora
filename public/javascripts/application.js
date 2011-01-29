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
   $('#shorten').qtip({
      content: 'Shorten your URL by adding an extra / in it!<br>E.g. http:<b>///</b>www.com or https:<b>///</b>www.com',
      position: {
         my: 'top left',
         target: 'mouse',
         viewport: $(window), // Keep it on-screen at all times if possible
         adjust: {
            x: 10,  y: 10
         }
      },
      hide: {
         fixed: true // Helps to prevent the tooltip from hiding ocassionally when tracking!
      },
      style: 'ui-tooltip-dark'
   });
 $(".expand").each(function() {
   $(this).qtip({
      content: { 
           // Set the text to an image HTML string with the correct src URL to the loading image you want to use
            text: '<img class="throbber" src="/images/ajax-loader.gif" alt="Loading..." />',
            ajax: {
               url: "/shorten/show/?url="+this.id
            },
            title: {
               text: 'Expanded URL and Stats: ' + $(this).text(), // Give the tooltip a title using each elements text
               button: true
            }

      },
      position: {
         my: 'top left',
         target: 'mouse',
         viewport: $(window), // Keep it on-screen at all times if possible
         adjust: {
            x: 10,  y: 10
         }
      },
      hide: {
         fixed: true // Helps to prevent the tooltip from hiding ocassionally when tracking!
      },
      style: 'ui-tooltip-dark'
   });
});
   $(".qtipimage").each(function() {
   $(this).qtip({
      content: '<img style="max-width:150px;max-height:150px;"src='+ this.href +'>',
      position: {
         my: 'top left',
         target: 'mouse',
         viewport: $(window), // Keep it on-screen at all times if possible
         adjust: {
            x: 10,  y: 10
         }
      },
      hide: {
         fixed: true // Helps to prevent the tooltip from hiding ocassionally when tracking!
      },
      style: 'ui-tooltip-dark'
   });
});

});

