$(document).ready(function(){
  //$('pre').makeExpandable(145, 520);
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
