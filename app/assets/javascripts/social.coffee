$ ->
  $(".share_button").click ->
    #при нажатии по соц кнопке открывай окошко соц сети
    share_button = $(@)
    unless share_button.hasClass("error_share")
      method = share_button.attr("data-method")
      reason = $("#reason_field").val()
      $.ajax "../stats/#{method}",
        type: "POST"
        dataType: "json"
        data:
          reason: reason
        success: ->
          console.log "yeahhhhhh"
        error: ->
          console.log "nooooo"
      if share_button.hasClass("fb_like_button")
        shortened_reason = reason.substr(0, 80)
        FB.ui({
          method: 'feed'
          link: 'brainlook.org'
          caption: app.social_title
          description: "#{app.social_text} #{shortened_reason}"
        }, (response)->);
      else
        url = share_button.attr("href")
        social_window(url)
    false

  $("#reason_field").change ->
    #переносит текст из поля причины в кнопки соц сетей
    reason = $(this).val()
    shortened_reason = reason.substr(0, 80)
    change_vk_link (shortened_reason)
    change_tw_link (shortened_reason)
    count_reason_text ($(this))

  $("#reason_field").on "input propertychange", ->
    count_reason_text ($(this))

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
  #TODO: перенести социальный текст в этот файл

count_reason_text = (textarea) ->
  text = textarea.val()
  current_length = text.length
  counter = $("#reason_text_counter")
  share_buttons = $(".share_button")
  max_length = 80
  letters_left = max_length - current_length
  if letters_left < 0
    counter.addClass("text-danger").removeClass("text-warning")
    share_buttons.addClass("error_share").removeClass("ok_share")
  else if letters_left < 6
    share_buttons.removeClass("error_share").addClass("ok_share")
    counter.addClass("text-warning").removeClass("text-danger")
  else
    share_buttons.removeClass("error_share").addClass("ok_share")
    counter.removeClass("text-danger text-warning")
  counter.html(letters_left)

social_window = (url) ->
  #функция для открытия окна шеринга, принимает адрес
  window.open url, "social_window", "height=300,width=550,resizable=1"