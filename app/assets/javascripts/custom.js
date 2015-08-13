$(document).ready(function(){
  $('.slider').slider({
    full_width: true,
    height: 500,
    //indicators: false
  });

  $(".show-material-message").each(function(){
    Materialize.toast($(this).data('message'), 5000, 'rounded');
  });

  $(".qty-editable-width").change(function(){
    var food_id = $(this).data('message');
    var qty = $(this).val();
    ajax_call($(this), food_id, qty);
  });

  var ajax_call = function(elem, food_id, qty){
    var price = parseInt($('#food_' + food_id).data('message'));
    var _qty = parseInt(qty);
    $.ajax({
      method: "PATCH",
      url: "/cart_items/1",
      data: {
        food_id: food_id,
        quantity: qty
      },
      beforeSend: function(){
        console.log(food_id + ", " + qty);
        $(this).prop('disabled', true);
      },
      success: function(data){
        $('#food_' + food_id).text(_qty * price);
        $(this).prop('disabled', false);      },
      error: function(){
        Materialize.toast($(this).data('An error occured. Please try again'), 5000, 'rounded');
      },
      complete: function(){
      }
    });
  };

});//end document ready
