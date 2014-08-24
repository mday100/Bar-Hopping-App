# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  L.mapbox.accessToken = 'pk.eyJ1IjoibWRheTEwMCIsImEiOiJhX3VSTW5ZIn0.tP48iAca3NOQblyHFHmesQ';

  # initialize the map on the 'map' div 
  # with the given map ID, center, and zoom
  map = L.mapbox.map('map', 'mday100.j68cmlo3', 
    { scrollWheelZoom: false, zoomControl: false }).setView([40.709, -74.012], 15);

  new L.Control.Zoom({ position: 'topright' }).addTo(map);

  # get JSON object
  # on success, parse it and 
  # hand it over to MapBox for mapping 
  $.ajax
    dataType: 'text'
    url: '/locations.json'
    success: (data) ->
      geojson = $.parseJSON(data)
      # console.log(geojson)
      map.featureLayer.setGeoJSON(geojson)

  # add custom popups to each marker
  map.featureLayer.on 'layeradd', (e) ->
    marker = e.layer
    properties = marker.feature.properties

    # create custom popup
    popupContent =  '<div class="popup">' +
                      '<h3>' + properties.address + '</h3>' +
                      # '<p>' + properties.name + '</p>' +
                    '</div>'

    # http://leafletjs.com/reference.html#popup
    marker.bindPopup popupContent,
      closeButton: false
      minWidth: 320