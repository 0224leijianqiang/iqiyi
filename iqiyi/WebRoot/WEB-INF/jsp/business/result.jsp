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
    <title>我的激活码</title>
    <jsp:include page="../general/head.jsp"/>
</head>
<body>
<c:if test="${cost.size()==0}">
    <div class="my-no-order"></div>
</c:if>
<c:forEach items="${cost}" var="o" varStatus="status">
    <c:if test="${status.first == true }">
        <div class="my-header">我的激活码</div>
        <ul class='my-code-list'>
    </c:if>
    <li>
        <span>
            <p class="my-combo-name">订单号:${o.id}${o.title.CONTENT}</p>
            <c:choose>
                <c:when test="${o.code == null}">
                </c:when>
                <c:otherwise>
                    <p class="my-combo-code">激活码：
                        ${o.code}
                    </p>
                </c:otherwise>
            </c:choose>
            <p class="my-combo-valid">订购日期: <fmt:formatDate value="${o.order_date}" pattern="yyyy-MM-dd hh:mm:ss" /></p>
        </span><span>
            <c:if test="${o.paid == '1'}">
                <a class="my-tel" href="http://t.cn/Ryn0dcG"></a>
            </c:if>
            <c:if test="${o.paid=='0'}">
                <c:choose>
                    <c:when test="${current.time-o.orderDate.time<1000*60*10}">
                        <a class="my-pay" href="/pay/${o.id}"></a>
                    </c:when>
                    <c:otherwise>
                        <a class="my-close"></a>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </span>
    </li>
    <c:if test="${status.last == true }">
        </ul>
    </c:if>
</c:forEach>
</body>
</html>