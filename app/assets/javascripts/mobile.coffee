$ ->
  run_mobile_checks()

  $(window).resize ->
    run_mobile_checks()

  first_news = $("#news_pagination article:first-child").clone()
  $("#news_evac").html(first_news)

  content = $("#content")

  $(".prev").click ->
    app.current_page -= 1
    change_mobile_block()

  $(".next").click ->
    app.current_page += 1
    change_mobile_block()

  # Перелистывание экранов на мобиле
  change_mobile_block = ->
    new_block = switch app.current_page
      when 0 then $("#reasons_content")
      when 1 then $("#news_content")
      when 2 then $("#main_content")
      else $("#about_content")

    new_block.removeClass("inactive_block")

    left = "-" + app.current_page + "00%"
    $("#content").animate({left: left}, 500, ->
      $(".active_block").addClass("inactive_block").removeClass("active_block")
      new_block.addClass("active_block"))


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