<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
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
						<form action="" name="form1" id="form1"  method="post">
							<div id="zhongxin" style="padding-top:13px;">
							<table class="table table-striped table-bordered table-hover" style="width:100%;">
									<c:forEach items="${varList}" var="var">
										<tr>
												<td><a href="/uploadFiles/uploadImgs/${var.URL}">${var.NAME }</a></td>
										</tr>
									</c:forEach>
							</table>
							</div>
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
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	top.hangge();
	//Save
	function save(){
		if($("#roleName").val()==""){
			$("#roleName").tips({
				side:3,
	            msg:'请输入',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#roleName").focus();
			return false;
		}
			$("#form1").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
	}
	
	
	</script>
</body>
</html>

