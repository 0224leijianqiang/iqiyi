﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
							
						<!-- Search  -->
						<form action="department/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="Enter search keywords" class="nav-search-input" id="keywords" name="keywords" autocomplete="off" value="${page.pd.keywords }" />
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td>&nbsp;
									<select name="DEPARTMENT_ID" id="DEPARTMENT_ID">
										<option value="${DEPARTMENT_ID}" <c:if test="${DEPARTMENT_ID != ''}">selected</c:if>>本级</option>
										<option value="" <c:if test="${DEPARTMENT_ID == ''}">selected</c:if>>全部</option>
									</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="gsearch();"  title="Search"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
							</tr>
						</table>
						<!-- Search  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">No</th>
									<th class="center">名称</th>
									<th class="center">英文</th>
									<th class="center">编码</th>
									<th class="center">部门负责人</th>
									<th class="center">部门电话</th>
									<th class="center">Operate</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'><a href="javascript:goSondict('${var.DEPARTMENT_ID }')"><i class="ace-icon fa fa-share bigger-100"></i>&nbsp;${var.NAME}</a></td>
											<td class='center'><a href="javascript:goSondict('${var.DEPARTMENT_ID }')">${var.NAME_EN}</a></td>
											<td class='center'>${var.BIANMA}</td>
											<td class='center'>${var.HEADMAN}</td>
											<td class='center'>${var.TEL}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="Edit" onclick="edit('${var.DEPARTMENT_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="Edit"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.DEPARTMENT_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="Delete"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.DEPARTMENT_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.DEPARTMENT_ID}');" class="tooltip-error" data-rel="tooltip" title="Delete">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
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
									<tr class="main_info">
										<td colspan="100" class="center" >No Data</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-sm btn-success" onclick="add('${DEPARTMENT_ID}');">Added</a>
									</c:if>
									<c:if test="${null != pd.DEPARTMENT_ID && pd.DEPARTMENT_ID != ''}">
									<a class="btn btn-sm btn-success" onclick="goSondict('${pd.PARENT_ID}');">返回</a>
									</c:if>
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- Delete时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//Search
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//去此ID下子级列表
		function goSondict(DEPARTMENT_ID){
			top.jzts();
			window.location.href="<%=basePath%>department/list.do?DEPARTMENT_ID="+DEPARTMENT_ID;
		};
		
		//Added
		function add(DEPARTMENT_ID){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="Added";
			 diag.URL = '<%=basePath%>department/goAdd.do?DEPARTMENT_ID='+DEPARTMENT_ID;
			 diag.Width = 466;
			 diag.Height = 546;
			 diag.CancelEvent = function(){ //关闭事件
				 if('none' == diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//Delete
		function del(Id){
			bootbox.confirm("确定要Delete吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>department/delete.do?DEPARTMENT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if("success" == data.result){
							nextPage(${page.currentPage});
						}else if("false" == data.result){
							top.hangge();
							bootbox.dialog({
								message: "<span class='bigger-110'>Delete失败！请先Delete子级部门.</span>",
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
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="Edit";
			 diag.URL = '<%=basePath%>department/goEdit.do?DEPARTMENT_ID='+Id;
			 diag.Width = 466;
			 diag.Height = 546;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
	</script>
</body>
</html>