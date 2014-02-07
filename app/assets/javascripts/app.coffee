global = exports ? this #для глобального обращения
global.app =
  #общие параметры приложения
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  google_map: undefined
  bounds: new google.maps.LatLngBounds(new google.maps.LatLng(41.2, 19.8), new google.maps.LatLng(77.792, 179.9999))
  social_title: "Симулятор эвакуации из Рашки"
  social_text: "Я решил валить из рашки, потому что"
  current_marker: undefined
  directions_renderer: undefined
  places:
    objects:
      gon.places
    closest: undefined
  infobox_options:
    #параметры отображения окна инфы при ховере поместу
    boxStyle:
      background: "#fff",
      padding: "20px",
      width: "280px",
      fontSize: "18px"
    closeBoxURL: ""