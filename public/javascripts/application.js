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

  //Tag cloud search
  $('#tag-name-search').keyup(function(){filterTagCloud($(this).val());});

  $('#search-form').ajaxForm({target: '#results',success: afterSearchComplete});
  $('#tag-name-search').keyup(function(){
    $(this).doTimeout('typing', 1000, function(){$(this).parent('form').submit();});
  });
  $('#tag-name-search').ajaxStart(function() {$(this).addClass('ajax');});
  $('#tag-name-search').ajaxStop(function() {$(this).removeClass('ajax');});

});
