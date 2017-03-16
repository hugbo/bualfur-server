var map;
var markers = [];
var currentInfoWindow = {};


var searchInfo = {
  postnumer : function() {
    return $('input:checkbox:checked.hasValue').map(function() {
      return ($(this).val());
    }).get();
  },

  verd : function() {
    return {min: $('#priceMin').val(), max: $('#priceMax').val()};
  },

  numRooms : function() {
    return {min: $('#min-rooms').val(), max: $('#max-rooms').val()};
  },

  houseType : function() {
    return $('input:checkbox:checked.houseTypeInput').map(function () {
      return ($(this).val());
    }).get();
  },

  squareMeters : function() {
    return {min: $('#min-size').val(), max: $('#max-size').val()};
  }
}

$(function() {
    console.log("ready!");

    $('#search-button').click(searchButtonListener);

    initAnimations();
    initSearchField();

    $('.propertyRow').click(function() {
      window.location = $(this).data('url');
    });

});

function searchButtonListener(){
      var valuesToSubmit = {
          zipcode: searchInfo.postnumer(),
          price_min: searchInfo.verd().min,
          price_max: searchInfo.verd().max,
          rooms_min: searchInfo.numRooms().min,
          rooms_max: searchInfo.numRooms().max,
          property_type: searchInfo.houseType(),
          square_meters_min: searchInfo.squareMeters().min,
          square_meters_max: searchInfo.squareMeters().max
      }

      if (valuesToSubmit['zipcode'].length == 0) {
        valuesToSubmit['zipcode'] = '';
      }

      if (valuesToSubmit['property_type'].length == 0) {
        valuesToSubmit['property_type'] = '';
      }

      performSearch(valuesToSubmit);
      return false; // prevents normal behaviour
}

function initMap() {
    var center = {'lat':64.139583, 'lng':-21.951879}
    map = new google.maps.Map($('#map').get(0), {});

    var defaultValues = {
      zipcode: '',
      price_min: '',
      price_max: '',
      rooms_min: '',
      rooms_max: '',
      property_type: '',
      square_meters_min: '0',
      square_meters_max: '0'
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
        propertyInfo: {
          address: data.properties[i].address,
          zipcode: data.properties[i].zipcode,
          size:    data.properties[i].size,
          rooms:   data.properties[i].rooms,
          price:   data.properties[i].price,
          property_id:     data.properties[i].property_id
        }
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
  setMarkerInfo(markers);
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
          $('#propertylist tbody').append('<tr class="propertyRow" data-url=/properties/' +
              data.properties[i].property_id + '>' +
              '<td>' + data.properties[i].address + '</td>' +
              '<td>' + data.properties[i].zipcode + '</td>' +
              '<td>' + data.properties[i].size + '</td>' +
              '<td>' + data.properties[i].rooms + '</td>' +
              // For some reason the icelandic locale string for numbers is wrong
              // the german locale is used as they use periods as thousands
              // separator
              '<td>' + data.properties[i].price.toLocaleString('de-DE') + '</td>' +
              '</tr>');
      }
    }

    $('.propertyRow').click(function() {
      window.location = $(this).data('url');
    });


}

function performSearch(query) {
    console.log(query);

    var token = $('meta[name="csrf-token"]').attr('content');
    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', token);
        }
    });

    $.ajax({
        type: "POST", url: "/properties/search", //submits it to the given url of the form
        data: {
            search: query
        },
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json) {
        updatePropertyList(json);
        updateMap(json);
    });
}

// Function for attaching info windows to markers
function setMarkerInfo(markers) {
  for (var i = 0; i < markers.length; i++) {
    var contentString = '<div class="markerContent">'+
    '<p>'+
    'Heimilisfang: ' + markers[i].propertyInfo.address + '<br/>' +
    'Póstnúmer: ' + markers[i].propertyInfo.zipcode + '<br/>' +
    'Stærð: ' + markers[i].propertyInfo.size + 'fm <br/>' +
    'Fjöldi svefnherbergja: ' + markers[i].propertyInfo.rooms + '<br/>' +
    'Leiga: ' + markers[i].propertyInfo.price.toLocaleString('de-DE') + ' kr/mán <br/>' +
    '<a href="/properties/'+markers[i].propertyInfo.property_id + '">Skoða</a>' +
    '</p>'+
    '</div>';

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });
    markers[i].infowindow = infowindow;
    attachMarkerListeners(i);
  }

}

function attachMarkerListeners(i) {
  google.maps.event.addListener(markers[i], 'click', function() {
    if (currentInfoWindow.content !== undefined) {
      currentInfoWindow.close();
    }
    this.infowindow.open(map, this);
    currentInfoWindow = this.infowindow;
  });
}

// Checkbox logic

function handleChange(checkbox) {
  if (checkbox.checked == true) {

    if (checkbox.name == 'zipALL') $('.zipMANY').prop('checked', true).trigger('change');
    else if (checkbox.name == 'REY') $('.zipREY').prop('checked', true);
    else if (checkbox.name == 'SEL') $('.zipSEL').prop('checked', true);
    else if (checkbox.name == 'KOP') $('.zipKOP').prop('checked', true);
    else if (checkbox.name == 'GAR') $('.zipGAR').prop('checked', true);
    else if (checkbox.name == 'HAF') $('.zipHAF').prop('checked', true);
    else if (checkbox.name == 'MOS') $('.zipMOS').prop('checked', true);

  } else {

    if (checkbox.name == 'zipALL') $('.zipMANY').prop('checked', false).trigger('change');
    else if (checkbox.name == 'REY') $('.zipREY').prop('checked', false);
    else if (checkbox.name == 'SEL') $('.zipSEL').prop('checked', false);
    else if (checkbox.name == 'KOP') $('.zipKOP').prop('checked', false);
    else if (checkbox.name == 'GAR') $('.zipGAR').prop('checked', false);
    else if (checkbox.name == 'HAF') $('.zipHAF').prop('checked', false);
    else if (checkbox.name == 'MOS') $('.zipMOS').prop('checked', false);

  }
}

