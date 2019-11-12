<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	1. 로그인 후에 보여지는 페이지
		=> 로그인이 안된 경우 => loginForm.jsp 페이지 이동하기
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원관리</title>
</head>
<body>
	<table style="width:100%; text-align:center;">
	<tr><td colspan="2"><h3>${sessionScope.login}님 안녕하세요.</h3></td></tr> <%-- session에있는 login정보만 가져옴 --%>
	<tr><td><h5><a href="logout.me">로그아웃</a></h5></td>
		<td><h5><a href="info.me?id=${sessionScope.login }">회원정보보기</a></h5></td>
	</tr>
	<%-- 관리자로 로그인 --%>
	<c:if test="${sessionScope.login == 'admin'}">
		<h3><a href="list.me">회원목록보기</a></h3>
	</c:if>
	</table>
</body>
</html>