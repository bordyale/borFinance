<table class="table table-bordered table-striped table-hover">
    <thead>
        <tr>
          <th>${uiLabelMap.Date}</th>
          <th>${uiLabelMap.CommonName}</th>
          <th>${uiLabelMap.Price}</th>
        </tr>
    </thead>
    <tbody>
        <#list ofbizDemoList as ofbizDemo>
            <tr>
              <td>${ofbizDemo.date}</td>
              <td>${ofbizDemo.prodId}</td>
              <td>${ofbizDemo.price?default("NA")}</td>
            </tr>
        </#list>
    </tbody>
</table> 