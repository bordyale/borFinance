<div id="div1">
</div>
<script>
         $(function() {
            $( "#autocomplete-4" ).autocomplete({
        		source: function (request, response) {
				        $.ajax({
				        type: "POST",
				        url:"<@ofbizUrl>LookupProduct</@ofbizUrl>",
				        data: {term:request.term,ajaxLookup:"Y"},
				        dataType: 'html',
				        minLength: 2,
				        delay: 100,
				        success: function(result){
				        	console.log("fff");
    						$("#div1").html(result);
    						console.log(autocomp);
    						response(autocomp);
    						}
	            	});
        }});
         });
</script>






<div class="table-responsive" style="margin-top: 2.0em">
  <form action="<@ofbizUrl>findBfinPurchase</@ofbizUrl>">
    <div class="form-group">
      <label for="text">${uiLabelMap.LookupProduct}</label>
      <input type="text" class="form-control" id="autocomplete-4" name="prodId">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>

</div>
