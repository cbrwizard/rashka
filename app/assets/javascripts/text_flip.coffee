$ ->
  $("#news_container h3").ticker()
  $("#reasons_container h3").ticker()


$.fn.ticker = () ->
  $this = $(this)

  letters = "ALU.CHBDRJFNQSIKP2E53O!А0GVЁ?4,T18»9'YM«0)Д(БЗК-ИТZ:XПЕХ6ЛГО7ВЙЭЧРЬФШЦНЮЪЫСЩМУЖЯ "

  letters_array = letters.split("")
  max_length = 17

  text = $this.attr("data-flip")
  text_array = text.split("")
  text_array.push "&#160"  while text_array.length < max_length

  target = $("<h3 class='flip'>")
  target.html "<span>" + text_array.join("</span><span>") + "</span>"

  parent_container = $this.parent()
  parent_container.prepend(target)

  $this.remove()

  target.show()
  unless app.mobile == true
    target.find("span").each ->
      magic(target.find($(this)), letters)

magic = (span, letters)->
  $this = span
  letter = span.html().toUpperCase()
  i = 0

  flipper_interval = setInterval(->
    $this.html(letters[i])
    if letter == letters[i]
      console.log "yeah, was #{letters[i]} and this was #{letter}"
#          alert 123
      clearInterval flipper_interval
    else
      console.log "nope, letter was #{letters[i]} and this was #{letter}"
      i += 1
  , 40)
#      flipper_interval = window.setInterval(->
##        console.log $this
#        console.log $this.html()
#        unless letter is $this.html()
#          $this.html(letters[i])
#          i += 1
#        else
#          window.clearInterval flipper_interval
#      , 20)



#    target.show()

#
#  @each ->
#    k = 1
#
#
#
#    target = $("<div>")
#    render = (print) ->
#      target.data "prev", print.join("")
#      fill print
#
#      target.html "<span>" + print.join("</span><span>") + "</span>"
#
#    attr = {}
#    $.each @attributes, (i, item) ->
#      target.attr item.name, item.value
#      return
#
#    $(this).replaceWith render(texts[0].split(""))
#    target.click (e) ->
#      print = prev
#      $.each next, (i) ->
#        return  if next[i] is prev[i]
#        index = alph.indexOf(prev[i])
#        j = 0
#        tid = window.setInterval(->
#          unless next[i] is arr[index]
#            index = (if index is alph.length - 1 then 0 else index + 1)
#          else
#            window.clearInterval tid
#          print[i] = alph[index]
#          render print
#          return
#        , 20)
#        return
#
#      k = (if k is texts.length - 1 then 0 else k + 1)
#      return
#
#    return
#
#
#$("#text").ticker()
#
#
#$.fn.ticker = () ->
#  alph = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVXYZ,.?!01234567890«»-():' "
#  @each ->
#    k = 1
#    elems = $(this).children()
#    arr = alph.split("")
#    len = 0
#    fill = (a) ->
#      a.push " "  while a.length < len
#      a
#
#    texts = $.map(elems, (elem) ->
#      text = $(elem).text()
#      len = Math.max(len, text.length)
#      text
#    )
#    target = $("<div>")
#    render = (print) ->
#      target.data "prev", print.join("")
#      fill print
#      print = $.map(print, (p) ->
#        (if p is " " then "&#160;" else p)
#      )
#      target.html "<span>" + print.join("</span><span>") + "</span>"
#
#    attr = {}
#    $.each @attributes, (i, item) ->
#      target.attr item.name, item.value
#      return
#
#    $(this).replaceWith render(texts[0].split(""))
#    target.click (e) ->
#      next = fill(texts[k].split(""))
#      prev = fill(target.data("prev").split(""))
#      print = prev
#      $.each next, (i) ->
#        return  if next[i] is prev[i]
#        index = alph.indexOf(prev[i])
#        j = 0
#        tid = window.setInterval(->
#          unless next[i] is arr[index]
#            index = (if index is alph.length - 1 then 0 else index + 1)
#          else
#            window.clearInterval tid
#          print[i] = alph[index]
#          render print
#          return
#        , 20)
#        return
#
#      k = (if k is texts.length - 1 then 0 else k + 1)
#      return
#
#    return