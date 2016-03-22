$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/'

  productCard = (product) ->
    $.ajax
      url: '/product_card'
      type: 'GET'
      data: product: product
      success: (data) ->
        $('#products').append data
        return
      error: (data) ->
        console.log data
        return
    return

  getProducts = ->
    $('#products').empty()
    $.ajax
      url: baseUrl + 'products'
      type: 'GET'
      success: (data) ->
        products = data.products
        i = 0
        while i < products.length
          product = products[i]
          productCard product
          i++
        return
      error: (data) ->
        console.log data
        return
    return

  getProducts()


  $(document).on 'click', '.edit_product', (e) ->
    e.preventDefault()
    editForm = $('#product_edit_form')
    $.ajax
      type: 'GET'
      url: baseUrl + 'products/' + $(this).data('product-id')
      success: (data) ->
        product = data.product
        editForm.find('#product_name').val product.name
        editForm.find '#product_base_price'
        editForm.find '#product_description'
        editForm.find '#product_quantity_on_hand'
        editForm.find '#product_color'
        editForm.find '#product_weight'
        editForm.find '#product_other_attributes'
        $('body').scrollTop 0
        editForm.removeClass 'hide'
        return
      error: (data) ->
        console.log data
        return
    return


  $('#product_edit_form').submit (e) ->
    e.preventDefault()
    name = $(this).find('#product_name').val()
    basePrice = $(this).find('#product_base_price').val()
    description = $(this).find('#product_description').val()
    quantityOnHand = $(this).find('#product_quantity_on_hand').val()
    color = $(this).find('#product_color').val()
    weight = $(this).find('#product_weight').val()
    otherAttributes = $(this).find('#product_other_attributes').val()
    $.ajax
      url: baseUrl + 'products/' + productId
      type: 'PUT'
      data: product:
        name: name
        base_price: basePrice
        description: description
        quantity_on_hand: quantityOnHand
        color: color
        weight: weight
        other_attributes: otherAttributes
      success: (data) ->
        getProducts()
        return
      error: (data) ->
        console.log data
        return


    $(document).on 'click', '.create_product', (e) ->
    e.preventDefault()
    name = $(this).find('#product_name').val()
    basePrice = $(this).find('#product_base_price').val()
    description = $(this).find('#product_description').val()
    quantityOnHand = $(this).find('#product_quantity_on_hand').val()
    color = $(this).find('#product_color').val()
    weight = $(this).find('#product_weight').val()
    otherAttributes = $(this).find('#product_other_attributes').val()
    $.ajax
      url: baseUrl + 'products/'
      type: 'POST'
      data: product:
        name: name
        base_price: basePrice
        description: description
        quantity_on_hand: quantityOnHand
        color: color
        weight: weight
        other_attributes: otherAttributes
      success: (data) ->
        getProducts()
        return
      error: (data) ->
        console.log data
        return
    

    return
  $(document).on 'click', '.show_product', (e) ->
    e.preventDefault()

    return

  $(document).on 'click', '.delete_product', (e) ->
    e.preventDefault()
    $.ajax
      url: baseUrl + 'products/' + $(this).attr('href')
      type: 'DELETE'
      success: (data) ->
        $('.alert').text(data.message).removeClass 'hide'
        getProducts()
        return
      error: (data) ->
        console.log data
        return
    return
  return


# $(document).ready ->
# 	baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1'
# 	$.ajax
# 		url: "#{baseUrl}/products"
# 		type: 'GET'
# 		success: (data) ->
# 			for product in data.products
# 				$.ajax
# 					url: '/product_card'
# 					type: 'GET'
# 					data:
# 						product: product
# 					success: (data) ->
# 						$('#products').append(data)
# 					error: (data) ->
# 						console.log data
# 		error: (data) ->
# 			console.log data