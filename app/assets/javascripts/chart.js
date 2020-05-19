$(document).on('click', '.chart-menu', function(e){
  $('.chart-menu-dropdown', this).toggle();
});

$(document).on('keyup', '.remarks', function(e){
  if($(this).val()){
    var count = $(this).val().length;
    $('.text-count').text(count+" / 65535");
    if(count > 0) {
      $('.markdown-help').css('display', 'none');
    }else{
      $('.markdown-help').css('display', 'inline');
    }
  }
});

$(document).on('click', '#food_tag', function(e){
  $('.incremental-tags').css('display', 'inline');
});

$(document).on('click', '.tags-item', function(e){
  var tag = $(this).text();
  $('#food_tag').val(tag);
});

$(document).click(function(event) {
  if(!$(event.target).closest('#food_tag').length) {
    $('.incremental-tags').css('display', 'none');
  }
});

$(document).on('click', '.caluculate', function(e){
  var cal = $('.calorie-form').val();
  var pro = $('.protain-form').val();
  var lip = $('.lipid-form').val();
  $('.carbohydrate-form').val((cal - pro*4 - lip*9)/4);
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
