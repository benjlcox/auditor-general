$(document).ready(function() {
  $('#model').multiselect();
  $('#action').multiselect();
  $('#origin').multiselect();
  $('#start').datetimepicker({format: "DD/MM/YYYY HH:mm:ss"});
  $('#finish').datetimepicker({format: "DD/MM/YYYY HH:mm:ss"});
  $('[data-toggle="tooltip"]').tooltip()
});

function goBack() {
  window.history.back();
}
