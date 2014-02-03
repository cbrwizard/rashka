$ ->
  $(document).on "click", ".share_button", () ->
    #при нажатии по соц кнопке открывай окошко соц сети
    url = $(@).attr("href")
    social_window(url)
    false


social_window = (url) ->
  #функция для открытия окна шеринга, принимает адрес
  window.open url, "social_window", "height=300,width=550,resizable=1"