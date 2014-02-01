module Admin
  extend ActiveSupport::Concern

  def allow_access?
    unless is_admin?
      notice = {class: "alert-danger", value: 'Сюда нельзя.' }
      redirect_to root_path, notice: notice
    end
  end

  def is_admin?
    session[:admin].try(:[], :value)
  end
end