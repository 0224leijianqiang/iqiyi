
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
<title>爱奇艺会员-立减20%</title>
<!-- Bootstrap -->
<!-- <meta name="viewport" content="initial-scale=1, user-scalable=0, minimal-ui"> -->
<meta name="viewport" content="user-scalable=0, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width"/>
   <style>
   /*  html, body {
        position: relative;
        height: 100%;
    }
    body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color:#000;
        margin: 0;
        padding: 0;
    }
    .swiper-container {
        width: 100%;
        height: 100%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    } */
    
     .td_active{
     	
     }
     .icon_bg{
     	width: 32px;
     	height: 32px;
     	float: left;
     }
      .icon_bg_right{
     	width: 32px;
     	height: 32px;
     	float: right;
     	margin-right: 10px
     }
      .icon_bg_right_check{
         background: url("static/master/images/radio_bg.png") -15px -15px no-repeat;
         
     }
     .icon_bg_right_uncheck{
         background: url("static/master/images/radio_bg.png") -15px -81px no-repeat;
     }
     .icon_bg_wx{
         background: url("static/master/images/b.png") -64px 0px no-repeat;
     }
     .icon_bg_bd{
         background: url("static/master/images/b.png") 0px 0px no-repeat;
     }
     .icon_bg_zfb{
         background: url("static/master/images/b.png") -32px 0px no-repeat;
     }
     .td_uncheck{
     	vertical-align: middle;text-align: center;background-color:  #efefef;width: 50%;
     }
     .td_check{
   		background-color:white;
   		background-size:100% 100%;
     	background-image: url('static/master/images/check_bg.png');
     	
     }
     .btn{
     	display: inline-block;
	    margin-bottom: 0;
	    font-weight: 400;
	    text-align: center;
	    vertical-align: middle;
	    cursor: pointer;
	    background-image: none;
	    border: 1px solid transparent;
	    white-space: nowrap;
	    color: #fff;
	    padding-top: 10px;
	    padding-bottom: 10px;
   	 	font-size: 18px;
    	line-height: 1.53;
     }
	a{
		color:black;
		font-size:14px;
		text-decoration: none;
		display: inline-block;
	    margin-bottom: 0;
	    font-weight: 400;
	    text-align: center;
	    vertical-align: middle;
	    cursor: pointer;
	    background-image: none;
	     padding-top: -15px;
   	 	font-size: 14px;
    	margin-bottom: 8px;
	}     
    </style>
<body style="background: #ddd;margin: 0px">
<p style="padding:15px;font-size: 18px;color: #fe6000;background-color: white;vertical-align: middle;margin: 0px">黄金VIP套餐<a href="appresultbusiness" style="float: right"><span style="float: right;font-size:18px;color: black;height: 100%;">我的订单&nbsp;<img src="static/master/images/enter.png" style="height: 18px;"></span></a></p>
<%-- <ul style="">
	<c:forEach  items="${tDatas}" var="o" varStatus="status">
		<li style="list-style: none;width: 45%;float: left;height: 120px;background: gray;margin: 2%;text-align: center;padding-top: 10px;background-color: #efefef">
			<p>${o.CURRENT_PRICE }元/${o.NAME}</p>
			<p style="font-size: 14px;color:#fe6000">原价:${o.PRICE }元/${o.NAME}</p>
		</li>
	</c:forEach>
</ul> --%>
 <%-- <div class="swiper-container swiper-container-horizontal" style="height: 200px">
        <div class="swiper-wrapper"  >
	        <c:forEach items="${tCategory}" var="c">
	            <img  class="swiper-slide" alt="" src="/uploadFiles/uploadImgs/${c.NAVIMG}" width="100%">
	        </c:forEach>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>
        <!-- Add Arrows -->
    </div> --%>
	<table id="table_report" style="width:100%; border-collapse:separate ; border-spacing: 10px;background: white;margin-top: 0.5px" >
							<c:forEach items="${tDatas}" varStatus="status" var="var">
								<c:if test="${status.index%2==0}">
									<tr style="height:89px;width: 172px">
								</c:if>
										<td class="td_uncheck ${var.TYPE_ID==checkType?'td_check':'' }"  data-id="${var.TYPE_ID}">
											<span style="font-size: 18px;">${var.CURRENT_PRICE}元/${var.NAME}</span><br>
											<span style="font-size: 12px;color:#fe6000">原价${var.PRICE}元/${var.NAME}</span>
										</td>
								<c:if test="${status.index%2==1}">
									</tr>
								</c:if>		
							</c:forEach>
