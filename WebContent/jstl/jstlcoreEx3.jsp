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
<title>jstl core 태그 : 반복문</title>
</head>
<body>
	<h3>반복 관련 태그 : forEach</h3>
	<c:forEach var="test" begin="1" end="10" step="2">
		${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</c:forEach>
	
	<h3>forEach 태그를 이용하여 1부터 100까지의 합 구하기</h3>
	<%-- 저장하고 있을 변수가 필요함  --%> 
	<c:forEach var="i" begin="1" end="100" >
		<c:if test="${i%2==0}">
			<c:set var="sum" value="${sum+i}"/>
		</c:if>
	</c:forEach>
		1부터 100까지의 짝수 합 : ${sum }<br>
	
		<c:set var="sum" value="${0}"></c:set>
		
	<c:forEach var="i" begin="1" end="100" >
		<c:if test="${i%2!=0}">
			<c:set var="sum" value="${sum+i}"/>
		</c:if>
	</c:forEach>
	1부터 100까지의 홀수 합 : ${sum }<br>
	
	<h3>forEach 태그를 이용하여 2~9단까지 구구단 출력하기</h3>
	<c:forEach var="i" begin="2" end="9">
		<h4>${i}단</h4>
		<c:forEach var="j" begin="2" end="9">
			${i} * ${j} = ${i*j}<br>
		</c:forEach>
		<br>
	</c:forEach>
	
	<h3>forEach 태그를 이용하여 List 객체 출력하기</h3>
	<%
		List<Integer> list = new ArrayList<Integer>();
		for(int i=1;i<=10;i++){
			list.add(i*10);
		}
		pageContext.setAttribute("list",list); //pageContext에 list라는 이름으로 등록
	%>
	<c:forEach var="i" items="${list}"><%--items --%> 
	<%--list에있는 내용들을 하나씩 출력 --%>
		${i}&nbsp;&nbsp;&nbsp;
	</c:forEach>
	
	<%-- varStatus : (index)--%>
	<c:forEach var="i" items="${list}" varStatus="stat">
		<c:if test="${stat.index ==0}">
			<h4>&nbsp;&nbsp;&nbsp;forEach 태그의 varStatus 속성연습</h4>
		</c:if>
		${stat.count} : ${i}<br> <%--count=1부터 --%>
	</c:forEach>
	
	<h3>forEach 태그를 이용하여 Map객체 출력하기</h3>
	<%
		Map<String, Object>map = new HashMap<String,Object>();
		map.put("name","홍길동");
		map.put("today",new Date());
		map.put("age",20);
		pageContext.setAttribute("maps",map);
	%>
	<c:forEach var="m" items="${maps}" varStatus="stat">
		${stat.count} : ${m.key}=${m.value}<br>
	</c:forEach>
	
	<h3>EL을 이용하여 Map객체 출력하기</h3>
		name=${maps.name}<br>
		today=${maps.today}<br>
		age=${maps.age}<br> <%-- (request.getParameter()) : 자체가 map이기때문에  => param.name로사용--%>
	
	<h3>forEach 태그를 이용하여 배열 객체 출력</h3>
		<%-- arr이 속성이지만 value를 통해 배열이 들어감 --%>
		<c:set var="arr" value="<%=new int[]{10,20,30,40,50} %>"/>
		<%-- set은 EL뿐만아니라 표현식도 들어갈 수 있음 --%>
		<c:forEach var="a" items="${arr}" varStatus="stat">
			arr[${stat.index}]=${a}<br>
		</c:forEach>
		${arr[0]}<br>
		${list[2]}<br><%--List도 배열처럼 표시 할 수 있다. --%>
		
	<h4>&nbsp;&nbsp;&nbsp;배열 객체의 두번째 요소 부터 세번째 요소까지 출력하기</h4>
		<%--arr배열 출력을 1번부터 2번까지 --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" begin="1" end="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
	
	<h4>&nbsp;&nbsp;&nbsp;배열 객체의 짝수 인덱스만 출력하기</h4>
		<%--arr배열 출력을 1번부터 2번까지 --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" step="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
	
	<h4>&nbsp;&nbsp;&nbsp;배열 객체의 홀수 인덱스만 출력하기</h4>
		<%--arr배열 출력을 1번부터 2번까지 --%>
	<c:forEach var="a" items="${arr}" varStatus="stat" begin="1" step="2">
		arr[${stat.index}]=${a}<br>
	</c:forEach>
</body>
</html>