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
});
