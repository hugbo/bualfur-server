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
          $('#propertylist tbody').append('<tr class="propertyRow" data-url=/properties/' +
              data.properties[i].property_id + '>' +
              '<td>' + data.properties[i].address + '</td>' +
              '<td>' + data.properties[i].zipcode + '</td>' +
              '<td>' + data.properties[i].size + '</td>' +
              '<td>' + data.properties[i].rooms + '</td>' +
              '<td>' + data.properties[i].price + '</td>' +
              '</tr>');
      }

      $(function() {
        $('.propertyRow').click(function() {
          console.log('ayy');
          window.location = $(this).data('url');
        });
      });

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

$(function() {

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
  })

});

// Animations

$(function() {



  $('#searchToggle').click(function() {
    $('.input-group').toggle(200);
    $('#searchValue').toggle(100);
  });

  $('#postnumerToggle').click(function() {
    $('#postnumerCollapse').toggle(200);
    $('#postnumerValue').toggle(100).text('');
    $('#postnumer').toggleClass('postnumer');
    $('#otherInputs').toggleClass('otherInputs');

    var arrayZip = $('input:checkbox:checked.hasValue').map(function() {
      return ($(this).val());
    }).get();

    if (arrayZip.length === 0) $('#postnumerValue').text('Ekkert valið')
    else if (arrayZip.length > 3) {
      for (var i = 0; i < 3; i++) {
        $('#postnumerValue').append(arrayZip[i] + ', ');
      }
      $('#postnumerValue').append('...');
    } else {
      for (var i = 0; i < arrayZip.length; i++) {
        $('#postnumerValue').append(' ' + arrayZip[i]);
      }
    }
  });

  $('#verdToggle').click(function() {
    $('#verdCollapse').toggle(100);
    $('#verdValue').toggle(100);

    var min = $('#priceMin').val();
    var max = $('#priceMax').val();
    if (min != '' && max != '') {

      if (min == max) $('#verdValue').text(min);
      else $('#verdValue').text(min + ' til ' + max);

    } else {
      $('#verdValue').text('Ekkert valið');
    }
  });

  $('#numRoomsToggle').click(function() {

    $('#numRoomsCollapse').toggle(100);
    $('#numRoomsValue').toggle(100);

    var min = $('#min-rooms').val();
    var max = $('#max-rooms').val();

    if (min == max ) $('#numRoomsValue').text(min);
    else $('#numRoomsValue').text(min + ' til ' + max);

  });

  $('#houseTypeToggle').click(function() {
    $('#houseTypeCollapse').toggle(100);
    $('#houseTypeValue').toggle(100).text('');

    $('input:checkbox[class=houseTypeInput]:checked').each(function() {
      $('#houseTypeValue').append(' ' + $(this).val());
      console.log($(this).val());
    });
    if ($('#houseTypeValue').text() == '') {
      $('#houseTypeValue').text('Ekkert valið');
    }

  });

  $('#squareFeetToggle').click(function() {
    $('#squareFeetCollapse').toggle(100);
    $('#squareFeetValue').toggle(100);

    var min = $('#min-size').val();
    var max = $('#max-size').val();

    if (min == max ) $('#squareFeetValue').text(min);
    else $('#squareFeetValue').text(min + ' til ' + max);

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


});
