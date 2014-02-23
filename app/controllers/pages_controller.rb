#Методы страниц для пользователей
class PagesController < ApplicationController
  include AuthorHelper
  include ModalHelper
  include SocialHelper

  # Главная страница. Готовит новости, причины и места к отображению.
  # @note GET /
  # @note Также вызывается в случае пагинации. Тогда выдает либо пагинацию новостей, либо пагинацию причин.
  # @param news_page [Integer] опциональный номер страницы пагинации новостей
  # @see News
  # @see Paginated
  # @see Place
  def index
    if params[:news_page].present?
      render_file = paginate_news
    else
      render_file = initial_index
    end

    respond_to do |format|
      format.html
      format.js { render render_file }
    end
  end


  # Пагинация для новостей
  # @note GET /
  # @note Вызывается в index с помощью AJAX при скролле до низа блока новостей
  # @example
  #  $.ajax
  #    type: 'GET'
  #    url: next.attr('href')
  #    dataType: 'script'
  # @param news_page [Integer] номер страницы пагинации новостей
  # @return [String] ссылка на файл для рендера новостей
  # @see News
  # @see Paginated
  def paginate_news
    @news = News.view_info.paginated(params[:news_page])
    'pages/pagination/news'
  end


  # Отображение первоначальных данных на главной: мест, причин и новостей
  # @note GET /
  # @note Вызывается в index когда нет никакой пагинации
  # @return [String] очень важный текст
  # @see Place
  # @see News
  # @see Reason
  # @see Paginated
  def initial_index
    gon.places = get_places_info
    @news = News.view_info.paginated(1)
    @reasons = Reason.view_info.paginated(1)
    set_meta_data
    "лолка штоли"
  end


  # Переносит данные мест в переменную gon для её использования картой
  # @note Вызывается в index когда нет никакой пагинации
  # @return [Hash] объект с инфой о каждом месте
  # @see Place
  # @see PlaceType
  def get_places_info
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
    hashes_array
  end


  # Устанавливает мета данные для главной страницы
  # @note Вызывается в index когда нет никакой пагинации
  def set_meta_data

    image = ActionController::Base.helpers.image_path("logo.jpg")

    set_meta_tags :title => "Вали из рашки",
                  :description => "Верный помощник по эвакуации из этой замечательной страны",
                  :keywords => "Vali iz rashki, ValiIzRashki, Вали из рашки, ВалиИзРашки, сатира, эвакуация, баттхёрт, поросенок, Пётр",
                  :image => image

    set_meta_tags :og => {
        :url => request.original_url,
        :site_name => "Вали из рашки",
        :image => image,
        :title => "Вали из рашки",
        :description => "Верный помощник по эвакуации из этой замечательной страны",
        :type => "article"
    }

    set_meta_tags :twitter => {
        :card => "summary",
        :site => "@valiizrashki",
        :url => request.original_url,
        :image => image,
        :title => "Вали из рашки",
        :description => "Верный помощник по эвакуации из этой замечательной страны"
    }
  end
end
