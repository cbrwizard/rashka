require 'active_support/concern'

# Для пагинации объектов
# @note На главной странице
# @param page_params [Integer] номер страницы в пролистывании
# @see Reason
# @see News
module Paginated
  extend ActiveSupport::Concern

  included do
    scope :paginated, -> (page_params) {paginate(:page => page_params, :per_page => 5)}
  end
end