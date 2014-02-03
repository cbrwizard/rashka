$ ->
  evac_btn.init()

evac_btn =
  #кнопка ВАЛИТЬ
  dom_element: $("#evac_btn")
  share_mode_on: ->
    #скрывает кнопку валить и показывает кнопку рассказать
    @.dom_element.addClass("hidden")
    share_btn.dom_element.removeClass("hidden")

  init: ->
    #запуск слушателей
    $(document).on "click", ->
      evac_btn.share_mode_on()

share_btn =
  #кнопка РАССКАЗАТЬ
  dom_element: $("#share_btn")