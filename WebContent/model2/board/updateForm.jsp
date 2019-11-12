<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%--
	1. num 값의 게시물을 db에서 조회하여 화면 출력하기
 --%>
<meta charset="EUC-KR">
<title>게시판 수정 화면</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function file_delete(){
		document.f.file2.value=""; //기본에 있는 내용을 없애버림
		file_desc.style.display="none"; //div를 아예 보이지 않게(실제 데이터는 지우지 않음)
	}
</script>
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data" name="f">
	<input type="hidden" name="num" value="${b.num}">
	<input type="hidden" name="file2" value="${b.file1}"><%--수정전의 이미지를 가져오기 위해 --%>
	<table><caption>게시판 수정 화면</caption>
		<tr>
			<th>글쓴이</th>
			<td><input type="text" name="name" value="${b.name }"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pass"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="subject" value="${b.subject }"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="15" name="content" id="content1">${b.content }</textarea>
			</td>
			<script>CKEDITOR.replace("content1", {
			filebrowserImageUploadUrl : "imgupload.do"
			});
			</script>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td style="text-align:left">
				<c:if test="${!empty b.file1 }">
					<div id="file_desc">${b.file1 }
					<a href="javascript:file_delete()">[첨부파일 삭제]</a></div>
				</c:if>
					<input type="file" name="file1">
			</td>
		</tr>
		<tr><th colspan="2">
			<a href="javascript:document.f.submit()" style="color:black;">[게시물수정]</a></th>
		</tr>
	</table>
</form>
</body>
</html>