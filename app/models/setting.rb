class Setting < ActiveRecord::Base
  attr_accessor :password

  def correct_admin?(login, try_hash)
    #проверяет, правильные ли данные введены в админку, принимает логин-стринг, пароль-стринг, хэш-стринг
    self.password_hash == try_hash && login == self.login
  end
end
