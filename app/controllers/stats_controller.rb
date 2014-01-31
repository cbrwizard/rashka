class StatsController < ApplicationController
  def index
    @stats = Stat.first
  end
end
