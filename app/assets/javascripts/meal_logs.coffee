$ ->
  @listTablesOfShift = (source) ->
    shiftId = $(source).data('shift')
    $.ajax
      url: '/list-table-names/' + shiftId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $("#table-group").html(data)
