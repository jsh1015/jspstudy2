<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�н����庯��</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function inchk(check){	//�����й�ȣ ��ġ����
		if(f.rpass1.value != f.rpass2.value){
			alert("���� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.")
			f.rpass2.value=""
			f.rpass2.focus()
			return false
		}
		return true
	}
</script>
</head>
<body>
	<form action="password.me" method="post" name="f" onsubmit="return inchk(this)">
	<table>
		<caption>��й�ȣ ����</caption>
		<tr><th>���� ��й�ȣ</th><td><input type="password" name="pass"></td></tr>
		<tr><th>���� ��й�ȣ</th><td><input type="password" name="rpass1"></td></tr>
		<tr><th>���� ��й�ȣ ���Է�</th><td><input type="password" name="rpass2"></td></tr>
		<tr><td colspan="2"><input type="submit" value="��й�ȣ ����"></td></tr>
	</table>
	</form>
</body>
</html>