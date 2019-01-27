var map;
var markers = [];

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 0, lng: 0},
    zoom: 2
  });
}

$('.clear').on('click', function() {
  clearMarkers();
})

$('.form').on('submit', function(e) {
  e.preventDefault();
  var formData = JSON.parse(JSON.stringify($(this).serializeArray()));
  var latitude = Number(formData[0]["value"]);
  var longitude = Number(formData[1]["value"])
  var message = formData[2]["value"]
  createMarker(latitude, longitude, message);
})

function createMarker(latitude, longitude, message) {
  var marker = new google.maps.Marker({
    position: {lat: latitude, lng: longitude},
    map: map
  });
  if (message.length > 0) {
    var infowindow = new google.maps.InfoWindow({
      content: '<h1>' + message + '</h1>'
    });
    marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
  }
  markers.push(marker);
}

function clearMarkers() {
  for (var i = 0; i < markers.length; i++ ) {
    markers[i].setMap(null);
  }
  markers = [];
}
