/*   Copyright (c) 2010, Diaspora Inc.  This file is
*   licensed under the Affero General Public License version 3 or later.  See
*   the COPYRIGHT file.
*/

var Mobile = {
  initialize: function() {
    $("abbr.timeago").timeago();
    $('#aspect_picker').change(Mobile.changeAspect);
  },
  
  changeAspect: function() {
    Mobile.windowLocation('/aspects/' + $('#aspect_picker option:selected').val());
  },
  
  windowLocation: function(url) {
    window.location = url;
  }
};

