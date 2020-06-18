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
      <input type="text" id="lastName" name="lastName" required>
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