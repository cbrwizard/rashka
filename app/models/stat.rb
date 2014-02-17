# Статистика сайта (1 шт)
# @example #<Stat id: 1, people_left: 100519, shares_vk: 31628, shares_tw: 12357, shares_fb: 15438, shares_gp: 8657, created_at: "2014-02-15 11:03:30", updated_at: "2014-02-17 07:32:36">
class Stat < ActiveRecord::Base

  # Увеличивает статистику эвакуировавшихся пользователей
  # @note Включается при нажатии по кнопке ВАЛИТЬ
  # @example Stat.first.try_to_save
  #
  # @see StatsController#evacuate
  def increase_people_left
    self.update(people_left: self.people_left + 1)
  end


  # Увеличивает статистику нажавших по соц сети вк
  # @note Включается при нажатии по кнопке соц сети вк
  # @example Stat.first.increase_shares_vk
  #
  # @see StatsController#vk_post
  def increase_shares_vk
    self.update(shares_vk: self.shares_vk + 1)
  end


  # Увеличивает статистику нажавших по соц сети тв
  # @note Включается при нажатии по кнопке соц сети тв
  # @example Stat.first.increase_shares_tw
  #
  # @see StatsController#tw_post
  def increase_shares_tw
    self.update(shares_tw: self.shares_tw + 1)
  end


  # Увеличивает статистику нажавших по соц сети фб
  # @note Включается при нажатии по кнопке соц сети фб
  # @example Stat.first.increase_shares_fb
  #
  # @see StatsController#fb_post
  def increase_shares_fb
    self.update(shares_fb: self.shares_fb + 1)
  end
end