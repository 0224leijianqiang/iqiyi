<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						
						<!-- Search  -->
						<form action="user/listAll.do" method="post" name="userForm" id="userForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span >
										<input  type="text" style="height: 30px;" name="keywords" value="${pd.keywords }" placeholder="Enter search keywords" />
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="Search"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						<!-- Search  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:50px;">No</th>
									<th class="center">编号</th>
									<th class="center">姓名</th>
									<th class="center">部门</th>
									<th class="center">Operate</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:forEach items="${userList}" var="user" varStatus="vs">
								<tr>
									<td class='center' style="width: 30px;">${vs.index+1}</td>
									<td class="center">${user.NUMBER }</td>
									<td class="center">${user.NAME }</td>
									<td class="center">${user.DEPARTMENT_NAME }</td>
									<td class="center"><a class="btn btn-minier btn-primary" onclick="top.Dialog.close('${user.USER_ID}');">选择</a></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td class="center">${page.pageSimpleStr}</td>
						</tr>
					</table>
					</div>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	</body>

<script type="text/javascript">
	$(top.hangge());
	//Search
	function searchs(){
		top.jzts();
		$("#userForm").submit();
	}
</script>
</html>
