<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 화면</title>
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
				<input type="submit" value="로그인">
				<input type="button" value="회원가입"
					onclick="location.href='joinForm.jsp'">
				<input type="button" value="아이디찾기" onclick="click_id()">
				<input type="button" value="비밀번호찾기" onclick="click_pass()">
			</td></tr>
	</table>
</form>
</body>
</html>