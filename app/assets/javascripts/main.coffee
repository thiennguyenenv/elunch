$ ->
  $(document).ajaxSend ->
      $('#spinner').addClass('in')
    $(document).ajaxStop ->
      $('#spinner').removeClass('in')

  @viewTable = (source) ->
    $(source).siblings().removeClass('active')
    $(source).addClass('active')

    $.ajax
      url: '/view-table/' + $(source).data('table')
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $("#table-detail").html(data)

  @loadTable = (source) ->
    shiftId = $(source).data('shift')
    $.ajax
      url: '/list-tables/' + shiftId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $("#tables-panel").html(data)
