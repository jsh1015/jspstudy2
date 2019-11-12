<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>���۵� �Ķ���� ����</title>
</head>
<body>
<%--
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name"); //name�� ���� ������
	//getParameter �� �ڷ����� ������ string
	//getParameter �� �Ѱ��� ���� ������. getParameterValues�� �������� ������
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String hobby = request.getParameter("hobby");
	String year = request.getParameter("year");
--%>
<fmt:requestEncoding value="euc-kr"/>
�̸� : ${param.name }<br> <%-- name�� ���� �������� name���� --%>
���� : ${param.age }<br>
���� : ${param.gender=='1'}?"��":"��"%><br>
��� : ${param.hobby }<br> <%-- hobby���߰��϶� ���� --%>
����⵵ : ${param.year }<br>
<h3>��� ���� ��� ��ȸ�ϱ�</h3>
��� : 
<c:forEach var="h" items="${paramValues.hobby }">
	${h } &nbsp;&nbsp;
</c:forEach>
<br>
${paramValues.hobby[0]}&nbsp;${paramValues.hobby[1]} <br>
<h3>��� �Ķ���� ���� ��ȸ�ϱ�</h3>
<table>
	<tr><th>�Ķ�����̸�</th><th>�Ķ���� ��</th></tr>
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