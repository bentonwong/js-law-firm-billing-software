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

function Lawyer(data) {
  this.id = data.id;
  this.name = data.name;
  this.clients = data.clients;
  this.matters = data.matters;
  this.time_entries = data.time_entries;
}

Lawyer.prototype.hoursByMatter = function(id) {
  var sum = 0;
  for (var i=0; i < this.time_entries.length; i++) {
    if (this.time_entries[i].matter_id === id) {
      sum = sum + parseFloat(this.time_entries[i].duration);
    }
  }
  return sum;
}

function Client(data) {
  this.id = data.id
  this.name = data.name;
  this.address = data.address;
  this.phone = data.phone;
  this.email = data.email;
}

Client.prototype.concatPhEmail = function() {
  return "Phone: " + this.phone + " | Email: " + this.email;
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

function addToLawyersShowTable(response) {
  var lawyerToShow = new Lawyer(response);
  const response_matters = response.matters
  for (var i=0; i < response_matters.length; i++) {
    var matter_client_id = response_matters[i].client_id
    var client = response.clients.filter(function(o){
      return o.id === matter_client_id;
    });
    var tr_item = ""
    tr_item += "<tr>"
    tr_item += "<td style='text-align:center'>" + response_matters[i].id + "</td>"
    tr_item += "<td><a href='/matters/" + response_matters[i].id + "'>" + response_matters[i].name + "</a></td>"
    tr_item += "<td><a href='/clients/" + response_matters[i].client_id + "'>" + client[0].name + "</a></td>"
    tr_item += "<td style='text-align:center'>" + lawyerToShow.hoursByMatter(response_matters[i].id) + "</td>"
    tr_item += "</tr>"
    $('#show_lawyer_matters').append(tr_item)
  }
}

function loadClient(response) {
  var client = new Client(response);
  client.quickContact = client.concatPhEmail()
  var source = $("#client-show-page-template").html();
  var template = Handlebars.compile(source);
  var result = template(client);
  $("#client-show-page").html(result);
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

  if (!!$('#show_lawyer_matters').length) {
    $('table#show_lawyer_matters').ready(function(e){
      $('#show_lawyer_matters').empty()
      const lawyer_id = $("#lawyer_show_header").attr("lawyer-id");
      $.ajax({
        url: '/lawyers/' + lawyer_id,
        method: "GET",
        dataType: "JSON",
        success: function(response){
          const table_header = "<tr><th>Matter ID</th><th>Matter</th><th>Client</th><th>Hours Billed</th></tr>"
          $('table#show_lawyer_matters').append(table_header)
          addToLawyersShowTable(response)
        }
      });
    });
  };

  if (!!$('#client-show-page').length) {
    var client_id = window.location.pathname.split("/").pop();
    $.ajax({
      url: '/clients/' + client_id,
      method: "GET",
      dataType: "JSON",
      success: function(response) {
        loadClient(response);
        attachNextClientListener();
      }
    });
  };

});

function getAdjacentClient(id){
  url = "/clients/" + id;
  $.ajax({
    url: url,
    method: "GET",
    dataType: "JSON",
    success: function(data){
      if (data) {
        loadClient(data);
        attachNextClientListener();
      }
    }
  });
}

function attachNextClientListener(){
  $('.js-next').on('click', function(event){
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    getAdjacentClient(nextId)
  });
  $('.js-previous').on('click', function(event){
    var nextId = parseInt($(".js-next").attr("data-id")) - 1;
    getAdjacentClient(nextId)
  });
}
