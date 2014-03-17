global = exports ? this #для глобального обращения между файлами

# Параметры приложения, использующиеся в нескольких js файлах
global.app =
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  google_map: undefined
  time_to_evac: undefined
  current_marker: undefined
  path_to_evac: undefined
  mobile: false
  current_page: 2

  # Точки эвакуации
  places:
    closest: undefined
    types:
      1:
        icon: "plane"
      2:
        icon: "boat"
      3:
        icon: "train"
      4:
        icon: "customs"
      5:
        icon: "bus"

  # Параметры отображения окна инфы при ховере поместу
  infobox_options:
    closeBoxURL: ""