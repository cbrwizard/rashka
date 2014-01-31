module Admin
  extend ActiveSupport::Concern

  def allow_access?
    unless is_admin?
      redirect_to root_path, notice: "Сюда нельзя"
    end
  end

  def is_admin?
    session[:admin].try(:[], :value)
  end
end