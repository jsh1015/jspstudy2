<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>전송된 파라미터 정보</title>
</head>
<body>
<%--
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name"); //name의 값을 가져옴
	//getParameter 는 자료형이 무조건 string
	//getParameter 는 한개의 값만 가져옴. getParameterValues는 여러값을 가져옴
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String hobby = request.getParameter("hobby");
	String year = request.getParameter("year");
--%>
<fmt:requestEncoding value="euc-kr"/>
이름 : ${param.name }<br> <%-- name이 위에 지정해준 name변수 --%>
나이 : ${param.age }<br>
성별 : ${param.gender=='1'}?"남":"여"%><br>
취미 : ${param.hobby }<br> <%-- hobby다중값일때 설정 --%>
출생년도 : ${param.year }<br>
<h3>취미 정보 모두 조회하기</h3>
취미 : 
<c:forEach var="h" items="${paramValues.hobby }">
	${h } &nbsp;&nbsp;
</c:forEach>
<br>
${paramValues.hobby[0]}&nbsp;${paramValues.hobby[1]} <br>
<h3>모든 파라미터 정보 조회하기</h3>
<table>
	<tr><th>파라미터이름</th><th>파라미터 값</th></tr>
	<c:forEach var="p" items="${paramValues }">
		<tr>
			<td>${p.key}</td>
			<td>
				<c:forEach var="v" items="${p.value}">
					${v } &nbsp;&nbsp;&nbsp;
				</c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>