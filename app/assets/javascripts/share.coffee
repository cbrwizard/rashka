# Обработка нажатий по соц кнопкам, а также поля ввода причины
$ ->
  # Включает обновление поля причины для учета кол-ва символов
  reason_field = $("#reason_field")
  reason_field.trigger("change")
  share.update_share_buttons(reason_field)

  $("#get_random_container").click ->
    $(this).addClass("loading")
    $(this).find("img").removeClass("hidden")

  # При нажатии по соц кнопке открывай окошко соц сети
  $(".share_button").click ->
    share.share_reason($(@).find("a"))

  # При нажатии по блоку брейнлука открывает страницу брейнлука
  $("#brainlook").click ->
    unless $(this).hasClass("error_share")
      reason = $(reason_field).val()
      share.update_statistics("bl_post", reason)
      window.open($(this).attr("data-link"), '_blank')

  # При изменении текста поля ввода причины меняет текст у соц кнопок
  $(reason_field).on "input propertychange change", ->
    share.update_share_buttons($(this))


  $(reason_field).on "click", ->
    reason_field.val("")


# Параметры и функции, связанные с соц кнопками и полем ввода причины
share =
  title: "Симулятор эвакуации из Рашки"
  text: "Я решил валить из рашки, потому что"


  # Меняет текст вк кнопки
  # @param reason [String] текст причины
  change_vk_link: (reason) ->
    vk_like_button = $(".vk_post")
    vk_href = vk_like_button.attr("href")
    correct_vk_href = vk_href.slice( 0, vk_href.indexOf('&title') )
    vk_like_button.attr("href", correct_vk_href + "&title=#{share.title}&description=#{share.text} #{reason}")


  # Меняет текст тв кнопки
  # @param reason [String] текст причины
  change_tw_link: (reason) ->
    tw_like_button = $(".tw_post")
    tw_href = tw_like_button.attr("href")
    correct_tw_href = tw_href.slice( 0, tw_href.indexOf('&text') )
    tw_like_button.attr("href", correct_tw_href + "&text=#{share.text} #{reason}")


  # Меняет текст мнения для брейнлука
  # @param reason [String] текст причины
  change_bl_link: (reason) ->
    brainlook = $("#brainlook")
    link = brainlook.attr("data-link")
    correct_link = link.slice( 0, link.indexOf('?opinion_text') )
    brainlook.attr("data-link", correct_link + "?opinion_text=#{share.text} #{reason}")


  # Считает количество символов у поля ввода и отображает, удовлетворяет ли длина требованиям
  # @param textarea [jQuery DOM] поле ввода причины
  count_reason_text: (textarea) ->
    text = textarea.val()
    counter = $("#reason_text_counter")
    share_buttons = $(".share_button, #brainlook")
    max_length = 80
    letters_left = max_length - text.length
    counter.html(letters_left)

    if letters_left < 0
      counter.addClass("text-danger").removeClass("text-warning ok_counter")
      share_buttons.addClass("error_share").removeClass("ok_share")
    else if letters_left < 6
      share_buttons.removeClass("error_share").addClass("ok_share")
      counter.addClass("text-warning").removeClass("text-danger ok_counter")
    else
      share_buttons.removeClass("error_share").addClass("ok_share")
      counter.removeClass("text-danger text-warning").addClass("ok_counter")


  # Переносит текст из поля причины в кнопки соц сетей
  # @param textarea [jQuery DOM] поле ввода причины
  update_share_buttons: (textarea) ->
    reason = textarea.val()
    shortened_reason = reason.substr(0, 80)
    share.change_vk_link (shortened_reason)
    share.change_tw_link (shortened_reason)
    share.change_bl_link (shortened_reason)
    share.count_reason_text (textarea)


  # Если текст короткий, то обновляет статистику и открывает окно соц сети
  # @param share_button [Jquery DOM] кнопка соц сети
  # @return false [boolean] останавливает обычное действие кнопки
  share_reason: (share_button) ->
    unless share_button.parent().hasClass("error_share")
      method = share_button.attr("data-method")
      reason = $("#reason_field").val()
      share.update_statistics(method, reason)

      if share_button.hasClass("fb_post")
        share.post_to_fb(reason)
      else
        url = share_button.attr("href")
        share.share_window(url)
    false


  # Запускает метод обновления статистики соц кнопки
  # @param method [String] имя метода
  # @param reason [String] текст причины
  update_statistics: (method, reason) ->
    $.ajax "../stats/#{method}",
      type: "POST"
      dataType: "json"
      data:
        reason: reason
      success: ->
        console.log "yeahhhhhh"
      error: ->
        console.log "nooooo"


  # Обрезает текст причины и открывает окно фейсбука
  # @param reason [String] текст причины
  post_to_fb: (reason) ->
    shortened_reason = reason.substr(0, 80)
    FB.ui({
      method: 'feed'
      link: 'valiizrashki.ru'
      caption: share.title
      description: "#{share.text} #{shortened_reason}"
    },
      (response)->)


  # Открывает окошко вк и твиттера для поста
  # @param url [String] текст ссылки на соц сеть с причиной и тд
  share_window: (url) ->
    window.open url, "share_window", "height=300,width=550,resizable=1"