# Обработка окошка о сайте
$ ->
  # При наведении по кнопке доната отображаются кнопки доната с сайта
  $("#donate_btn_container").hover ->
    $("#donate_btn, #donate_plugins").stop().fadeToggle(500)


  # При клике по автору открывается ссылка на его сайт
  $(document).on "click", ".author_container", ->
    window.open($(this).attr("data-link"), '_blank')