$ ->
  evac_btn.init()

# Feed the animal
#
# @param [World.Food] food the food to eat
# @param [Object] options the feeding options
# @option options [String] time the time to feed
#
evac_btn =
  #кнопка ВАЛИТЬ
  dom_element: $("#evac_btn")
  share_mode_on: ->
    #скрывает кнопку валить и показывает кнопку рассказать
    @.dom_element.addClass("hidden")
    $("#share_btn").removeClass("hidden")

  evac_stat_increase: ->
    $.ajax "../stats/evacuate",
      type: "POST"
      dataType: "json"
      success: (reason_text) ->
        $("#reason_field").val(reason_text)
        $("#reason_field").trigger("change")
        console.log "yeahhhhhh"
      error: ->
        console.log "nooooo"

  init: ->
    #запуск слушателей
    $(evac_btn.dom_element).click ->
      get_directions(app.current_location, app.places.closest)
      evac_btn.share_mode_on()
      evac_btn.evac_stat_increase()

get_directions = (start_point, end_place) ->
  #построение маршрута до ближайшего места, принимает место начала и конца

  end_point = new google.maps.LatLng(end_place.lat, end_place.lng)

  directions_service =new google.maps.DirectionsService()
  directions_service_options = get_directions_service_options(start_point, end_point)

  directions_service.route(directions_service_options, (response, status) ->
    #в случае успеха запроса выводит маршрут
    if (status == google.maps.DirectionsStatus.OK)
      show_directions(response)
      create_end_place_infobox(end_place)
  )

create_end_place_infobox = (end_place) ->
  #отображение инфобокса у ближайшего места
  place_infobox = new InfoBox(app.infobox_options)
  infobox_content = "
    <p><b>#{end_place.type} :</b> #{end_place.name} </p>
    <p><b>Расстояние:</b> #{end_place.distance.toFixed(1)} км</p>"

  place_infobox.setContent(infobox_content)
  place_infobox.open(app.google_map, end_place.marker)

get_directions_renderer = () ->
  #создает рендерер для маршрута
  directions_renderer_options =
    map: app.google_map
    suppressMarkers: true
  new google.maps.DirectionsRenderer(directions_renderer_options)

get_directions_service_options = (start_point, end_point) ->
  #настройки отображения маршрута
  origin: start_point
  destination: end_point
  travelMode: google.maps.TravelMode.DRIVING

show_directions = (response) ->
  #отображение маршрута
  directions_renderer = get_directions_renderer()
  directions_renderer.setDirections(response)
  app.directions_renderer = directions_renderer
  console.log("Вам надо всего-то #{response.routes[0].legs[0].duration.text} ехать на машине и вы свалите из этой замечательной страны!")


