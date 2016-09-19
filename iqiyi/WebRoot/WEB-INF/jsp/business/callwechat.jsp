<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../general/var.jsp"/>
<!DOCTYPE html>
<html ${fz}>
<head >
    <meta charset="UTF-8">
    <title>爱奇艺支付</title>
    <jsp:include page="../general/head.jsp"/>
</head>
<body>
<div style="font-size: .4rem;padding:.2rem;color:green;border-bottom: 1px dotted green">微信扫码支付</div>
<div class="pay-order-info">
    <span>订单号：${order.ID}</span>
    <span style="margin-left: .25rem">${title.NAME}</span>
    <span style="margin-left: .25rem">支付金额：<span style="color:#E62E04">${order.AMOUNT}</span></span>
</div>
<div class="pay-order-img">
    <img src="../pictureCode?codeUrl=${url}">
</div>
<div class="pay-order-finish">
    <a href="../../app" >首页</a>
    <a href="../../appresultbusiness/result" style="margin-left: .5rem">我的订单</a>
</div>
<div style="text-align: center;color: red;margin-top: .3rem;padding: .2rem">
    发此二维码至微信对话框，长按识别支付，或者使用pc浏览器下单，微信扫码支付。
</div>
</body>
</html>