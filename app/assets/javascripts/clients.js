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

function loadClient(response) {
  var client = new Client(response);
  client.quickContact = client.concatPhEmail()
  var source = $("#client-show-page-template").html();
  var template = Handlebars.compile(source);
  var result = template(client);
  $("#client-show-page").html(result);
}

function getAdjacentClient(id){
  url = "/clients/" + id;
  $.ajax({
    url: url,
    method: "GET",
    dataType: "JSON",
    success: function(client_data){
      if (client_data) {
        loadClient(client_data);
        attachNextClientListener();
      }
    }
  });
}

function attachNextClientListener(){
  var nextId = parseInt($(".js-next").attr("data-id"));
  $('.js-next').on('click', function(event){
    getAdjacentClient(nextId + 1);
  });
  $('.js-previous').on('click', function(event){
    getAdjacentClient(nextId - 1);
  });
}

$(document).on('turbolinks:load', function(){
  if (!!$('#client-show-page').length) {
    var client_id = window.location.pathname.split("/").pop();
    $.ajax({
      url: '/clients/' + client_id + '.json',
      method: "GET",
      success: function(response) {
        loadClient(response);
        attachNextClientListener();
      }
    });
  };
});
