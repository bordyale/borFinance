<script language="JavaScript" type="text/javascript">

$(document).ready(function() {

  var columnDefs = [{
    data: "prodId",
    title: "prodId",
    editorOnChange : function(event, altEditor) {
        console.log(event, altEditor);    
    }
  },
  {
    data: "prodSym",
    title: "prodSym"
  },
  {
    data: "prodName",
    title: "prodName"
  },
  {
    data: "purchDate",
    title: "purchDate"
  },
  {
    data: "quantity",
    title: "quantity"
  },
  {
    data: "price",
    title: "price"
  },
  {
    data: "currencyUomId",
    title: "currencyUomId"
  },
  {
    data: "exchangeId",
    title: "exchangeId"
  },
  {
    data: "brokerId",
    title: "brokerId"
  }
  ];

  var myTable;

  // local URL's are not allowed
  var url_ws_mock_get = './mock_svc_load.json';
  var url_ws_mock_ok = './mock_svc_ok.json';
  
  myTable = $('#example').DataTable({
    "sPaginationType": "full_numbers",
    "paging": false,
    columns: columnDefs,
	    dom: 'Bfrtip',        // Needs button container
        select: 'single',
        responsive: true,
        altEditor: true,     // Enable altEditor
        buttons: [{
            text: 'Add',
            name: 'add'        // do not change name
        },
        {
            extend: 'selected', // Bind to Selected row
            text: 'Edit',
            name: 'edit'        // do not change name
        },
        {
            extend: 'selected', // Bind to Selected row
            text: 'Delete',
            name: 'delete'      // do not change name
        }
        ],
        onAddRow: function(datatable, rowdata, success, error) {
            $.ajax({
                // a tipycal url would be / with type='PUT'
                type: "POST",
				url:"<@ofbizUrl>createBfinPurchase</@ofbizUrl>",
                data: rowdata,
                success: success,
                error: error
            });
        },
        onDeleteRow: function(datatable, rowdata, success, error) {
            $.ajax({
                // a tipycal url would be /{id} with type='DELETE'
                url: url_ws_mock_ok,
                type: 'GET',
                data: rowdata,
                success: success,
                error: error
            });
        },
        onEditRow: function(datatable, rowdata, success, error) {
            $.ajax({
                // a tipycal url would be /{id} with type='POST'
                url: url_ws_mock_ok,
                type: 'GET',
                data: rowdata,
                success: success,
                error: error
            });
        }
  });



});


</script>


<div class="table-responsive" style="margin-top: 2.0em">
<table id="example" class="display responsive nowrap compact" style="width:100%">  
    <tbody>  
        <#list purchaseList as item>
   
        	<tr>  
            	<td>${item.prodId}</td>  
            	<td>${item.prodSym}</td>
            	<td>${item.prodName}</td>
            	<td>${item.purchDate}</td>
            	<td>${item.quantity}</td>
            	<td>${item.price}</td>
            	<td>${item.currencyUomId}</td>
            	<td>${item.exchangeId}</td>
            	<td>${item.brokerId}</td>
            	
          	</tr> 
	                        
	    </#list>
        
        </tbody>      
</table>

</div>






