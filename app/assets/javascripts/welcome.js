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

        console.log(valuesToSubmit);
        performSearch(valuesToSubmit);
        return false; // prevents normal behaviour
    });
});

function initMap() {

    // var center = {
    //     lng: -21.949227,
    //     lat: 64.140457
    // };
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 10,
        // center: center
    });

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
    // TODO
    console.log("Updating map");
    console.log(data);

    // Remove old markers
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }

    // Create new markers

    for (var i = 0; i < data.properties.length; i++) {
        markers.push(new google.maps.Marker({position: data.properties[i].gpslocation, map: map}))
    }

    // Change the view so all markers are visible
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < markers.length; i++) {
        bounds.extend(markers[i].getPosition());
    }

    map.fitBounds(bounds);
}

function updatePropertyList(data) {
    console.log("Updating list");
    // Remove old listings
    $("#propertylist").find('tr:gt(0)').remove();

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
            'Skoða</a></td>' + '</tr>');
    }
}

function performSearch(query) {
    $.ajax({
        type: "POST", url: "/properties/search", //sumbits it to the given url of the form
        data: {
            search: query
        },
        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json) {
        updatePropertyList(json);
        updateMap(json);
    });
}
