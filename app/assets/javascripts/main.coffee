$ ->
  $(document).ajaxSend ->
      $('#spinner').show()
    $(document).ajaxStop ->
      $('#spinner').hide()

  $('#user_table_id').change ->
    $.ajax
      url: '/view-table/' + $('#user_table_id').val()
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
