<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core �±� ���� : taglib ���þ� ǥ���ؾ� �Ѵ�.</title>
<%--
	�ݵ�� taglib�� ����ؾ� ��
	prefix : c ===== ���ξ� c:set 
	uri : ���ͳ����� �������°� �ƴ�
 --%>
</head>
<body>
	<h3>�Ӽ� ���� �±� : set, remove, out �±�</h3>
	<% session.setAttribute("test","Hello JSTL"); %>
	<c:set var="test" value="${'Hello JSTL'}" scope="session"/> 
		<%--session������ �̸��� test��� ���� Hello JSTL�� ��� 
			scope ������ ��� page --%>
	test �Ӽ� : ${sessionScope.test}<br>
	test �Ӽ� : <c:out value="${test}" /><br>
		<%-- ���ȿ� �� ����, ��� value=test --%>
	<c:remove var="test" />
	<%-- test �Ӽ��� ����, ã�Ƽ� ������ --%>
	test �Ӽ� : ${test}<br>
</body>
</html>