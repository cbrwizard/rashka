class Reason < ActiveRecord::Base
  default_scope order(updated_at: :desc)
  scope :view_info, -> {select(:text, :updated_at)}
  scope :random, -> {unscoped.order("RANDOM()").first}

  validates_presence_of :text, message: "нужно чем-то заполнить"

  validates_uniqueness_of :text, :message => "такая причина уже есть"

  validates_length_of :text, :minimum => 2, :maximum => 241, :message => "должен быть длиной от 2 до 240 символов"
end
