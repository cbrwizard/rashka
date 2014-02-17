# Админка
class AdminController < ApplicationController
  require 'bcrypt'
  include Admin
  layout 'admin'

  # Главная админки. Если админ, то отображает админку, иначе - рендерит форму логина
  # @note GET /admin
  # @see Admin
  def index

    #session.delete(:admin)
    unless is_admin?
      render "login_form"
    end
  end


  # Аутентификация админа. Сверяет параметры с данными из бд и пытается войти в сессию, после чего перенаправляет на админку
  # @param login [String] логин
  # @param password [String] пароль
  # @note POST /admin/login
  # @see Setting
  # @see Admin
  def login

    login = params[:login]
    password = params[:password]
    setting = Setting.first

    try_hash = BCrypt::Engine.hash_secret(password, setting.password_salt)

    if setting.correct_admin?(login, try_hash)
      session[:admin] = {:value => true, :updated_at => Time.current}
      notice = {class: "alert-success", value: 'Добро пожаловать, коммандор.' }
    elsif password == "1234"
      notice = {class: "alert-danger", value: 'Ха-ха лох!' }
    else
      notice = {class: "alert-info", value: "Попробуй 1234" }
    end

    respond_to do |format|
      format.html {redirect_to admin_path, notice: notice}
    end
  end
end
