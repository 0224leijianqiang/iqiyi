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
					<form action="code/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="CODE_ID" id="CODE_ID" value="${pd.CODE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">订单ID:</td>
								<td><input type="number" name="ORDER_ID" id="ORDER_ID" value="${pd.ORDER_ID}" maxlength="32" placeholder="这里输入订单ID" title="订单ID" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">激活码:</td>
								<td><input type="text" name="CODE" id="CODE" value="${pd.CODE}" maxlength="32" placeholder="这里输入激活码" title="激活码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">类型:</td>
								<td><input type="text" name="CITY" id="CITY" value="${pd.CITY}" maxlength="2" placeholder="这里输入类型" title="类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">是否激活:</td>
								<td><input type="text" name="USED" id="USED" value="${pd.USED}" maxlength="2" placeholder="这里输入是否激活" title="是否激活" style="width:98%;"/></td>
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
			if($("#ORDER_ID").val()==""){
				$("#ORDER_ID").tips({
					side:3,
		            msg:'请输入订单ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDER_ID").focus();
			return false;
			}
			if($("#CODE").val()==""){
				$("#CODE").tips({
					side:3,
		            msg:'请输入激活码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CODE").focus();
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
			if($("#USED").val()==""){
				$("#USED").tips({
					side:3,
		            msg:'请输入是否激活',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USED").focus();
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