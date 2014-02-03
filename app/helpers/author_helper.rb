module AuthorHelper
  include ActionView::Context
  def author (image, name, link, text)
    #во вьюхе pages/about/authors_container отображение автора в блоке

    content_tag(:div, :class => "author col-md-4 col-xs-12") do
      raw(
        content_tag(:div, :class => "image_container") do
          image_tag image
        end +
        content_tag(:h4) do
          link_to name, link, :target => '_blank'
        end +
        content_tag(:p) do
          text
        end
      )
    end
  end
end
