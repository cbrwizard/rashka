# Методы страниц для пользователей
class PagesController < ApplicationController
  include PlacesCache

  # Главная страница. Готовит новости, причины и места к отображению.
  # @note GET /
  # @note Также вызывается в случае пагинации. Тогда выдает либо пагинацию новостей, либо пагинацию причин.
  # @param news_page [Integer] опциональный номер страницы пагинации новостей
  # @see News
  # @see Paginated
  # @see Place
  def index
    if params[:news_page].present?
      render_file = _paginate_news
    elsif params[:reasons_page].present?
      render_file = _paginate_reasons
    else
      render_file = _initial_index
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
  def _paginate_news
    @news = News.paginated(params[:news_page], 10)
    'pages/pagination/news'
  end


  # Отображение первоначальных данных на главной: мест, причин и новостей, а также первой новости для мобил и готовит случайную причину для формы "рассказать друзьям"
  # @note GET /
  # @note Вызывается в index когда нет никакой пагинации
  # @return [String] очень важный текст
  # @see Place
  # @see News
  # @see Reason
  # @see Paginated
  def _initial_index
    gon.places = _get_places_info
    @news = News.paginated(1, 10)
    @reasons = Reason.popular.paginated(1, 25)
    @one_news = News.first
    @one_reason = Reason.random_one.text
    _set_meta_data
    "лолка штоли"
  end


  # Пагинация для причин
  # @note GET /
  # @note Вызывается в index с помощью AJAX при скролле до низа модульного окошка причин
  # @example
  #  $.ajax
  #    type: 'GET'
  #    url: next.attr('href')
  #    dataType: 'script'
  # @param reasons_page [Integer] номер страницы пагинации причин
  # @return [String] ссылка на файл для рендера причин
  # @see Reason
  # @see Paginated
  def _paginate_reasons
    @reasons = Reason.popular.paginated(params[:reasons_page], 25)
    'pages/pagination/reasons'
  end


  # Переносит данные мест в переменную gon для её использования картой
  # @note Вызывается в index когда нет никакой пагинации
  # @note Берет переменные из redis для быстрого использования
  # @return [JSON] инфа о каждом месте
  # @see Place
  # @see PlaceType
  def _get_places_info
    unless $redis.exists("places_array")
      update_places_cache
    end
    JSON.parse($redis.get('places_array'))
  end


  # Устанавливает мета данные для главной страницы
  # @note Вызывается в index когда нет никакой пагинации
  def _set_meta_data

    image = "#{request.protocol}#{request.host_with_port}#{ActionController::Base.helpers.asset_path("logo.png")}"

    set_meta_tags :title => "Вали из рашки",
                  :description => "Незаменимый помощник в эвакуации из этой замечательной страны",
                  :keywords => "Vali iz rashki, ValiIzRashki, Вали из рашки, ВалиИзРашки, сатира, эвакуация, баттхёрт, поросенок, Пётр, vali is rashki, valiisrashki, россия, политика, новости, батхёрт, милонов, путин, цензура, патриотизм",
                  :image => image

    set_meta_tags :og => {
        :url => request.original_url,
        :site_name => "Вали из рашки",
        :image => image,
        :title => "Вали из рашки",
        :description => "Незаменимый помощник в эвакуации из этой замечательной страны"
    }

    set_meta_tags :twitter => {
        :card => "summary",
        :site => "@valiizrashki",
        :url => request.original_url,
        :image => image,
        :title => "Вали из рашки",
        :description => "Незаменимый помощник в эвакуации из этой замечательной страны"
    }
  end
end
