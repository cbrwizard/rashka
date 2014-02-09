class NewsController < ApplicationController
  include Admin

  before_action :allow_access?, on: [:index_admin, :show, :edit, :new, :create, :update, :destroy]

  def index
    @news = News.all
  end

  def show
    @one_news = News.find(params[:id])
  end

  def edit
    @one_news = News.find(params[:id])
  end

  def new
    @one_news = News.new
  end

  def create
    @one_news = News.new(news_params)

    respond_to do |format|
      if @one_news.save
        notice = {class: "alert-success", value: 'Успешно обновил новость.' }
        format.html { redirect_to @one_news, notice: notice }
      else
        notice = {class: "alert-danger", value: 'Ошибка при добавлении.' }
        format.html { render action: "new", notice: notice }
      end
    end
  end

  def update
    @one_news = News.find(params[:id])

    respond_to do |format|
      if @one_news.update_attributes(news_params)
        notice = {class: "alert-success", value: 'Успешно обновил новость.' }

        format.html { redirect_to @one_news, notice: notice }
      else
        notice = {class: "alert-danger", value: 'Ошибка при редактировании.' }

        format.html { render action: "edit", notice: notice }
      end
    end
  end

  def destroy
    @one_news = News.find(params[:id])
    @one_news.destroy

    respond_to do |format|
      notice = {class: "alert-danger", value: 'Успешно удалил новость.' }
      format.html { redirect_to index_admin_news_index_path, notice: notice }
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :text, :link)
  end
end
