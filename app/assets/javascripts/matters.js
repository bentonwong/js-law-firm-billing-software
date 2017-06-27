function TimeEntry(data) {
  this.id = data.id;
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
  var time_entry = new TimeEntry(response);
  var template_data = {
    te_id: time_entry.id,
    matter_id: time_entry.matter_id,
    date: time_entry.date,
    description: time_entry.description,
    duration: time_entry.duration,
    lawyer_name: time_entry.lawyer_name,
    atty_fee: time_entry.calculateAttyFee()
  };

  var source = $("#matters-time-entries-show-page-template").html();
  var template = Handlebars.compile(source);
  var result = template(template_data);
  $('table#show_matter_time_entries').append(result);
}

function readForm() {
  return {
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
      'billable': $("input#time_entry_billable").is(':checked') ? "1" : "0",
      'paid': $("input#time_entry_paid").is(':checked') ? "1" : "0"
      }
    };
}

function setupHeader() {
  $('#show_matter_time_entries').empty();
  const table_header = $("#matters-time-entries-show-page-header-template").html();
  $('#show_matter_time_entries').html(table_header);
}

function resetForm() {
  $(".new_time_entry").trigger('reset');
  $("#errors").empty();
  $("input[type='submit']").removeAttr('disabled');
}

function deleteTimeEntry(matterId, timeEntryId){
  url = "/matters/" + matterId + "/time_entries/" + timeEntryId
  console.log(url)
  /*$.ajax({
    url: url,
    method: "DELETE",
    success: function(response){
    },
    error: function(response){
    }
  })*/
}

function attachDeleteTimeEntryListener(){
  $('button.delete-time-entry-button').on('click', function(event){
    event.preventDefault();
    var matterId = $('h3#matter-name').attr('matter-id');
    var timeEntryToBeDeleteId = event.target.id;
    deleteTimeEntry(matterId, timeEntryToBeDeleteId);
  })
}

function enableDeleteTimeEntry(){
  attachDeleteTimeEntryListener()
}

$(document).on('turbolinks:load', function(){
  if (!!$('#show_matter_time_entries').length) {

    $('#show_matter_time_entries').ready(function(e){
      const matter_id = $("#matter-name").attr("matter-id")
      $.ajax({
        url: '/matters/' + matter_id + '/time_entries',
        method: "GET",
        dataType: "JSON",
        success: function(response) {
          if (response.length > 0) {
            setupHeader();
            for (var i=0; i < response.length; i++){
              addToMattersShowTable(response[i]);
            }
            enableDeleteTimeEntry();
          } else {
            $('#show_matter_time_entries').html(">> This matter does not have any time entries.");
          }
        }
      });
    }); //end of this function

    $('form#new_time_entry.new_time_entry').ready(function(e){

      if(!$('div#turn_off_event_handler').length){
        $("#new_time_entry").on("submit", function(e) {
          e.preventDefault();
          url = this.action;
          data = readForm();
          $.ajax({
            url: url,
            method: "POST",
            data: data,
            dataType: "JSON",
            success: function(response){
             if ($('#show_matter_time_entries').text() === ">> This matter does not have any time entries.") {
                setupHeader(); //puts in a header if no prior time entries
             }
             addToMattersShowTable(response);
             resetForm();
            },
             error: function(response){
               $("input[type='submit']").removeAttr('disabled');
               $("#errors").html(response.responseText);
            }
           });
        });
      }; //end of this if statement

    }); //end of $('form#new_time_entry.new_time_entry').ready(function(e){})
  }; //end of if statement
});
