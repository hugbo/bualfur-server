$(function(){
  console.log("ready!");
  initMap();
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
}
