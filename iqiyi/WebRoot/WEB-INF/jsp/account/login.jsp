<%@ page import="java.util.Random" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../general/var.jsp"/>
<!DOCTYPE html>
<html ${fz}>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <jsp:include page="../general/head.jsp"/>
    <c:if test="${param.state == null}">
    <%--<script name="baidu-tc-cerfication" type="text/javascript" charset="utf-8" data-appid="6776158" src="http://apps.bdimg.com/cloudaapi/lightapp.js"></script>--%>
    <%
        int i=(int)(Math.random()*1000000000);
        pageContext.setAttribute("signalStrength",new Integer(i));
    %>
    </c:if>
    <script>
        $(function () {
            <%--<c:if test="${param.state == null}">--%>
            <%--clouda.lightInit({--%>
                <%--ak:"d5yoHN1ZkCGMvT3u0kc9Pehb",--%>
                <%--module:["account","socialshare"]--%>
            <%--});--%>
            <%--clouda.mbaas.account.login({--%>
                <%--redirect_uri: "http://www.uping8.com/login",--%>
                <%--state: "${pageScope.signalStrength}",--%>
                <%--login_mode:0--%>
            <%--});--%>
            <%--</c:if>--%>

            var preg = /[0-9]{11}/, nreg = /[0-9]{4}/;
            $("#send").bind("click", function () {
                var phone = $("#phone").val();
                if (!preg.test(phone)) {
                    showMsg("请输入正确的手机号码");
                    return false;
                }
                $.ajax({
                    url: "app/sendValidateMsg",
                    data: {phone: phone}
                });
                $(this).off();
                var fun = arguments.callee, n = 30, that = this;
                var t = setInterval(function () {
                    $(that).text(n-- + "秒后重新发送");
                    if (n == 0) {
                        clearInterval(t);
                        $(that).text("发送验证码").bind("click", fun);
                    }
                }, 1000)
            });
            $("#login").bind("click", function () {
                var phone = $("#phone").val();
                var number = $("#number").val();
                if (!preg.test(phone)) {
                    showMsg("请输入正确的手机号码");
                    return false;
                }
                if (!nreg.test(number)) {
                    showMsg("请输入正确的验证码");
                    return false;
                }
                $(this).off();
                var fun = arguments.callee,that = this;
                $.ajax({
                    url: "app/validate",
                    data: {phone: phone, number: number},
                    success: function (o) {
                    	 if(o==null){
                    		 showMsg("手机或验证码错误！！");
                    		 $(that).bind("click", fun);
                    		 return false;
                    	 }
                    	 window.location.href=o==null?"/":o;
                        /* if(o.code==1) {
                            var url = o.data.toUrl;
                            if(/www/.test(window.location.href)) {
                                url = url.replace("uping8","www.uping8");
                                window.location.href=url==null?"/":url;
                            } else {
                                window.location.href=url==null?"/":url;
                            }

                        }else{
                            $(that).bind("click", fun);
                            showMsg(o.data.msg);
                        } */
                    }
                });
            });
        })
    </script>
</head>
<%--<body class="ln-bd" <c:if test="${param.state == null}">style="display: none"</c:if>>--%>
<body class="ln-bd" style="vertical-align: middle;">
 <div class="my-header">用户登录</div>
<div class="ln-user-block">
    <input type="text" value="" placeholder='请输入手机号' maxlength="11" id="phone">
</div>
<div class="ln-valid-block">
    <input type="text" placeholder='请输入验证码' maxlength="4" id="number">
    <A class='ln-btn' id="send">发送验证码</A>
</div>
<div style="display: none">
    <a class="ln-voice">如收不到短信，请点击此语音获取</a>
</div>
<div class='ln-login-block'><a class='ln-btn' id="login">登录</a></div>
<jsp:include page="../general/box.jsp"/>
</body>
</html>

<%--如何激活--%>
<%--帮助  http://uping8.com/login/help--%>
<%--去激活  http://t.cn/Ryn0dcG--%>