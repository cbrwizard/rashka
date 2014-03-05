$ ->
  run_mobile_checks()

  $(window).resize ->
    run_mobile_checks()

  first_news = $("#news_pagination article:first-child").clone()
  $("#news_evac").html(first_news)

  current_page = 2
  content = $("#content")

  $(".prev").click ->
    current_page -= 1
    change_mobile_block()

  $(".next").click ->
    current_page += 1
    change_mobile_block()

  # Перелистывание экранов на мобиле
  change_mobile_block = ->
    left = "-" + current_page + "00%"
    $(".screen_block").addClass("inactive_block")

    current_block = switch current_page
      when 0 then $("#reasons_content")
      when 1 then $("#news_content")
      when 2 then $("#main_content")
      else $("#about_content")

    console.log current_page
    if current_page == 0
      $(".prev").hide()
    else if current_page == 3
      $(".next").hide()
    else
      $(".next, .prev").show()

    current_block.removeClass("inactive_block")

    $("#content").animate({left: left}, 500)
    false


# Запускает проверки по поводу мобилы
run_mobile_checks = ->
  total_height = $("body").height()
  app.is_mobile()
  resize_containers(total_height)



resize_containers = (total_height) ->
  if app.mobile == true
    $(".screen_block").css({"height": total_height})