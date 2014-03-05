$ ->
  run_mobile_checks()

  $(window).resize ->
    run_mobile_checks()

  first_news = $("#news_pagination article:first-child").clone()
  $("#news_evac").html(first_news)

  content = $("#content")


  $(document).on "swiperight", ".screen_block > header", ->
    if app.current_page != 0
      app.current_page -= 1
      change_mobile_block(100)

  $(document).on "swipeleft", ".screen_block > header", ->
    if app.current_page != 3
      app.current_page += 1
      change_mobile_block(-100)

  $(".prev").click ->
    app.current_page -= 1
    change_mobile_block(100)

  $(".next").click ->
    app.current_page += 1
    change_mobile_block(-100)


  # Перелистывание экранов на мобиле
  # @param percent проценты, на которые нужно сдвинуть все блоки
  change_mobile_block = (percent) ->
    new_block = switch app.current_page
      when 0 then $("#reasons_content")
      when 1 then $("#news_content")
      when 2 then $("#main_content")
      else $("#about_content")

    new_block.removeClass("inactive_block")

    $(".screen_block").each ->
      $this = $(this)
      this_left = parseInt($this.attr("data-left"))
      new_left = this_left + percent + "%"
      $this.attr("data-left", new_left)
      console.log $this
      console.log this_left
      console.log new_left
      $this.animate {left: new_left}, 500
    setTimeout (->
      $(".active_block").addClass("inactive_block").removeClass("active_block")
      new_block.addClass("active_block")
    ), 500


#      $(this).animate({left: left}, 500)

#    left = "-" + app.current_page + "00%"
#    $("#content").animate({left: left}, 500, ->


    if app.current_page == 0
      $(".prev").hide()
    else if app.current_page == 3
      $(".next").hide()
    else
      $(".next, .prev").show()
    false


# Запускает проверки по поводу мобилы
run_mobile_checks = ->
  total_height = $("body").height()
  app.is_mobile()
  resize_containers(total_height)



resize_containers = (total_height) ->
  if app.mobile == true
    $(".screen_block").css({"height": total_height})