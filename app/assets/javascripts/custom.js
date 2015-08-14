$(document).ready(function(){
  $('.slider').slider({
    full_width: true,
    height: 500,
    //indicators: false
  });

  $(".show-material-message").each(function(){
    Materialize.toast($(this).data('message'), 5000, 'rounded');
  });

   // Initialize collapse button
  $(".button-collapse").sideNav();
  // Initialize collapsible (uncomment the line below if you use the dropdown variation)
  $('.collapsible').collapsible();

  Template.collapsible.rendered = function() {
    this.$('.collapsible').collapsible();
};

});//end document ready
