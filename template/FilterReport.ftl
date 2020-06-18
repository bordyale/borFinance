<script>
         $(function() {
            $( "#autocomplete-4" ).autocomplete({
        source: function (request, response) {
        $.ajax({
        type: "POST",
        url:"employees.php",
        data: {term:request.term,my_variable2:"variable2_data"},
        success: response,
        dataType: 'json',
        minLength: 2,
        delay: 100
            });
        }});
         });
</script>




<form method="post" action="<@ofbizUrl>createOfbizDemoEventFtl</@ofbizUrl>" name="createOfbizDemoEvent" class="form-horizontal">
  
  <div class="control-group">
    <label class="control-label" for="firstName">${uiLabelMap.OfbizDemoFirstName}</label>
    <div class="controls">
      <@htmlTemplate.lookupField formName="createOfbizDemoEvent" name="add_product_id" id="add_product_id" fieldFormName="LookupProduct"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="lastName">${uiLabelMap.OfbizDemoLastName}</label>
    <div class="controls">
      <input type="text" id="autocomplete-4" name="lastName" required>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="comments">${uiLabelMap.OfbizDemoComment}</label>
    <div class="controls">
      <input type="text" id="comments" name="comments">
    </div>
  </div>
  <div class="control-group">
    <div class="controls">
      <button type="submit" class="btn">${uiLabelMap.CommonAdd}</button>
    </div>
  </div>
</form>