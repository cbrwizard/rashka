#Методы статистики
class StatsController < ApplicationController
  include Admin

  before_action :_get_stat
  before_action :_update_reason, only: [:vk_post, :tw_post, :fb_post, :bl_post]
  before_action :_allow_access?, only: [:index]

  layout 'admin', only: [:index]


  # Отображение инфы о статистике
  # @note GET /stats
  def index

  end


  # Обрабатывает нажатие по ВАЛИТЬ. Увеличивает статистику
  # @note POST stats/evacuate через AJAX
  # @example
  #  $.ajax "../stats/evacuate",
  #    type: "POST"
  #    dataType: "json"
  #
  # @see Stat
  def evacuate
    @stats.increase_people_left

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => "yay" }
    end
  end


  # Обрабатывает нажатие по соц кнопке ВК. Увеличивает статистику, также пытается сохранить причину, указанную в посте
  # @note POST stats/evacuate через AJAX
  # @param reason [String] Текст отправленной в пост причины
  # @return shares_vk [Integer] количество текущей статистики соц кнопки
  # @example
  #   $.ajax "../stats/vk_post",
  #     type: "POST"
  #     dataType: "json"
  #     data:
  #       reason: reason
  #
  # @see Stat
  # @see Reason#try_to_save
  def vk_post
    @stats.increase_shares_vk

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => @stats.shares_vk }
    end
  end


  # Обрабатывает нажатие по соц кнопке ФБ. Увеличивает статистику, также пытается сохранить причину, указанную в посте
  # @note POST stats/evacuate через AJAX
  # @param reason [String] Текст отправленной в пост причины
  # @return shares_fb [Integer] количество текущей статистики соц кнопки
  # @example
  #   $.ajax "../stats/fb_post",
  #     type: "POST"
  #     dataType: "json"
  #     data:
  #       reason: reason
  #
  # @see Stat
  # @see Reason#try_to_save
  def fb_post
    @stats.increase_shares_fb

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => @stats.shares_fb }
    end
  end


  # Обрабатывает нажатие по соц кнопке ТВ. Увеличивает статистику, также пытается сохранить причину, указанную в посте
  # @note POST stats/evacuate через AJAX
  # @param reason [String] Текст отправленной в пост причины
  # @return shares_tw [Integer] количество текущей статистики соц кнопки
  # @example
  #   $.ajax "../stats/tw_post",
  #     type: "POST"
  #     dataType: "json"
  #     data:
  #       reason: reason
  #
  # @see Stat
  # @see Reason#try_to_save
  def tw_post
    @stats.increase_shares_tw

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => @stats.shares_tw }
    end
  end


  # Обрабатывает нажатие по соц кнопке брейнлука. Увеличивает статистику, также пытается сохранить причину, указанную в посте
  # @note POST stats/evacuate через AJAX
  # @param reason [String] Текст отправленной в пост причины
  # @return shares_bl [Integer] количество текущей статистики соц кнопки
  # @example
  #   $.ajax "../stats/bl_post",
  #     type: "POST"
  #     dataType: "json"
  #     data:
  #       reason: reason
  #
  # @see Stat
  # @see Reason#try_to_save
  def bl_post
    @stats.increase_shares_bl

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => @stats.shares_bl }
    end
  end


  private

  # Передает в переменную единственную запись статистики
  def _get_stat
    @stats = Stat.first
  end


  # Пытается сохранить причину, указанную в посте
  # @note Из метода соц сети
  # @param reason [String] Текст отправленной в пост причины
  # @see Stat
  # @see Reason#try_to_save
  def _update_reason
    reason_text = params[:reason]
    reason = Reason.new(text: reason_text.squish)
    reason.try_to_save
  end
end
