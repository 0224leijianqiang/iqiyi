<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="general/var.jsp"/>
<!DOCTYPE html>
<html ${fz}>
<head >
    <meta charset="UTF-8">
    <title>爱奇艺会员，立减20%</title>
    <jsp:include page="general/head.jsp"/>
    <script type="text/javascript" name="baidu-tc-cerfication" data-appid="6776158" src="http://apps.bdimg.com/cloudaapi/lightapp.js"></script>
    <script type="text/javascript"  src="http://s.servingcdn.com/adhoc.min.js"></script>
</head>
<body onload="adhoc_load()">
<div class="aqy-bd">
    <div class="aqy-top"></div>
    <a class="aqy-banner"></a>
    <div class="aqy-content">
        <a href="/order?cid=4" class="aqy-a" onclick="adhoc.incrementStat('bt1', 1)"></a>
        <a href="/order?cid=3" class="aqy-b" onclick="adhoc.incrementStat('bt2', 1)"></a>
        <a href="/order?cid=2" class="aqy-c" onclick="adhoc.incrementStat('bt3', 1)"></a>
        <a href="/order?cid=1" class="aqy-d" onclick="adhoc.incrementStat('bt4', 1)"></a>
        <a href="http://vip.iqiyi.com/membershipagreement.html" class="aqy-clause" ></a>
    </div>
</div>
<script>
    function adhoc_load() {
        adhoc.init('ADHOC_1e2bde06-06e8-4210-be80-a8063eaa414f');
        adhoc.incrementStat('p1_imp', 1)
    }
</script>
</body>
</html>