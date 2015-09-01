$(document).ready(function() {
  $('#model').multiselect({nonSelectedText: 'Model'});
  $('#action').multiselect({nonSelectedText: 'Action'});
  $('#origin').multiselect({nonSelectedText: 'Origin'});
  $('#start').datetimepicker({format: "DD/MM/YYYY HH:mm:ss"});
  $('#finish').datetimepicker({format: "DD/MM/YYYY HH:mm:ss"});
  $('[data-toggle="tooltip"]').tooltip()
});

function goBack() {
  window.history.back();
}
