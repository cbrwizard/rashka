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

  $("#reason_field").change ->
    title = "Симулятор эвакуации из Рашки"
    text = "Я решил валить из рашки, потому что"
    reason = $(this).val()
    vk_like_button = $(".vk_like_button")
    vk_href = vk_like_button.attr("href")
    correct_vk_href = vk_href.slice( 0, vk_href.indexOf('&title') )
    tw_like_button = $(".tw_like_button")
    tw_href = tw_like_button.attr("href")
    correct_tw_href = tw_href.slice( 0, tw_href.indexOf('&text') )
#    console.log "vk_href #{vk_href}"
#    console.log "correct_vk_href #{correct_vk_href}"
#    console.log "vk_like_button #{vk_like_button.attr("href")}"
#    console.log "tw_href #{tw_href}"
#    console.log "correct_tw_href #{correct_tw_href}"
#    console.log "tw_like_button #{tw_like_button.attr("href")}"
    vk_like_button.attr("href", correct_vk_href + "&title=#{title}&description=#{text} #{reason}")
    tw_like_button.attr("href", correct_tw_href + "&text=#{text} #{reason}")


social_window = (url) ->
  #функция для открытия окна шеринга, принимает адрес
  window.open url, "social_window", "height=300,width=550,resizable=1"
  false