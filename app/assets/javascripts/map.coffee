$ ->
  map.init()
  map.get_current_location()

map =
  #параметры карты
  dom: document.getElementById("map-canvas")
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  options:
    center: @current_location,
    disableDefaultUI: true,
    zoom: 12

  get_current_location: ->
    #центрование карты, пытается разместить окно по центру текущего местоположения
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
        map.google_map.setCenter current_location

        console.log(map.current_location)
        map.current_location = current_location

        console.log(map.current_location)

        current_loc_marker_options =
          position: current_location
          icon: 'assets/logo.jpg'
          map: map.google_map
        new google.maps.Marker current_loc_marker_options

        places.objects.forEach(places.get_distance)
        places.objects.forEach(places.render)

        map.get_directions(map.current_location)


        #TODO: сделать так, чтобы места появлялись на карте даже в случае отсутствия текущей геолокации

  get_directions: (start_point) ->
    #построение маршрута до ближайшего места, принимает объект карты и место начала
    directions_renderer_options =
      map: map.google_map
      suppressMarkers: true
    directions_renderer = new google.maps.DirectionsRenderer(directions_renderer_options)

    end_point = new google.maps.LatLng(places.objects[0].lat, places.objects[0].lng)

    directions_service_options =
      origin: start_point
      destination: end_point
      travelMode: google.maps.TravelMode.DRIVING
    directions_service = new google.maps.DirectionsService()

    directions_service.route(directions_service_options, (response, status) ->
      #в случае успеха запроса выводи маршрут
      if (status == google.maps.DirectionsStatus.OK)
        directions_renderer.setDirections(response)
    )

  init: ->
    #запуск карты, центрование на текущем месте и отображение всех мест
    map.google_map = new google.maps.Map(@.dom, @.options)



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
    infobox_content = "<b>" + place.type + ":</b> " + place.name + " расстояние: " + place.distance

    google.maps.event.addListener marker, 'mouseover', ->
      place_infobox.setContent(infobox_content)
      place_infobox.open(map.google_map, this)

    google.maps.event.addListener marker, 'mouseout', ->
      place_infobox.close()


  rad:(x) ->
    #перевод в радианы
    x * Math.PI / 180

  get_distance:(place) ->
    cur_loc_lat = map.current_location.lat()
    cur_loc_lng = map.current_location.lng()
    earth_radius = 6371
    place_lat = place.lat
    place_lng = place.lng

    dLat = places.rad(place_lat - cur_loc_lat)
    dLong = places.rad(place_lng - cur_loc_lng)
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(places.rad(cur_loc_lat)) * Math.cos(places.rad(cur_loc_lat)) * Math.sin(dLong / 2) * Math.sin(dLong / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    place.distance = earth_radius * c


infobox_options =
  #параметры отображения окна инфы при ховере поместу
  boxStyle:
    background: "#fff",
    padding: "20px",
    width: "280px",
    fontSize: "18px"
  closeBoxURL: ""