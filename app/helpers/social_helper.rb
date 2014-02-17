# Хелпер отображения соц кнопок
module SocialHelper

  # Отображает кнопку соц сети
  # @note На вьюхе pages/share/social_container
  # @example social_btn("vk_like_button", "Нравится", "http://vkontakte.ru/share.php?url=", "vk_post")
  #
  # @param btn_class [String] html class контейнера кнопки
  # @param text [String] текст на кнопке
  # @param href_start [String] адрес соц сети, связанный с шерингом
  # @param stat_method [String] название метода увеличения статистики
  # @return [HTML] блок для вьюхи
  #
  # @see Stat Stat model
  # @todo убрать stat_method и объединить его с btn_class
  def social_btn (btn_class, text, href_start, stat_method)

    href = href_start + "http://valiizrashki.ru/"

    content_tag(:a, :class => "btn btn-lg share_button ok_share #{btn_class}", "href" => href, "target" => "_blank", :data => {:method => stat_method}) do
      text
    end
  end
end
