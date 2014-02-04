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
          icon: 'assets/logo.jpg'
          map: map_object


  init: ->
    #запуск карты
    map_object = new google.maps.Map(@.map_dom, @.map_options)
    @.nav_geolocation(map_object)

    iconBase = 'assets/places/'
    icons =
      1:
        icon: iconBase + 'airplane.png'
      2:
        icon: iconBase + 'seaport.png'
      3:
        icon: iconBase + 'railway.png'
      4:
        icon: iconBase + 'border.png'
      5:
        icon: iconBase + 'car.png'


    outputItem = (item) ->
      position = new google.maps.LatLng(item.lat, item.lng)
      marker = new google.maps.Marker
        position: position
        map: map_object
        icon: icons[item.type_id].icon
      infobox = new InfoBox
        boxStyle:
          background: "#fff",
          padding: "20px",
          width: "280px",
          fontSize: "18px"
        closeBoxURL: ""

      google.maps.event.addListener marker, 'mouseover', ->
        infobox.setContent(
          "<b>" + item.type + ":</b> " + item.name
        )
        infobox.open(map_object, this)

      google.maps.event.addListener marker, 'mouseout', ->
        infobox.close()

    gon.places.forEach outputItem