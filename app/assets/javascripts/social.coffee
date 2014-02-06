$ ->
  $(".share_button").click (e) ->
    #при нажатии по соц кнопке открывай окошко соц сети
    e.preventDefault
    share_button = $(@)
    method = share_button.attr("data-method")
    $.ajax "../stats/#{method}",
      type: "POST"
      dataType: "json"
      success: ->
        console.log "yeahhhhhh"
      error: ->
        console.log "nooooo"
    url = share_button.attr("href")
    social_window(url)


social_window = (url) ->
  #функция для открытия окна шеринга, принимает адрес
  window.open url, "social_window", "height=300,width=550,resizable=1"
  false