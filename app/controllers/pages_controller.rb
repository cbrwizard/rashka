class PagesController < ApplicationController
  include AuthorHelper
  include ModalHelper
  include SocialHelper

  respond_to :json

  def index
    #главная страница
    @news = News.view_info
    @reasons = Reason.view_info

    gon.places = get_places_info
  end

  def get_places_info
    #возвращает инфу о местах в формате json
    json_object = []
    Place.includes(:type).each do |place|
      place_object = {}
      place_object[:name] = place.name
      place_object[:lat] = place.lat
      place_object[:lng] = place.lng
      place_object[:type] = place.type.name
      place_object[:type_id] = place.type_id

      json_object << place_object
    end
    json_object
  end
end
