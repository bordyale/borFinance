<#assign docLangAttr = locale.toString()?replace("_", "-")>
<#assign langDir = "ltr">
<#if "ar.iw"?contains(docLangAttr?substring(0, 2))>
    <#assign langDir = "rtl">
</#if>
<html lang="${docLangAttr}" dir="${langDir}" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${layoutSettings.companyName}: <#if (titleProperty)?has_content>${uiLabelMap[titleProperty]}<#else>${title!}</#if></title>
<#if layoutSettings.shortcutIcon?has_content>
    <#assign shortcutIcon = layoutSettings.shortcutIcon/>
<#elseif layoutSettings.VT_SHORTCUT_ICON?has_content>
    <#assign shortcutIcon = layoutSettings.VT_SHORTCUT_ICON.get(0)/>
</#if>
<#if shortcutIcon?has_content>
    <link rel="shortcut icon" href="<@ofbizContentUrl>${StringUtil.wrapString(shortcutIcon)}</@ofbizContentUrl>" />
</#if>
<#if layoutSettings.VT_STYLESHEET_LESS?has_content>
    <#list layoutSettings.VT_STYLESHEET_LESS as styleSheet>
        <link rel="stylesheet/less" href="<@ofbizContentUrl>${StringUtil.wrapString(styleSheet)}</@ofbizContentUrl>" type="text/css"/>
    </#list>
</#if>
<!-- prova. -->
<#if layoutSettings.VT_HDR_JAVASCRIPT?has_content>
    <#list layoutSettings.VT_HDR_JAVASCRIPT as javaScript>
        <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
    </#list>
</#if>
<#if layoutSettings.javaScripts?has_content>
<#--layoutSettings.javaScripts is a list of java scripts. -->
<#-- use a Set to make sure each javascript is declared only once, but iterate the list to maintain the correct order -->
    <#assign javaScriptsSet = Static["org.apache.ofbiz.base.util.UtilMisc"].toSet(layoutSettings.javaScripts)/>
    <#list layoutSettings.javaScripts as javaScript>
        <#if javaScriptsSet.contains(javaScript)>
            <#assign nothing = javaScriptsSet.remove(javaScript)/>
            <script src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
        </#if>
    </#list>
</#if>
<!-- prova2. -->


<link rel="stylesheet" href="/rainbowstone/javascript.css" type="text/css">
<link rel="stylesheet" href="/borFinance/css//bootstrap.min.css" type="text/css">
<!--
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
-->

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.5/css/responsive.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css">
	
<script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" language="javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.2.5/js/dataTables.responsive.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.colVis.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/plug-ins/1.10.21/sorting/numeric-comma.js"></script>


<script language="JavaScript" type="text/javascript">

$(document).ready(function(){
    $('#myTable').dataTable({
    	"language": {
                "url": "dataTables.german.lang"
            },
        dom: 'Bfrtip',
        buttons: [
            'colvis'
        ],
       "pageLength": 30,
       "columns": [
    			null,
    			null,
    			null,
    			{ "type": "numeric-comma" },
			    null,
    			{ "type": "numeric-comma" },
    			{ "type": "numeric-comma" },
			    { "type": "numeric-comma" },    		
    			{ "type": "numeric-comma" },
    			null,
    			null,
    			{ "type": "numeric-comma" },
			    null,
    			null
  ]
     
    } );
});

</script>


</head>
