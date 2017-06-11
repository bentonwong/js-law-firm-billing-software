$(function(){
  if(!$('div#turn_off_event_handler').length){
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
        dataType: "JSON",
        success: function(response){
          $(".new_time_entry").trigger("reset");
          $("input[type='submit']").removeAttr('disabled');
          $("#errors").empty();
          var li_item = undefined
          li_item += "<tr>"
          li_item += "<td>" + response.date + "</td>"
          li_item += "<td>" + response.description + "</td>"
          li_item += "<td>" + response.duration + "</td>"
          li_item += "<td>" + response.lawyer.name + "</td>"
          li_item += "</tr>"
          $('#show_matter_time_entries tbody').append(li_item)
          $("input[type='submit']").removeAttr('disabled');
         },
         error: function(response){
           $("input[type='submit']").removeAttr('disabled');
           $("#errors").html(response.responseText);
         }
       });
    });
  }
  if (!!$('#show_matter_time_entries').length) {
    $("#show_matter_time_entries").ready(function(e){
      //e.preventDefault();
      const matter_id = $("#matter-name").attr("matter-id")
      $.ajax({
        url: '/matters/' + matter_id + '/time_entries',
        method: "GET",
        dataType: "JSON",
        success: function(response){
          const table_header = "<tr><th>Date</th><th>Description</th><th>Duration</th><th>Lawyer</th></tr>"
          $('#show_matter_time_entries').append(table_header)
          for (var i=0; i < response.length; i++){
            var li_item = undefined
            li_item += "<tr>"
            li_item += "<td>" + response[i].date + "</td>"
            li_item += "<td>" + response[i].description + "</td>"
            li_item += "<td>" + response[i].duration + "</td>"
            li_item += "<td>" + response[i].lawyer.name + "</td>"
            li_item += "</tr>"
            $('#show_matter_time_entries').append(li_item)
          }
        }
      });
    });
  }
});
