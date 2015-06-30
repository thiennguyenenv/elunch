$ ->
  @addDish = (source) ->
    menuId = $(source).data('menu')
    dishId = $(source).data('dish')
    $.ajax
      url: '/menus/' + menuId + '/dishes'
      type: 'POST'
      data:
        dish_id: dishId
      dataType: 'html'
      success: (data) ->
        $('#added_dishes').html(data)

  @deleteDish = (source) ->
    menuId = $(source).data('menu')
    dishId = $(source).data('dish')
    $.ajax
      url: '/menus/' + menuId + '/dishes/' + dishId
      type: 'DELETE'
      dataType: 'html'
      success: (data) ->
        $('#added_dishes').html(data)

