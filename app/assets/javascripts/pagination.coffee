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
  check_news_for_pagination: (container, scrollData)->
    body = $("body")
    next = $("#news_pagination").find(".pagination .next_page")
    if scrollData
      if scrollData.scrollPercent >= 75 && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)
    else
      if $(window).scrollTop() + $(window).height() > $(document).height() / 1.3 && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)


  # При определенной высоте скролла внутри блока пытается вызвать пагинацию
  # @param container [Jquery DOM] контейнер, за которым надо следить
  check_reasons_for_pagination: (container)->
    body = $("body")
    next = $("#reasons_pagination").find(".pagination .next_page")
    console.log container
    if container[0].self == window
      if $(window).scrollTop() + $(window).height() > $(document).height() / 1.3 && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)
    else
      scrolled_already = container.scrollTop()
      container_height = container.innerHeight()
      pagination_height = container[0].scrollHeight - 250
      if scrolled_already + container_height >= pagination_height && !body.hasClass("paginating") && !next.hasClass("disabled")
        @.paginate(body, next)


  # При скролле блока новостей идет пагинация
  news_pagination: ->
    $(window).on "scroll", ->
      if app.current_page == 1
        pagination.check_news_for_pagination($(this))

    $("#news_pagination").on "customScroll", (event, scrollData) ->
      pagination.check_news_for_pagination($(this), scrollData)


  # При скролле блока причин идет пагинация
  reasons_pagination: ->
    $(window).on "scroll", ->
      if app.current_page == 0
        pagination.check_reasons_for_pagination($(this))

    $("#reasons_modal").on "scroll", ->
      pagination.check_reasons_for_pagination($(this))


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