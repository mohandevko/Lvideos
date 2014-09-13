(function($){
							
					// remove input text		   
					$('input.blink').each(function(){
						$(this).attr('default',$(this).val());
					}).focus(function(){
						if($(this).val()==$(this).attr('default'))
						$(this).val('');
					}).blur(function(){
						if($(this).val()=='')
						$(this).val($(this).attr('default'));
					}); 

				  // video tabbers
				  var SHOW_CLASS = 'show',
					  HIDE_CLASS = 'hide',
					  ACTIVE_CLASS = 'active';
				  
				  $('.tabs').on( 'click', 'li a', function(e){
					e.preventDefault();
					var $tab = $(this),
						 href = $tab.attr('href');
				  
					 $('.active').removeClass(ACTIVE_CLASS);
					 $tab.addClass(ACTIVE_CLASS);
				  
					 $('.show')
						.removeClass(SHOW_CLASS)
						.addClass(HIDE_CLASS)
						.hide();
					
					  $(href)
						.removeClass(HIDE_CLASS)
						.addClass(SHOW_CLASS)
						.hide()
						.fadeIn(700);
				  });

					
					 
})(jQuery);