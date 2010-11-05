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

$(document).ready(function(){
  $('input[placeholder], textarea[placeholder]').placeholder();

  //Tag cloud search
  $('#tag-name-search').keyup(function(){
    var regexp = new RegExp($(this).val());
    $('.tag-cloud li:hidden').show();
    $('.tag-cloud li').filter(function(){
      return !$('a', this).text().match(regexp);
    }).hide();
    delete regexp;
  });

  $('#search-form').ajaxForm({target: '#results',success: afterSearchComplete});
  $('#tag-name-search').keyup(function(){
    $(this).doTimeout('typing', 1000, function(){$(this).parent('form').submit();});
  });
  $('#tag-name-search').ajaxStart(function() {$(this).addClass('ajax');});
  $('#tag-name-search').ajaxStop(function() {$(this).removeClass('ajax');});

});
