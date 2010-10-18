jQuery.fn.makeExpandable = function(max_height, width) {
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
      $(this).stop(true, false).animate({'max-height':max_height+'px','width':width + 'px'},'fast');
    }
  );
};