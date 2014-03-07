# Обработка блока причин на главной
$ ->
  reasons.init()

# Параметры и функции, связанные с блоком причин
reasons =
  # Отображение трех причин на главной и бинд этого отображения на клик по кнопке
  init: ->
    @.get_three()

    setInterval (->
      unless app.mobile
        reasons.get_three()
    ), 10000


  # Грузит три случайные причины в блок причин
  get_three: ->
    unless $("body").hasClass("loading_three")
      $.ajax
        type: 'GET'
        url: "../reasons/get_three_random"
        dataType: 'script'
        beforeSend: ->
          $("body").addClass("loading_three")
          $("#reasons_loader, #more_reasons").toggleClass("hidden")
        success: ->
          $("body").removeClass("loading_three")
          $("#reasons_loader, #more_reasons").toggleClass("hidden")
          console.log("yay")