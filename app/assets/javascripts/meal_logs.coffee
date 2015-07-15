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
    chartCatId = $('#chart_category_id').find(":selected").val()
    $.ajax
      url: '/view-table-seats-status/' + tableId + '?meal=' + mealId + '&menu=' + menuId + '&chart_cat_id=' + chartCatId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('#table-detail').html(data)

  @updateTrack = (source) ->
    $('form.edit_meal_log').css('border', "9px solid red")
    console.log $("input", source).val()
    console.log $('form').serialize()

  @refreshSeatingChart = (source) ->
    logId = $('#meal_log_id').val()
    tableId = $('#meal_log_table_id').val()
    chartCatId = $('#chart_category_id').find(":selected").val()
    $.ajax
      url: '/refresh-data/' + logId + '?table_id=' + tableId + '&chart_cat_id=' + chartCatId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('#table-detail').html(data)
