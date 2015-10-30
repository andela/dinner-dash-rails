$(document).ready(function(){

  $(".sale-editable-width").change(function(){
    var foodId = $(this).data("message");
    var percentage = $(this).val();
    var foodPrice = $(".price_for_"+foodId).html();
    var foodSalePrice = (1 - (percentage/100)) * foodPrice;
    $(".sale_price_"+foodId).text(foodSalePrice);
  });

  $(".sale_status").each(function() {
    if ($(this).data("status") === "true") {
      $(this).prop("checked", true);
    } else {
      $(this).prop("checked", false);
    }
  });

  $('.slider').slider({
    full_width: true,
    height: 500,
    //indicators: false
  });
  $(".food_status").each(function() {
    if ($(this).data("status") === "available") {
      $(this).prop("checked", true);
    } else {
      $(this).prop("checked", false);
    }
  });

  $(".parallax").parallax();

  $(".select_field").change(function() {
      var url = $(".select_field").val();
      document.location.href = url;
  });

  $(".show-material-message").each(function(){
    Materialize.toast($(this).data("message"), 5000, "rounded");
  });

  var calcTotal = function() {
    var _total = 0;
    $(".line-total").each(function(){
      _total += parseFloat($(this).text());
    });
    return _total;
  }
  var calcPrepTotal = function() {
    var _preptotal = 0;
    $(".food-prep").each(function(){
      _preptotal += parseFloat($(this).text());
    });
    return _preptotal;
  }

  var calcTotalItemsInCart = function() {
    var _totalItemsInCart = 0;
    $(".qty").each(function(){
      _totalItemsInCart += parseInt($(this).val());
    });
    $("#cart").html("<i class='material-icons left'>shopping_cart</i>" + _totalItemsInCart);
  }

  var line_prep_total = function(qty, prep_time) {
    var added_time = parseInt(qty/7) * 10;
    var time = added_time + prep_time;
    return time;
  }


  $(".qty-editable-width").change(function(){
    var food_id = $(this).data("message");
    var qty = parseFloat($(this).val());
    var price = parseFloat($('#food_sub_total_' + food_id).data('message'));
    var prep_time = parseFloat($('#food_prep_' + food_id).data('message'));
    var line_total = parseFloat(qty * price).toFixed(2);
    $('#food_sub_total_' + food_id).text(line_total);
    $('#food_prep_' + food_id).text(line_prep_total(qty, prep_time) + "mins");

    var _total = calcTotal();
    var _preptotal = calcPrepTotal();

    var params = {
        cart_items: {
          food_id: food_id,
          quantity: qty
        },
        order_details: {
          sub_total: line_total,
          total: _total,
          prep_time: line_prep_total,
          pickup_time: _preptotal
        }
      };
    var url = "/cart_items/1";
    ajax_call($(this), params, url, "PATCH", function(data){

        $("#total").text("N" + _total.toFixed(2));
        $("#prep_total").text("Your order will be ready in: " +
                               _preptotal + "mins");
        calcTotalItemsInCart();
        $(this).prop('disabled', false);
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
    ajax_call($(this), params, url, "POST", function(comment) {
      $("div.comments").prepend(
        "<div class='divider'></div>" +
        "  <div class='section'>" +
        "    <h6>" + comment.first_name + " " + comment.last_name + " says </h6>" +
        "    <p>" + comment.comment + "</p>" +
        "  </div>"
      );
        $("#comment").val('');
    })
  });

  $(".food_status").click(function() {
    var food_id = $(this).data("foodid");
    var food_status = $(this).prop("checked");
    var url = "/foods/" + food_id + "/edit_status";
    params = {
      food: {
        id: food_id,
        status: food_status
      }
    }
    ajax_call($(this), params, url, "PATCH", function(food) {
      if (food.status === "available") {
        $(this).prop("checked", true);
      } else {
        $(this).prop("checked", false);
      }
    });
  })

  $(".add_to_sale").click(function(){
     var food_id = $(this).data('message');
     var sale_price = $('.sale_price_'+ food_id).html();
     var sale_percent = $('.sale-editable-width').val();
     var url = "/foods/" + food_id ;
     params = {
      food: {
        id: food_id,
        sales: {
          price: sale_price,
          percentage: sale_percent,
          status: true,
          js: true
        } 
      }
     }
     var that = this.parentNode;
     ajax_call($(this), params, url, "PATCH", function(data){
      if (data.success){
        $(that).html("Added to Sale");
      }

     });
  });
  
  var ajax_call = function(elem, params, url, method, callback){
    $.ajax({
      method: method,
      url: url,
      data: params,
      beforeSend: function(){

        elem.prop("disabled", true);
      },
      success: function(data){
        elem.prop("disabled", false);
        callback(data);
      },
      error: function(){
        Materialize.toast(elem.data("An error occured. Please try again"), 5000, "rounded");
      },
      complete: function(){
      }
    });
  };

  $(".cloudinary-fileupload").bind("fileuploadprogress", function(e, data) {
  $(".food_upload_progress_bar").css("width", Math.round((data.loaded * 100.0) / data.total) + "%");
});
});//end document ready
