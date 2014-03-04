# Обработка блока новостей
$ ->
  news.init()

# Параметры и функции, связанные с блоком новостей
news =
  # Добавляет кастомный скролл для блока новостей и включает переход по новости
  init: ->
    news.try_to_custom_pagination()
    $(window).resize ->
      news.try_to_custom_pagination()

    $(document).on "click", "#news_container article", ->
      window.open($(this).attr("data-link"), '_blank')


  # На десктопах пытается включить кастомную пагинацию
  try_to_custom_pagination: ->
    if app.mobile == false
      $("#news_pagination").customScrollbar()