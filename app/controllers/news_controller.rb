class NewsController < ApplicationController
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
        format.html { redirect_to @one_news, notice: 'Успешно добавил новость.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @one_news = News.find(params[:id])

    respond_to do |format|
      if @one_news.update_attributes(news_params)
        format.html { redirect_to @one_news, notice: 'Успешно обновил новость.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @one_news = News.find(params[:id])
    @one_news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_path, notice: 'Успешно удалил новость.' }
    end
  end


  private

  def news_params
    params.require(:news).permit(:title, :text, :link)
  end
end
