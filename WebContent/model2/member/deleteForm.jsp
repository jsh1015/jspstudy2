<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String login = (String)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ��Ż�� ��й�ȣ �Է� ȭ��</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
	<form action="delete.me" method="post">
		<input type="hidden" name="id" value='${id}'>
		<table>
			<caption>ȸ�� ��й�ȣ �Է�</caption>
			<tr><th>��й�ȣ</th>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><td colspan="2">
				<input type="submit" value="Ż���ϱ�"></td></tr>
		</table>
	</form>
</body>
</html>