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
					<form action="log/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="LOG_ID" id="LOG_ID" value="${pd.LOG_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">日志内容:</td>
								<td><input type="text" name="TLOGDESC" id="TLOGDESC" value="${pd.TLOGDESC}" maxlength="255" placeholder="这里输入日志内容" title="日志内容" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">OperateIP:</td>
								<td><input type="text" name="TUSERIP" id="TUSERIP" value="${pd.TUSERIP}" maxlength="255" placeholder="这里输入OperateIP" title="OperateIP" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">Operate用户ID:</td>
								<td><input type="text" name="TUSERID" id="TUSERID" value="${pd.TUSERID}" maxlength="255" placeholder="这里输入Operate用户ID" title="Operate用户ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">Operate人:</td>
								<td><input type="text" name="TUSERNAME" id="TUSERNAME" value="${pd.TUSERNAME}" maxlength="255" placeholder="这里输入Operate人" title="Operate人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">Save</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">Close</a>
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
	<!-- Edit框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="static/js/myjs/fhsms.js"></script>	
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//Save
		function save(){
			if($("#TLOGDESC").val()==""){
				$("#TLOGDESC").tips({
					side:3,
		            msg:'请输入日志内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TLOGDESC").focus();
			return false;
			}
			if($("#TUSERIP").val()==""){
				$("#TUSERIP").tips({
					side:3,
		            msg:'请输入OperateIP',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TUSERIP").focus();
			return false;
			}
			if($("#TUSERID").val()==""){
				$("#TUSERID").tips({
					side:3,
		            msg:'请输入Operate用户ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TUSERID").focus();
			return false;
			}
			if($("#TUSERNAME").val()==""){
				$("#TUSERNAME").tips({
					side:3,
		            msg:'请输入Operate人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TUSERNAME").focus();
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