$ ->
  first_news = $("#news_pagination article:first-child").clone()
  $("#popup").html(first_news)