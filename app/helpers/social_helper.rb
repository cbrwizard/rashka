# Хелпер отображения соц кнопок
module SocialHelper

  # Отображает кнопку соц сети
  # @note На вьюхе pages/share/social_container
  # @example social_btn("share/vk.png", "Рассказать", "vk_post", "http://vkontakte.ru/share.php?url=http://valiizrashki.ru/")
  #
  # @param social_name [String] сокращенное название соц сети
  # @param btn_title [String] текст на кнопке
  # @param link [String] адрес соц сети
  # @return [HTML] блок для вьюхи
  #
  # @see Stat Stat model
  def social_btn (social_name, btn_title, link)
    method_name = "#{social_name}_post"

    content_tag(:div, class: "share_button") do
      concat(content_tag(:div, "", class: "social_icon #{social_name}"))
      concat(content_tag(:div, "", class: "arrow-right-small"))
      concat(link_to btn_title, "#", {:class => "ok_share #{method_name}", :href => link, :target => "_blank", :data => {:method => method_name}})
    end
  end
end