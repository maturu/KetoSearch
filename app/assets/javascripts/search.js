$(document).on('click', '.st-header-user', function(e){
  $('.user-dropdown').toggle();
});

$(document).on('turbolinks:load', function() {
  $(document).on('keyup', '#search', function(e){
    e.preventDefault();
    update($.trim($('#search').val()));
    destroy($.trim($('#search').val()));
  });

  $(document).click(function(event) {
    if(!$(event.target).closest('#search').length) {
      destroy($.trim($('#search').val()));
    }else{
      update($.trim($('#search').val()));
    }
  });

  function update(input){
    $.ajax({
      url: '/chart/show',
      type: 'GET',
      data: ('id=&search=' + input),
      processData: false,
      contetType: false,
      dataType: 'json'
    })
    .done(function(data){
      $('.incremental-search .incremental-content').find('a').remove();
      $('.incremental-search').css('display', 'inline');
      $('.r-intro-searchModel').css({
        'border-bottom-left-radius': '0',
        'border-bottom-right-radius': '0'
      });
      $('.st-form-searchModel').css({
        'border-bottom-left-radius': '0',
        'border-bottom-right-radius': '0'
      });
      $(data).each(function(i, food){
        $('.incremental-search .incremental-content').append(
          '<a href="/chart/show?id='+food[0]+'&search='+food[1]+'">'+ 
            '<div>'+
              food[1]+
            '</div>'+
          '</a>'
        );
      });
    })
  }

  function destroy(input){
    input = input.split(/\s/);
    $('.incremental-search .incremental-content').find('a').each(function(i, e){
      input.forEach(function(value){
        if(e.textContent.indexOf(value) == -1 || input == ""){
          $('.incremental-search').css('display', 'none');
          $('.incremental-search .incremental-content').find('a').remove();
          $('.r-intro-searchModel').css({
            'border-radius': '4px'
          });
          $('.st-form-searchModel').css({
            'border-radius': '4px'
          });
          return
        }
      })
    })
  }
});
