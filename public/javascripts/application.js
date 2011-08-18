function hideDescriptions() {
  $('article .description').before('<a href="#" class="show-description">Show description</a>').hide();
  $('.show-description').click(function(){
    var item_to_show = $(this).next('.description');
    $(this).remove();
    item_to_show.fadeIn();
    return false;
  });
  $('article').hover(
          function(){$('.show-description', this).fadeIn();},
          function(){$('.show-description', this).fadeOut();});
}

function afterSearchComplete(){
  $('pre code').each(function(i, e) {hljs.highlightBlock(e)});hideDescriptions();
}

function filterTagCloud(str) {
  var regexp = new RegExp(str);
  $('.tag-cloud li:hidden').show();
  $('.tag-cloud li').filter(function(){
    return !$('a', this).text().match(regexp);
  }).hide();
  delete regexp;
}

$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').placeholder();

  $("textarea").keydown(function(e) {
    var start = this.selectionStart;
    var end = this.selectionEnd;
    var val = $(this).val();
    switch(e.keyCode) {
      case 13:
        var match = val.substring(0, start).match(/(^|\n)([ \t]*)([^\n]*)$/);
        if (!match) return;
        var spaces = match[2];
        var length = spaces.length + 1;
        $(this).val(val.substring(0, start) + '\n' + spaces + val.substr(end));
        this.setSelectionRange(start + length, start + length);
        return false;
      case 9:
        if (end - start == 0) {
          $(this).val(val.substring(0, start) + '  ' + val.substr(end));
          this.setSelectionRange(start + 2, start + 2);
        }
        return false;
    }
  })

  //OpenID
  $('#user_session_openid_identifier').blur(function() {
    var input = $(this);
    if (input.val() == 'http://') {
      input.val('');
    }
  }).focus(function() {
    var input = $(this);
    if (!input.val()) {
      input.val('http://');
    }
  });

  //Tag cloud search
  $('#tag-name-search').keyup(function(){filterTagCloud($(this).val());});

  $('#search-form').ajaxForm({target: '#results',success: afterSearchComplete});
  $('#tag-name-search').keyup(function(){
    $(this).doTimeout('typing', 1000, function(){$(this).parent('form').submit();});
  });
  $('#tag-name-search').ajaxStart(function() {$(this).addClass('ajax');});
  $('#tag-name-search').ajaxStop(function() {$(this).removeClass('ajax');});

});
