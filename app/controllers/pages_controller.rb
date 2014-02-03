class PagesController < ApplicationController
  include AuthorHelper
  include ModalHelper
  include SocialHelper

  def index
    #главная страница
    @news = News.view_info
    @reasons = Reason.view_info

    @last_reason_text = Reason.last.text
  end
end
