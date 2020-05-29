$(document).on('click', '.reset-btn', function(e) {
  $('.item-group input').val("");
  $('.tags-selector .select-btn-text').text("全て");
  $('.sort-selector .select-btn-text').text("指定なし");
});
