# Обработка пагинации
$ ->
  pagination.init()


# Функции, связанные с пагинацией
pagination =
  # Подключает пагинацию новостей и причин на главной
  init: ->
    @.news_pagination()
    @.reasons_pagination()


  # При скролле блока новостей идет пагинация
  news_pagination: ->
    $("#news_container").on "scroll", ->
      pagination.check_for_pagination($(this))


  # При скролле блока причин идет пагинация
  reasons_pagination: ->
    $("#reasons_container").on "scroll", ->
      pagination.check_for_pagination($(this))


  # При определенной высоте скролла внутри блока пытается вызвать пагинацию
  # @param container [Jquery DOM] контейнер, за которым надо следить
  check_for_pagination: (container)->
    body = $("body")
    next = container.find(".pagination .next_page")
    scrolled_already = container.scrollTop()
    container_height = container.innerHeight()
    pagination_height = container[0].scrollHeight - 250
    if scrolled_already + container_height >= pagination_height && !body.hasClass("paginating") && !next.hasClass("disabled")
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