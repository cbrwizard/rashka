class StatsController < ApplicationController
  before_action :get_stat
  before_action :update_reason, only: [:vk_post, :tw_post, :fb_post]

  layout 'admin', only: [:index]

  def index

  end

  def evacuate
    @stats.increase_people_left
    reason = Reason.random.text

    respond_to do |format|
      format.json { render :json => reason.to_json }
    end
  end

  def vk_post
    @stats.increase_shares_vk

    respond_to do |format|
      format.json { render :json => @stats.shares_vk }
    end
  end

  def fb_post
    @stats.increase_shares_fb

    respond_to do |format|
      format.json { render :json => @stats.shares_fb }
    end
  end

  def tw_post
    @stats.increase_shares_tw

    respond_to do |format|
      format.json { render :json => @stats.shares_tw }
    end
  end

  private

  def get_stat
    @stats = Stat.first
  end

  def update_reason
    reason_text = params[:reason]
    downcase_text = reason_text.mb_chars.downcase.to_s
    reason = Reason.find_downcase(downcase_text)
    reason.present? ? reason.first.increase_popularity : Reason.create(text: reason_text)
  end
end
