$(function() {  
	/* Click checked fields. */
  $(':checked').triggerHandler('click');
  
  if ($('fieldset.pack').length >= 2) {
    $('.delete_pack').show();
  }
  
  if ($('#barcode_per').val() == "pack") {
    $('.per_order').hide();
    $('.per_pack').show();
  }
  
  $('.pack_sizes').livequery(function() {
    if (!$('.pack_sizes').is(':has(td)')) {
      $(this).hide();
    }
	});
	
	$('.add_add_on').live('click', function() {
		var pack_letter = $(this).parents('fieldset').attr('id').split('_')[1];
    var new_pack = ($('#pack_' + pack_letter + ' :input:first').attr('id').split('_')[1] == 'new');

		$.get('/orders/new_pack_add_on', {pack_letter:pack_letter}, function(data) {
			if (new_pack) {
		  	$('#pack_' + pack_letter + ' .add_ons tbody').append(data);
  		} else {
  		  $('#pack_' + pack_letter + ' .add_ons tbody').append(data.replace(/new_pack_attributes/g, 'existing_pack_attributes'));
  		}
		});
		return false;
	});
	
	/* Change the visible sizes when the department changes. */
	$('#order_department_id').change(function() {
	
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
			
			/* Delete all pack sizes. */
			$('.pack_size').remove();
			
			$.get('/sizes.js', {department_id:$(this).val()}, function(data) {
				$('#order_weight_size_id').html(data);
			});
      
      $.get('/size_charts.js', {department_id:$(this).val(), customer_id:$('#order_customer_id').val()}, function(data) {
				$('#order_size_chart_id').html(data);
			});
		}
	});
	
	$('#order_customer_id').change(function() {
	  $.get('/size_charts.js', {department_id:$('#order_department_id').val(), customer_id:$(this).val()}, function(data) {
			$('#order_size_chart_id').html(data);
		});
	});
	
	/* When the page loads, load the size charts. */
	if ($('#order_size_chart_id option').length == 1) {
  	$.get('/size_charts.js', {department_id:$('#order_department_id').val(), customer_id:$('#order_customer_id').val()}, function(data) {
  		$('#order_size_chart_id').html(data);
  	});
  }
  
  $('#order_season').example('e.g. A/W06');
	$('#order_description').example('e.g. Animals');	
	
	$('#order_packaging_reference').example('e.g. Packaging Artwork Reference');
	$('#order_packaging_type').example('e.g. Cascade, Overrider');
	$('#order_packaging_colour').example('e.g. Black');
	$('.source').example('e.g. Matis to source');
	$('#order_description_on_packaging').example('e.g. 5pk Boys Football Socks');
	$('#order_packaging_rrp').example('e.g. £3.00 €4.50');
	$('#order_carton_details').example('e.g. No staples');
	$('#order_packaging_finish').example('e.g. Matte');
	$('#order_tape_type').example('e.g. Paper');
	$('#order_carton_quality').example('e.g. Double Wall')
	$('#order_barcode_description').example('e.g. Printed on the Packaging')
	$('#order_hook_type_description').example('e.g. T611')
	$('#order_size_sticker_description').example('e.g. Yes to be placed on the hook')
	$('#order_promo_sticker_description').example('e.g. 2 for 1 Sticker as Artwork')
	$('#order_custom_box_description').example('e.g. Metal Heart Tin')
	$('#order_card_insert_description').example('e.g. White Matte, 10cm x 25cm, 200g')
	$('#order_polybag_description').example('e.g. Best Fit')
	$('#order_polybag_sticker_description').example('e.g. Barcode sticker')
	$('#order_polybag_warning_description').example('e.g. Suffocation Warning Printed in Red')

	
	/* The above examples are bound to their appropriate fields when the page is ready but
	 * the fields below may be loaded dynamically long after the page has loaded so we have to
	 * use the LiveQuery plugin. By using LiveQuery, any new elements that match these
	 * selectors will have their examples set.
	 */
	$('.pack_fibre_composition').livequery(function() {
		$(this).example('e.g. Cotton, Nylon, Lycra');
	});
	$('.pack_description').livequery(function() {
		$(this).example('e.g. Giraffe/Red');
	});
	$('.pack_design_reference').livequery(function() {
		$(this).example('e.g. Previous Order 1001');
	});
	$('.pack_sample_reference').livequery(function() {
		$(this).example('e.g. CH101');
	});
	$('.pack_weight').livequery(function() {
		$(this).example('e.g. 6-8H = 30g, 9-12 = 34g');
	});
	
	$('#add_pack').click(function() {
	  
	  var $this = $(this);
		var pack_letter = $('fieldset.pack:last').attr('id').split('_')[1];
		var next_pack_letter = pack_letter.succ(); // Courtesy of my core extensions.

		if (next_pack_letter == 'z') {
			$(this).hide();
		} else {
		  $this.hide();
		  $('#pack_progress').show();
			$.get('/orders/new_pack', {id: next_pack_letter}, function(data) {
				$('fieldset.pack:last').after(data);
				if ($('fieldset.pack').length >= 2) {
				  $('.delete_pack').show();
				}
				$('#pack_progress').hide();
				$this.show();
			});
		}
		
		return false;
	});
	
	/* Barcode, style & line number per-pack and per-order selector. */
	/* By default, details are per order, so per pack options should be
	 * hidden. 
	 */
	$('#barcode_per').change(function() {
		if (($('.per_pack :input:not(:empty)').length == 0) || confirm('This will delete the existing barcode, style and line numbers that you have entered; are you sure you want to proceed?')) {
		  if ($('.per_order').is(':hidden')) {
				$('.per_order').fadeIn();
			} else {
				$('.per_order').fadeOut();
			}
			
		  if ($('.per_pack').is(':hidden')) {
  			$('td.per_pack, th.per_pack').css('display', 'table-cell');
  			$('.per_order').clear();
  		} else {
  			$('.per_pack').hide().clear();
  		}
  	}
	});

	/* When new packs are added, their per-pack fields must be examined
	 * so that they are only visible if the barcode, style and line number
	 * per-pack and per-order selector is set to per-pack.
	 */
	$('td.per_pack, th.per_pack').livequery(function() {
		if ($('#barcode_per').val() == 'pack') {
			$(this).css('display', 'table-cell');
		} else {
			$(this).hide();
		}
	});
	
	/* Change the available factories when the country of manufacture is changed. */
	$('#order_country_of_manufacture').change(function() {
	  $.get('/factories.js', {country:$(this).val()}, function(data) {
	    $('#order_factory_id').html(data);
	  });
	});
	
	/* When new packs are added, their size check boxes need to be examined
	 * so that only ones for the current department are displayed.
	 */
	$('.size_check_box').livequery(function() {
		if ($(this).hasClass('department_' + $('#order_department_id').val())) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});

	// Design drop-down.
	$('.new_design_reference').livequery('blur', function() {
		var $this = $(this);
		var design_reference = $this.val();
		if (design_reference) {
			$.get('/designs/' + design_reference, {}, function(data) {
				$this.next('.thumbnail').html(data);
			});
		}
	});
	
	$(".delete_pack").live('click', function() {
	  if ($('fieldset.pack').length >= 2 && confirm("Are you sure you want to delete this pack? THIS CANNOT BE UNDONE.")) {
	    $(this).parents('fieldset:first').remove();
	    if ($('fieldset.pack').length < 2) {
	      $('.delete_pack').hide();
	    }
	  }
	  return false;
	});
	
	$(".delete_add_on").live('click', function() {
	  if (confirm("Are you sure you want to delete this add-on? THIS CANNOT BE UNDONE.")) {
	    $(this).parents('tr:first').clear();
	  }
	  return false;
	});
	
	$('.size_check_box :checkbox').live('click', function() {

		/* The size check box IDs are of the form pack_a_size_12 where a is
		 * the pack letter and 12 is the size ID. To extract this information
		 * from the ID reliably (with multiple digit IDs, etc.), we just
		 * split the ID by underscores and then store the bits of information
		 * in variables.
		 */
		var info = $(this).attr('id').split('_');
		var $pack_letter = info[1];
		var $size_id = info[3];
    var new_pack = ($('#pack_' + $pack_letter + ' :input:first').attr('id').split('_')[1] == 'new');
		/* As check boxes may be clicked many times to enable and disable
		 * a size, we need to detect whether this is someone checking or
		 * unchecking. While one could check the 'checked' attribute, it
		 * also makes sense to determine this from the state of the page:
		 * does a pack_size row exist for this check box already? If so,
		 * then this must be an UNchecking and perform all operations relevant
		 * to that.
		 */
		if ($('#pack_' + $pack_letter + '_sizes').is(':has(#pack_' + $pack_letter + '_' + $size_id + ')')) {

			/* Remove the pack size row. */
			$('#pack_' + $pack_letter + '_' + $size_id).remove();
			
			if (!$('#pack_' + $pack_letter + '_sizes').is(':has(tbody tr td)')) {
			  $('#pack_' + $pack_letter + '_sizes').hide();
			}

		} else {
      
      if ($('#pack_' + $pack_letter + '_sizes').is(':hidden')) {
        $('#pack_' + $pack_letter + '_sizes').show();
      }
			/* Load a new pack_size row for the given pack letter and size id. */
			$.get('/orders/new_pack_size', {pack_letter:$pack_letter, 
																			size_id:$size_id,
																			per_pack:($('#barcode_per').val() == 'pack')},
																			function(data) {
				if (new_pack) {
				  $('#pack_' + $pack_letter + '_sizes').append(data);
				} else {
				  $('#pack_' + $pack_letter + '_sizes').append(data.replace(/new_pack_attributes/g, 'existing_pack_attributes'));
				}
			});
		}
	});
	
	$('input.new_design_reference').livequery(function() {
		$(this).autocomplete({ajax:'/designs.js', timeout:300});
	});
});