$(document).ready(function(){
  $('.post-submenus-btn').click(function(){
    $(this).prev('.post-submenus').toggleClass('open');
  });

  $(document).on('click touchend', function(event) {
    if (!$(event.target).closest('.posts-index-item').length) {
      $('.post-submenus').removeClass('open');
    }
  });

  $('.about-continue').click(function(){
    var speed = 800;
    var position = $('#how').offset().top;
    $("html, body").animate({scrollTop:position}, speed, "swing");
    return false;
  });
});
