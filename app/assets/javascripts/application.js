// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// = require jquery_ujs
//= require bootstrap
//= require_tree .
//= require bootstrap-datepicker

$(document).ready(function(){
    $('.datepicker').datepicker();
  });


$(document).ready(function(){
	setTimeout(function(){
		$('#notice_wrapper').fadeOut("slow", function() {
			$(this).remove();
		})
	}, 4500);
});

// For printing charts
// function printpage() {
// 	window.print()
// }
// Printing charts (pieChart and lineChart)
function printDiv(divName) {
	var printContents = document.getElementById(divName).innerHTML;
	var originalContents = document.body.innerHTML;

	document.body.innerHTML = printContents;

	window.print();
	document.body.innerHTML = originalContents;
}


