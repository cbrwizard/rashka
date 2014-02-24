# Хелпер отображения модульных окошек
module ModalHelper

  # Отображает данные о создателе
  # @note На вьюхе pages/modals
  # @example modal("about_modal") {render :partial => 'pages/about/about_modal'}
  #
  # @param id [String] html id контейнера окошка
  # @param block [HTML] содержимое модульного окошка
  # @return [HTML] блок для вьюхи
  def modal (id, &block)

    content = capture(&block)

    content_tag(:div, :id => id, :class => "modal fade", "aria-hidden" => "true", role: "dialog", tabindex: "-1") do
      content_tag(:div, :class => "modal-dialog") do
        content_tag(:div, :class => "modal-content") do
          content_tag(:div, content, :class => 'modal-body')
        end
      end
    end
  end
end
