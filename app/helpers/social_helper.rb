module SocialHelper

  def social_btn (btn_class, text, href_start, stat_method)
    #во вьюхе pages/share/social_container создает кнопки соц сетей, принимает класс кнопки, надпись в кнопке, начало соц ссылки, а также название метода для увеличения статистики

    #TODO: убрать stat_method и объединить его с btn_class
    href = href_start + WEBSITE_ADDRESS

    content_tag(:a, :class => "btn btn-lg share_button #{btn_class}", "href" => href, "target" => "_blank", :data => {:method => stat_method}) do
      text
    end
  end
end
