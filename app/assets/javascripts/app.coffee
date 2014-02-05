global = exports ? this #для глобального обращения
global.app =
  #общие параметры приложения
  current_location: new google.maps.LatLng(55.751667, 37.617778)
  google_map: undefined
  places:
    objects:
      gon.places
    closest: undefined