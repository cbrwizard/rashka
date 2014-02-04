$ ->
  map.init()

map =
  #параметры карты
  map_dom: document.getElementById("map-canvas")
  map_options:
    center: new google.maps.LatLng(55.751667, 37.617778),
    disableDefaultUI: true,
    zoom: 12
  nav_geolocation:(map_object) ->
    #центрование карты
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        map_object.setCenter initialLocation
        new google.maps.Marker
          position: initialLocation
          map: map_object


  init: ->
    #запуск карты
    map_object = new google.maps.Map(@.map_dom, @.map_options)
    @.nav_geolocation(map_object)

    outputItem = (item) ->
      console.log item.lat
      new google.maps.Marker
        position: new google.maps.LatLng(item.lat, item.lng)
        map: map_object

    gon.places.forEach outputItem