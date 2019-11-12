<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� ��� ����</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function listdo(page){ //list.do�� ������ �����ϰ� ��
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
				<option value="">�����ϼ���</option>
				<option value="subject">����</option>
				<option value="name">�ۼ���</option>
				<option value="content">����</option>
				<option value="subject,name">����+�ۼ���</option>
				<option value="subject,content">����+����</option>
				<option value="name,content">�ۼ���+����</option>
			</select>
			<script>
				document.sf.column.value="${param.column}"; //������ column�� ���� column.value�� �־���
			</script>
			<input type="text" name="find" value="${param.find}" style="width:50%">
			<input type="submit" value="�˻�">
			</td>
		</tr>
		</table>
	</form>
	<table>
	<caption>�Խ��� ���</caption>
	<c:if test="${boardcnt == 0}">
		<tr><td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td></tr>
	</c:if>
	<c:if test="${boardcnt > 0 }">
		<tr><td colspan="5" style="text-align:right">�۰���:${boardcnt }</td></tr>
		<tr><th width="8%">��ȣ</th><th width="50%">����</th>
			<th width="14%">�ۼ���</th><th width="17%">�����</th>
			<th width="11%">��ȸ��</th>
		</tr>
		<c:forEach items="${list}" var="b">
			<tr>
				<td>${boardnum}</td><c:set var="boardnum" value="${boardnum-1 }"/>
				<td style="text-align:left">
					<c:if test="${!empty b.file1}"><%--null�̰ų� ����ִ� ��� empty --%>
						<a href="file/${b.file1 }" style="text-decoration:none;">@</a>
					</c:if>
					<c:if test="${empty b.file1}">
						&nbsp;&nbsp;&nbsp; 
					</c:if>
					<%--��� ǥ���ϱ� --%>
					<a href="info.do?num=${b.num}">
					<c:if test="${b.grplevel>0}">
						<c:forEach begin="1" end="${b.grplevel}">
							&nbsp;&nbsp;&nbsp;
						</c:forEach> ��  <%-- ��+���� --%>
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
		</c:forEach> <!-- for���� �� --> 
		<tr><td colspan="5">
			<c:if test="${pageNum <=1}">
					[����] 
			</c:if>
			<c:if test="${pageNum >1 }">
				<a href="javascript:listdo(${pageNum-1 })">[����]</a> <%--�˻��� ������������ �Ѿ�� ������ �ʰ� --%>
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
				[����]
			</c:if>
			<c:if test="${pageNum < maxpage}">
					<a href="javascript:listdo(${pageNum+1 })">[����]</a>
			</c:if>
		</td></tr>
	</c:if><!-- else ���� �� -->
	<tr><td colspan="5" style="text-align:right">
		<a href="writeForm.do">[�۾���]</a></td>
	</tr> 
	</table>
</body>
</html>