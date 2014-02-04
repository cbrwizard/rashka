$ ->
  map.init()

map =
  #параметры карты
  dom: document.getElementById("map-canvas")
  options:
    center: new google.maps.LatLng(55.751667, 37.617778),
    disableDefaultUI: true,
    zoom: 12

  get_current_location: ->
    #центрование карты, пытается разместить окно по центру текущего местоположения
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        map.google_map.setCenter current_location

        current_loc_marker_options =
          position: current_location
          icon: 'assets/logo.jpg'
          map: map.google_map
        new google.maps.Marker current_loc_marker_options

        map.get_directions(current_location)

  get_directions: (start_point) ->
    #построение маршрута до ближайшего места, принимает объект карты и место начала
    directionsService = new google.maps.DirectionsService()
    directionsDisplay = new google.maps.DirectionsRenderer()
    directionsDisplay.setMap(map.google_map)

    end_point = new google.maps.LatLng(places.objects[0].lat, places.objects[0].lng)

    direction_options =
      origin: start_point,
      destination: end_point,
      travelMode: google.maps.TravelMode.DRIVING

    directionsService.route(direction_options, (response, status) ->
      #в случае успеха запроса выводи маршрут
      if (status == google.maps.DirectionsStatus.OK)
        directionsDisplay.setDirections(response)
    )

  init: ->
    #запуск карты, центрование на текущем месте и отображение всех мест
    map.google_map = new google.maps.Map(@.dom, @.options)
    @.get_current_location()

    places.objects.forEach(places.render)

places =
  #параметры мест
  objects: gon.places
  types:
    1:
      icon: 'assets/places/airplane.png'
    2:
      icon: 'assets/places/seaport.png'
    3:
      icon: 'assets/places/railway.png'
    4:
      icon: 'assets/places/border.png'
    5:
      icon: 'assets/places/car.png'

  render:(place) ->
    #отображение мест на карте, принимает json объект места
    position = new google.maps.LatLng(place.lat, place.lng)
    place_marker_options =
      position: position
      map: map.google_map
      icon: places.types[place.type_id].icon
    marker = new google.maps.Marker(place_marker_options)

    place_infobox = new InfoBox(infobox_options)
    infobox_content = "<b>" + place.type + ":</b> " + place.name

    google.maps.event.addListener marker, 'mouseover', ->
      place_infobox.setContent(infobox_content)
      place_infobox.open(map.google_map, this)

    google.maps.event.addListener marker, 'mouseout', ->
      place_infobox.close()

infobox_options =
  #параметры отображения окна инфы при ховере поместу
  boxStyle:
    background: "#fff",
    padding: "20px",
    width: "280px",
    fontSize: "18px"
  closeBoxURL: ""