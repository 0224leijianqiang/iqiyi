<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>${pd.SYSNAME}</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="static/login/bootstrap.min.css" />
<link rel="stylesheet" href="static/login/css/camera.css" />
<link rel="stylesheet" href="static/login/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="static/login/matrix-login.css" />
<link href="static/login/font-awesome.css" rel="stylesheet" />
<script type="text/javascript" src="static/login/js/jquery-1.5.1.min.js"></script>

</head>
<body>
	<div style="width:100%;text-align: center;margin: 0 auto;position: absolute;">
		<div id="loginbox">
			<form action="" method="post" name="loginForm"
				id="loginForm">
				<div class="control-group normal_text">
					<h4>
						<!-- <img src="static/login/logo.png" alt="Logo" /> -->
						Ads System Manger Platform
					</h4>
				</div>
				<div class="control-group">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on bg_lo">
							<i><img src="static/login/user.png" /></i>
							</span><input type="text" name="loginname" id="loginname" value="" placeholder="Enter You Username" />
						</div>
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on bg_lo">
							<i><img src="static/login/pwd.png" /></i>
							</span><input type="password" name="password" id="password" placeholder="Enter You Password" value=""/>
						</div>
					</div>
				</div>
					<div class="control-group">
					<div class="controls">
						<div class="main_input_box">
							<span class="add-on bg_lo">
							<i><img  src="static/login/checkcode.png" /></i>
							</span><input type="text" name="code" id="code" class="login_code"  placeholder="Enter You Captcha" value=""/>
							<img style="height:38px;margin-top:1px; margin-left:-73px;float: right;position:absolute;" id="codeImg"
								 src="" />
						</div>
						
					</div>
				</div>
				<div class="form-actions">
					<div style="width:86%;padding-left:8%;">
						<span class="pull-center"><a onclick="severCheck();" style="width:180px" class=" btn btn-lg  btn-primary" id="to-recover">LOGIN</a></span>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function severCheck(){
			if(check()){
				var loginname = $("#loginname").val();
				var password = $("#password").val();
				var code =loginname+","+password+","+$("#code").val();
				$.ajax({
					type: "POST",
					url: 'login_login',
			    	data: {KEYDATA:code,tm:new Date().getTime()},
					dataType:'json',
					cache: false,
					success: function(data){
						if("success" == data.result){
							saveCookie();
							window.location.href="main/index";
						}else if("usererror" == data.result){
							$("#loginname").tips({
								side : 1,
								msg : "Wrong UserName Or Pwd",
								bg : '#FF5080',
								time : 3
							});
							$("#loginname").focus();
						}else if("codeerror" == data.result){
							$("#code").tips({
								side : 1,
								msg : "Wrong Captcha",
								bg : '#FF5080',
								time : 3
							});
							$("#code").focus();
						}else{
							$("#loginname").tips({
								side : 1,
								msg : "Missing Params",
								bg : '#FF5080',
								time : 3
							});
							$("#loginname").focus();
						}
					}
				});
			}
		}
	
		$(document).ready(function() {
			changeCode();
			$("#codeImg").bind("click", changeCode);
		});

		$(document).keyup(function(event) {
			if (event.keyCode == 13) {
				$("#to-recover").trigger("click");
			}
		});

		function genTimestamp() {
			var time = new Date();
			return time.getTime();
		}

		function changeCode() {
			$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
		}

		//客户端校验
		function check() {

			if ($("#loginname").val() == "") {

				$("#loginname").tips({
					side : 1,
					msg : 'Cannot Be Empty',
					bg : '#006dcc',
					time : 3
				});

				$("#loginname").focus();
				return false;
			} else {
				$("#loginname").val(jQuery.trim($('#loginname').val()));
			}

			if ($("#password").val() == "") {

				$("#password").tips({
					side : 1,
					msg : 'Cannot Be Empty',
					bg : '#006dcc',
					time : 3
				});

				$("#password").focus();
				return false;
			}
			if ($("#code").val() == "") {

				$("#code").tips({
					side : 1,
					msg : 'Cannot Be Empty',
					bg : '#006dcc',
					time : 3
				});

				$("#code").focus();
				return false;
			}

			$("#loginbox").tips({
				side : 1,
				msg : 'Please Watting...',
				bg : '#006dcc',
				time :10
			});
			return true;
		}

		function savePaw() {
			if (!$("#saveid").attr("checked")) {
				$.cookie('loginname', '', {
					expires : -1
				});
				$.cookie('password', '', {
					expires : -1
				});
				$("#loginname").val('');
				$("#password").val('');
			}
		}

		function saveCookie() {
			if ($("#saveid").attr("checked")) {
				$.cookie('loginname', $("#loginname").val(), {
					expires : 7
				});
				$.cookie('password', $("#password").val(), {
					expires : 7
				});
			}
		}
		function quxiao() {
			$("#loginname").val('');
			$("#password").val('');
		}
		
		jQuery(function() {
			var loginname = $.cookie('loginname');
			var password = $.cookie('password');
			if (typeof(loginname) != "undefined"
					&& typeof(password) != "undefined") {
				$("#loginname").val(loginname);
				$("#password").val(password);
				$("#saveid").attr("checked", true);
				$("#code").focus();
			}
		});
	</script>
	<script>
		//TOCMAT重启之后 点击左侧列表跳转登录首页 
		if (window != top) {
			top.location.href = location.href;
		}
	</script>
	<%--  <c:if test="${'1' == pd.msg}">
		<script type="text/javascript">
		$(tsMsg());
		function tsMsg(){
			alert('此用户在其它终端已经早于您登录,您暂时无法登录');
		}
		</script>
	</c:if>
	<c:if test="${'2' == pd.msg}">
		<script type="text/javascript">
			$(tsMsg());
			function tsMsg(){
				alert('您被系统管理员强制下线');
			}
		</script>
	</c:if>  --%>
	<script src="static/login/js/bootstrap.min.js"></script>
	<script src="static/js/jquery-1.7.2.js"></script>
	<script src="static/login/js/jquery.easing.1.3.js"></script>
	<script src="static/login/js/jquery.mobile.customized.min.js"></script>
	<script src="static/login/js/camera.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.cookie.js"></script>
</body>

</html>