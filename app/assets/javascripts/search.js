$(document).on('turbolinks:load', function() {
  var input = "";
  setInterval(function(){
    input = $.trim($('#search').val());
    destroy(input);
  }, 500);

  $(document).on('input', '#search', function(e){
    e.preventDefault();
    input = $.trim($(this).val());
    update(input);
  });

  $(document).click(function(event) {
    input = $.trim($(this).val());
    if(!$(event.target).closest('#search').length) {
      destroy(input);
    }else{
      update(input);
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
      $('.incremental-content').find('a').remove();
      $('.incremental-search').css('display', 'inline');
      $('.r-intro-searchModel').css({
        'border-bottom-left-radius': '0',
        'border-bottom-right-radius': '0'
      });
      $(data).each(function(i, food){
        $('.incremental-content').append(
          '<a href="/chart/show?id='+food.id+'&search='+food.name+'">'+ 
            '<div>'+
              food.name+
            '</div>'+
          '</a>'
        );
      });
    })
  }

  function destroy(keywords){
    key = keywords.split(/\s/);
    $('.incremental-content').find('a').each(function(i, e){
      key.forEach(function(value){
        if(e.textContent.indexOf(value) == -1 || input == ""){
          $('.incremental-search').css('display', 'none');
          $('.incremental-content').find('a').remove();
          $('.r-intro-searchModel').css({
            'border-radius': '4px'
          });
          return
        }
      })
    })
  }
});
