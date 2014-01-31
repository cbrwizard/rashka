class AdminController < ApplicationController
  require 'bcrypt'

  def index
    #главная админки
    if session[:admin].try(:[], :value)
      @result = "yay"
    else
      @result = "nay"
    end

  end

  def login
    #POST принимает логин и пароль для входа в админки, сверяет с хэшем в базе и пытается войти в сессию

    login = params[:login]
    password = params[:password]
    setting = Setting.first

    try_hash = BCrypt::Engine.hash_secret(password, setting.password_salt)
    if setting.password_hash == try_hash && login == setting.login
      session[:admin] = {:value => true, :updated_at => Time.current}
    end

    respond_to do |format|
      format.html {redirect_to admin_path, notice: 'Добро пожаловать, коммандор.'}
    end
  end
end
