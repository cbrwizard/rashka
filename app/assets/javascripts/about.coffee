# Обработка окошка о сайте
$ ->
  # При наведении по кнопке доната отображаются кнопки доната с сайта
  $("#donate_btn_container").hover ->
    $("#donate_btn, #donate_plugins").stop().fadeToggle(500)