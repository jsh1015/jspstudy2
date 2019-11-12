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
	<%--loginForm.me요청이 들어오면 loginForm.me의 title부분만 끊어서 가져옴 (나의타이틀로)--%>
<decorator:head/>
<%-- 
	decorator:head
	회원가입의 사진등록을 누르면 javascript로 설정되어있음 
	title을 제외한 head부분 (script부분)이 들어오게됨 
	기존에 Form에있는 link는 없애도됨
--%>
<link rel="stylesheet" href="${path }/css/main.css">
<!-- writeForm.jsp에 있는 script를 가져옴 -->
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
</head>
<body>
	<table>
		<tr><td colspan="3" align="right" style="text-align:center;">디지털 컨버전스 과정 2회차 프로그램 연습
				<div style="float: right;">
				<c:if test="${empty sessionSope.login }">
					<a href="${path }/model2/member/loginForm.me" style="text-align: right;">로그인</a>&nbsp;
					<a href="${path }/model2/member/joinForm.me" style="text-align: right;">회원가입</a>
				</c:if> 
				<c:if test="${!empty sessionSope.login }">
						${login }님이 로그인 하셨습니다.&nbsp;
						<a href="${path }/model2/member/logout.me" style="text-align: right;">로그아웃</a>
				</c:if>
				</div>
			</td>
		</tr>
		<tr><td width="15%" style="vertical-align:top">
			<a href="${path }/model2/member/main.me">회원관리</a><br>
			<a href="${path }/model2/board/list.do">게시판</a><br>
			</td>
			<td colspan="2" style="text-align:left; vertical-align:top">
			<decorator:body/><!-- loginForm에있는 body부분을 가져옴 -->
			</td>
		</tr>
		<tr><td colspan="3">구디아카데미 Since 2016</td></tr>
	</table>
</body>
</html>