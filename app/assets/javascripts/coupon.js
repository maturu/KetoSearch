$(document).on('turbolinks:load', function() {
  $(document).on("change", '#gold', function(){
    $('.coupon-type input[type="checkbox"]').prop('checked', false);
    $(this).prop('checked', true);
    $('#coupon_coupon_color').val("gold");
    $('.coupon-card').css("background", "linear-gradient(to bottom, #ffce00, #ffa700)");
    $('.coupon-card-header').css("color", "#ffce00");
    $('.coupon-expiration').css("color", "#ffa700");
    white();
  });

  $(document).on("change", '#silver', function(){
    $('.coupon-type input[type="checkbox"]').prop('checked', false);
    $(this).prop('checked', true);
    $('#coupon_coupon_color').val("silver");
    $('.coupon-card').css("background", "linear-gradient(to bottom,#f7f8fa,#e7e9ec)");
    $('.coupon-card-container').css("border-color", "#767676");
    $('.coupon-card-header').css("color", "#fff");
    $('.coupon-card-header').css("background", "#767676");
    $('.coupon-price').css("color", "#767676");
    $('.signature').css("border-color", "#767676");
    $('.coupon-expiration').css("color", "#fff");
    $('.coupon-expiration').css("background-color", "#767676");
  });

  $(document).on("change", '#bronze', function(){
    $('.coupon-type input[type="checkbox"]').prop('checked', false);
    $(this).prop('checked', true);
    $('#coupon_coupon_color').val("bronze");
    $('.coupon-card').css("background", "linear-gradient(to bottom, #ffe8d7, #ab6300)");
    $('.coupon-card-header').css("color", "#ffe8d7");
    $('.coupon-expiration').css("color", "#ab6300");
    white();
  });

  $(document).on("change", '#normal', function(){
    $('.coupon-type input[type="checkbox"]').prop('checked', false);
    $(this).prop('checked', true);
    $('#coupon_coupon_color').val("normal");
    $('.coupon-card').css("background", "linear-gradient(to bottom, #00b8ff, #0053ff)");
    $('.coupon-card-header').css("color", "#00b8ff");
    $('.coupon-expiration').css("color", "#0053ff");
    white();
  });

  $(document).on("input", '#coupon_signature', function(){
    $('.signature #signature-text').text($(this).val());
  });

  $(document).on("input", '#coupon_price', function(){
    var num = Number($(this).val());
    if(window.matchMedia && window.matchMedia('(max-width: 414px)').matches){
      var font = 35;
      var offfont = 20;
    }else{
      var font = 70;
      var offfont = 40;
    }

    $('.price-num').text(num.toLocaleString());
    if(num >= 10000){
      $('.price-num, .yen').css('font-size', font-10+'px');
      $('.off').css('font-size', offfont-10+'px');
    }
    if(num < 10000){
      $('.price-num, .yen').css('font-size', font+'px');
      $('.off').css('font-size', offfont+'px');
    }
    if(num >= 1000000000){
      $('.price-num, .yen').css('font-size', font-20+'px');
      $('.off').css('font-size', offfont-20+'px');
    }
    if(num >= 10000 && num < 1000000000){
      $('.price-num, .yen').css('font-size', font-10+'px');
      $('.off').css('font-size', offfont-10+'px');
    }
  });

  $(document).on("change", '#coupon_expiration_date', function(){
    $('.coupon-expiration span').text($(this).val());
  });
});

$(document).on("ajax:complete", ".coupon-use-btn", function(xhr, response, status){
  $(this).parent().html(
    '<div class="meta">'+
      '<span>下のボタンをお会計の際、店員さんにお見せください。お客様が誤って押してしまった場合、このクーポンはもう使えなくなります。</span>'+
      '<span>飲食店の方はこのクーポンの使用を許可する場合、下のボタンを押してください。</span>'+
    '</div>'+
    '<a class="coupon-use-confirm-btn" data-confirm="このクーポンの使用を許可しますか？"'+
    'data-remote="true" rel="nofollow" data-method="post" href="/coupon/confirm?id='+gon.coupon_id+'">'+
      '飲食店用確認ボタン'+
    '</a>'
  );
  $(this).remove();
});

$(document).on("ajax:complete", ".coupon-use-confirm-btn", function(xhr, response, status){
  $(this).parent().html('<div class="used-and-confirmed"><span>使用済み</span></div>');
  $(this).remove();
  $('.coupon-card').removeClass("gold");
  $('.coupon-card').removeClass("silver");
  $('.coupon-card').removeClass("bronze");
  $('.coupon-card').removeClass("normal");
  $('.coupon-card').addClass("used");
})

function white(){
  $('.coupon-card-container').css("border-color", "#fff");
  $('.coupon-card-header').css("background", "#fff");
  $('.coupon-price').css("color", "#fff");
  $('.signature').css("border-color", "#fff");
  $('.coupon-expiration').css("background-color", "#fff");
}
