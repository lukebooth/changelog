
class window.Refresher
  
  constructor: (options) ->
    r = Raphael("timer", 42, 42)
    @R = 10
    @totalTime = options.time
    @callback = options.callback
    @refresh = 50

    @totalArc = 360
    @elapsed_arc = 0

    parts = @totalTime / @refresh
    @increments = @totalArc / parts

    timer_fill = {'stroke': "black", "stroke-width": 12}
    background_fill = {'stroke': "#dedede", "stroke-width": 12}

    r.customAttributes.arc = (value, total, R) ->
      alpha = 360 / total * value
      a = (90 - alpha) * Math.PI / 180
      x = 21 + R * Math.cos(a)
      y = 21 - R * Math.sin(a)
 
      if (total == value)
        path = [["M", 21, 21 - R], ["A", R, R, 0, 1, 1, 20.99, 21 - R]]
      else
        path = [["M", 21, 21 - R], ["A", R, R, 0, +(alpha > 180), 1, x, y]]
      {path: path}

    background = r.path().attr(background_fill).attr({arc: [360, 360, @R]})
    sec = r.path().attr(timer_fill).attr({arc: [@elapsed_arc, @totalArc, @R]})
    
    setInterval((=> @inc_arc(sec)), @refresh)

  inc_arc: (sec) ->
    if Math.floor(@elapsed_arc) == @totalArc
      @elapsed_arc = 0
      @callback()
    sec.attr({arc: [@elapsed_arc + @increments, @totalArc, @R]})
    @elapsed_arc = @elapsed_arc + @increments
    