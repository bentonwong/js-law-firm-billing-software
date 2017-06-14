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

function buildTableBody(lawyer) {
  for (var i=0; i < lawyer.matters.length; i++) {
    var template_data = {
      matter_id: lawyer.matters[i].id,
      matter_name: lawyer.matters[i].name,
      cliend_id: lawyer.matters[i].client_id,
      client_name: $.grep(lawyer.clients, function(client){ return client.id == lawyer.matters[i].client_id })[0].name,
      hours_billed: lawyer.hoursByMatter(lawyer.matters[i].id)
    };
    renderTableWithHandlebars(template_data);
  }
}

function renderTableWithHandlebars(template_data) {
  var source = $("#lawyer-matters-show-page-template").html();
  var template = Handlebars.compile(source);
  var result = template(template_data);
  $('#show_lawyer_matters').append(result);
}

function buildLawyerTableHeader() {
  const table_header = $("#lawyer-matters-show-page-header-template").html();
  $('table#show_lawyer_matters').append(table_header);
}

function renderLawyersShowTable(lawyer_data) {
  var lawyer = new Lawyer(lawyer_data);
  buildLawyerTableHeader();
  buildTableBody(lawyer);
}

$(document).on('turbolinks:load', function(){
  if (!!$('#show_lawyer_matters').length) {
    $('table#show_lawyer_matters').ready(function(e){
      $('#show_lawyer_matters').empty();
      const lawyer_id = $("#lawyer_show_header").attr("lawyer-id");
      $.ajax({
        url: '/lawyers/' + lawyer_id + ".json",
        method: "GET",
        success: function(lawyer_data) {
          if (lawyer_data.matters.length > 0) {
            renderLawyersShowTable(lawyer_data);
          } else {
            $('table#show_lawyer_matters').html(">> None at this time.");
          }
        }
      });
    });
  };
});
