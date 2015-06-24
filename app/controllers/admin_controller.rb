# Админка
class AdminController < ApplicationController
  require 'bcrypt'
  layout 'admin'
  include Admin

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
    notice = _get_login_result(login, password, try_hash)
    respond_to do |format|
      format.html {redirect_to admin_path, notice: notice}
    end
  end


  # Проверяет, правильные ли данные логина и возвращает сообщение
  # @param login [String] логин
  # @param password [String] пароль
  # @param try_hash [String] хэш пароля
  # @note вызывается при аутентификации в login
  # @example
  #   notice = _get_login_result(login, try_hash)
  # @see Setting
  # @see Admin
  # @return [Hash] notice для отображения сообщения сверху экрана
  def _get_login_result(login, password, try_hash)
    setting = Setting.first
    if setting.correct_admin?(login, try_hash)
      session[:admin] = {:value => true, :updated_at => Time.current}
      {class: "alert-success", value: 'Добро пожаловать, коммандор.' }
    elsif password == "1234"
      {class: "alert-danger", value: 'Ха-ха лох!' }
    else
      {class: "alert-info", value: "Попробуй 1234" }
    end
  end
end
