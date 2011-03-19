$(document).ready(function() { 

//  $('#status_message_fake_text').live('keyup', function() {
    $('#status_message_fake_text').jqEasyCounter({'maxChars': 1000,'maxCharsWarning': 140});
//  });
  //$("textarea[id*='comment_text_on_']").live('click', function() {
    $("textarea[id*='comment_text_on_']").jqEasyCounter({'maxChars': 1000,'maxCharsWarning': 140});
  //});

   $('#shorten').qtip({content: 'Shorten your URL by adding an extra / in it!<br>E.g. http:<b>///</b>www.com or https:<b>///</b>www.com',
      position: {my: 'top left', target: 'mouse', viewport: $(window),adjust: {x: 10,  y: 10}},hide: {fixed: true},style: 'ui-tooltip-dark'});
   $('#mention').qtip({content: 'Mention another Diaspora user by entering a @ and then their name',
      position: {my: 'top left', target: 'mouse', viewport: $(window),adjust: {x: 10,  y: 10}},hide: {fixed: true},style: 'ui-tooltip-dark'});
   $('#public').qtip({content: 'Toggle your public services by clicking their icons, when they are highlighted your post will go to them',
      position: {my: 'top left', target: 'mouse', viewport: $(window),adjust: {x: 10,  y: 10}},hide: {fixed: true},style: 'ui-tooltip-dark'});
   $('#aspects').qtip({content: 'Toggle your aspects to have this post go to more than one at a time.',
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

});
