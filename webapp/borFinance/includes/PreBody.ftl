<#if (requestAttributes.externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists></#if>
<#if (externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists></#if>
<#assign ofbizServerName = application.getAttribute("_serverId")?default("default-server")>
<#assign contextPath = request.getContextPath()>
<#assign displayApps = Static["org.apache.ofbiz.base.component.ComponentConfig"].getAppBarWebInfos(ofbizServerName, "main")>
<#assign displaySecondaryApps = Static["org.apache.ofbiz.base.component.ComponentConfig"].getAppBarWebInfos(ofbizServerName, "secondary")>
<#if person?has_content>
    <#assign avatarList = delegator.findByAnd("PartyContent", {"partyId" : person.partyId, "partyContentTypeId" : "LGOIMGURL"}, null, false)>
    <#if avatarList?has_content>
        <#assign avatar = Static["org.apache.ofbiz.entity.util.EntityUtil"].getFirst(avatarList)>
        <#assign avatarDetail = Static["org.apache.ofbiz.entity.util.EntityUtil"].getFirst(delegator.findByAnd("PartyContentDetail", {"partyId" : person.partyId, "contentId" : avatar.contentId}, null, false))>
    </#if>
</#if>








<body data-offset="125">

<div class="container">

<#if userLogin?has_content>
    <#assign appMax = 8>
    <#assign alreadySelected = false>
<!-- Static navbar -->
<nav class="navbar navbar-default">
	<!-- Messages -->
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
        </div>
	
        <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
        <li class="dropdown">
            <a href="https://bootstrapdocs.com/v3.3.6/docs/examples/navbar/#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${uiLabelMap.CommonApplications} <span class="caret"></span></a>
            <ul class="dropdown-menu">
            <#assign appCount = 0>
            <#assign firstApp = true>
            <#list displayApps as display>
                <#assign thisApp = display.getContextRoot()>
                <#assign permission = true>
                <#assign selected = false>
                <#assign permissions = display.getBasePermission()>
                <#list permissions as perm>
                    <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                    <#-- User must have ALL permissions in the base-permission list -->
                        <#assign permission = false>
                    </#if>
                </#list>
                <#if permission == true>
                    <#if thisApp == contextPath || contextPath + "/" == thisApp>
                        <#assign selected = true>
                    </#if>
                    <#assign thisApp = StringUtil.wrapString(thisApp)>
                    <#assign thisURL = thisApp>
                    <#if thisApp != "/">
                        <#assign thisURL = thisURL + "/control/main">
                    </#if>
                    <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
                    <#-- do not display this component-->
                    <#else>
                        <#if appCount<=appMax>
                        
                        	<li <#if selected> class="active"</#if>><a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"><#if uiLabelMap?exists> ${uiLabelMap[display.title]}<#else> ${display.title}</#if></a></li>
                        
                            
                        <#else>
                            <#break>
                        </#if>
                        <#assign appCount = appCount + 1>
                    </#if>
                </#if>
            </#list>
            <#list displaySecondaryApps as display>
                <#assign thisApp = display.getContextRoot()>
                <#assign permission = true>
                <#assign selected = false>
                <#assign permissions = display.getBasePermission()>
                <#list permissions as perm>
                    <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                    <#-- User must have ALL permissions in the base-permission list -->
                        <#assign permission = false>
                    </#if>
                </#list>
                <#if permission == true>
                    <#if thisApp == contextPath || contextPath + "/" == thisApp>
                        <#assign selected = true>
                    </#if>
                    <#assign thisApp = StringUtil.wrapString(thisApp)>
                    <#assign thisURL = thisApp>
                    <#if thisApp != "/">
                        <#assign thisURL = thisURL + "/control/main">
                    </#if>
                    <#if appCount<=appMax>
                    
                    	<li <#if selected> class="active"</#if>><a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"><#if uiLabelMap?exists> ${uiLabelMap[display.title]}<#else> ${display.title}</#if></a></li>
                    	
                        
                    <#else>
                        <#break>
                    </#if>
                    <#assign appCount = appCount + 1>
                </#if>
            </#list>
        
        <!-- Si le nombre d'application est supérieur au nombre d'application max affichable, je met le restant
        dans un menu déroulant. J'ai volontairement doublé le code car sinon, la lecture du code lors d'une maintenance
        risquait d'être compliquée. A corriger si jamais les performances s'en font ressentir -->
        <#assign appCount = 0>
        <#assign moreApp = false>
        <#list displayApps as display>
            <#assign thisApp = display.getContextRoot()>
            <#assign permission = true>
            <#assign selected = false>
            <#assign permissions = display.getBasePermission()>
            <#list permissions as perm>
                <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                <#-- User must have ALL permissions in the base-permission list -->
                    <#assign permission = false>
                </#if>
            </#list>
            <#if permission == true>
                <#if thisApp == contextPath || contextPath + "/" == thisApp>
                    <#assign selected = true>
                </#if>
                <#assign thisApp = StringUtil.wrapString(thisApp)>
                <#assign thisURL = thisApp>
                <#if thisApp != "/">
                    <#assign thisURL = thisURL + "/control/main">
                </#if>
                <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
                <#-- do not display this component-->
                <#else>
                    <#if appMax < appCount>
                        <#if !moreApp>
                        	<#assign moreApp = true>
                        </#if>
                        <li <#if selected> class="active"</#if>><a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"><#if uiLabelMap?exists> ${uiLabelMap[display.title]}<#else> ${display.title}</#if></a></li>
    			      </#if>
                    <#assign appCount = appCount + 1>
                </#if>
            </#if>
        </#list>
        <#list displaySecondaryApps as display>
            <#assign thisApp = display.getContextRoot()>
            <#assign permission = true>
            <#assign selected = false>
            <#assign permissions = display.getBasePermission()>
            <#list permissions as perm>
                <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
                <#-- User must have ALL permissions in the base-permission list -->
                    <#assign permission = false>
                </#if>
            </#list>
            <#if permission == true>
                <#if thisApp == contextPath || contextPath + "/" == thisApp>
                    <#assign selected = true>
                </#if>
                <#assign thisApp = StringUtil.wrapString(thisApp)>
                <#assign thisURL = thisApp>
                <#if thisApp != "/">
                    <#assign thisURL = thisURL + "/control/main">
                </#if>
                <#if appMax < appCount>
                    <#if !moreApp>
                        <#assign moreApp = true>
                    </#if>
                    <li <#if selected> class="active"</#if>><a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"><#if uiLabelMap?exists> ${uiLabelMap[display.title]}<#else> ${display.title}</#if></a></li>
                    
                </#if>
                <#assign appCount = appCount + 1>
            </#if>
        </#list>
        <#if moreApp>
        
        </#if>
        </ul>
        </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
           <li><a href="<@ofbizUrl>logout</@ofbizUrl>" title="${uiLabelMap.CommonLogout}">logout</i></a></li>
        </ul>
        </div><!--/.nav-collapse -->
	</div><!--/.container-fluid -->        
</nav> <!-- main navigation bar -->
    
</#if>

  
  
    
     
      
	 



      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
      <div class="container menus" id="container2">
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
      </div>
        
      
    
    
    
    
    
      
