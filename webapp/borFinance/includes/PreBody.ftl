<#assign docLangAttr = locale.toString()?replace("_", "-")>
<#assign langDir = "ltr">
<#if "ar.iw"?contains(docLangAttr?substring(0, 2))>
    <#assign langDir = "rtl">
</#if>
<html lang="${docLangAttr}" dir="${langDir}" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
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


</head>

  <body data-offset="125">
  
  
  

    <div class="container">
    

      <!-- Static navbar -->
      <nav class="navbar navbar-default">
      	<div class="alert alert-danger alert-dismissible">
  			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  			<strong>Success!</strong> Indicates a successful or positive action.
		</div>
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">${StringUtil.wrapString(uiLabelMap[titleProperty])}</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="<@ofbizUrl>main</@ofbizUrl>">Main</a></li>
              <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">About</a></li>
              <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">Contact</a></li>
              <li class="dropdown">
                <a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${uiLabelMap.CommonApplications} <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">Action</a></li>
                  <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">Another action</a></li>
                  <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">Something else here</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">Separated link</a></li>
                  <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#">One more separated link</a></li>
                </ul>
              </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="active"><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/">Default <span class="sr-only">(current)</span></a></li>
              <li><a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar-static-top/">Static top</a></li>
              <li><a href="<@ofbizUrl>logout</@ofbizUrl>" title="${uiLabelMap.CommonLogout}">logout</i></a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>Navbar example</h1>
        <p>This example is a quick exercise to illustrate how the default, static navbar and fixed to top navbar work. It includes the responsive CSS and HTML, so it also adapts to your viewport and device.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="https://bootstrapdocs.com/v3.3.6/docs/components/#navbar" role="button">View navbar docs �</a>
        </p>
      
    
    
    
    
    <div class="container menus" id="container">
      <div class="row">
        <div class="col-sm-12">
          <ul id="page-title" class="breadcrumb">
            <li>
                <a href="<@ofbizUrl>main</@ofbizUrl>">Main</a>
            </li>
            <li class="active"><span class="flipper-title">${StringUtil.wrapString(uiLabelMap[titleProperty])}</span></li>
            <li class="pull-right">
              <a href="<@ofbizUrl>logout</@ofbizUrl>" title="${uiLabelMap.CommonLogout}">logout</i></a>
            </li>
          </ul>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 header-col">
          <div id="main-content">
              <h4 align="center"> ==================Page PreBody Ends From Decorator Screen=========================</h4>
              <h4 align="center"> ==================Page Body starts From Screen=========================</h4>
