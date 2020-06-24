$(document).on('turbolinks:load', function() {
  var timer;
  $(document).on('input', '#search', function(e){
    e.preventDefault();
    clearTimeout(timer);
    timer = setTimeout(function() {
      searcu_inc($.trim($('#search').val()))
    }, 250);
    destroy($.trim($('#search').val()));
  });

  $(document).click(function(event) {
    if(!$(event.target).closest('#search').length) {
      destroy($.trim($('#search').val()));
    }else{
      searcu_inc($.trim($('#search').val()));
    }
  });

  function searcu_inc(input){
    $.ajax({
      url: '/chart/show',
      type: 'GET',
      data: ('search=' + input),
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
          '<a class="incremental-item" href="/chart/show?id='+food[0]+'">'+ 
            food[1]+
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
