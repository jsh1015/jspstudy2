<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><decorator:title/></title> 
	<%--loginForm.me��û�� ������ loginForm.me�� title�κи� ��� ������ (����Ÿ��Ʋ��)--%>
<decorator:head/>
<%-- 
	decorator:head
	ȸ�������� ��������� ������ javascript�� �����Ǿ����� 
	title�� ������ head�κ� (script�κ�)�� �����Ե� 
	������ Form���ִ� link�� ���ֵ���
--%>
<link rel="stylesheet" href="${path }/css/main.css">
<!-- writeForm.jsp�� �ִ� script�� ������ -->
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
</head>
<body>
	<table>
		<tr><td colspan="3" align="right" style="text-align:center;">������ �������� ���� 2ȸ�� ���α׷� ����
				<div style="float: right;">
				<c:if test="${empty sessionSope.login }">
					<a href="${path }/model2/member/loginForm.me" style="text-align: right;">�α���</a>&nbsp;
					<a href="${path }/model2/member/joinForm.me" style="text-align: right;">ȸ������</a>
				</c:if> 
				<c:if test="${!empty sessionSope.login }">
						${login }���� �α��� �ϼ̽��ϴ�.&nbsp;
						<a href="${path }/model2/member/logout.me" style="text-align: right;">�α׾ƿ�</a>
				</c:if>
				</div>
			</td>
		</tr>
		<tr><td width="15%" style="vertical-align:top">
			<a href="${path }/model2/member/main.me">ȸ������</a><br>
			<a href="${path }/model2/board/list.do">�Խ���</a><br>
			</td>
			<td colspan="2" style="text-align:left; vertical-align:top">
			<decorator:body/><!-- loginForm���ִ� body�κ��� ������ -->
			</td>
		</tr>
		<tr><td colspan="3">�����ī���� Since 2016</td></tr>
	</table>
</body>
</html>