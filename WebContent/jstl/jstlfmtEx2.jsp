<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>형식 관련 태그 예제2</title>
</head>
<body>
	<h3>Format 된 숫자를 일반 숫자로 변경</h3>
	<fmt:parseNumber value="20,000" var="num1" pattern="##,###"/>
	<fmt:parseNumber value="10,000" var="num2" pattern="##,###"/>
	합 : ${num1+num2 }<br>
	합 : <fmt:formatNumber value="${num1+num2 }" pattern="##,###" var="num3"/>${num3 }
	<h3>Format 된 날짜를 일반 날짜로 변경</h3>
	<fmt:parseDate value="2019-10-30 12:00:00" pattern="yyyy-MM-dd HH:mm:ss" var="day"/>
	날짜 : ${day }<br>
	
	<h3>2019-10-30의 요일 출력하기</h3>
	2019-10-30 : <fmt:formatDate value="${day}" pattern="E요일"/><br>
</body>
</html>