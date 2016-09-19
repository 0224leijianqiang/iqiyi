<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="current" class="java.util.Date" />
<jsp:include page="../general/var.jsp"/>
<!DOCTYPE html>
<html ${fz}>
<head >
    <meta charset="UTF-8">
    <title>爱奇艺会员立减20%</title>
    <jsp:include page="../general/head.jsp"/>
<link href="/static/master/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
</head>
<body>
<div class="my-header" style="background-color: #d22e7d;color: white;font-size: 20px;">确认订单</div>
<table id="table_report" class="table table-striped table-bordered table-hover" style="width:100%;">
	<tr style="height: 60px">
		<td style="text-align: right;vertical-align: middle;width: 120px">商品名：</td>
		<td style="vertical-align: middle;"><span  style="color:#d22e7d;font-size: 18px;padding-left: 5px;font-weight: bold;">${type.NAME }</span></td>
	</tr>
	<tr style="height: 60px">
		<td style="text-align: right;vertical-align: middle;width: 120px">单价：</td>
		<td style="vertical-align: middle;color:#d22e7d;font-size: 18px;padding-left: 15px">${type.CURRENT_PRICE}</td>
	</tr>
	<tr style="height: 60px">
		<td style="text-align: right;vertical-align: middle;">购买数量：</td>
		<td  style="vertical-align: middle;padding-left: 15px"><span style="font-size: 16px">1</span></td>
	</tr>
	<tr style="height: 60px">
		<td style="text-align: right;vertical-align: middle;">总金额：</td>
		<td  style="vertical-align: middle;padding-left: 15px"><span style="color:#d22e7d;font-size: 20px">${type.CURRENT_PRICE }</span></td>
	</tr>
	<tr style="height: 60px">
		<td style="text-align: right;vertical-align: middle;" rowspan="3">选择支付方式：</td>
		<td style="vertical-align: middle;">
			<label style="float:left;padding-left: 5px;">
				<input name="form-field-radio2" type="radio" class="ace" checked="checked" id="form-field-radio3"/>
				<span class="lbl" style="color:#d22e7d;">&nbsp;微信支付</span>
			</label>
		</td>
	</tr>
	<tr style="height: 60px">
		<td style="vertical-align: middle;">
			<label style="float:left;padding-left: 5px;">
				<input name="form-field-radio2" type="radio" class="ace" id="form-field-radio3"/>
				<span class="lbl" style="color:#d22e7d;">&nbsp;百度钱包支付</span>
			</label>
		</td>
	</tr>
	<tr style="height: 60px">
		<td style="vertical-align: middle;">
			<label style="float:left;padding-left: 5px;">
				<input name="form-field-radio2" type="radio" class="ace" id="form-field-radio3" />
				<span class="lbl" style="color:#d22e7d;">&nbsp;支付宝支付</span>
			</label>
		</td>
	</tr>
	
	<tr style="height: 135px">
		<td colspan="10" style="text-align: center;vertical-align: middle;">
			<a href="appbusiness/result" class="btn btn-lg btn-warning" style="background-color: #d22e7d;border-color: #d22e7d;font-size: 14px;">确认订单</a>
		</td>
	</tr>
	
</table>
<script type="text/javascript">
	function changePrice(dom){
		$("#totalPrice").val($(dom).val()*${type.CURRENT_PRICE});
	}
</script>
</body>
</html>