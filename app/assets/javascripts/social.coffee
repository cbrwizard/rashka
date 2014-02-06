$ ->
  $(".share_button").click ->
    #при нажатии по соц кнопке открывай окошко соц сети
    share_button = $(@)
    method = share_button.attr("data-method")
    $.ajax "../stats/#{method}",
      type: "POST"
      dataType: "json"
      success: ->
        console.log "yeahhhhhh"
      error: ->
        console.log "nooooo"
    if share_button.hasClass("fb_like_button")
      FB.ui({
        method: 'feed'
        link: 'brainlook.org'
        caption: app.social_title
        description: "#{app.social_text} #{$("#reason_field").val()}"
      }, (response)->);
    else
      url = share_button.attr("href")
      social_window(url)
    false

  $("#reason_field").change ->
    #переносит текст из поля причины в кнопки соц сетей
    reason = $(this).val()
    change_vk_link (reason)
    change_tw_link (reason)

change_vk_link = (reason) ->
  #меняет текст тв кнопки
  vk_like_button = $(".vk_like_button")
  vk_href = vk_like_button.attr("href")
  correct_vk_href = vk_href.slice( 0, vk_href.indexOf('&title') )
  vk_like_button.attr("href", correct_vk_href + "&title=#{app.social_title}&description=#{app.social_text} #{reason}")

change_tw_link = (reason) ->
  #меняет текст вк кнопки
  tw_like_button = $(".tw_like_button")
  tw_href = tw_like_button.attr("href")
  correct_tw_href = tw_href.slice( 0, tw_href.indexOf('&text') )
  tw_like_button.attr("href", correct_tw_href + "&text=#{app.social_text} #{reason}")

social_window = (url) ->
  #функция для открытия окна шеринга, принимает адрес
  window.open url, "social_window", "height=300,width=550,resizable=1"