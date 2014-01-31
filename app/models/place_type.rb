class PlaceType < ActiveRecord::Base
  has_many :places, class_name: "Place", foreign_key: "type_id"
end
