# Хелпер для отображения создателей сайта
module AuthorHelper

  # Отображает данные о создателе
  # @note На вьюхе about/authors_container
  # @example author("authors/fyodor.jpg", "Фёдор Иванищев", "http://vk.com/cbrwizard", "Разработка и борода")
  #
  # @param image [String] ссылка на изображение
  # @param name [String] имя человека
  # @param link [String] ссылка на сайт чела
  # @param text [String] описание
  # @return [HTML] блок для вьюхи
  def author (image, name, link, text)
    content_tag(:div, :class => "author col-md-4 col-xs-12") do
      content_tag(:div, :class => "image_container") do
        image_tag image
      end +
      content_tag(:h4) do
        link_to name, link, :target => '_blank'
      end +
      content_tag(:p) do
        text
      end
    end
  end
end
