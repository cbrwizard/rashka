# Модуль для обработки админского доступа
module Admin
  extend ActiveSupport::Concern

  # Если юзер не админ, то делает редирект на главную
  # @note На вьюхах моделей и админки
  # @example
  #   before_action :allow_access?
  #
  # @see AdminController
  def allow_access?
    unless is_admin?
      notice = {class: "alert-danger", value: 'Сюда нельзя' }
      redirect_to root_path, notice: notice
    end
  end


  # Проверяет содержимое сессии админа на право быть админом
  # @return [Boolean] админ текущий юзер или нет
  # @example
  #   unless is_admin?
  #
  # @see Admin#allow_access?
  def is_admin?
    session[:admin].try(:[], :value)
  end
end