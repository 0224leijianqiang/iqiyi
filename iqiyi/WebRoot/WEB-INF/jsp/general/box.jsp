<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="ge-mask"></div>
<div class="ge-box">
    <div class="ge-box-content">
        <p class="ge-box-title">提示信息</p>
        <p class="ge-box-info"></p>
    </div>
    <c:choose>
    <c:when test="${param.type == '1'}">
        <A class="ge-box-confirm">确定</A><A class="ge-box-ok">取消</A>
    </c:when>
    <c:otherwise>
        <div class="ge-box-ok">知道了</div>
    </c:otherwise>
    </c:choose>

</div>
<script>
    $(function(){
        $(".ge-box-ok").bind("click",function(){
            $(".ge-box").hide();
            $(".ge-mask").fadeOut();
        });
        window.showMsg = function(msg){
            $(".ge-box-info").text(msg);
            $(".ge-mask").show();
            $(".ge-box").fadeIn();
        }
    })
</script>