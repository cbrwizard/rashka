$ ->
  current_page = 2
  content = $("#content")

  first_news = $("#news_pagination article:first-child").clone()
  $("#news_evac").html(first_news)

  # @todo Объединить эти функции
  $(".prev").click ->
    current_page -= 1
    left = "-" + current_page + "00%"

    $(".active_block").removeClass("active_block")
    $("#main_content").addClass("active_block")

    if $("#main_content").hasClass("active_block")
      $("body").removeClass("no_overflow")
    else
      $("body").addClass("no_overflow")

    $("#content").animate({left: left}, 500)
    false


  $(".next").click ->
    current_page += 1
    left = "-" + current_page + "00%"
    $(".active_block").removeClass("active_block")
    $("#about_content").addClass("active_block")

    if $("#main_content").hasClass("active_block")
      $("body").removeClass("no_overflow")
    else
      $("body").addClass("no_overflow")

    $("#content").animate({left: left}, 500)
    false
