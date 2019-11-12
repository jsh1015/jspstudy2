<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>core 태그 : 조건문 예제</title>
</head>
<body>
	<h3>조건문 관련 태그 : if, choose(else대신) 태그</h3>
	<c:if test="${5<10}"> <%--반드시 결과가 boolean --%>
		<h4>5는 10보다 작다</h4>
	</c:if>
	<%	if(5<10){ %>
			<h4>5는 10보다 작다</h4>
	<%	}%>
	
	<c:if test="${6+3 != 10}">
		<h4>6+3은 10이 아니다</h4>
	</c:if>
	<c:choose>
		<c:when test="${5+10==510}">
			<h4>5+10=510</h4>
		</c:when>
		<c:otherwise>
			<h4>5+10=모름</h4>
		</c:otherwise>
	</c:choose>
</body>
</html>