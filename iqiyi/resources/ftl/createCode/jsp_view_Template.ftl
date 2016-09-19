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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
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
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
				<#list fieldList as var>
					<#if var[3] == "是">
						<#if var[1] == 'Date'>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td>${r"${pd."}${var[0] }${r"}"}</td>
							</tr>
						<#elseif var[1] == 'Integer'>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td>${r"${pd."}${var[0] }${r"}"}</td>
							</tr>
						<#elseif var[1] == 'Blob'><tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">${var[2]}:</td>
							<td style="padding-top: 3px;">
								 ${r"${pd."}${var[0] }${r"}"}
							</td>
						</tr>
						<#else>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">${var[2] }:</td>
								<td>${r"${pd."}${var[0] }${r"}"}</td>
							</tr>
						</#if>
					</#if>
				</#list>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
</body>
</html>