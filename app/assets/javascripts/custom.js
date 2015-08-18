
$(document).ready(function(){
  $('.slider').slider({
    full_width: true,
    height: 500,
    //indicators: false
  });

  $(".show-material-message").each(function(){
    Materialize.toast($(this).data('message'), 5000, 'rounded');
  });

  var calcTotal = function() {
    var _total = 0;
    $(".line-total").each(function(){
      _total += parseFloat($(this).text());
    });
    $("#total").text("N" + _total.toFixed(2));
  }

  var calcTotalItemsInCart = function() {
    var _totalItemsInCart = 0;
    $(".qty").each(function(){
      _totalItemsInCart += parseInt($(this).val());
    });
    $("#cart").text(_totalItemsInCart);
  }

  $(".qty-editable-width").change(function(){
    var food_id = $(this).data('message');
    var qty = parseFloat($(this).val());

    var price = parseFloat($('#food_' + food_id).data('message'));

    var params = {
        cart_items: {
          food_id: food_id,
          quantity: qty
        }
      };
    var url = "/cart_items/1";
    ajax_call($(this), params, url, "PATCH", function(data){
        var line_total = parseFloat(qty * price).toFixed(2)
        $('#food_' + food_id).text(line_total);
        calcTotal();
        calcTotalItemsInCart();
        $(this).prop('disabled', false)
      });
  });

  $("#add_comment").click(function(){
    var food_id = parseInt($(this).data("foodid"));
    var url = "/foods/" + food_id + "/comments";
    params = {
      comment: {
        comment: $("#comment").val(),
        user_id: parseInt($(this).data("userid")),
        food_id: food_id
      }
    }
    var res = ajax_call($(this), params, url, "POST", function(comment) {
      $("div.comments").prepend(
        "<div class='divider'></div>" +
        "  <div class='section'>" +
        "    <h6>" + comment.first_name + " " + comment.last_name + " says </h6>" +
        "    <p>" + comment.comment + "</p>" +
        "  </div>"
      );
    })
  });

  var ajax_call = function(elem, params, url, method, callback){
    $.ajax({
      method: method,
      url: url,
      data: params,
      beforeSend: function(){
        elem.prop('disabled', true);
      },
      success: callback,
      error: function(){
        Materialize.toast(elem.data('An error occured. Please try again'), 5000, 'rounded');
      },
      complete: function(){
      }
    });
  };
});//end document ready
