# Места
# @example
#   #<Place id: 1, lng: 91.385, lat: 53.74, name: "Абакан", type_id: 1, created_at: "2014-02-15 11:03:30", updated_at: "2014-02-15 11:03:30">
class Place < ActiveRecord::Base
  include PlacesCache
  belongs_to :type, class_name: "PlaceType", foreign_key: "type_id"

  # После изменения базы мест обновляет кэш
  after_create :update_places_cache
  after_update :update_places_cache

end
