global = exports ? this #для глобального обращения
global.app =
  #общие параметры приложения
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  google_map: undefined
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