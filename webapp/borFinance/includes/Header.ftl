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
<!-- prova.
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
 -->
<!-- prova2. -->


<link rel="stylesheet" href="/rainbowstone/javascript.css" type="text/css">

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" />

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.1.2/css/buttons.dataTables.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.1.2/css/select.dataTables.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.0.2/css/responsive.dataTables.css" />


<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
<script type="text/javascript" language="javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.js" ></script>
<script src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.js" ></script>
<script src="https://cdn.datatables.net/select/1.1.2/js/dataTables.select.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.js" ></script>
<script src="https://cdn.datatables.net/responsive/2.0.2/js/dataTables.responsive.js" ></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.colVis.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/plug-ins/1.10.21/sorting/numeric-comma.js"></script>
<script type="text/javascript" language="javascript" src="/borFinance/js/dataTables.altEditor.free.js"></script>
<script src="/borFinance/js/canvasjs.min.js"></script>
	






</head>
