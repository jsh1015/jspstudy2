<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>idã��</title>
<script>
	 function send(){
		  opener.document.f.id.value="${id}"
		  self.close()
	 }
</script>
</head>
<body>
	<table>
	  <tr><td>ID : ${id}**</td></tr>
	  <tr><td><input type="button" value="���̵�����" onclick="send()"></td></tr>
	</table>
</body>
</html>