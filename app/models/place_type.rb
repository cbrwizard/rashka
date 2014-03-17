# Типы мест
# @example
#   #<PlaceType id: 1, name: "Аэропорт", created_at: "2014-02-15 11:03:30", updated_at: "2014-02-15 11:03:30">
class PlaceType < ActiveRecord::Base
  include PlacesCache
  has_many :places, class_name: "Place", foreign_key: "type_id"

  # После изменения базы типов мест обновляет кэш
  after_create :update_places_cache
  after_update :update_places_cache
end
