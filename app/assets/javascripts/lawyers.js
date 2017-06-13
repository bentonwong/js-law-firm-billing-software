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

$(document).on('turbolinks:load', function(){
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
          addToLawyersShowTable(response);
        }
      });
    });
  };
});
