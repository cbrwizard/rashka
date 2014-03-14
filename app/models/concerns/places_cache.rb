require 'active_support/concern'

# Для обновления кэша мест
# @note На главной странице либо при изменении мест
# @see Place
# @see PlaceType
module PlacesCache
  extend ActiveSupport::Concern

  included do
    # Заносит данные о местах в redis для быстрого использования
    # @see Place
    # @see PlaceType
    def update_places_cache
      hashes_array = []
      Place.includes(:type).each do |place|
        place_hash = {}
        place_hash[:name] = place.name
        place_hash[:lat] = place.lat
        place_hash[:lng] = place.lng
        place_hash[:type] = place.type.name
        place_hash[:type_id] = place.type_id

        hashes_array << place_hash
      end
      $redis.set "places_array", hashes_array.to_json
    end
  end
end