/*   Copyright (c) 2010, Diaspora Inc.  This file is
 *   licensed under the Affero General Public License version 3 or later.  See
 *   the COPYRIGHT file.
 */

var Stream = {
  selector: "#main_stream",

  initialize: function() {
    //Diaspora.page.timeAgo.updateTimeAgo(); // this is not needed because
                                             // we do this in both streamelement
                                             // and comment widgets
    Diaspora.page.directionDetector.updateBinds();

    //audio links
    Stream.setUpAudioLinks();
  },

  initializeLives: function(){
    // reshare button action
    $(".reshare_button", this.selector).live("click", function(evt) {
      evt.preventDefault();
      var button = $(this),
        box = button.siblings(".reshare_box");

      if (box.length > 0) {
        button.toggleClass("active");
        box.toggle();
      }
    });

//    this.setUpComments();
  },

  setUpComments: function(){
    // comment link form focus
    $(".focus_comment_textarea", this.selector).live('click', function(evt) {
      Stream.focusNewComment($(this), evt);
    });

    $("textarea.comment_box", this.selector).live("focus", function(evt) {
      if (this.value === undefined || this.value ===  ''){
        var commentBox = $(this);
        commentBox
          .parent().parent()
            .addClass("open");
      }
    });
    $("textarea.comment_box", this.selector).live("blur", function(evt) {
      if (this.value === undefined || this.value ===  ''){
        var commentBox = $(this);
        commentBox
          .parent().parent()
            .removeClass("open");
      }
    });

  },

  setUpAudioLinks: function() {
    $(".stream a[target='_blank']").each(function(r){
      var link = $(this);
      if(this.href.match(/\.mp3$|\.ogg$/)) {
        $("<audio/>", {
          preload: "none",
          src: this.href,
          controls: "controls"
        }).appendTo(link.parent());

        link.remove();
      }
    });
  },

  focusNewComment: function(toggle, evt) {
    evt.preventDefault();
    var post = toggle.closest(".stream_element");
    var commentBlock = post.find(".new_comment_form_wrapper");
    var textarea = post.find(".new_comment textarea");

    if(commentBlock.hasClass("hidden")) {
      commentBlock.removeClass("hidden");
      textarea.focus();
    } else {
      if(commentBlock.children().length <= 1) {
        commentBlock.addClass("hidden");
      } else {
        textarea.focus();
      }
    }
  }
};

$(document).ready(function() {
  if( $(Stream.selector).length == 0 ) { return }
  Stream.initializeLives();
//  Diaspora.page.subscribe("stream/reloaded", Stream.initialize, Stream);
//  Diaspora.page.publish("stream/reloaded");
});
