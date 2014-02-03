class PagesController < ApplicationController

  def index
    #главная страница
    @news = News.view_info
    @reasons = Reason.view_info
  end
end
