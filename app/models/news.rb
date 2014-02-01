class News < ActiveRecord::Base
  default_scope order(:id)

  validates_presence_of :title, :text, :link, message: "нужно чем-то заполнить"

  validates_uniqueness_of :text, :title, :link, :message => "не должно повторяться в другой новости"

  validates_length_of :text, :title, :link, :minimum => 2, :maximum => 241, :message => "должен быть длиной от 2 до 240 символов"
end
