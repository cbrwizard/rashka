# Обработка малых экранов
$ ->
  mobile.init()
  mobile.run_mobile_checks()

# Функции, связанные с мобильниками
mobile =
  enabled_swipes: false

  # Проверяет, мобила ли это
  is_mobile: ->
    if $('#popup').css('display') == 'block'
      app.mobile = true
     else
      app.mobile = false


  # Проверяет, мобила ли это и пробует поставить новую высоту основных контейнеров
  run_mobile_checks: ->
    mobile.is_mobile()
    mobile.try_resize_containers()
    mobile.try_enable_swipe()


  # Перелистывание экранов на мобиле
  # @param percent проценты, на которые нужно сдвинуть все блоки
  change_mobile_block: (percent) ->
    new_block = mobile.get_current_screen_name()
    new_block.removeClass("inactive_block")

    # Чтобы новый контейнер успел отрендериться
    setTimeout (->
      $("html, body").animate({ scrollTop: "0" }, 200)
      $(".screen_block").each ->
        $this = $(this)
        this_left = parseInt($this.attr("data-left"))
        new_left = this_left + percent + "%"
        $this.attr("data-left", new_left)
        $this.css {left: new_left}

      mobile.update_screens(new_block)
      mobile.update_navigation()
      mobile.display_map()
    ), 100

    false


  # Отображает или скрывает навигацию по экранам в зависимости от текущего экрана
  update_navigation: ->
    if app.current_page == 0
      $(".prev").hide()
    else if app.current_page == 3
      $(".next").hide()
    else
      $(".next, .prev").show()



  # Отображает или скрывает карту в зависимости от текущего экрана
  display_map: ->
    if app.current_page == 2
      $("#map-canvas").fadeIn(500)
      # Чтобы на карте не было глюков
      google.maps.event.trigger(app.google_map,'resize')
    else
      $("#map-canvas").fadeOut(500)


  # Скрывает не активные экраны после анимации
  # @param new_block [jQuery Object] элемент активного экрана
  # @note Timeout чтобы контейнеры успели прогнать анимацию
  update_screens:(new_block) ->
    setTimeout (->
      $(".active_block").addClass("inactive_block").removeClass("active_block")
      new_block.addClass("active_block")
    ), 500


  # В зависимости от текущего значения экрана, выдает его элемент
  # @return [jQuery Object] элемент текущего экрана
  get_current_screen_name: ->
    current_screen = switch app.current_page
      when 0 then $("#reasons_content")
      when 1 then $("#news_content")
      when 2 then $("#main_content")
      else $("#about_content")


  # Если это мобильник, то подстраивает высоту основных контейнеров
  try_resize_containers: ->
    if app.mobile == true
      total_height = $("body").height()
      $(".screen_block").css({"height": total_height})


  # Если это мобильник, то добавляет возможность свайп навигации по экранам
  # @note При свайпах проверяет, можно ли дальше перелистывать
  try_enable_swipe: ->
    if app.mobile == true && mobile.enabled_swipes == false
      mobile.enabled_swipes = true
      $(".screen_block > header, #authors_container, #donate_container .about_text, #explain_container, #news_pagination, #reasons_modal").hammer().on "dragend", (event) ->
        if event.gesture.direction == 'right'
          if app.current_page != 0 && app.mobile == true
            mobile.go_left()

        if event.gesture.direction == 'left'
          if app.current_page != 3 && app.mobile == true
            mobile.go_right()


  # Перелистывает экраны влево
  go_left: ->
    app.current_page -= 1
    mobile.change_mobile_block(100)


  # Перелистывает экраны вправо
  go_right: ->
    app.current_page += 1
    mobile.change_mobile_block(-100)


  # Переключает обратно блоки после изменения размера экрана когда перестает/начинает быть mobile
  try_to_revert_screens: ->
    before_resize = app.mobile
    if app.mobile == false && app.mobile != before_resize
      app.current_page = 2
      $("#reasons_content").css({"left": ""})
      $("#news_content").css({"left": ""})
      $("#main_content").css({"left": ""})
      $("#about_content").css({"left": ""})
      mobile.display_map()
    else if app.mobile == true && app.mobile != before_resize
      app.current_page = 2
      $(".screen_block").addClass("inactive_block")
      $("#main_content").removeClass("inactive_block").addClass("active_block")


  # При изменении размеров экрана проверяет, не стал ли экран малым; включает кнопки перелистывания экранов
  init: ->
    $(window).resize ->
      mobile.run_mobile_checks()
      mobile.try_to_revert_screens()

    $(".prev, .news_evac .news_article").click ->
      mobile.go_left()

    $(".next").click ->
      mobile.go_right()