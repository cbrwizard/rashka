# Типы мест
# @example #<PlaceType id: 1, name: "Аэропорт", created_at: "2014-02-15 11:03:30", updated_at: "2014-02-15 11:03:30">
class PlaceType < ActiveRecord::Base
  has_many :places, class_name: "Place", foreign_key: "type_id"
end
