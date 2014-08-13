# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
L.mapbox.accessToken = 'pk.eyJ1IjoibWRheTEwMCIsImEiOiJhX3VSTW5ZIn0.tP48iAca3NOQblyHFHmesQ';

# initialize the map on the 'map' div 
# with the given map ID, center, and zoom
map = L.mapbox.map('map', 'mday100.j68cmlo3').setView([40.709, -74.012], 16)

# get JSON object
# on success, parse it and 
# hand it over to MapBox for mapping 
$.ajax
  dataType: 'text'
  url: 'locations/index.json.jbuilder'
  success: (data) ->
    geojson = $.parseJSON(data)
    map.featureLayer.setGeoJSON(geojson)

# add custom popups to each marker
map.featureLayer.on 'layeradd', (e) ->
  marker = e.layer
  properties = marker.feature.properties

  # create custom popup
  popupContent =  '<div class="popup">' +
                    '<h3>' + properties.name + '</h3>' +
                    '<p>' + properties.address + '</p>' +
                  '</div>'

  # http://leafletjs.com/reference.html#popup
  marker.bindPopup popupContent,
    closeButton: false
    minWidth: 320