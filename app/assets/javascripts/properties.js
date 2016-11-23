$(function(){
  //tmp
});

var newPropertyMap;

function initNewPropertyMap(){
  console.log("Initializing new property map");
  var center = {'lat':64.139583, 'lng':-21.951879}
  newPropertyMap = new google.maps.Map($('#map').get(0), {center: center, zoom: 11});
}
