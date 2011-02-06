$(document).ready(function() { 

   $('#status_message_fake_message').jqEasyCounter({'maxChars': 1000,'maxCharsWarning': 140});

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

   $(".expand").live('mouseover', function() {
   $(this).qtip({
      content: { 
           // Set the text to an image HTML string with the correct src URL to the loading image you want to use
            text: '<img class="throbber" src="/images/ajax-loader.gif" alt="Loading..." />',
            ajax: {
               url: "/shorten/show/?url="+this.id
            },
            title: {
               text: 'Expanded URL and Stats: ' + $(this).text(), // Give the tooltip a title using each elements text
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

   $('img.avatar').each(function() {
   $(this).attr('title', this.alt+'\'s pod is '+ this.src.split(/\/+/g)[1].replace(new RegExp(/^www\./i),"").replace(new RegExp(/.s3.amazonaws.com/i),""));
   });
});
  $(function() {
  $( "#chatresizable" ).resizable();
  });

  (function() {
  var s = document.createElement('script'), t = document.getElementsByTagName('script')[0];
  s.type = 'text/javascript';
  s.async = true;
  s.src = 'https://api.flattr.com/js/0.6/load.js?mode=auto';
  t.parentNode.insertBefore(s, t);
  })();

