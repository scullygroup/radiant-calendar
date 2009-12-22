jQuery(document).ready(function($) {
  // Load Facebox
  $('a[rel*=facebox]').facebox();
  
  // Datepicker
  $('form input.date-pick').datepicker({
    showOn: 'both',
    buttonImage: '/images/calendar.png',
    buttonImageOnly: true,
    changeMonth: true,
  	changeYear: true
  });
  
  $('a#check_all').click(function(){
    $('#categories form :checkbox').each(function(){
       $(this).attr('checked', true);
    });
  });
  
  $('a#uncheck_all').click(function(){
    $('#categories form :checkbox').each(function(){
       $(this).attr('checked', false);
    });
  });
});