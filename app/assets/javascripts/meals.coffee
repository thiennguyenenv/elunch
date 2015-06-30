$ ->
  @selectMenu = (source) ->
    menuId = $(source).data('menu')
    $.ajax
      url: 'select_menu'
      type: 'PUT'
      data:
        menu_id: menuId
      dataType: 'html'
      success: (data) ->
        $('#meal_items').html(data)
