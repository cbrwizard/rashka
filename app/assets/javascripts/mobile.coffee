$ ->
  first_news = $("#news_pagination article:first-child").clone()
  $("#news_evac").html(first_news)