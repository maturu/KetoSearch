var page = 1;

$(document).on('turbolinks:load', function() {
  page = 1;
});

$(window).on({
  'scroll': function(){
    var scrollHeight = $(document).height();
    var scrollPosition = $(window).height() + $(window).scrollTop();
    if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
      page += 1;
      more_data(page);
    }
  }
});

$(document).on('click', '#more-load', function(){
  page += 1;
  more_data(page);
});

$(document).on('click', '.subscribe-btn', function(){
  subscribe();
});

$(document).on('click', '.subscribe-text', function(){
  subscribe();
});

$(document).on('click', '.unsubscribe-btn', function(){
  unsubscribe();
});

$(document).on('click', '.unsubscribe-text', function(){
  unsubscribe();
});

function subscribe(){
  $.ajax({
    url: '/store/subscribe',
    type: 'POST',
    data: ('id='+gon.store_id),
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    $('.buttons').html('<button name="button" type="button" class="unsubscribe-btn">登録済み</button>');
    $('.subscribe-text').remove();
    $('.subscriber').prepend('<span class="unsubscribe-text underline mr-2">登録済み</span>');
    var obj = $('.subscriber .count .count-val');
    obj.text(parseInt(obj.text())+1);
  })
}

function unsubscribe(){
  $.ajax({
    url: '/store/unsubscribe',
    type: 'POST',
    data: ('id='+gon.store_id),
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    $('.buttons').html('<button name="button" type="button" class="subscribe-btn">ストア登録</button>');
    $('.unsubscribe-text').remove();
    $('.subscriber').prepend('<span class="subscribe-text underline mr-2">ストア登録</span>');
    var obj = $('.subscriber .count .count-val');
    obj.text(parseInt(obj.text())-1);
  })
}

function more_data(page){
  $.ajax({
    url: '/store/show',
    type: 'GET',
    data: ('id='+gon.store_id+'&page='+page),
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    $(data).each(function(i, food){
      $('.grid-foods').append(
        '<a class="grid-food-item" href="/chart/show?id='+food.id+'">'+
          '<div class="food-name">'+
            '<span>'+food.name+'</span>'+
          '</div>'+
          '<div class="food-review">'+
          '</div>'+
          '<div class="food-browse">'+
            '<span>'+food.browse+' 回閲覧・2020年06月14日</span>'+
          '</div>'+
          '<div class="food-price">'+
          '</div>'+
        '</a>'
      );

      if(food.price > 0){
        $('.food-price').html(
          '<span class="price-text">価格: </span>'+
          '<span class="price-number">￥'+food.price+'</span>'
        )
      }

      if(food.review_permit){
        $('.food-review').html(
          '<span class="mr-1">'+
            '<span class="section-total-star" id="star-'+food.id+'"></span>'+
          '</span>'+
          '<span class="review-count">'+food.reviews.length+'個の評価</span>'
        );
        var rate = 0;
        $(food.reviews).each(function(i, review){
          rate += review.rate;
        });
        rate = (rate / food.reviews.length).toFixed(1);
        $('#star-'+food.id).empty();
        $('#star-'+food.id).raty({
          starOff: gon.star_off,
          starOn: gon.star_on,
          starHalf: gon.star_half,
          half: true,
          readOnly: true,
          score: rate
        });
        $('#star-'+food.id+' img').css('width', '14px');
        $('#star-'+food.id+' img').removeAttr("title");
        $('#star-'+food.id).removeAttr("title");
      }
    });
  })
}
