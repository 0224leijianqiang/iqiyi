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
					<form action="type/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="TYPE_ID" id="TYPE_ID" value="${pd.TYPE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">类目:</td>
								<td>
								<select class="chosen-select form-control" name="CATEGORY_ID" id="CATEGORY_ID" data-placeholder="请选择分类" style="height: 30px;">
								 		<c:forEach items="${varList}" var="STATUS">
											<option value="${STATUS.CATEGORY_ID}" ${STATUS.CATEGORY_ID==pd.CATEGORY_ID?'SELECTED':''}>${STATUS.NAME }</option>
								 		</c:forEach>
									</select>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="64" placeholder="这里输入名称" title="名称" style="width:98%;"/></td>
							</tr>
<tr>	
								<td style="width:120px;text-align: right;padding-top: 13px;">内容:</td>
							<td style="padding-top: 3px;">
								 <textarea name="CONTENT" id="editor" style="height:180px;width:89%;">${pd.CONTENT}</textarea>  
							</td>
						</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">优惠:</td>
								<td><input type="text" name="GIFT" id="GIFT" value="${pd.GIFT}" maxlength="10" placeholder="这里输入优惠" title="优惠" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">原价:</td>
								<td><input type="number" name="PRICE" id="PRICE" value="${pd.PRICE}" maxlength="32" placeholder="这里输入原价" title="原价" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">现价:</td>
								<td><input type="number" name="CURRENT_PRICE" id="CURRENT_PRICE" value="${pd.CURRENT_PRICE}" maxlength="32" placeholder="这里输入现价" title="现价" style="width:98%;"/></td>
							</tr>
													<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">是否上架:</td>
								<td>	<label style="float:left;padding-left: 1px;padding-top:7px;">
															<input name="USED" type="radio" class="ace" id="USED" value="1" checked <c:if test="${pd.USED == '1'}">checked="checked"</c:if>/>
															<span class="lbl">上架</span>
								</label>
								<label style="float:left;padding-left: 1px;padding-top:7px;">
															<input name="USED" type="radio" class="ace" id="USED" value="0" <c:if test="${pd.USED == '0' }">checked="checked"</c:if>/>
															<span class="lbl">下架</span>
								</label></td>
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
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#CONTENT").val()==""){
				$("#CONTENT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENT").focus();
			return false;
			}
			if($("#GIFT").val()==""){
				$("#GIFT").tips({
					side:3,
		            msg:'请输入优惠',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GIFT").focus();
			return false;
			}
			if($("#CATEGORY_ID").val()==""){
				$("#CATEGORY_ID").tips({
					side:3,
		            msg:'请输入类目',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CATEGORY_ID").focus();
			return false;
			}
			if($("#PRICE").val()==""){
				$("#PRICE").tips({
					side:3,
		            msg:'请输入现价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRICE").focus();
			return false;
			}
			if($("#CURRENT_PRICE").val()==""){
				$("#CURRENT_PRICE").tips({
					side:3,
		            msg:'请输入现价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CURRENT_PRICE").focus();
			return false;
			}
			if($("#USED").val()==""){
				$("#USED").tips({
					side:3,
		            msg:'请输入是否上架',
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