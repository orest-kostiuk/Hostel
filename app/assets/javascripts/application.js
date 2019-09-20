// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-sprockets
//= require_tree .
$( document ).on('turbolinks:load', function() {
  let n = $('.collapse').length;
  let z = $('.content').length;
  let item = $('.content').eq(z-1);
  let item_index = $(item).data('index');
  function removeLine() {
    item.toggleClass('set-border')
  }

  $(`#content-accordion_${item_index}`).addClass('set-border');

  $('.accordion').on('show.bs.collapse hide.bs.collapse', function () {
    let notification_id = $(this).data('index');
    $(`#notification-text-${notification_id}`).before(function() {
      if ($( `.item-${notification_id}` ).hasClass('no-read')) {
        let request = $.ajax({
          url: "/read_notification",
          method: "POST",
          data: { id : notification_id },
          dataType: "html"
        });
        request.done(function(data) {
          $( `.item-${notification_id}` ).removeClass('no-read');
          if(data == '0'){
            $('.notification_count').hide();
          }else{
            $('.notification_count').text(data);
          }
        });
      }
      if (!$(`#notification-hide-${notification_id}`).hasClass('d-none')) {
        $(`#notification-hide-${notification_id}`).addClass('d-none  before');
        $(`.align-self-start-${notification_id}`).css("white-space", "nowrap");
      }}).fadeToggle(200, 'swing', function() {
        if ($(`#notification-hide-${notification_id}`).hasClass('before')) {
          $(`#notification-hide-${notification_id}`).removeClass('before');
        }else {
          $(`#notification-hide-${notification_id}`).removeClass('d-none ');
          $(`.align-self-start-${notification_id}`).css("white-space", "normal");
        }
      }
    );
  });

  //
  item.addClass('set-border');
  item.on('click', function() {
    item.hasClass('set-border') ? setTimeout(removeLine, 0) : setTimeout(removeLine, 300)
  });
});