@readUrl = (input) ->
  if input.files && input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $("#img_prev").attr("src", e.target.result).width(70).height(70)

    reader.readAsDataURL(input.files[0])
