$ ->
  $(document).ajaxSend ->
      $('#spinner').addClass('in')
    $(document).ajaxStop ->
      $('#spinner').removeClass('in')

  @viewTable = (source) ->
    $(source).siblings().removeClass('active')
    $(source).addClass('active')
    $("#table-detail").empty()
    tableId = $(source).data('table')
    $("#user_table_id").val(tableId)
    $.ajax
      url: '/view-table/' + tableId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $("#table-detail").html(data)
