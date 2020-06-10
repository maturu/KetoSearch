$(document).on('click', '#tags-item', function(e){
  var tag = $(this).text();
  $('#food_tag').val(tag);
  $('.tags-selector').val(tag);
  $('.tags-selector .select-btn-text').text(tag);
});

$(document).on('click', '#sort-item', function(e){
  var sort = $(this).text();
  $('.sort-selector').val(sort);
  $('.sort-selector .select-btn-text').text(sort);
});

$(document).on('click', '.select-form', function(e){
  $('.incremental-dropdown', this).toggle();
});

$(document).click(function(event) {
  if(!$(event.target).closest('.select-form').length) {
    $('.incremental-dropdown').css('display', 'none');
  }
});

$(document).on('click', '.st-header-user', function(e){
  $('.user-dropdown').toggle();
});

$(document).click(function(event) {
  if(!$(event.target).closest('.st-header-user').length) {
    $('.user-dropdown').css('display', 'none');
  }
});
