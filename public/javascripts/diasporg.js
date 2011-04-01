$(document).ready(function() { 

   $(".expand").live('mouseover', function() {
   $(this).qtip({
      content: { 
            text: '<img class="throbber" src="/images/ajax-loader.gif" alt="Loading..." />',
            ajax: {
               url: "/shorten/show/?url="+this.href
            },
            title: {
               text: 'Expanded URL and Stats: ' + $(this).text(),
               button: false
            },
      },
      show: {
         ready: true // Needed to make it show on first mouseover event
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

   $(".qtipimage").live('mouseover', function() {
   $(this).qtip({
      content: '<img style="max-width:150px;max-height:150px;"src='+ this.href +'>',
      show: {
         ready: true // Needed to make it show on first mouseover event
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

});
