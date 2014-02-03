module SocialHelper

  def social_btn (btn_class, text)
    #во вьюхе pages/share/social_container создает кнопки соц сетей, принимает класс кнопки и надпись в кнопке

    content_tag(:a, :class => "btn btn-lg share_button #{btn_class}", "href" => "", "target" => "_blank") do
      text
    end
  end
end
