<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<%--
	1. ���Ͼ��ε� => java
	2. opener ȭ�鿡 ��� ���� =>javascript
	3. ���� ȭ�� close() =>javascript
 --%>

 <script type="text/javascript">
	img = opener.document.getElementById("pic"); //opener�̹������� �˷���
	img.src = "picture/${fname}";//request��ü�� fname�� �ʿ� 
	opener.document.f.picture.value="${fname}"; //opener�� �Ķ���Ͱ����� ����
	self.close();	
 </script>
<meta charset="EUC-KR">