// Search field logic

function initSearchField() {

  $('#min-size').change(function() {
    var min = $('#min-size').val();
    var max = $('#max-size').val();
    console.log(min + ' > ' + max + ': ' + (+min > +max));

    if (+min > +max) $('#max-size').val(min);
  });

  $('#max-size').change(function() {
    var max = $('#max-size').val();
    var min = $('#min-size').val();
    console.log(min + ' > ' + max + ': ' + (+min > +max));

    if (+min > +max) $('#min-size').val(max);
  });

  $('#min-rooms').change(function() {
    var min = $('#min-rooms').val();
    var max = $('#max-rooms').val();

    if (+min > +max) $('#max-rooms').val(min);
  });

  $('#max-rooms').change(function() {
    var min = $('#min-rooms').val();
    var max = $('#max-rooms').val();

    if (+min > +max) $('#min-rooms').val(max);
  });

}

// Animations

function initAnimations() {

  $('#searchToggle').click(function() {
    $('.input-group').toggle(200);
    $('#searchValue').toggle(100).text('');

    var postnumer = searchInfo.postnumer()
    $('#searchValue').append('Póstnúmer: ')
    if (postnumer.length === 0) $('#searchValue').append('Ekkert valið')
    else if (postnumer.length > 3) {
      for (var i = 0; i < 3; i++) {
        $('#searchValue').append(postnumer[i] + ', ');
      }
      $('#searchValue').append('...');
    } else {
      for (var i = 0; i < postnumer.length; i++) {
        $('#searchValue').append(' ' + postnumer[i]);
      }
    }
    $('#searchValue').append(' | ');

    var verd = searchInfo.verd();
    $('#searchValue').append('Verð: ')
    if (verd.min != '' && verd.max != '') {

      if (verd.min == verd.max) $('#searchValue').append(verd.min);
      else $('#searchValue').append(verd.min + ' til ' + verd.max);

    } else {
      $('#searchValue').append('Ekkert valið');
    }
    $('#searchValue').append(' | ');

    var numRooms = searchInfo.numRooms();
    $('#searchValue').append('Fjöldi herbergja: ');
    if (numRooms.min === numRooms.max ) $('#searchValue').append(numRooms.min);
    else $('#searchValue').append(numRooms.min + ' til ' + numRooms.max);
    $('#searchValue').append(' | ');

    var houseType = searchInfo.houseType();
    $('#searchValue').append('Tegund húsnæðis: ');
    if (houseType.length === 0) {
      $('#searchValue').append('Ekkert valið');
    } else {
      for (var i = 0; i < houseType.length; i++) {
        $('#searchValue').append(houseType[i] + ' ');
      }
    }
    $('#searchValue').append(' | ');

    var squareMeters = searchInfo.squareMeters();
    $('#searchValue').append('Fermetrar: ');
    if (squareMeters.min === squareMeters.max ) {
      $('#searchValue').append(squareMeters.min);
    }
    else $('#searchValue').append(squareMeters.min + ' til ' + squareMeters.max);

  });

  $('#postnumerToggle').click(function() {
    $('#postnumerCollapse').toggle(200);
    $('#postnumerValue').toggle(100).text('');
    $('#postnumer').toggleClass('postnumer');
    $('#otherInputs').toggleClass('otherInputs');

    var postnumer = searchInfo.postnumer();

    if (postnumer.length === 0) $('#postnumerValue').text('Ekkert valið')
    else if (postnumer.length > 3) {
      for (var i = 0; i < 3; i++) {
        $('#postnumerValue').append(postnumer[i] + ', ');
      }
      $('#postnumerValue').append('...');
    } else {
      for (var i = 0; i < postnumer.length; i++) {
        $('#postnumerValue').append(' ' + postnumer[i]);
      }
    }
  });

  $('#verdToggle').click(function() {
    $('#verdCollapse').toggle(100);
    $('#verdValue').toggle(100);

    var verd = searchInfo.verd();
    if (verd.min != '' && verd.max != '') {

      if (verd.min == verd.max) $('#verdValue').text(verd.min);
      else $('#verdValue').text(verd.min + ' til ' + verd.max);

    } else {
      $('#verdValue').text('Ekkert valið');
    }
  });

  $('#numRoomsToggle').click(function() {

    $('#numRoomsCollapse').toggle(100);
    $('#numRoomsValue').toggle(100);

    var numRooms = searchInfo.numRooms();

    if (numRooms.min === numRooms.max ) $('#numRoomsValue').text(numRooms.min);
    else $('#numRoomsValue').text(numRooms.min + ' til ' + numRooms.max);

  });

  $('#houseTypeToggle').click(function() {
    $('#houseTypeCollapse').toggle(100);
    $('#houseTypeValue').toggle(100).text('');

    var houseType = searchInfo.houseType();

    if (houseType.length === 0) {
      $('#houseTypeValue').text('Ekkert valið');
    } else {
      for (var i = 0; i < houseType.length; i++) {
        $('#houseTypeValue').append(houseType[i] + ' ');
      }
    }

  });

  $('#squareMetersToggle').click(function() {
    $('#squareMetersCollapse').toggle(100);
    $('#squareMetersValue').toggle(100);

    var squareMeters = searchInfo.squareMeters();

    if (squareMeters.min === squareMeters.max ) {
      $('#squareMetersValue').text(squareMeters.min);
    }
    else $('#squareMetersValue').text(squareMeters.min + ' til ' + squareMeters.max);

  });

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


}
