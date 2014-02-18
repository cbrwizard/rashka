global = exports ? this #для глобального обращения между файлами

# Параметры приложения, использующиеся в нескольких js файлах
global.app =
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  google_map: undefined
  directions_renderer: undefined

  # Точки эвакуации
  places:
    objects:
      gon.places
    closest: undefined

  # Параметры отображения окна инфы при ховере поместу
  infobox_options:
    boxStyle:
      background: "#fff",
      padding: "20px",
      width: "280px",
      fontSize: "18px"
    closeBoxURL: ""