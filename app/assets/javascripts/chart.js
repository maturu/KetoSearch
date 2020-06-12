$(document).on('change', '#food_enter_allergies', function(e){
  $('#allergies_form').toggle();
});

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

$(document).click(function(event) {
  if(!$(event.target).closest('.chart-menu').length) {
    $('.chart-menu-dropdown').css('display', 'none');
  }
});

$(document).on('turbolinks:load', function() {
  var prop = $('#food_enter_allergies').prop('checked');
  if(prop){
    $('#allergies_form').css("display", "block");
  }else{
    $('#allergies_form').css("display", "none");
  }

  $('.remarks').scroll(function() {
    var h =  Math.round(this.scrollTop / (this.scrollHeight - this.clientHeight)*100) / 100;
    $('.preview-content').scrollTop(($('.preview-content')[0].scrollHeight - $('.preview-content')[0].clientHeight)*h);
  });

  $('.preview-content').scroll(function() {
    var h =  Math.round(this.scrollTop / (this.scrollHeight - this.clientHeight)*100) / 100;
    $('.remarks').scrollTop(($('.remarks')[0].scrollHeight - $('.remarks')[0].clientHeight)*h);
  });

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
