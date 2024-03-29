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




<div class="table-responsive">
	<a href="<@ofbizUrl>ReportExport.csv?<#if (prodId)?has_content>prodId=${prodId}</#if><#if (brokerId)?has_content>brokerId=${brokerId}</#if></@ofbizUrl>" class="btn btn-primary btn-lg active btn-sm" role="button" aria-pressed="true">Export CSV</a>
</div>

<div class="table-responsive" style="margin-top: 2.0em">
  <form action="<@ofbizUrl>findBfinReport</@ofbizUrl>" method="POST">
    <div class="form-group">
      <label for="text">${uiLabelMap.LookupProduct}</label>
      <input type="text" class="form-control" id="autocomplete-4" name="prodId" value="<#if (prodId)?has_content>${prodId}</#if>">
    </div>
    <div class="form-group">
    <label for="brokerId">${uiLabelMap.Broker}</label>
    <select class="form-control" name="brokerId" id="brokerId" >
    	<option disabled <#if !(brokerId)?has_content>selected</#if> value> -- select an option -- </option>
      <#list brokers as broker>
                <option value="${broker.enumId}" <#if broker.enumId.equals(brokerId)>selected</#if>>${broker.get("description",locale)}</option>
      </#list>
    </select>
    <label for="brokerId">${uiLabelMap.Sector}</label>
    <select class="form-control" name="sectorId" id="sectorId">
    	<option disabled <#if !(sectorId)?has_content>selected</#if> value> -- select an option -- </option>
      <#list sectors as sector>
                <option value="${sector.enumId}" <#if sector.enumId.equals(sectorId)>selected</#if>>${sector.get("description",locale)}</option>
      </#list>
    </select>
  </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>

</div>
