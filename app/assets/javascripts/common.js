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

  $('.st-header-user').on('click', function(e){
    $('.user-dropdown').toggle();
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
});

$(window).resize(function(){
  $('.mobile-user-dropdown .user-dropdown-container').css('height', 
    $(window).outerHeight()-$('.user-dropdown-header').outerHeight()-$('.user-dropdown-footer').outerHeight()-16+'px'
  );
  $('.mobile-user-dropdown').css('left', 0);
  $('.pc-user-dropdown').css('left', $('.st-header-user').offset().left-$('.user-dropdown').width()+32);
});
