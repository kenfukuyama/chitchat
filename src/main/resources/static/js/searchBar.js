$(document).ready(function(){
  $(".live-search-box").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $(".live-search-list").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});