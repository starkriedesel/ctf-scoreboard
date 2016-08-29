function setAffiliation() {
  var affiliation = $('#affiliation-select').val();
  $('#affiliation-text').val(affiliation);
  if (affiliation == '') {
    $('#affiliation-text').show();
  } else {
    $('#affiliation-text').hide();
  }
}

$('#affiliation-select').on('change', function() {
  setAffiliation();
});

$(function () {
  if ($('#affiliation-select').length > 0) {
    setAffiliation();
  }
});

