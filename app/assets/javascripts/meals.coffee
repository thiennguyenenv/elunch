$ ->
  @loadDishes = (source) ->
    categoryId = source.value
    menuId = $(source).data('menu')
    $.ajax
      url: '/category/' + categoryId + '/dishes?menu=' + menuId
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('#list_dishes').html(data)
