function TimeEntry(data) {
  this.id = data.id
  this.date = data.date;
  this.description = data.description;
  this.duration = data.duration;
  this.lawyer_name = data.lawyer.name;
  this.matter_id = data.matter_id;
  this.rate = data.rate;
}

TimeEntry.prototype.calculateAttyFee = function() {
  var atty_fee = this.duration * this.rate;
  return '$' + atty_fee.toFixed(2);
}

function addToMattersShowTable(response) {
  var line_entry = new TimeEntry(response);
  var tr_item = ""
  tr_item += "<tr>"
  tr_item += "<td>" + line_entry.date + "</td>"
  tr_item += "<td><a href='/matters/" + line_entry.matter_id + "/time_entries/" + line_entry.id + "'>" + line_entry.description + "</a></td>"
  tr_item += "<td>" + line_entry.duration + "</td>"
  tr_item += "<td>" + line_entry.lawyer_name + "</td>"
  tr_item += "<td align='center'>" + line_entry.calculateAttyFee() + "</td>"
  tr_item += "</tr>"
  $('#show_matter_time_entries tbody').append(tr_item)
}

$(document).on('turbolinks:load', function(){
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
          addToMattersShowTable(response)
          $('#show_matter_time_entries tbody').append(tr_item)
          $("input[type='submit']").removeAttr('disabled');
         },
         error: function(response){
           $("input[type='submit']").removeAttr('disabled');
           $("#errors").html(response.responseText);
         }
       });
    });
  };


//objectified
  if (!!$('#show_matter_time_entries').length) {
    $('#show_matter_time_entries').ready(function(e){
      $('label[for=time_entry_matter],select#time_entry_matter_id').hide();
      $('label[for=time_entry_lawyer],select#time_entry_lawyer_id').hide();
      const matter_id = $("#matter-name").attr("matter-id")
      $.ajax({
        url: '/matters/' + matter_id + '/time_entries',
        method: "GET",
        dataType: "JSON",
        success: function(response){
          const table_header = "<tr><th>Date</th><th>Description</th><th>Duration</th><th>Lawyer</th><th>Fee</tr>"
          $('#show_matter_time_entries').append(table_header)
          for (var i=0; i < response.length; i++){
            addToMattersShowTable(response[i])
          }
        }
      });
    });
  };
});
