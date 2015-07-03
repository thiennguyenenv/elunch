$ ->
  @listTablesOfShift = (source) ->
    shiftId = $(source).data('shift')
    $.ajax
      url: '/list-table-names/' + shiftId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $("#table-group").html(data)

  @viewTableSeatsStatus = (source) ->
    tableId = $(source).data('table')
    mealId = $('#meal_id').find(":selected").val()
    menuId = $('#menu_id').find(":selected").val()

    $.ajax
      url: '/view-table-seats-status/' + tableId + '?meal=' + mealId + '&menu=' + menuId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('#table-detail').html(data)
