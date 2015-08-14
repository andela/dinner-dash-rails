// $(document).ready(function(){
//   $('.slider').slider({
//     full_width: true,
//     height: 500,
//     //indicators: false
//   });
//
//   $(".show-material-message").each(function(){
//     Materialize.toast($(this).data('message'), 5000, 'rounded');
//   });
//
//   var calcTotal = function() {
//     var _total = 0;
//     $(".line-total").each(function(){
//       _total += parseFloat($(this).text());
//     });
//     $("#total").text("N" + _total.toFixed(2));
//   }
//
//   var calcTotalItemsInCart = function() {
//     var _totalItemsInCart = 0;
//     $(".qty").each(function(){
//       _totalItemsInCart += parseInt($(this).val());
//     });
//     $("#cart").text(_totalItemsInCart);
//   }
//
//   $(".qty-editable-width").change(function(){
//     var food_id = $(this).data('message');
//     var qty = $(this).val();
//     ajax_call($(this), food_id, qty);
//   });
//
//   var ajax_call = function(elem, food_id, qty){
//     var price = parseFloat($('#food_' + food_id).data('message'));
//     var _qty = parseFloat(qty);
//     $.ajax({
//       method: "PATCH",
//       url: "/cart_items/1",
//       data: {
//         food_id: food_id,
//         quantity: qty
//       },
//       beforeSend: function(){
//         $(this).prop('disabled', true);
//       },
//       success: function(data){
//         var line_total = parseFloat(_qty * price).toFixed(2)
//         $('#food_' + food_id).text(line_total);
//         calcTotal();
//         calcTotalItemsInCart();
//         $(this).prop('disabled', false);      },
//       error: function(){
//         Materialize.toast($(this).data('An error occured. Please try again'), 5000, 'rounded');
//       },
//       complete: function(){
//       }
//     });
//   };
// });//end document ready
