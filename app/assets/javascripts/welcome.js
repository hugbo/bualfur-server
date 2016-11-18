var map;
var markers = [];
var bounds = [];

$(function() {
    console.log("ready!");

    $('#search-button').click(function() {
        var valuesToSubmit = {
            zipcode: $('#zipcode').val(),
            priceMin: $('#priceMin').val(),
            priceMax: $('#priceMax').val(),
            roomsMin: $('#roomsMin').val(),
            roomsMax: $('#roomsMax').val(),
            propertyType: $('#propertyType').val()
        }
        performSearch(valuesToSubmit);
        return false; // prevents normal behaviour
    });

    // get CSRF token to make secure POSTS to server
    var token = $('meta[name="csrf-token"]').attr('content');
    $.ajaxSetup({
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-TOken', token);
      }
    });

});

function initMap() {

    var center = {'lat':64.139583, 'lng':-21.951879}
    map = new google.maps.Map($('#map').get(0), {});

    var defaultValues = {
        zipcode: "",
        priceMin: "",
        priceMax: "",
        roomsMin: "",
        roomsMax: "",
        propertyType: ""
    }

    performSearch(defaultValues);

}

function updateMap(data) {
  // Remove old markers
  for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
  }

  markers = [];

  if(data.properties.length === 0){
    return;
  }

  // Create new markers
  for (var i = 0; i < data.properties.length; i++) {
      markers.push(new google.maps.Marker({
        position: data.properties[i].gpslocation,
        map: map,
        title: data.properties[i].address
      }))
  }

  // Change the view so all markers are visible
  var bounds = new google.maps.LatLngBounds();
  for (var i = 0; i < markers.length; i++) {
      bounds.extend(markers[i].getPosition());
  }
  map.fitBounds(bounds);

  // set minimum zoom
  if(map.getZoom() > 16){
    map.setZoom(16);
  }
}

function updatePropertyList(data) {
    // Remove old listings
    $("#propertylist").find('tr:gt(0)').remove();

    if (data.properties.length === 0) {
      $('#propertylist tbody').append('<tr><td>Engar niðurstöður</td></tr>');
    } else {
      // Insert new listings into property list

      for (var i = 0; i < data.properties.length; i++) {
          var id = data.properties[i].property_id;
          $('#propertylist tbody').append('<tr>' +
              '<td>' + data.properties[i].address + '</td>' +
              '<td>' + data.properties[i].zipcode + '</td>' +
              '<td>' + data.properties[i].size + '</td>' +
              '<td>' + data.properties[i].rooms + '</td>' +
              '<td>' + data.properties[i].price + '</td>' +
              '<td><a href=/properties/' + data.properties[i].property_id + '>' +
              'Skoða</a></td>' +
              '</tr>');
      }

    }

}

function performSearch(query) {
    $.ajax({
        type: "POST",
        url: "/properties/search", //submits it to the given url of the form
        data: {
            search: query
        },
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json) {
        updatePropertyList(json);
        updateMap(json);
    });
}

// Checkbox logig
/*
function handleChange(checkbox) {
  if (checkbox.checked == true) {
    if (checkbox.name == zipALL) {
      $('input[name='zipMANY']').prop('checked', true);
    }
  } else {
    if (checkbox.name == zipALL) {
      $('input[name='zipMANY']').prop('checked', false);
    }
  }
}
*/
// Animations
$(function() {

// Search fields

  $('#postnumerToggle').click(function() {
    $('#postnumerCollapse').toggle(400);
    $('#postnumer').toggleClass('postnumer');
    $('#otherInputs').toggleClass('otherInputs');
  });

  $('#verdToggle').click(function() {
    $('#verdCollapse').toggle();
  });

  $('#numRoomsToggle').click(function() {
    $('#numRoomsCollapse').toggle();
  });

  $('#houseTypeToggle').click(function() {
    $('#houseTypeCollapse').toggle();
  });

// Postnumer

  $('#toggleREY').click(function(){
    $('#collapseREY').toggle(100);
  });

  $('#toggleSEL').click(function(){
    $('#collapseSEL').toggle(100);
  });

  $('#toggleKOP').click(function(){
    $('#collapseKOP').toggle(100);
  });

  $('#toggleGAR').click(function(){
    $('#collapseGAR').toggle(100);
  });

  $('#toggleHAF').click(function(){
    $('#collapseHAF').toggle(100);
  });

  $('#toggleMOS').click(function(){
    $('#collapseMOS').toggle(100);
  });


});
