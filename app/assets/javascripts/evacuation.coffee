# Обработка эвакуации
$ ->
  evacuation.init()


# Параметры и функции, связанные с эвакуацией
evacuation =
  dom_element: $("#evac_btn")


  # Запуск слушателя при нажатии
  init: ->
    # При нажатии строит маршрут до ближайшего места от текущего, отображает кнопку рассказать и увеличивает статистику
    $(evacuation.dom_element).click ->
      evacuation.get_directions(app.current_location, app.places.closest)
      evacuation.share_mode_on()
      evacuation.evac_stat_increase()


  # Скрывает кнопку валить и показывает кнопку рассказать
  share_mode_on: ->
    @.dom_element.addClass("hidden")
    $("#share_btn").removeClass("hidden")


  # Запускает метод увеличения статистики
  evac_stat_increase: ->
    $.ajax "../stats/evacuate",
      type: "POST"
      dataType: "json"

      # В случае успеха обновляет поле текста случайной причиной
      success: (reason_text) ->
        $("#reason_field").val(reason_text)
        $("#reason_field").trigger("change")
        console.log "yeahhhhhh"
      error: ->
        console.log "nooooo"


  # Строит маршрут до ближайшего места
  # @param start_point [google.maps.LatLng] место начала
  # @param end_place [Object] место конца
  get_directions: (start_point, end_place) ->

    end_point = new google.maps.LatLng(end_place.lat, end_place.lng)

    directions_service =new google.maps.DirectionsService()
    directions_service_options = evacuation.get_directions_service_options(start_point, end_point)

    directions_service.route(directions_service_options, (response, status) ->
      #в случае успеха запроса выводит маршрут
      if status == google.maps.DirectionsStatus.OK
        evacuation.show_directions(response)
        evacuation.create_end_place_infobox(end_place)
    )


  # Отображение инфобокса у места
  # @param end_point [google.maps.LatLng] место конца маршрута
  create_end_place_infobox: (end_point) ->
    place_infobox = new InfoBox(app.infobox_options)
    infobox_content = "
      <p><b>#{end_point.type} :</b> #{end_point.name} </p>
      <p><b>Расстояние:</b> #{end_point.distance.toFixed(1)} км</p>"

    place_infobox.setContent(infobox_content)
    place_infobox.open(app.google_map, end_point.marker)


  # Создает рендерер для маршрута
  # @return [google.maps.DirectionsRenderer] рендерер маршрута
  get_directions_renderer: () ->
    directions_renderer_options =
      map: app.google_map
      suppressMarkers: true
    new google.maps.DirectionsRenderer(directions_renderer_options)


  # Настройки отображения маршрута
  # @param start_point [google.maps.LatLng] место начала
  # @param end_point [google.maps.LatLng] место конца маршрута
  # @return [Object] настройки маршрута
  get_directions_service_options: (start_point, end_point) ->
    origin: start_point
    destination: end_point
    travelMode: google.maps.TravelMode.DRIVING


  # Отображение маршрута на карте
  # @param response [Маршрут] маршрут до места
  show_directions: (response) ->
    directions_renderer = evacuation.get_directions_renderer()
    directions_renderer.setDirections(response)
    app.directions_renderer = directions_renderer
    console.log("Вам надо всего-то #{response.routes[0].legs[0].duration.text} ехать на машине и вы свалите из этой замечательной страны!")