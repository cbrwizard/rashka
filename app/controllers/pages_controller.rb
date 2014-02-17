class PagesController < ApplicationController
  include AuthorHelper
  include ModalHelper
  include SocialHelper

  def index
    #главная страница
    @news = News.view_info.paginate(:page => params[:news_page], :per_page => 10)
    @reasons = Reason.view_info.paginate(:page => params[:reasons_page], :per_page => 10)

    if params[:news_page].present?
      render_file = 'pages/pagination/news'
    elsif params[:reasons_page].present?
      render_file = 'pages/pagination/reasons'
    else
      gon.places = get_places_info
      render_file = "лолка штоли"
    end
    asd

    respond_to do |format|
      format.html
      format.js { render render_file }
    end
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
