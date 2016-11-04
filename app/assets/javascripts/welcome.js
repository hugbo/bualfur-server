$(function() {
    console.log("ready!");

    $('#search-button').click(function() {
        console.log("Ayyy lmao");

        var valuesToSubmit = {
          zipcode: $('#zipcode').val(),
          priceMin: $('#priceMin').val(),
          priceMax: $('#priceMax').val(),
          roomsMin: $('#roomsMin').val(),
          roomsMax: $('#roomsMax').val(),
          propertyType: $('#propertyType').val()
        }

        console.log(valuesToSubmit);
        $.ajax({
            type: "POST", url: "/properties/search", //sumbits it to the given url of the form
            data: {
                search: valuesToSubmit
            },
            dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
        }).success(function(json) {
            console.log("success", json);
        });
        return false; // prevents normal behaviour
    });
});

function initMap() {
var uluru = {
    lng: -21.949227,
    lat: 64.140457
};
var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: uluru
});
var marker = new google.maps.Marker({position: uluru, map: map});
}
