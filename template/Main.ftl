




<div class="table-responsive">
	<a href="<@ofbizUrl>sendBfinEmail</@ofbizUrl>" class="btn btn-primary btn-lg active btn-sm" role="button" aria-pressed="true">sendBfinEmail</a><br/><br/>
	<a href="<@ofbizUrl>populateDividendTable</@ofbizUrl>" class="btn btn-primary btn-lg active btn-sm" role="button" aria-pressed="true">populateDividendTable</a><br/><br/>
	<a href="<@ofbizUrl>populPriceEODH</@ofbizUrl>" class="btn btn-primary btn-lg active btn-sm" role="button" aria-pressed="true">populPriceEODH</a><br/><br/>
	<a href="<@ofbizUrl>populDataYahooFin</@ofbizUrl>" class="btn btn-primary btn-lg active btn-sm" role="button" aria-pressed="true">populDataYahooFin</a>
</div>




<div class="table-responsive" style="margin-top: 2.0em">
  <form action="<@ofbizUrl>createBfinBroker</@ofbizUrl>" method="POST">
    
    <label for="brokerId">${uiLabelMap.Broker}</label>
    <select class="form-control" name="brokerId" id="brokerId" >
    	<option disabled <#if !(brokerId)?has_content>selected</#if> value> -- select an option -- </option>
      <#list brokers as broker>
                <option value="${broker.enumId}" <#if broker.enumId.equals(brokerId)>selected</#if>>${broker.get("description",locale)}</option>
      </#list>
    </select>
   	<div class="form-group">
      <label for="text">${uiLabelMap.Cash}</label>
      <input type="text" class="form-control" id="cash" name="cash" value="">
    </div>
    <div class="form-group">
  </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>

</div>