map_global = exports ? this #для глобального обращения

map_global.map =
  #параметры карты
  map_dom: document.getElementById("map-canvas")
  map_options:
    center: new google.maps.LatLng(-34.397, 150.644),
    disableDefaultUI: true,
    zoom: 9
  nav_geolocation:(map_object) ->
    #центрование карты
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        map_object.setCenter initialLocation

  init: ->
    #запуск карты
    map_object = new google.maps.Map(@.map_dom, @.map_options)
    @.nav_geolocation(map_object)