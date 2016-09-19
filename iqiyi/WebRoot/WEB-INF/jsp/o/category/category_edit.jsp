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
					<form action="category/${msg }.do" name="Form" id="Form" method="post"  enctype="multipart/form-data">
						<input type="hidden" name="CATEGORY_ID" id="CATEGORY_ID" value="${pd.CATEGORY_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">标题:</td>
								<td>
								<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入标题" title="标题" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">背景图:</td>
								<td>
								<input type="file" id="BGIMG" name="BGIMG" onchange="fileType(this)"/>
							</td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">导航图:</td>
								<td>
								<input type="file" id="NAVIMG" name="NAVIMG" onchange="fileType(this)"/>
								</td>
							</tr>
<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">内容说明:</td>
							<td style="padding-top: 3px;">
								 <textarea name="CONTENT" id="editor" style="height:180px;width:86%;">${pd.CONTENT}</textarea>  
							</td>
						</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">排序:</td>
								<td><input type="text" name="LINK" id="LINK" value="${pd.LINK}" maxlength="255" placeholder="这里输入链接地址" title="链接地址" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:120px;text-align: right;padding-top: 13px;">是否上架:</td>
								<td>
								<label style="float:left;padding-left: 1px;padding-top:7px;">
															<input name="USED" type="radio" class="ace" id="USED" value="0" checked <c:if test="${pd.USED == '0'}">checked="checked"</c:if>/>
															<span class="lbl">上架</span>
								</label>
								<label style="float:left;padding-left: 1px;padding-top:7px;">
															<input name="USED" type="radio" class="ace" id="USED" value="1" <c:if test="${pd.USED == '0' }">checked="checked"</c:if>/>
															<span class="lbl">下架</span>
								</label>
								</td>
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
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--提示框-->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			//上传
			$('#BGIMG').ace_file_input({
				no_file:'${pd.ICON==null?'请选择背景图 ...':pd.ICON}',
				btn_choose:'${pd.ICON==null?'选择':'更改'}',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'gif|png|jpg|jpeg',
				//blacklist:'gif|png|jpg|jpeg'
				//onchange:''
				//
			});
			 $('#NAVIMG').ace_file_input({
					no_file:'${pd.ICON==null?'请选择导航图 ...':pd.ICON}',
					btn_choose:'${pd.ICON==null?'选择':'更改'}',
					btn_change:'更改',
					droppable:false,
					onchange:null,
					thumbnail:false, //| true | large
					whitelist:'gif|png|jpg|jpeg',
					//blacklist:'gif|png|jpg|jpeg'
					//onchange:''
					//
				});
		});
		//过滤类型
		function fileType(obj){
		var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
	    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
	    	$("#BGIMG").tips({
				side:3,
	            msg:'请上传图片格式的文件',
	            bg:'#AE81FF',
	            time:3
	        });
	    	$("#BGIMG").val('');
	    	document.getElementById("BGIMG").files[0] = '请选择图片';
	    }
	   
	}
	//过滤类型
	function fileType(obj){
	var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
    	$("#NAVIMG").tips({
			side:3,
            msg:'请上传图片格式的文件',
            bg:'#AE81FF',
            time:3
        });
    	$("#NAVIMG").val('');
    	document.getElementById("NAVIMG").files[0] = '请选择图片';
    }
	}
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#CONTENT").val()==""){
				$("#CONTENT").tips({
					side:3,
		            msg:'请输入内容说明',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENT").focus();
			return false;
			}
			if($("#LINK").val()==""){
				$("#LINK").tips({
					side:3,
		            msg:'请输入链接地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LINK").focus();
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