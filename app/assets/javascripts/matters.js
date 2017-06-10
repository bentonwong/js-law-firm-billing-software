$(function(){
  $("#new_time_entry").on("submit", function(e) {
    e.preventDefault();
    url = this.action
    data = {
      'authenticity_token': $("input[name='authenticity_token']").val(),
      'time_entry': {
        'matter_id': $("select#time_entry_matter_id option:selected").val(),
        'date(2i)': $("select#time_entry_date_2i option:selected").val(),
        'date(3i)': $("select#time_entry_date_3i option:selected").val(),
        'date(1i)': $("select#time_entry_date_1i option:selected").val(),
        'duration': $("input#time_entry_duration").val(),
        'rate': $("input#time_entry_rate").val(),
        'description': $("textarea#time_entry_description").val(),
        'lawyer_id': $("select#time_entry_lawyer_id option:selected").val(),
        'billable': $("input#time_entry_billable").val(),
        'paid': $("input#time_entry_paid").val()
        }
      };
    $.ajax({
      url: url,
      method: "POST",
      data: data,
      success: function(response){
        $(".new_time_entry").trigger("reset");
        $("input[type='submit']").removeAttr('disabled');
          if ($.isPlainObject(response)) {
            $("#errors").empty();
            $("#show_matter_time_entries").append("<li>"+response.description+"</li>");
          } else {
            $("#errors").html(response);
          }
          $("input[type='submit']").removeAttr('disabled');
       }
     });
  });
});
