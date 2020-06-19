

  
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
      
