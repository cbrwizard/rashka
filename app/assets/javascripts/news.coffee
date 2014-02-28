# Обработка блока новостей
$ ->
  news.init()

# Параметры и функции, связанные с блоком новостей
news =
  # Добавляет кастомный скролл для блока новостей, включает пагинацию и включает переход по новости
  init: ->
    $("#news_pagination").customScrollbar()
    @.pagination()
    $("#news_container article").click ->
      window.open($(this).attr("data-link"), '_blank');


  # При скролле блока новостей идет пагинация
  pagination: ->
    $("#news_pagination").on "customScroll", (event, scrollData) ->
      news.check_for_pagination($(this), scrollData)


  # При определенной высоте скролла внутри блока пытается вызвать пагинацию
  # @param container [Jquery DOM] контейнер, за которым надо следить
  # @param scrollData [Object] объект с данными о текущем скролле
  check_for_pagination: (container, scrollData)->
    body = $("body")
    next = container.find(".pagination .next_page")
    if scrollData.scrollPercent >= 75 && !body.hasClass("paginating") && !next.hasClass("disabled")
      @.paginate(body, next)


  # Через аякс грузит следующие данные в блок данных
  # @note к body добавляется на время пагинации класс, чтобы не дублировалась пагинация
  # @param body [Jquery DOM] body документа
  # @param next_link [Jquery DOM] контейнер ссылки "перелистать далее"
  paginate:(body, next_link) ->
    body.addClass("paginating")
    $.ajax
      type: 'GET'
      url: next_link.attr('href')
      dataType: 'script'
      success: ->
        body.removeClass("paginating")
        $("#news_pagination").customScrollbar("resize", true)