</table>
<p style="font-size: 18px;padding: 15px;background-color: white;margin:0px;margin-top: 10px">选择支付方式</p>
<table style="width: 100%;background-color: white;margin-top: 1px">
	<tr class="icon_bg_td" style="height: 55px;" data-id="1">
		<td  style="vertical-align: middle;padding-left: 15px;border-bottom: 1px solid #ddd;">
			<div  class="icon_bg icon_bg_wx"></div><span style="font-size: 18px;float: left;vertical-align: middle;padding-top: 2px">&nbsp;微信支付</span>
			<div class="icon_bg_right ${payType==1?'icon_bg_right_check':'icon_bg_right_uncheck'}"></div>
		</td>
	</tr>
	<tr class="icon_bg_td" style="height: 55px;"  data-id="2">
		<td  style="vertical-align: middle;padding-left: 15px;border-bottom:1px solid #ddd">
				<div  class="icon_bg icon_bg_bd"></div><span style="font-size: 18px;float: left;vertical-align: middle;padding-top: 2px">&nbsp;百度钱包支付</span><div style="background-image: url('static/master/images/radio_bg.png');"></div>
			<div class="icon_bg_right ${payType==2?'icon_bg_right_check':'icon_bg_right_uncheck'}"></div>
		</td>
	</tr>
	<tr  class="icon_bg_td" class="icon_bg_td" style="height: 55px;" data-id="3">
		<td style="padding-left: 15px;">
		<div  class="icon_bg icon_bg_zfb"></div><span style="font-size: 18px;float: left;vertical-align: middle;padding-top: 2px">&nbsp;支付宝支付</span>
			<div class="icon_bg_right ${payType==3?'icon_bg_right_check':'icon_bg_right_uncheck'}"></div>
		</td>
	</tr>
</table>
<p style="font-size: 18px;padding: 15px;background-color: white;margin:0px;margin-top: 10px">黄金VIP特权</p>
<div >
	 <img src="static/res/images/bottom_bg.png" width="100%">
</div>
<table style="width: 100%;height: 55px">
	<tr>
		<td style="text-align: center;vertical-align: middle;width: 50%;padding: 10px;">
			<a href="appnotice/x">会员服务协议</a>&nbsp;<img src="static/master/images/enter.png" style="height: 15px;">
		</td>
		<td style="text-align: center;vertical-align: middle;width: 50%;">
			<a href="appnotice/g">使用规则</a>&nbsp;<img src="static/master/images/enter.png" style="height: 15px;margin-top:10px">
		</td>
	</tr>
</table> 
<a class="btn" onclick="goPay();" style="width: 100%;border-radius: 0px;background-color:#fe6000;border-color: #fe6000;bottom: 0px;font-size: 22px">立即付款</a>
</body>
<script type="text/javascript" src="static/master/js/jquery.min.js"></script>
  <script>
  	var checkType = ${checkType};
  	var payType = ${payType};
    $(".td_uncheck").click(function(){
    	$(".td_uncheck").removeClass("td_check");
		$(this).addClass("td_check"); 
		checkType = $(this).attr("data-id");
		addCookie("checkType",checkType,48);
    });
    $(".icon_bg_td").click(function(){
    	$(".icon_bg_right").addClass("icon_bg_right_uncheck");
    	$(this).find(".icon_bg_right").removeClass("icon_bg_right_uncheck");
		$(this).find(".icon_bg_right").addClass("icon_bg_right_check"); 
		payType = $(this).attr("data-id");
		addCookie("payType",payType,48);
    });
    function goPay(){
    	window.location.href="appbusiness/order?cid="+checkType+"&chanel=${param.from}&pay="+payType+"&tm="+new Date().getTime();
    }
    function addCookie(objName, objValue, objHours){//添加cookie 
        var str = objName + "=" + escape(objValue); 
        if (objHours > 0) {//为0时不设定过期时间，浏览器关闭时cookie自动消失 
            var date = new Date(); 
            var ms = objHours * 3600 * 1000; 
            date.setTime(date.getTime() + ms); 
            str += "; expires=" + date.toGMTString(); 
        } 
        document.cookie = str; 
    } 
    
    function getCookie(objName){//获取指定名称的cookie的值 
        var arrStr = document.cookie.split("; "); 
        for (var i = 0; i < arrStr.length; i++) { 
            var temp = arrStr[i].split("="); 
            if (temp[0] == objName) 
                return unescape(temp[1]); 
        } 
    } 
    
  </script>
</html>