# Настройка сайта (1 шт)
# @example #<Setting id: 1, login: "admin", password_hash: "$2a$10$Jem9RC31Mt.6QQ1c7WNma.cj5l9w3DR9RUXF7AOpVin.ru/mDIQei", password_salt: "$2a$10$Jem9RC31Mt.6QQ1c7WNma., created_at: "2014-02-15 11:03:30", updated_at: "2014-02-16 19:47:53">
class Setting < ActiveRecord::Base
  #attr_accessor :password


  # Проверяет, правильные ли данные введены в админку
  # @note Вызывается при логине на админку
  # @example Reason.try_to_save
  # @param login [String] логин
  # @param try_hash [String] результат действия BCrypt::Engine.hash_secret(password, salt) к введенному паролю и к соли из бд
  # @return [Boolean]
  #
  # @see AdminController#login
  def correct_admin?(login, try_hash)
    self.password_hash == try_hash && login == self.login
  end
end
