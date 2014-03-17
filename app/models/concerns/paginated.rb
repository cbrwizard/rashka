require 'active_support/concern'

# Для пагинации объектов (новостей и причин)
# @note На главной странице
# @param page_params [Integer] номер страницы в пролистывании
# @see News
# @see Reason
module Paginated
  extend ActiveSupport::Concern

  included do
    scope :paginated, -> (page_params, amount) {paginate(:page => page_params, :per_page => amount)}
  end
end