$(document).ready(function() {
  $('#model').multiselect();
  $('#action').multiselect();
  $('#origin').multiselect();

  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
});

function goBack() {
  window.history.back();
}
