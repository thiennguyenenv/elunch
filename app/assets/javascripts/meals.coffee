$ ->
  @selectMenu = (source) ->
    mealId = $(source).data('meal')
    menuId = $(source).data('menu')
    $.ajax
      url: '/meals/' + mealId + '/select_menu'
      type: 'PUT'
      data:
        menu_id: menuId
      dataType: 'html'
      success: (data) ->
        $('#meal_items').html(data)
