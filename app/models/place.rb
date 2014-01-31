class Place < ActiveRecord::Base
  belongs_to :type, class_name: "PlaceType", foreign_key: "type_id"
end
