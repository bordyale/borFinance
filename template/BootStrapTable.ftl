<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<script language="JavaScript" type="text/javascript">

$(document).ready(function(){
    $('#myTable').DataTable({
       "sPaginationType": "full_numbers",
		dom: 'Bfrtip',        // Needs button container
          select: 'single',
          responsive: true,
          buttons: [
            'colvis'
          ],
          "pageLength": 30,
          "columns": [
    			null,
    			null,
    			null,
    			{ "type": "numeric-comma" },
			    { "type": "numeric-comma" },
    			{ "type": "numeric-comma" },
    			{ "type": "numeric-comma" },
			    { "type": "numeric-comma" },
			    { "type": "numeric-comma" },    		
    			{ "type": "numeric-comma" },
    			{ "type": "numeric-comma" },
    			null,
			    null,
    			null,
    			null
  		]
  });
   
    



});



</script>

<#setting number_format="0.##">
<div class="table-responsive" style="margin-top: 2.0em">
<table id="myTable" class="display responsive nowrap compact" style="width:100%">  
        <thead>  
          <tr>  
            <th>${uiLabelMap.Symbol}</th>   
            <th>${uiLabelMap.Quantity}</th>
            <th>${uiLabelMap.CommonCurrency}</th>
            <th>${uiLabelMap.AvgBoughtPrice}</th>
            <th>${uiLabelMap.LastMktPrice}</th>
            <th>${uiLabelMap.MktGainPerc}</th>
            <th>${uiLabelMap.mktValue}</th>
            <th>${uiLabelMap.mktValueConverted}</th>
            <th>${uiLabelMap.Percentage}</th>
            <th>${uiLabelMap.currYield}</th>
            <th>${uiLabelMap.lastDividend}</th>
            <th>${uiLabelMap.lastDividendDate}</th>            
            <th>${uiLabelMap.CommonName}</th> 
            <th>${uiLabelMap.LastMktPriceDate}</th>
            <th>${uiLabelMap.productType}</th> 
          </tr>  
        </thead>  
        <tbody>  
        <#list reportList as item>
   
        	<tr>  
            	<td>${item.prodSym}</td>  
            	<td>${item.quantitySum}</td>
            	<td><#if item.currencyUomId?has_content>${item.currencyUomId}<#else></#if></td>
            	<td><a href="<@ofbizUrl>findBfinPurchase?prodId=${item.prodId}</@ofbizUrl>">${item.avgPurchPrice}</a></td>
            	<td><#if item.lastMktPrice?has_content>${item.lastMktPrice}<#else>0</#if></td>
            	<td><#if item.mktGainPerc?has_content>${item.mktGainPerc} %<#else>0</#if></td>
            	<td><#if item.mktValue?has_content>${item.mktValue}<#else>0</#if></td>
            	<td><#if item.mktValueConverted?has_content>${item.mktValueConverted}<#else>0</#if></td>
            	<td><#if item.percentage?has_content>${item.percentage}<#else></#if>%</td>
            	<td><#if item.currYield?has_content>${item.currYield}<#else></#if>%</td>
            	<td><#if item.lastDividend?has_content>${item.lastDividend}<#else>0</#if></td>
            	<td><#if item.lastDividendDate?has_content>${item.lastDividendDate}<#else>0</#if></td>
            	
            	<td>${item.prodName}</td>
            	<td><#if item.lastMktPriceDate?has_content>${item.lastMktPriceDate}<#else>0</#if></td>
            	<td>${item.productType}</td>
          	</tr> 
	                        
	    </#list>
        
        </tbody>  
      </table>

</div>

<script>
window.onload = function() {

var chart = new CanvasJS.Chart("chartContainer", {
	theme: "light2", // "light1", "light2", "dark1", "dark2"
	exportEnabled: true,
	animationEnabled: true,
	title: {
		text: "Stock Portfolio"
	},
	data: [{
		type: "pie",
		startAngle: 25,
		toolTipContent: "<b>{label}</b>: {y}%",
		//showInLegend: "true",
		legendText: "{label}",
		indexLabelFontSize: 12,
		indexLabel: "{label} - {y}%",
		dataPoints: [
			<#list reportList as item>
				{ y: ${item.percString}, label: "${item.prodSym}"},
			</#list>
			
		]
	}]
});
chart.render();

}
</script>


<div id="chartContainer" style="height: 970px; margin: 0px auto;"></div>



<#setting number_format="0.0##">
<div class="table-responsive" style="margin-top: 2.0em">
<table id="sectors" class="table table-hover table-sm">  
        <thead>  
          <tr>  
            <th>${uiLabelMap.Sector}</th>          
            <th>${uiLabelMap.mktValue}</th>
            <th>${uiLabelMap.percentage}</th>
             
          </tr>  
        </thead>  
        <tbody>  
        <#list sectorList as item>
   
        	<tr>  
            	<td><#if item.sectorId?has_content>${item.sectorId}<#else>0</#if></td>
            	<td>$<#if item.mktValue?has_content>${item.mktValue}<#else>0</#if></td>
            	<td><#if item.percentage?has_content>${item.percentage}%<#else>0</#if></td>
          	</tr> 
	                        
	    </#list>
        
        </tbody>  
      </table>

</div>

<div class="table-responsive" style="margin-top: 2.0em">
<table id="sectors" class="table table-hover table-sm">  
        <thead>  
          <tr>  
            <th>${uiLabelMap.Symbol}</th>   
            <th>${uiLabelMap.CommonName}</th> 
            <th>${uiLabelMap.Sector}</th>   
             
          </tr>  
        </thead>  
        <tbody>  
        <#list prodsNotInPortfolio as item>
   
        	<tr>  
        		<td>${item.prodSym}</td>  
        		<td>${item.prodName}</td>
            	<td><#if item.sectorId?has_content>${item.sectorId}<#else>0</#if></td>
            	
          	</tr> 
	                        
	    </#list>
        
        </tbody>  
      </table>

</div>