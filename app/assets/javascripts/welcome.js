$(function(){
  console.log("ready!");
})

function initMap() {
  var uluru = {lng: -21.949227, lat: 64.140457};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: uluru
  });
  var marker = new google.maps.Marker({
    position: uluru,
    map: map
  });


  $('form').submit(function() {
      var valuesToSubmit = "3000";
      // $(this).serialize();
      $.ajax({
          type: "POST",
          url: "/properties/getjson.json", //sumbits it to the given url of the form
          data: {search: valuesToSubmit},
          dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
      }).success(function(json){
          console.log("success", json);
      });
      return false; // prevents normal behaviour
  });
}
