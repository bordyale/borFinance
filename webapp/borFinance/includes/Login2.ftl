<!DOCTYPE html>
<html lang="en">
<head>
	<title>${layoutSettings.companyName}: <#if (titleProperty)?has_content>${uiLabelMap[titleProperty]}<#else>${title!}</#if></title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="/borFinance/login/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/borFinance/login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/borFinance/login/css/util.css">
	<link rel="stylesheet" type="text/css" href="/borFinance/login/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">
				<form class="login100-form validate-form" action="<@ofbizUrl>login</@ofbizUrl>" method="post" >
					<span class="login100-form-title p-b-33">
						Account Login
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Valid user is required: ex@abc.xyz">
						<input class="input100" type="text" name="USERNAME" placeholder="Username">
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>

					<div class="wrap-input100 rs1 validate-input" data-validate="Password is required">
						<input class="input100" type="password" name="PASSWORD" placeholder="Password">
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>
					<input type="hidden" id="JavaScriptEnabled" name="JavaScriptEnabled" value="Y">

					<div class="container-login100-form-btn m-t-20">
						<button class="login100-form-btn">
							Sign in
						</button>
					</div>

					

					
				</form>
			</div>
		</div>
	</div>
	

	
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/bootstrap/js/popper.js"></script>
	<script src="/borFinance/login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="/borFinance/login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/borFinance/login/js/main.js"></script>

</body>
</html>