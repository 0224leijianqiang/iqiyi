<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<form action="happuser/${msg }.do" name="userForm" id="userForm" method="post">
							<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">ROLE:</td>
									<td id="js">
									<select class="chosen-select form-control" name="ROLE_ID" id="role_id" data-placeholder="Please Select Role " style="vertical-align:top;"  title="级别" style="width:98%;" >
									<c:forEach items="${roleList}" var="role">
										<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
									</c:forEach>
									</select>
									</td>
								</tr>
								
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">LOGINNAME:</td>
									<td><input class="valid"  type="text" name="USERNAME" id="loginname" value="${pd.USERNAME }" placeholder="ENTER LOGIN NAME" title="LOGINNAME" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">PASSWORD:</td>
									<td><input   type="password" name="PASSWORD" id="PASSWORD"  placeholder="ENTER PASSWORD"  title="PASSWORD" style="width:98%;" /></td>
									</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">REPASSWORD:</td>
									<td><input  type="password" name="chkpwd" id="chkpwd"  placeholder="ENTER REPASSWORD"  title="REPASSWORD" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">NAME:</td>
									<td><input class="valid"  type="text" name="NAME" id="name"  value="${pd.NAME }" placeholder="ENTER NAME" title="NAME" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">CONTACTS:</td>
									<td><input class="valid"  type="tel" name="PHONE" id="PHONE" value="${pd.PHONE }" placeholder="ENTER CONTACTS" title="CONTACTS" style="width:98%;" /></td>
								</tr>
								<tr><td style="width:100px;text-align: right;padding-top: 13px;">EMAIL:</td>
									<td><input class="valid"  type="email" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" maxlength="32" placeholder="ENTER EMAIL" title="EMAIL" onblur="hasE('${pd.USERNAME }')" style="width:98%;" /></td>
								</tr>
								
										
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">SALES:</td>
									<td><input class="valid"  type="text" name="NUMBER" id="NUMBER" value="${pd.NUMBER }" maxlength="32" placeholder="ENTER SALES" title="SALES" onblur="hasN('${pd.USERNAME }')" style="width:98%;" /></td>
								</tr>
								<tr><td style="width:100px;text-align: right;padding-top: 13px;">AGENCY:</td>
									<td><input  class="valid" type="text" name="SFID" id="SFID" value="${pd.SFID }" placeholder="ENTER AGENCY" title="AGENCY" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:100px;text-align: right;padding-top: 13px;">DESCRIPT:</td>
									<td><input class="valid" type="text" name="BZ" id="BZ"value="${pd.BZ }" placeholder="ENTER DESCRIPT" title="DESCRIPT" style="width:98%;" /></td>
									</tr>
								<tr>
									<td class="center" colspan="6">
										<a class="btn btn-mini btn-primary" onclick="save();">Save</a>
										<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">Close</a>
									</td>
								</tr>
							</table>
							</div>
							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>						
<script type="text/javascript">
	$(top.hangge());
	
	$(document).ready(function(){
		if($("#user_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	});
	
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}

	//Save
	function save(){
		var through = true;
		$.each($(".valid"),function(index,dom){
			if($(dom).val()==""){
				$(dom).tips({
					side:3,
		            msg:'Cannot Be Empty',
		            bg:'#AE81FF',
		            time:2
		        });
				$(dom).focus();
				through = false;
				return false;
			}
		})
		if(!through){
			return false;
		}		
		if($("#user_id").val()==""){
			hasU();
		}else{
			$("#userForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	
	//判断用户名是否存在
	function hasU(){
		var USERNAME = $("#loginname").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>happuser/hasU.do',
	    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#userForm").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					$("#loginname").css("background-color","#D16E6C");
					setTimeout("$('#loginname').val('此用户名已存在!')",500);
				 }
			}
		});
	}
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $("#EMAIL").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>happuser/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱'+EMAIL+'已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					$('#EMAIL').val('');
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $("#NUMBER").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>happuser/hasN.do',
	    	data: {NUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUMBER").tips({
							side:3,
				            msg:'编号'+NUMBER+'已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $('#NUMBER').val('');
				 }
			}
		});
	}
	
	$(function() {
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		//下拉框
		if(!ace.vars['touch']) {
			$('.chosen-select').chosen({allow_single_deselect:true}); 
			$(window)
			.off('resize.chosen')
			.on('resize.chosen', function() {
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			}).trigger('resize.chosen');
			$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
				if(event_name != 'sidebar_collapsed') return;
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			});
			$('#chosen-multiple-style .btn').on('click', function(e){
				var target = $(this).find('input[type=radio]');
				var which = parseInt(target.val());
				if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
				 else $('#form-field-select-4').removeClass('tag-input-style');
			});
		}
	});
</script>
</html>