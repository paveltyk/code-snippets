jQuery.fn.makeExpandable = function() {
  var orig_size = {'max-height':$(this).height()+'px','width':$(this).width() + 'px'};
  $(this).hover(
    function(){
      var innerWidth = $("code", this).innerWidth();
      var innerHeight = $("code", this).innerHeight();
      var new_size = {};
      if ($(this).innerWidth() < innerWidth) new_size['width'] = innerWidth + 'px';
      if ($(this).innerHeight() < innerHeight) new_size['max-height'] = innerHeight + 'px';
      $(this).stop(true, false).animate(new_size,'fast');
    },
    function(){
      $(this).stop(true, false).animate(orig_size,'fast');
    }
  );
};