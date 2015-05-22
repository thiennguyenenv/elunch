$ ->
  $(document).ajaxSend ->
      $('#spinner').addClass('in')
    $(document).ajaxStop ->
      $('#spinner').removeClass('in')

  @viewTable = (source) ->
    tableId = $(source).data('table')
    collapsible = $('#table-' + tableId)
    if $(source).hasClass('active')
      # do not request if it's active. Not sure the reason 'hide.bs.collapse' doesn't work, still collapse the active item
      return collapsible.on 'hidden.bs.collapse', ->
        collapsible.collapse('show')

    $(source).siblings().removeClass('active')
    $(source).addClass('active')
    $.ajax
      url: '/view-table/' + tableId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        collapsible.html(data)
