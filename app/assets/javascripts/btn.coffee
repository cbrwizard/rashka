$ ->
  evac_btn.init()

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
        console.log "yeahhhhhh"
        $("#reason_field").val(reason_text)
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
  #TODO: оптимизировать и рефакторить этот метод
  directions_renderer_options =
    map: app.google_map
    suppressMarkers: true
  directions_renderer = new google.maps.DirectionsRenderer(directions_renderer_options)

  end_point = new google.maps.LatLng(end_place.lat, end_place.lng)

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

  place_infobox = new InfoBox(app.infobox_options)
  infobox_content = "
    <p><b>#{end_place.type} :</b> #{end_place.name} </p>
    <p><b>Расстояние:</b> #{end_place.distance.toFixed(1)} км</p>"

  place_infobox.setContent(infobox_content)
  place_infobox.open(app.google_map, end_place.marker)