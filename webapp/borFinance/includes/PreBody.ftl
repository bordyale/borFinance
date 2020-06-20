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



<#if userLogin?has_content>
    <#assign appMax = 8>
    <#assign alreadySelected = false>
<div id="main-navigation-bar">
    <div id="main-nav-bar-left">
        <#--<a id="homeButton" href="<@ofbizUrl>HomeMenu</@ofbizUrl>"><img id="homeButtonImage" src="/rainbowstone/images/home.svg" alt="Home"></a>-->
        <ul id="app-bar-list">
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
                            <li class="app-btn<#if selected> selected</#if>">
                                <#if selected>
                                <div id="app-selected">
                                    <#assign alreadySelected = true>
                                </#if>
                                <a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a>
                                <#if selected>
                                    <div id="color-add"></div>
                                </div>
                                </#if>
                            </li>
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
                        <li class="app-btn<#if selected> selected</#if>">
                            <#if selected>
                            <div id="app-selected">
                                <#assign alreadySelected = true>
                            </#if>
                            <a href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a>
                            <#if selected>
                                <div id="color-add"></div>
                            </div>
                            </#if>
                        </li>
                    <#else>
                        <#break>
                    </#if>
                    <#assign appCount = appCount + 1>
                </#if>
            </#list>
        </ul>
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
                        <div id="more-app" <#if !alreadySelected>class="selected"</#if>>
                            <span>+</span>
                        <ul id="more-app-list">
                            <#assign moreApp = true>
                        </#if>
                        <li class="app-btn-sup<#if selected> selected</#if>">
                            <a class="more-app-a" href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a>
                        </li>
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
                    <div id="more-app">
                        <span>+</span>
                    <ul id="more-app-list">
                        <#assign moreApp = true>
                    </#if>
                    <li class="app-btn-sup<#if selected> selected</#if>">
                        <a class="more-app-a" href="${thisURL}${StringUtil.wrapString(externalKeyParam)}"<#if uiLabelMap?exists> title="${uiLabelMap[display.description]}">${uiLabelMap[display.title]}<#else> title="${display.description}">${display.title}</#if></a>
                    </li>
                </#if>
                <#assign appCount = appCount + 1>
            </#if>
        </#list>
        <#if moreApp>
        </ul> <!-- more-app-list -->
        </div> <!-- more-app -->
        </#if>
    </div>
        
    </div> <!-- main navigation bar -->
    
</#if>

  
    <div class="container">
    
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
      
