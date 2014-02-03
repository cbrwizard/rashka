module SocialHelper

  def social_btn (btn_class, text, href_start)
    #во вьюхе pages/share/social_container создает кнопки соц сетей, принимает класс кнопки, надпись в кнопке, а также начало соц ссылки

    href = href_start + WEBSITE_ADDRESS

    content_tag(:a, :class => "btn btn-lg share_button #{btn_class}", "href" => href, "target" => "_blank") do
      text
    end
  end
end
