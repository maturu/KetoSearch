$(document).on('turbolinks:load', function() {
  $('.review-item-content').each(function(){
    if($('.review-details', this).height() > 150){
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

  $('.st-header-notification').on('click', function(e){
    $('.notification-dropdown').toggle();
    $('.user-dropdown').css('display', 'none');
    if($('.notification-dropdown').css('display') == 'none'){
      $('body').css('position', 'initial');
      $('body').css('width', 'auto');
      $('body').css('overflow-y', 'auto');
    }else{
      get_notification();
      $('body').css('position', 'fixed');
      $('body').css('width', '100%');
      $('body').css('overflow-y', 'scroll');
    }
    $('.mobile-notification-dropdown').css('left', 0);
    $('.mobile-notification-dropdown .notification-dropdown-container').css('height',
      $(window).outerHeight()-$('.notification-dropdown-header').outerHeight()-16+'px'
    );
    $('.pc-notification-dropdown').css('left', $(this).offset().left-$('.notification-dropdown').width()+14);
  });

  $('.st-header-user').on('click', function(e){
    $('.user-dropdown').toggle();
    $('.notification-dropdown').css('display', 'none');
    if($('.user-dropdown').css('display') == 'none'){
      $('body').css('position', 'initial');
      $('body').css('width', 'auto');
      $('body').css('overflow-y', 'auto');
    }else{
      $('body').css('position', 'fixed');
      $('body').css('width', '100%');
      $('body').css('overflow-y', 'scroll');
    }
    $('.mobile-user-dropdown .user-dropdown-container').css('height', 
      $(window).outerHeight()-$('.user-dropdown-header').outerHeight()-$('.user-dropdown-footer').outerHeight()-16+'px'
    );
    $('.mobile-user-dropdown').css('left', 0);
    $('.pc-user-dropdown').css('left', $(this).offset().left-$('.user-dropdown').width()+32);
  });

  $('.user-dropdown-close').on('click', function(e){
    $('.user-dropdown').css('display', 'none');
    $('body').css('position', 'initial');
    $('body').css('width', 'auto');
    $('body').css('overflow-y', 'auto');
  });

  $('.notification-dropdown-close').on('click', function(e){
    $('.notification-dropdown').css('display', 'none');
    $('body').css('position', 'initial');
    $('body').css('width', 'auto');
    $('body').css('overflow-y', 'auto');
  });
});

$(window).resize(function(){
  $('.mobile-user-dropdown .user-dropdown-container').css('height', 
    $(window).outerHeight()-$('.user-dropdown-header').outerHeight()-$('.user-dropdown-footer').outerHeight()-16+'px'
  );
  $('.mobile-user-dropdown').css('left', 0);
  $('.pc-user-dropdown').css('left', $('.st-header-user').offset().left-$('.user-dropdown').width()+32);
  $('.mobile-notification-dropdown').css('left', 0);
  $('.pc-notification-dropdown').css('left', $('.st-header-notification').offset().left-$('.notification-dropdown').width()+14);
});

$(function(){
  if($('.st-header-notification').size()){
    $(function(){
      setInterval(function(){
        get_attention();
      }, 5000);
    });
  }
});

function get_attention(){
  $.ajax({
    url: '/notifications/attention',
    data: 'id='+$('.notification-dropdown-item:first').data('id'),
    type: 'GET',
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    if(data.length > 0){
      $('#notification-check').css('display', 'block');
    }else{
      $('#notification-check').css('display', 'none');
    }
  })
}

function get_notification(){
  $.ajax({
    url: '/notifications/index',
    type: 'GET',
    processData: false,
    contetType: false,
    dataType: 'json'
  })
  .done(function(data){
    if(data.length > 0){
      $('.notification-dropdown-container').empty();
      $(data).each(function(i, notification){
        if(notification.action == "review"){
          $('.notification-dropdown-container').append(
            '<a class="notification-dropdown-item" data-id="'+notification.id+'" href="/review/show?fid='+notification.food_id+'&id='+notification.review_id+'">'+
              '<div class="user-icon mr-2"><i class="fas fa-user"></i></div>'+
              '<div class="meta">'+
                '<span class="text">'+notification.visiter_name+'様が'+notification.food_name+'をレビューしました。</span>'+
                '<br>'+
                '<span class="date">'+notification.created_at+'</span>'+
              '</div>'+
            '</div>'
          );
        }
      });
    }else{
      $('.notification-dropdown-container').html(
        '<div class="notification-error-text">通知はありません。</div>'
      )
    }
  })
}
