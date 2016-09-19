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
							 <table style="margin-top: 8px;">
								<tr height="35">
									<c:if test="${QX.add == 1 }">
									 <td style="width:69px;padding-right: 5px;"><a href="javascript:addRole(0);" class="btn btn-sm btn-success">Added Group</a></td> 
									</c:if>
										<c:choose>
										<c:when test="${not empty roleList}">
										<c:forEach items="${roleList}" var="role" varStatus="vs">
											<td style="width:100px;height: 32px;" class="center" <c:choose><c:when test="${pd.ROLE_ID == role.ROLE_ID}">bgcolor="#FFC926" onMouseOut="javascript:this.bgColor='#FFC926';"</c:when><c:otherwise>bgcolor="#E5E5E5" onMouseOut="javascript:this.bgColor='#E5E5E5';"</c:otherwise></c:choose>  onMouseMove="javascript:this.bgColor='#FFC926';" >
												<a href="role.do?ROLE_ID=${role.ROLE_ID }" style="text-decoration:none; display:block;"><i class="menu-icon fa fa-users"></i><font color="#666666"> ${role.ROLE_NAME }</font></a>
											</td>
											<td style="width:5px;"></td>
										</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
											<td colspan="100">No Data</td>
											</tr>
										</c:otherwise>
										</c:choose>
									<td></td>
								</tr>
							</table>  
							
							 <table>
								<tr height="7px;"><td colspan="100"></td></tr>
								<tr>
								<td>
								<c:if test="${QX.edit == 1 }">
								<a class="btn btn-mini btn-info" onclick="editRole('${pd.ROLE_ID }');">Update Group Name<i class="icon-arrow-right  icon-on-right"></i></a>
								</c:if>
									<c:choose>
										<c:when test="${pd.ROLE_ID == '99'}">
										</c:when>
										<c:otherwise>
										<c:if test="${QX.edit == 1 }">
										<a class="btn btn-mini btn-purple" onclick="editRights('${pd.ROLE_ID }');"><i class="icon-pencil"></i>Group Menu Permission</a>
										</c:if>
										</c:otherwise>
									</c:choose>
									<c:choose> 
										<c:when test="${pd.ROLE_ID == '1' or pd.ROLE_ID == '2'}">
										</c:when>
										<c:otherwise>
										 <c:if test="${QX.del == 1 }">
										 <a class='btn btn-mini btn-danger' title="Delete" onclick="delRole('${pd.ROLE_ID }','z','${pd.ROLE_NAME }');"><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
										 </c:if>
										</c:otherwise>
									</c:choose>
								</td>
								</tr>
							</table> 
							
							<table id="dynamic-table" class="table table-striped table-bordered table-hover" style="margin-top:7px;">
								<thead>
								<tr>
									<th class="center" style="width: 50px;">No</th>
									<th class='center'>Role Name</th>
									<c:if test="${QX.edit == 1 }">
									<th class="center">Add</th>
									<th class="center">Delete</th>
									<th class="center">Update</th>
									<th class="center">Select</th>
									</c:if>
									<th class="center" style="width: 150px">Menu Operate</th>
									<th style="width:100px;"  class="center">Operate</th>
								</tr>
								</thead>
								<c:choose>
									<c:when test="${not empty roleList_z}">
										<c:if test="${QX.cha == 1 }">
										<c:forEach items="${roleList_z}" var="var" varStatus="vs">
										
										<tr>
										<td class='center' style="width:30px;">${vs.index+1}</td>
										<td id="ROLE_NAMETd${var.ROLE_ID }">${var.ROLE_NAME }</td>
										<c:if test="${QX.edit == 1 }">
										<td class="center" style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','add_qx');" class="btn btn-warning btn-minier" title="Grant Add Permission"><i class="ace-icon fa fa-wrench bigger-110 icon-only"></i></a></td>
										<td class="center" style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','del_qx');" class="btn btn-warning btn-minier" title="Grant Delete Permission"><i class="ace-icon fa fa-wrench bigger-110 icon-only"></i></a></td>
										<td class="center" style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','edit_qx');" class="btn btn-warning btn-minier" title="Grant Update Permission"><i class="ace-icon fa fa-wrench bigger-110 icon-only"></i></a></td>
										<td class="center" style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','cha_qx');" class="btn btn-warning btn-minier" title="Grant Select Permission"><i class="ace-icon fa fa-wrench bigger-110 icon-only"></i></a></td>
										</c:if>
										<td class="center"><a class="btn btn-minier btn-purple" onclick="editRights('${var.ROLE_ID }');"><i class="icon-pencil"></i>Menu Permission</a></td>
										<td style="width:100px;">
										<c:if test="${QX.edit != 1 && QX.del != 1 }">
										<div style="width:100%;" class="center">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="No Permission"></i></span>
										</div>
										</c:if>
										<c:if test="${QX.edit == 1 }">
											<a class='btn btn-minier btn-success' title="Edit" onclick="editRole('${var.ROLE_ID }');"><i class='ace-icon fa fa-pencil-square-o bigger-120'></i></a>
										</c:if>
										<c:choose> 
											<c:when test="${var.ROLE_ID == '2' or var.ROLE_ID == '1'}">
											</c:when>
											<c:otherwise>
											 <c:if test="${QX.del == 1 }">
												 <a class='btn btn-minier btn-danger' title="Delete" onclick="delRole('${var.ROLE_ID }','c','${var.ROLE_NAME }');"><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
											 </c:if>
											</c:otherwise>
										</c:choose>
										</td>
										</tr>
										</c:forEach>
										</c:if>
										<c:if test="${QX.cha == 0 }">
											<tr>
												<td colspan="100" class="center">You do not have permission</td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr>
										<td colspan="100" class="center" >No Data</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
							<div>
							<c:if test="${QX.add == 1 }">
								&nbsp;&nbsp;<a class="btn btn-mini btn-primary" onclick="addRole('${pd.ROLE_ID }');">Added Role</a>
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
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
		$(top.hangge());
		
		//Added组
		function addRole(pid){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="Added";
			 diag.URL = '<%=basePath%>role/toAdd.do?parent_id='+pid;
			 diag.Width = 222;
			 diag.Height = 100;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.jzts();
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function editRole(ROLE_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="Edit";
			 diag.URL = '<%=basePath%>role/toEdit.do?ROLE_ID='+ROLE_ID;
			 diag.Width = 222;
			 diag.Height = 100;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					top.jzts();
					setTimeout("self.location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//Delete
		function delRole(ROLE_ID,msg,ROLE_NAME){
			bootbox.confirm("Are you Delete ["+ROLE_NAME+"]?", function(result) {
				if(result) {
					var url = "<%=basePath%>role/delete.do?ROLE_ID="+ROLE_ID+"&guid="+new Date().getTime();
					top.jzts();
					$.get(url,function(data){
						if("success" == data.result){
							if(msg == 'c'){
								top.jzts();
								document.location.reload();
							}else{
								top.jzts();
								window.location.href="role.do";
							}
							
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>Delete Default，Please Delete Lower Role!</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "Ok",
										"className" : "btn-sm btn-success"
									}
								}
							});
						}else if("false2" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>Delete失败，此角色已被使用!</span>",
								buttons: 			
								{
									"button" :
									{
										"label" : "确定",
										"className" : "btn-sm btn-success"
									}
								}
							});
						}
					});
				}
			});
		}
		
		//菜单权限
		function editRights(ROLE_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = "Menu Permission";
			 diag.URL = '<%=basePath%>role/menuqx.do?ROLE_ID='+ROLE_ID;
			 diag.Width = 320;
			 diag.Height = 450;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//按钮权限(增删改查)
		function roleButton(ROLE_ID,msg){
			top.jzts();
			if(msg == 'add_qx'){
				var Title = "Grant Added Permission";
			}else if(msg == 'del_qx'){
				Title = "Grant Delete Permission";
			}else if(msg == 'edit_qx'){
				Title = "Grant Update Permission";
			}else if(msg == 'cha_qx'){
				Title = "Grant Select Permission";
			}
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = Title;
			 diag.URL = '<%=basePath%>role/b4Button.do?ROLE_ID='+ROLE_ID+'&msg='+msg;
			 diag.Width = 330;
			 diag.Height = 450;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
	</script>


</body>
</html>