require 'active_support/concern'

# Для пагинации объектов
# @note На главной странице
# @param page_params [Integer] номер страницы в пролистывании
# @see News
module Paginated
  extend ActiveSupport::Concern

  included do
    scope :paginated, -> (page_params) {paginate(:page => page_params, :per_page => 10)}
  end
end