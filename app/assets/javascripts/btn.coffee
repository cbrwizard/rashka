$ ->
  evac_btn.init()

evac_btn =
  #кнопка ВАЛИТЬ
  dom_element: $("#evac_btn")
  share_mode_on: ->
    #скрывает кнопку валить и показывает кнопку рассказать
    @.dom_element.addClass("hidden")
    share_btn.dom_element.removeClass("hidden")

  init: ->
    #запуск слушателей
    $(evac_btn.dom_element).click ->
      closest_place = new google.maps.LatLng(app.places.closest.lat, app.places.closest.lng)
      get_directions(app.current_location, closest_place)
      evac_btn.share_mode_on()


share_btn =
  #кнопка РАССКАЗАТЬ
  dom_element: $("#share_btn")

get_directions = (start_point, end_point) ->
  #построение маршрута до ближайшего места, принимает место начала и конца
  directions_renderer_options =
    map: app.google_map
    suppressMarkers: true
  directions_renderer = new google.maps.DirectionsRenderer(directions_renderer_options)

  directions_service_options =
    origin: start_point
    destination: end_point
    travelMode: google.maps.TravelMode.DRIVING
  directions_service = new google.maps.DirectionsService()

  directions_service.route(directions_service_options, (response, status) ->
    #в случае успеха запроса выводит маршрут
    if (status == google.maps.DirectionsStatus.OK)
      directions_renderer.setDirections(response)
      console.log("Вам надо всего-то #{response.routes[0].legs[0].duration.text} ехать на машине и вы свалите из этой замечательной страны!")
  )