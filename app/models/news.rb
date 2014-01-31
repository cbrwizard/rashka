class News < ActiveRecord::Base
  default_scope order(:id)
end
