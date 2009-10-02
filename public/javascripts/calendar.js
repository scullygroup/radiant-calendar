jQuery.noConflict();
jQuery(document).ready(function($) {
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
