<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 목록 보기</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function listdo(page){ //list.do를 위에서 실행하게 함
		document.sf.pageNum.value=page;
		document.sf.submit();
	}
</script>
</head>
<body>
	<form action="list.do" method="post" name="sf">
		<input type="hidden" name="pageNum" value="1">
		<table>
		<tr>
			<td style="border-width:0px;">
			<select name="column">
				<option value="">선택하세요</option>
				<option value="subject">제목</option>
				<option value="name">작성자</option>
				<option value="content">내용</option>
				<option value="subject,name">제목+작성자</option>
				<option value="subject,content">제목+내용</option>
				<option value="name,content">작성자+내용</option>
			</select>
			<script>
				document.sf.column.value="${param.column}"; //선택한 column의 값을 column.value에 넣어줌
			</script>
			<input type="text" name="find" value="${param.find}" style="width:50%">
			<input type="submit" value="검색">
			</td>
		</tr>
		</table>
	</form>
	<table>
	<caption>게시판 목록</caption>
	<c:if test="${boardcnt == 0}">
		<tr><td colspan="5">등록된 게시글이 없습니다.</td></tr>
	</c:if>
	<c:if test="${boardcnt > 0 }">
		<tr><td colspan="5" style="text-align:right">글개수:${boardcnt }</td></tr>
		<tr><th width="8%">번호</th><th width="50%">제목</th>
			<th width="14%">작성자</th><th width="17%">등록일</th>
			<th width="11%">조회수</th>
		</tr>
		<c:forEach items="${list}" var="b">
			<tr>
				<td>${boardnum}</td><c:set var="boardnum" value="${boardnum-1 }"/>
				<td style="text-align:left">
					<c:if test="${!empty b.file1}"><%--null이거나 비어있는 경우 empty --%>
						<a href="file/${b.file1 }" style="text-decoration:none;">@</a>
					</c:if>
					<c:if test="${empty b.file1}">
						&nbsp;&nbsp;&nbsp; 
					</c:if>
					<%--답글 표시하기 --%>
					<a href="info.do?num=${b.num}">
					<c:if test="${b.grplevel>0}">
						<c:forEach begin="1" end="${b.grplevel}">
							&nbsp;&nbsp;&nbsp;
						</c:forEach> └  <%-- ㅂ+한자 --%>
					</c:if>
					${b.subject}</a>
				</td>
				<td>${b.name}</td>
				<td>
<%--					
					<fmt:formatDate var="rdate" value="${b.regdate }" pattern="yyyyMMdd"/>
					<c:if test="${today==rdate }">
						<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss"/>
					</c:if>
--%>
					<c:set var="today" value="<%=new java.util.Date()%>"/>
					<fmt:formatDate pattern="yy-MM-dd" value="${today }" var="now"/>
					<fmt:formatDate pattern="yy-MM-dd" value="${b.regdate }" var="reg"/>
					<c:if test="${reg==now}">
						<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss"/>
					</c:if>
					<c:if test="${reg!=now}">
						<fmt:formatDate pattern="yy-MM-dd HH:mm" value="${b.regdate }"/>
					</c:if>
				</td>
				<td>${b.readcnt}</td>
			</tr>
		</c:forEach> <!-- for구문 끝 --> 
		<tr><td colspan="5">
			<c:if test="${pageNum <=1}">
					[이전] 
			</c:if>
			<c:if test="${pageNum >1 }">
				<a href="javascript:listdo(${pageNum-1 })">[이전]</a> <%--검색시 다음페이지로 넘어가도 깨지지 않게 --%>
			</c:if>
			<c:forEach var="a" begin="${startpage }" end="${endpage}">
				<c:if test="${a==pageNum }"> 
						[${a}] 
				</c:if>
				<c:if test="${a!=pageNum }">
						<a href="javascript:listdo(${a})">[${a}]</a>
				</c:if>
			</c:forEach> 
			<c:if test="${pageNum >= maxpage}">
				[다음]
			</c:if>
			<c:if test="${pageNum < maxpage}">
					<a href="javascript:listdo(${pageNum+1 })">[다음]</a>
			</c:if>
		</td></tr>
	</c:if><!-- else 구문 끝 -->
	<tr><td colspan="5" style="text-align:right">
		<a href="writeForm.do">[글쓰기]</a></td>
	</tr> 
	</table>
</body>
</html>