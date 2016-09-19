<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
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
					<form action="order/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ORDER_ID" id="ORDER_ID" value="${pd.ORDER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">用户:</td>
								<td><input type="number" name="USER_ID" id="USER_ID" value="${pd.USER_ID}" maxlength="32" placeholder="这里输入用户" title="用户" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">是否支付:</td>
								<td><input type="text" name="PAID" id="PAID" value="${pd.PAID}" maxlength="2" placeholder="这里输入是否支付" title="是否支付" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">支付金额:</td>
								<td><input type="number" name="AMOUNT" id="AMOUNT" value="${pd.AMOUNT}" maxlength="32" placeholder="这里输入支付金额" title="支付金额" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">数量:</td>
								<td><input type="number" name="COUNT" id="COUNT" value="${pd.COUNT}" maxlength="32" placeholder="这里输入数量" title="数量" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">类型:</td>
								<td><input type="text" name="CITY" id="CITY" value="${pd.CITY}" maxlength="255" placeholder="这里输入类型" title="类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">手机号:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" maxlength="11" placeholder="这里输入手机号" title="手机号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">支付码:</td>
								<td><input type="text" name="PAY_CODE" id="PAY_CODE" value="${pd.PAY_CODE}" maxlength="128" placeholder="这里输入支付码" title="支付码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">消息码:</td>
								<td><input type="text" name="MSG_CODE" id="MSG_CODE" value="${pd.MSG_CODE}" maxlength="32" placeholder="这里输入消息码" title="消息码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">渠道:</td>
								<td><input type="text" name="CHANEL" id="CHANEL" value="${pd.CHANEL}" maxlength="32" placeholder="这里输入渠道" title="渠道" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						
					</form>
	
					<div id="zhongxin2" class="center" style="display:none"><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
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


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>	
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#USER_ID").val()==""){
				$("#USER_ID").tips({
					side:3,
		            msg:'请输入用户',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER_ID").focus();
			return false;
			}
			if($("#PAID").val()==""){
				$("#PAID").tips({
					side:3,
		            msg:'请输入是否支付',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAID").focus();
			return false;
			}
			if($("#AMOUNT").val()==""){
				$("#AMOUNT").tips({
					side:3,
		            msg:'请输入支付金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AMOUNT").focus();
			return false;
			}
			if($("#COUNT").val()==""){
				$("#COUNT").tips({
					side:3,
		            msg:'请输入数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT").focus();
			return false;
			}
			if($("#CITY").val()==""){
				$("#CITY").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CITY").focus();
			return false;
			}
			if($("#PHONE").val()==""){
				$("#PHONE").tips({
					side:3,
		            msg:'请输入手机号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PHONE").focus();
			return false;
			}
			if($("#PAY_CODE").val()==""){
				$("#PAY_CODE").tips({
					side:3,
		            msg:'请输入支付码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAY_CODE").focus();
			return false;
			}
			if($("#MSG_CODE").val()==""){
				$("#MSG_CODE").tips({
					side:3,
		            msg:'请输入消息码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MSG_CODE").focus();
			return false;
			}
			if($("#CHANEL").val()==""){
				$("#CHANEL").tips({
					side:3,
		            msg:'请输入渠道',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CHANEL").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>