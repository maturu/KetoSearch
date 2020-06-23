$(document).on("ajax:complete", ".violation-report", function(xhr, response, status){
  $(this).parent().html('<div class="alert-container"><i class="fas fa-check mr-1"></i><span>ご報告ありがとうございます。</span></div>');
  $(this).remove();
});

$(document).on("ajax:complete", ".button_to", function(xhr, response, status){
  $(this).parent().prepend('<div class="alert-container"><i class="fas fa-check mr-1"></i><span>フィードバックをお寄せいただきありがとうございます。</span></div>');
  $(this).remove();
});
