$(function() {		
	$('#sample_design_reference').livequery(function() {
		$(this).autocomplete({ajax:'/designs.js', timeout:300});
	});
	$('#sample_description').example('e.g. Animals');
	$('#sample_design_reference').example('e.g. CP101');
	$('#sample_fibre_composition').example('e.g. Cotton (1/20), Nylon (70/2), Lycra (70/12)');
	$('#sample_type_of_cotton').example('e.g. Combed or Carded');
	$('#sample_yarn_count').example('e.g. 1/20');
	
	$('li.department_' + $('#sample_department_id').val()).show();

	$('#sample_country_id').change(function() {
		$.get('/factories.js', {country_id: $(this).val() }, function(data) {    	
			$('#sample_factory_id').html(data);
		});
	});

	$('.add_add_on').live('click', function() {
		$.get('/samples/new_sample_add_on', {}, function(data) {
	  	$('.add_ons tbody').append(data);
		});
		return false;
	});
	
	if ($('#sample_size_chart_id option').length == 1) {
      $.get('/size_charts.js', {customer_id: $('#sample_customer_id').val(), department_id:$('#sample_department_id').val()}, function(data) {
      	$('#sample_size_chart_id').html(data);
      });
  	}

    $('#sample_customer_id, #sample_department_id').change(function() {
      $.get('/size_charts.js', {customer_id: $('#sample_customer_id').val(), department_id:$('#sample_department_id').val()}, function(data) {
        $('#sample_size_chart_id').html(data);
      });
    });

	// Design drop-down.
	$('#sample_design_reference').livequery('blur', function() {
		var $this = $(this);
		var design_reference = $this.val();
		if (design_reference) {
			$.get('/designs/' + design_reference, {}, function(data) {
				$this.next('.thumbnail').html(data);
			});
		}
	});
	
	// Clear the add_on fields.
	$(".delete_add_on").live('click', function() {
	  if (confirm("Are you sure you want to delete this add-on? THIS CANNOT BE UNDONE.")) {
	    $(this).parents('tr:first').clear();
	  }
	  return false;
	});
	
	/* When new packs are added, their size check boxes need to be examined
	 * so that only ones for the current department are displayed.
	 */
	$('.size_check_box').livequery(function() {
		if ($(this).hasClass('department_' + $('#sample_department_id').val())) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});

	/* Change the visible sizes when the department changes. */
	$('#sample_department_id').change(function() {
	
		/* As changing sizes will remove any size-specific information,
		 * the user must be prompted if any information loss will occur.
		 *
		 * If a user has selected any sizes then prompt them to confirm
		 * but if they haven't chosen any sizes yet then they are free
		 * to change department without interruption.
		 */
		if ($('.size_check_box :checked').size() == 0 || confirm('Changing departments will change the sizes available to you and remove all information you have entered for existing sizes. Are you sure you want to change department?')) {
		
			/* Show the newly selected department's fields. */
			$('.department_' + $(this).val()).show();
		
			/* Select all the non-department fields, hide them and clear
			 * any checkboxes within them.
			 */
			$('.size_check_box:not(.department_' + $(this).val() + ')').hide().find(':checkbox').clear();
			
			/* Delete all sizes. */
			$('.sample_size').remove();
      
      $.get('/size_charts.js', {department_id:$(this).val(), customer_id:$('#sample_customer_id').val()}, function(data) {
				$('#sample_size_chart_id').html(data);
			});
		}
	});
});