$ ->
  @loadDishes = (source) ->
    categoryId = source.value
    $.ajax
      url: '/category/' + categoryId + '/dishes'
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('#list_dishes').html(data)
