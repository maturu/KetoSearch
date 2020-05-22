$(document).on('click', '.chart-menu', function(e){
  $('.chart-menu-dropdown', this).toggle();
});

$(document).on('keyup', '.remarks', function(e){
  marked.setOptions({
    "baseUrl": null,
    "breaks": true,
    "gfm": true,
    "headerIds": true,
    "headerPrefix": "",
    "highlight": null,
    "langPrefix": "language-",
    "mangle": true,
    "pedantic": false,
    "sanitize": false,
    "sanitizer": null,
    "silent": false,
    "smartLists": false,
    "smartypants": false,
    "tokenizer": null,
    "walkTokens": null,
    "xhtml": false
  });

  $('.md-text').html(marked($(this).val()));
  if($(this).val()){
    $('.markdown-help').css("display", "none");
  } else {
    $('.markdown-help').css("display", "inline");
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
  if(!$(event.target).closest('.chart-menu').length) {
    $('.chart-menu-dropdown').css('display', 'none');
  }
});

$(document).on('click', '.calculate', function(e){
  var cal = $('.calorie-form').val();
  var pro = $('.protain-form').val();
  var lip = $('.lipid-form').val();
  var tmp = Math.round((cal - pro*4 - lip*9)/4 * 10) / 10
  $('.carbohydrate-form').val(tmp);
});

$(document).on('turbolinks:load', function() {
  if($('.remarks').val()){
    marked.setOptions({
      "baseUrl": null,
      "breaks": true,
      "gfm": true,
      "headerIds": true,
      "headerPrefix": "",
      "highlight": null,
      "langPrefix": "language-",
      "mangle": true,
      "pedantic": false,
      "sanitize": false,
      "sanitizer": null,
      "silent": false,
      "smartLists": false,
      "smartypants": false,
      "tokenizer": null,
      "walkTokens": null,
      "xhtml": false
    });

    $('.md-text').html(marked($('.remarks').val()));
    $('.markdown-help').css("display", "none");
  } else {
    $('.markdown-help').css("display", "inline");
  }
});
