$(document).on('click', '.chart-menu', function(e){
  $('.chart-menu-dropdown', this).toggle();
});

$(document).on('keyup', '.remarks', function(e){
  let count = $(this).val().length;
  $('.text-count').text(count+" / 65535");
  if(count > 0) {
    $('.markdown-help').css('display', 'none');
  }else{
    $('.markdown-help').css('display', 'inline');
  }
});

$(document).on('click', '#food_tag', function(e){
  $('.incremental-tags').css('display', 'inline');
});

$(document).on('click', '.tags-item', function(e){
  let tag = $(this).text();
  $('#food_tag').val(tag);
});

$(document).click(function(event) {
  if(!$(event.target).closest('#food_tag').length) {
    $('.incremental-tags').css('display', 'none');
  }
});

$(document).on('turbolinks:load', function() {
  if($('.remarks').val()){
    if($('.remarks').val().length > 0){
      $('.markdown-help').css('display', 'none');
    }else{
      $('.markdown-help').css('display', 'inline');
    }
  }
});
