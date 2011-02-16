$(document).ready(function() { 

   $('#status_message_fake_message').jqEasyCounter({'maxChars': 1000,'maxCharsWarning': 140});
   $("textarea[id*='comment_text_on_']").jqEasyCounter({'maxChars': 1000,'maxCharsWarning': 140});
   $('#shorten').qtip({content: 'Shorten your URL by adding an extra / in it!<br>E.g. http:<b>///</b>www.com or https:<b>///</b>www.com',
      position: {my: 'top left', target: 'mouse', viewport: $(window),adjust: {x: 10,  y: 10}},hide: {fixed: true},style: 'ui-tooltip-dark'});

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

   $(".avatar").live('mouseover', function() {
   $(this).qtip({
      content: this.alt+'\'s pod is '+ this.src.split(/\/+/g)[1].replace(new RegExp(/^www\./i),"").replace(new RegExp(/.s3.amazonaws.com/i),""),
      show: {
         ready: true // Needed to make it show on first mouseover event
      },
      position: {
         my: 'bottom left',
         target: $(this),
         viewport: $(window), // Keep it on-screen at all times if possible
         adjust: {
            x: -10,  y: -40
         }
      },
      hide: {
         fixed: true // Helps to prevent the tooltip from hiding ocassionally when tracking!
      },
      style: 'ui-tooltip-dark'
   });
   });


});
