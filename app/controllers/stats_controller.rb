class StatsController < ApplicationController
  before_filter :get_stat

  def index

  end

  def evacuate
    @stats.increase_people_left

    respond_to do |format|
      format.json { render :json => @stats.people_left }
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
end
