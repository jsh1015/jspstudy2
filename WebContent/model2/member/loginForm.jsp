<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ȭ��</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function click_id(){
		var op = "width=500, height=150, left=50, top=150";
		open("idForm.me","",op)
	}
	function click_pass(){
		var op = "width=500, height=250, left=50, top=150";
		open("pwForm.me","",op)
	}
	/*function win_open(page){
		var op = "width=500, height=250, left=50, top=150";
		open(page+".me","",op)
	}*/
</script>
</head>
<body>
<form action="login.me" method="post" name="f">
	<table>
		<caption>Login</caption>
		<tr><td><input type="text" style="border-radius:10px; width:25%" name=" id"> id</td></tr>
		<tr><td><input type="password" style="border-radius:10px; width:25%" name="pass"> pw</td></tr>
		<tr><td>
				<input type="submit" value="�α���">
				<input type="button" value="ȸ������"
					onclick="location.href='joinForm.jsp'">
				<input type="button" value="���̵�ã��" onclick="click_id()">
				<input type="button" value="��й�ȣã��" onclick="click_pass()">
			</td></tr>
	</table>
</form>
</body>
</html>