# Обработка пагинации
$ ->
  pagination.init()


# Функции, связанные с пагинацией
pagination =
  # Подключает пагинацию новостей и причин на главной
  init: ->
    @.news_pagination()
    @.reasons_pagination()


  # При определенной высоте скролла внутри блока пытается вызвать пагинацию
  # @param container [Jquery DOM] контейнер, за которым надо следить
  # @param scrollData [Object] объект с данными о текущем скролле
  check_for_pagination: (container, scrollData)->
    body = $("body")
    if container == $(window)
      next = $("#news_pagination").find(".pagination .next_page")
    else
      next = container.find(".pagination .next_page")
    if scrollData
      if scrollData.scrollPercent >= 75 && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)
        container.customScrollbar("resize", true);
    else
      scrolled_already = container.scrollTop()
      pagination_height = 250
      if scrolled_already >= pagination_height && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)


  # При скролле блока новостей идет пагинация
  news_pagination: ->
    $(window).on "scroll", ->
      pagination.check_for_pagination($(this))

    $("#news_pagination").on "customScroll", (event, scrollData) ->
      pagination.check_for_pagination($(this), scrollData)


  # При скролле блока причин идет пагинация
  reasons_pagination: ->
    $("#reasons_container").on "scroll", ->
      pagination.check_for_pagination($(this))


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