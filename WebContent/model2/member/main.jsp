<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	1. �α��� �Ŀ� �������� ������
		=> �α����� �ȵ� ��� => loginForm.jsp ������ �̵��ϱ�
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
</head>
<body>
	<table style="width:100%; text-align:center;">
	<tr><td colspan="2"><h3>${sessionScope.login}�� �ȳ��ϼ���.</h3></td></tr> <%-- session���ִ� login������ ������ --%>
	<tr><td><h5><a href="logout.me">�α׾ƿ�</a></h5></td>
		<td><h5><a href="info.me?id=${sessionScope.login }">ȸ����������</a></h5></td>
	</tr>
	<%-- �����ڷ� �α��� --%>
	<c:if test="${sessionScope.login == 'admin'}">
		<h3><a href="list.me">ȸ����Ϻ���</a></h3>
	</c:if>
	</table>
</body>
</html>