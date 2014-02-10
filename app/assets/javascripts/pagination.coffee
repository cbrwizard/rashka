$ ->
  news_pagination()
  reasons_pagination()

news_pagination = ->
  $("#news_container").on "scroll", ->
    pagination($(this))

reasons_pagination = ->
  $("#reasons_container").on "scroll", ->
    pagination($(this))

pagination = ($this)->
  #пагинация блоков на главной, при определенном скролле через аякс грузит следующие блоки
  body = $("body")
  next = $this.find(".pagination .next_page")
  scrolled_already = $this.scrollTop()
  container_height = $this.innerHeight()
  pagination_height = $this[0].scrollHeight - 250
  if scrolled_already + container_height >= pagination_height && !body.hasClass("paginating") && !next.hasClass("disabled")
    body.addClass("paginating")
    $.ajax
      type: 'GET'
      url: next.attr('href')
      dataType: 'script'
      success: ->
        body.removeClass("paginating")