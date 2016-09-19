<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../general/var.jsp"/>
<!DOCTYPE html>
<html ${fz}>
<head >
    <meta charset="UTF-8">
    <title>购买</title>
    <jsp:include page="../general/head.jsp"/>
    <script>
        $(function(){
            $(":radio:first").attr("checked",true)
            $(".kfc-pay").one("click",function(){
                $("form").submit();
            });
        })
    </script>
</head>
<body>

    <form action="order" method="get" class="kfc-panel">
        <div class="kfc-pay-attention">
            <p>注意：特价产品，一经售出，概不退款。</p>
            <p style="font-size: 0.15rem;margin-top: 5px">如果未收到兑换码，请把您的手机号发送至31787051@qq.com,感谢支持！</p>
        </div>
        <div>
            <span class="kfc-label">消费城市：</span>
            <c:if test="${bc>=5}">
                <span><input type="radio" name="cid" value=1 checked="true">北京</span>
            </c:if>
            <c:if test="${sc>=5}">
                <span><input type="radio" name="cid" value=2 >上海</span>
            </c:if>
            <c:if test="${gc>=5}">
                <span><input type="radio" name="cid" value=3 >广州</span>
            </c:if>
            <%--<select name="cid">--%>
                <%--<option value="-1" selected>请选择</option>--%>
                <%--<option value="1">北京</option>--%>
                <%--<option value="2">上海</option>--%>
                <%--<option value="3">广州</option>--%>
            <%--</select>--%>
        </div>
        <div>
            <span>购买数量：</span>
            <select name="count">
                <option value="1">1杯</option>
                <option value="2">2杯</option>
                <option value="3">3杯</option>
                <option value="4">4杯</option>
                <option value="5">5杯</option>
            </select>
        </div>
        <A class="kfc-pay">立即支付</A>
    </form>
</body>
</html>