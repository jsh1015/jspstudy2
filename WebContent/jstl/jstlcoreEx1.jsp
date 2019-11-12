<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core 태그 예제 : taglib 지시어 표시해야 한다.</title>
<%--
	반드시 taglib를 사용해야 함
	prefix : c ===== 접두어 c:set 
	uri : 인터넷으로 가져오는게 아님
 --%>
</head>
<body>
	<h3>속성 설정 태그 : set, remove, out 태그</h3>
	<% session.setAttribute("test","Hello JSTL"); %>
	<c:set var="test" value="${'Hello JSTL'}" scope="session"/> 
		<%--session영역에 이름이 test라는 곳에 Hello JSTL을 등록 
			scope 생략될 경우 page --%>
	test 속성 : ${sessionScope.test}<br>
	test 속성 : <c:out value="${test}" /><br>
		<%-- 보안에 더 안전, 출력 value=test --%>
	<c:remove var="test" />
	<%-- test 속성을 지움, 찾아서 삭제함 --%>
	test 속성 : ${test}<br>
</body>
</html>