$(function(){
  $('#time_entry_form_submit').on('click', function(e) {
    e.preventDefault();
    saveTimeEntry();
  });
})

function saveTimeEntry(){
  $.ajax({
    url: '/time_entries',
    method: "POST",
    dataType: "JSON",
    data: { time_entry: {
      matter_id: $("select#timße_entry_matter_id option:selected").text(),
      date('2i'): $("select#time_entry_date_2i option:selected").text(),
      date('3i'): $("select#time_entry_date_3i option:selected").text(),
      date('1i'): $("select#time_entry_date_1i option:selected").text(),
      duration: $("input#time_entry_duration").val(),
      rate: $("input#time_entry_rate").val(),
      description: $("input#time_entry_description").val(),
      lawyer_id: $("#select#time_entry_lawyer_id").val(),
      billable: $("input#time_entry_billable").val(),
      paid: $("input#time_entry_paid").val()
      },
      authenticity_token: $("input[name="authenticity_token"]").val();
    },
    success: function(response) {
      debugger
    }
  })
}
