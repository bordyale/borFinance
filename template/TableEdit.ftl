<script language="JavaScript" type="text/javascript">

$(document).ready(function(){
    
    
$('#example2').dataTable({
        dom: 'Bfrtip',
        buttons: [
            'colvis'
        ],
       "paging": false,
     
    } );

$('#example2').Tabledit({
    url: 'inLineTableSwitch?service=BfinProduct',
    columns: {
        identifier: [0, 'prodId'],
        editable: [[1, 'prodSym']]
    }
});



});



</script>




<div class="table-responsive" style="margin-top: 2.0em"> 
	<table id="example2"  class="table table-bordered table-striped">  
        <thead>  
          <tr>  
            <th>${uiLabelMap.CommonId}</th>  
            <th${uiLabelMap.Symbol}</th>  
            <th>${uiLabelMap.CommonName}</th>  
            <th></th>  
            
          </tr>  
        </thead>  
        <tbody>  
          <#list productList as item>
   
        	<tr>  
            	<td>${item.prodId}</td>  
            	<td>${item.prodSym}</td>
            	<td>${item.prodName}</td>
            	
          	</tr> 
	                        
	    </#list>
        </tbody>  
      </table>
      
</div>



