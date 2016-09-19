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

							<table id="dynamic-table" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th class="right" style="width: 50px;">No</th>
										<th class='right' style="width: 220px;">Name</th>
										<th class='right'>Resource Url</th>
										<th class='right' style="width: 50px;">Status</th>
										<th class='center' style="width: 160px;">Operate</th>
									</tr>
								</thead>

								<tbody>
								<c:choose>
									<c:when test="${not empty menuList}">
									<c:forEach items="${menuList}" var="menu" varStatus="vs">
									<tr>
										<td class='center'>${vs.index+1 }</td>
										<td class='center'><i class="${menu.MENU_ICON }">&nbsp;</i>
											<a href="javascript:goSonmenu('${menu.MENU_ID }')">${menu.MENU_NAME }</a>
											&nbsp;
											<%-- <c:if test="${menu.PARENT_ID == '0' }">
											<c:if test="${menu.MENU_TYPE == '1' }">
											<span class="label label-success arrowed">系统</span>
											</c:if>
											<c:if test="${menu.MENU_TYPE != '1' }">
											<span class="label label-important arrowed-in">业务</span>
											</c:if>
											</c:if> --%>
										</td>
										<td>${menu.MENU_URL == '#'? '': menu.MENU_URL}</td>
										<td class='center'><i class="ace-icon fa ${menu.MENU_STATE == 1? 'fa-eye': 'fa-eye-slash'}"></i></td>
										<td class='center'>
											<c:if test="${QX.edit != 1 && QX.del != 1 }">
											<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
											</c:if>
												<c:if test="${QX.edit == 1 }">
												<%-- <a  class="btn btn-minier btn-info" href="javascript:editTb('${menu.MENU_ID }');"> 
													<i class="ace-icon fa fa-hdd-o bigger-120" title="Edit Icon"></i>
												</a>  --%>
												<a  class="btn btn-minier btn-success" href="javascript:editmenu('${menu.MENU_ID }');">
													<i class="ace-icon fa fa-pencil-square-o bigger-120" title="Update"></i>
												</a>
												</c:if>
												<c:if test="${QX.del == 1 }">
												<a  class="btn btn-minier btn-danger" href="javascript:delmenu('${menu.MENU_ID }');">
													<i class="ace-icon fa fa-trash-o bigger-120" title="Delete"></i>
												</a>
												</c:if>
										</td>
									</tr>
									</c:forEach>
									</c:when>
										<c:otherwise>
											<tr>
											<td colspan="100" class='center'>No Data</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div>
								&nbsp;&nbsp;
								<c:if test="${QX.add == 1 }"><a class="btn btn-mini btn-primary" onclick="addmenu('${MENU_ID}');">Added Menu</a></c:if>
								<c:if test="${null != pd.MENU_ID && pd.MENU_ID != '0'}">
									<a class="btn btn-mini btn-success" onclick="goSonmenu('${pd.PARENT_ID}');">Back Superior</a>
								</c:if>
							</div>
							
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-mini btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- Delete时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>

	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(document).ready(function(){
			top.hangge();
		});	
		
		//去此ID下子菜单列表
		function goSonmenu(MENU_ID){
			top.jzts();
			window.location.href="<%=basePath%>menu.do?MENU_ID="+MENU_ID;
		};
		
		//Added菜单
		function addmenu(MENU_ID){
			top.jzts();
			window.location.href="<%=basePath%>menu/toAdd.do?MENU_ID="+MENU_ID;
		};
		
		//Edit菜单
		function editmenu(MENU_ID){
			top.jzts();
			window.location.href="<%=basePath%>menu/toEdit.do?id="+MENU_ID;
		};
		//Delete
		function delmenu(MENU_ID){
			bootbox.confirm("确定要Delete此菜单吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>menu/delete.do?MENU_ID="+MENU_ID+"&guid="+new Date().getTime();
					top.jzts();
					$.get(url,function(data){
						if("success" == data.result){
							setTimeout("location.reload()",100);
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>Delete失败,请先Delete子菜单!</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "确定",
										"className" : "btn-mini btn-success"
									}
								}
							});
						}
					});
				}
			});
		}
		
		//Edit菜单 Icon
		function editTb(MENU_ID){
			 top.jzts();
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="Edit Icon";
			 diag.URL = '<%=basePath%>menu/toEditicon.do?MENU_ID='+MENU_ID;
			 diag.Width = 800;
			 diag.Height = 380;
			 diag.CancelEvent = function(){ //关闭事件
				location.reload(true);
				diag.close();
			 };
			 diag.show();
		}
	</script>


</body>
</html>