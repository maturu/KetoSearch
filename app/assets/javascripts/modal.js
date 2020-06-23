var spos;
$(document).on('click', '.modal-open', function(e){
  $('.modal-window').fadeIn();
  if(window.matchMedia && window.matchMedia('(max-width: 959px)').matches){
    $('.st-header').addClass('none');
    $('.p-edit-chart').addClass('none');
    $('.st-footer').addClass('none');
  }
});

$(document).on('click', '.modal-close', function(e){
  $('.modal-window').fadeOut();
  if(window.matchMedia && window.matchMedia('(max-width: 959px)').matches){
    $('.st-header').removeClass('none');
    $('.p-edit-chart').removeClass('none');
    $('.st-footer').removeClass('none');
  }
});

$(document).on('click', '.material-list-item .delete', function(e){
  $(this).parent().remove()
});

$(document).on('click', '.add-item', function(e){
  $('.material-list').append(
    '<div class="material-list-item">'+
      '<span class="name select-form">'+
        '<input autocomplete="off" class="line-name" placeholder="" type="text">'+
        '<div class="incremental-search" style="display: none;">'+
          '<div class="incremental-wrapper">'+
            '<ul class="incremental-content">'+
            '</ul>'+
          '</div>'+
        '</div>'+
      '</span>'+
      '<span class="quantity">'+
        '<input autocomplete="off" class="line-quantity" placeholder="" type="text">'+
      '</span>'+
      '<span class="delete">'+
        '<i class="fas fa-times" aria-hidden="true"></i>'+
      '</span>'+
    '</div>'
  );
  $('.material-list').scrollTop($('.material-list')[0].scrollHeight);
});

var timer;
var obj;
$(document).on('keyup', '.line-name', function(e){
  obj = this;
  e.preventDefault();
  clearTimeout(timer);
  timer = setTimeout(function() {
    modal_inc(obj)
  }, 250);
  destroy();
  if(!$(this).next().find('.incremental-item').length && $(this).val() != ""){
    $(this).next().css('display', 'inline');
    $(this).next().find('.incremental-content').html(
      '<div class="incremental-error">'+ 
        "材料がありません"+
      '</div>'
    );
  }
});

$(document).on('click', '.line-name', function(e){
  obj = this;
  e.preventDefault();
  destroy();
  modal_inc(obj)
});

$(document).click(function(event) {
  if(!$(event.target).closest('.line-name').length) {
    destroy();
  }
});

$(document).on('focus', 'input', function(){
  destroy();
});

$(document).on('click', '.incremental-item', function(e){
  var name = $(this).text();
  $(this).parent().parent().parent().prev().val(name);
});

function modal_inc(obj){
  $.ajax({
    url: '/chart/show',
    type: 'GET',
    data: ('search=' + $.trim($(obj).val())),
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    $(obj).next().find('.incremental-content').empty();
    $(obj).next().css('display', 'inline');
    $(data).each(function(i, food){
      $(obj).next().find('.incremental-content').append(
        '<div class="incremental-item">'+ 
          food[1]+
        '</div>'
      );
    });
    $('.material-list').scrollTop($('.material-list')[0].scrollHeight);
  })
}

function destroy(){
  $('.incremental-search .incremental-content').empty();
  $('.incremental-search').css('display', 'none');
}

$(document).on('click', '.calc-item', function(e){
  var names = [];
  var grams = [];
  $('.line-name').each(function(){
    names.push($(this).val());
  });
  $('.line-quantity').each(function(){
    grams.push($(this).val());
  });
  $.ajax({
    url: '/chart/calc',
    type: 'GET',
    data: ('names='+names+'&grams='+grams),
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    $('#food_gram').val(data.gram);
    $('#food_calorie').val(data.calorie);
    $('#food_protain').val(data.protain);
    $('#food_lipid').val(data.lipid);
    $('#food_carbohydrate').val(data.carbohydrate);
    $('#food_water').val(data.water);
    $('#food_fibtg').val(data.fibtg);
    $('#food_na').val(data.na);
    $('.modal-window').fadeOut();
    if(window.matchMedia && window.matchMedia('(max-width: 959px)').matches){
      $('.st-header').removeClass('none');
      $('.p-edit-chart').removeClass('none');
      $('.st-footer').removeClass('none');
    }
  })
});
