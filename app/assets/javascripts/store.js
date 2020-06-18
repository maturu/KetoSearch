var page = 1;

$(document).on('turbolinks:load', function() {
  page = 1;
});

$(window).on('scroll', function(){
  var doc_h = $(document).innerHeight(),
      win_h = $(window).innerHeight(),
      win_bottom = doc_h - win_h;
  if($(window).scrollTop() >= win_bottom) {
    page += 1;
    update(page);
  }
});

function update(page){
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
            '<span class="mr-1">'+
              '<span class="section-total-star" id="star-'+food.id+'"></span>'+
            '</span>'+
            '<span class="review-count">'+food.reviews.length+'個の評価</span>'+
          '</div>'+
          '<div class="food-browse">'+
            '<span>'+food.browse+' 回閲覧・2020年06月14日</span>'+
          '</div>'+
          '<div class="food-price">'+
            '<span class="price-text">価格: </span>'+
            '<span class="price-number">￥'+food.price+'</span>'+
          '</div>'+
        '</a>'
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
    });
  })
}
