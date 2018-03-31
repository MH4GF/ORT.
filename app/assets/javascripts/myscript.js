$(document).ready(function(){
  $('.post-submenus-btn').click(function(){
    $(this).prev('.post-submenus').toggleClass('open');
  });

  $(document).on('click touchend', function(event) {
    if (!$(event.target).closest('.posts-index-item').length) {
      $('.post-submenus').removeClass('open');
    }
  });
});
