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

$(document).on('turbolinks:load', function() {
  $('.review-list-item').each(function(){
    if($('.review-details', this).height() > 300){
      $('.review-details', this).css('height', '150px');
      $(this).append(
        '<div class="details-expander-in">'+
          '<i class="fas fa-angle-down mr-1"></i>'+
          '<span class="underline">続きを読む</span>'+
        '</div>'
      );
    }
  });

  $(document).on('click', '.details-expander-in', function(e){
    $(this).prev().css('height', 'auto');
    $('span', this).text("もっと少なく読む");
    $('i', this).removeClass();
    $('i', this).addClass("fas fa-angle-up mr-1");
    $(this).removeClass();
    $(this).addClass("details-expander-out");
  });

  $(document).on('click', '.details-expander-out', function(e){
    $(this).prev().css('height', '150px');
    $('span', this).text("続きを読む");
    $('i', this).removeClass();
    $('i', this).addClass("fas fa-angle-down mr-1");
    $(this).removeClass();
    $(this).addClass("details-expander-in");
  });
});
