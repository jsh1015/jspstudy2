<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%--
	1. num ���� �Խù��� db���� ��ȸ�Ͽ� ȭ�� ����ϱ�
 --%>
<meta charset="EUC-KR">
<title>�Խ��� ���� ȭ��</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function file_delete(){
		document.f.file2.value=""; //�⺻�� �ִ� ������ ���ֹ���
		file_desc.style.display="none"; //div�� �ƿ� ������ �ʰ�(���� �����ʹ� ������ ����)
	}
</script>
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data" name="f">
	<input type="hidden" name="num" value="${b.num}">
	<input type="hidden" name="file2" value="${b.file1}"><%--�������� �̹����� �������� ���� --%>
	<table><caption>�Խ��� ���� ȭ��</caption>
		<tr>
			<th>�۾���</th>
			<td><input type="text" name="name" value="${b.name }"></td>
		</tr>
		<tr>
			<th>��й�ȣ</th>
			<td><input type="password" name="pass"></td>
		</tr>
		<tr>
			<th>����</th>
			<td><input type="text" name="subject" value="${b.subject }"></td>
		</tr>
		<tr>
			<th>����</th>
			<td><textarea rows="15" name="content" id="content1">${b.content }</textarea>
			</td>
			<script>CKEDITOR.replace("content1", {
			filebrowserImageUploadUrl : "imgupload.do"
			});
			</script>
		</tr>
		<tr>
			<th>÷������</th>
			<td style="text-align:left">
				<c:if test="${!empty b.file1 }">
					<div id="file_desc">${b.file1 }
					<a href="javascript:file_delete()">[÷������ ����]</a></div>
				</c:if>
					<input type="file" name="file1">
			</td>
		</tr>
		<tr><th colspan="2">
			<a href="javascript:document.f.submit()" style="color:black;">[�Խù�����]</a></th>
		</tr>
	</table>
</form>
</body>
</html>