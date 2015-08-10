$( document ).ready(function() {
	$(".dropdown-button").dropdown();

	$('.button-collapse').sideNav({
		menuWidth: 300, // Default is 240
		edge: 'right', // Choose the horizontal origin
		closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
	});


		// Show sideNav
		// $('.button-collapse').sideNav('show');
		// Hide sideNav
		// $('.button-collapse').sideNav('hide');
});
