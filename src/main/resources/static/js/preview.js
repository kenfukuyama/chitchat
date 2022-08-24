$('a[rel=popover]').popover().click(function(e) {
  e.preventDefault();
  var open = $(this).attr('data-easein');
  $(this).next().velocity('transition.' + open);

});

// add the animation to the modal
$(".modal").each(function(index) {
  $(this).on('show.bs.modal', function(e) {
    var open = $(this).attr('data-easein');
    $('.modal-dialog').velocity('transition.' + open);

  });
});