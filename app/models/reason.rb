class Reason < ActiveRecord::Base
  default_scope -> {order(updated_at: :desc)}
  scope :view_info, -> {select(:text, :updated_at)}
  scope :random, -> {unscoped.order("RANDOM()").first}
  scope :find_downcase, -> (downcase_text) {where('lower(text) like ?', "%#{downcase_text}%")}

  validates_uniqueness_of :text, :message => "такая причина уже есть"

  validates_length_of :text, :minimum => 2, :maximum => 81, :message => "должен быть длиной от 2 до 81 символа"

  def try_to_save(text)
    downcase_text = text.mb_chars.downcase.to_s
    reason = Reason.find_downcase(downcase_text)
    reason ? reason.first.increase_popularity : Reason.create(text: text)
  end

  def increase_popularity
    self.update(popularity: self.popularity + 1)
  end
end
