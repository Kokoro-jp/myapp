$(document).on('turbolinks:load', function() {
  $('.tab').on('click', function() {
    $('.tab, .panel').removeClass('active');
    $(this).addClass('active');
    var index = $('.tab').index(this);
    $('.panel').eq(index).addClass('active');
  });
});
