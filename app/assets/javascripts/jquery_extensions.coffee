$.fn.extend
  
  pseudoHover: ->
    $(@).hover(
      -> $(@).addClass('hover'),
      -> $(@).removeClass('hover'))
  
  popoverForTicket: ->
    is_staged_for_development = $(@).closest('ul').is '#staged_for_development'
    $(@).popover
      title: -> 
        title = $(@).find('.ticket-summary').html().split(': ')
        if title[1] then title[0] else '<span class="no-feature">No Feature</span>'
      content: ->
        content = $(@).find('.ticket-summary').html().split(': ')
        content = if content[1] then content[1] else content
        if is_staged_for_development then content + '<span class="remove-instructions">Shift + Click to remove</span>' else content.capitalize()
  
  initializeAutoUpdate: (interval, kanban)->
    $(@).click ->
      $('#timer_wrapper').fadeIn()
      new Refresher
        time: interval
        callback: => kanban.loadQueues()
      $(@).remove()



$.extend

  # Extend jQuery with functions for PUT and DELETE requests.
  put: (url, data, callback, type)->
    if jQuery.isFunction(data)
      callback = data
      data = {}
    
    data = data || {}
    data['_method'] = 'put'
    jQuery.post(url, data, callback, type)
  
  destroy: (url, data, callback, type)->
    if jQuery.isFunction(data)
      callback = data
      data = {}

    data = data || {}
    data._method = 'delete'
    jQuery.post(url, data, callback, type)
