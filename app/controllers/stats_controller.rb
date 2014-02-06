class StatsController < ApplicationController
  def index
    @stats = Stat.first
  end

  def evacuate
    stat = Stat.first
    stat.increase_people_left

    respond_to do |format|
      format.json { render :json => stat.people_left }
    end
  end
end
