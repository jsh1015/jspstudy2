<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>jstl core �±� : �ݺ���</title>
</head>
<body>
	<h3>�ݺ� ���� �±� : forEach</h3>
	<c:forEach var="test" begin="1" end="10" step="2">
		${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</c:forEach>
	
	<h3>forEach �±׸� �̿��Ͽ� 1���� 100������ �� ���ϱ�</h3>
	<%-- �����ϰ� ���� ������ �ʿ���  --%> 
	<c:forEach var="i" begin="1" end="100" >
		<c:if test="${i%2==0}">
			<c:set var="sum" value="${sum+i}"/>
		</c:if>
	</c:forEach>
		1���� 100������ ¦�� �� : ${sum }<br>
	
		<c:set var="sum" value="${0}"></c:set>
		
	<c:forEach var="i" begin="1" end="100" >
		<c:if test="${i%2!=0}">
			<c:set var="sum" value="${sum+i}"/>
		</c:if>
	</c:forEach>
	1���� 100������ Ȧ�� �� : ${sum }<br>
	
	<h3>forEach �±׸� �̿��Ͽ� 2~9�ܱ��� ������ ����ϱ�</h3>
	<c:forEach var="i" begin="2" end="9">
		<h4>${i}��</h4>
		<c:forEach var="j" begin="2" end="9">
			${i} * ${j} = ${i*j}<br>
		</c:forEach>
		<br>
	</c:forEach>
	
	<h3>forEach �±׸� �̿��Ͽ� List ��ü ����ϱ�</h3>
	<%
		List<Integer> list = new ArrayList<Integer>();
		for(int i=1;i<=10;i++){
			list.add(i*10);
		}
		pageContext.setAttribute("list",list); //pageContext�� list��� �̸����� ���
	%>
	<c:forEach var="i" items="${list}"><%--items --%> 
	<%--list���ִ� ������� �ϳ��� ��� --%>
		${i}&nbsp;&nbsp;&nbsp;
	</c:forEach>
	
	<%-- varStatus : (index)--%>
	<c:forEach var="i" items="${list}" varStatus="stat">
		<c:if test="${stat.index ==0}">
			<h4>&nbsp;&nbsp;&nbsp;forEach �±��� varStatus �Ӽ�����</h4>
		</c:if>
		${stat.count} : ${i}<br> <%--count=1���� --%>
	</c:forEach>
	
	<h3>forEach �±׸� �̿��Ͽ� Map��ü ����ϱ�</h3>
	<%
		Map<String, Object>map = new HashMap<String,Object>();
		map.put("name","ȫ�浿");
		map.put("today",new Date());
		map.put("age",20);
		pageContext.setAttribute("maps",map);
	%>
	<c:forEach var="m" items="${maps}" varStatus="stat">
		${stat.count} : ${m.key}=${m.value}<br>
	</c:forEach>
	
	<h3>EL�� �̿��Ͽ� Map��ü ����ϱ�</h3>
		name=${maps.name}<br>
		today=${maps.today}<br>
		age=${maps.age}<br> <%-- (request.getParameter()) : ��ü�� map�̱⶧����  => param.name�λ��--%>
	
	<h3>forEach �±׸� �̿��Ͽ� �迭 ��ü ���</h3>
		<%-- arr�� �Ӽ������� value�� ���� �迭�� �� --%>
		<c:set var="arr" value="<%=new int[]{10,20,30,40,50} %>"/>
		<%-- set�� EL�Ӹ��ƴ϶� ǥ���ĵ� �� �� ���� --%>
		<c:forEach var="a" items="${arr}" varStatus="stat">
			arr[${stat.index}]=${a}<br>
		</c:forEach>
		${arr[0]}<br>
		${list[2]}<br><%--List�� �迭ó�� ǥ�� �� �� �ִ�. --%>
		
	<h4>&nbsp;&nbsp;&nbsp;�迭 ��ü�� �ι�° ��� ���� ����° ��ұ��� ����ϱ�</h4>
		<%--arr�迭 ����� 1������ 2������ --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" begin="1" end="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
	
	<h4>&nbsp;&nbsp;&nbsp;�迭 ��ü�� ¦�� �ε����� ����ϱ�</h4>
		<%--arr�迭 ����� 1������ 2������ --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" step="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
	
	<h4>&nbsp;&nbsp;&nbsp;�迭 ��ü�� Ȧ�� �ε����� ����ϱ�</h4>
		<%--arr�迭 ����� 1������ 2������ --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" begin="1" step="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
</body>
</html>