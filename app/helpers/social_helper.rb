# Хелпер отображения соц кнопок
module SocialHelper

  # Отображает кнопку соц сети
  # @note На вьюхе pages/share/social_container
  # @example social_btn("share/vk.png", "Рассказать", "vk_post", "http://vkontakte.ru/share.php?url=http://valiizrashki.ru/")
  #
  # @param image_link [String] ссылка до изображения соц кнопки
  # @param btn_title [String] текст на кнопке
  # @param method_name [String] название метода увеличения статистики
  # @param link [String] адрес соц сети
  # @return [HTML] блок для вьюхи
  #
  # @see Stat Stat model
  def social_btn (image_link, btn_title, method_name, link)

    content_tag(:div, class: "share_button") do
      concat(image_tag image_link, {class: "social_icon"})
      concat(image_tag "arrow-right.png", {class: "arrow-right"})
      concat(link_to btn_title, "#", {:class => "ok_share #{method_name}", :href => link, :target => "_blank", :data => {:method => method_name}})
    end
  end
end