module ModalHelper

  def modal (id, &block)
    #во вьюхе pages/modals создает модульные окошки, принимает id окошка, заголовок и блок вьюхи

    content = capture(&block)

    content_tag(:div, :id => id, :class => "modal", "aria-hidden" => "true", "aria-labelledby" => "myModalLabel", role: "dialog", tabindex: "-1") do
      content_tag(:div, :class => "modal-dialog") do
        content_tag(:div, :class => "modal-content") do
          content_tag(:div, content, :class => 'modal-body')
        end
      end
    end
  end
end
