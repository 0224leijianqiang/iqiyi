<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:choose>
    <c:when test="${cookie['w'].value == null}">
        <c:set var="fz" value="style='font-size: 48px'" scope="request"/>
    </c:when>
    <c:otherwise>
        <c:set var="fz" value="style='font-size: ${cookie['w'].value}px'" scope="request"/>
    </c:otherwise>
</c:choose>
