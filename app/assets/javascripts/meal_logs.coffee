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
        $('form.edit_meal_log').submit ->
          id = $('#meal_log_id').val()
          notes = $('#meal_log_notes').val()
          valuesToSubmit =
            meal_log:
              notes: notes
              seats: jsonSeats()

          $.ajax
            url: '/meal_logs/' + id
            type: 'PATCH'
            data: JSON.stringify(valuesToSubmit)
            dataType: 'html'
            contentType: 'application/json'
            success: (data) ->
              console.log 'Success!'
              $('#table-detail').html(data)
          false # prevent normal behavior

  @updateTrack = (source) ->
    $('form.edit_meal_log').css('border', "9px solid red")
    console.log $("input", source).val()
    console.log $('form').serialize()

  jsonSeats = ->
    seats = []
    $('input[type=radio][name!=shifts]:checked').each (index) ->
      seats.push({id: $(this).attr('name'), status: $(this).val()})
    seats
