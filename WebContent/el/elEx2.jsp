<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>elEx1.jsp의 결과화면</title>
</head>
<body>
	<% 
	request.setCharacterEncoding("euc-kr");
	String tel = "010-1111-2222";
	pageContext.setAttribute("tel",tel);
	pageContext.setAttribute("test","pageContext객체의 test 속성 값");
	request.setAttribute("test","request객체의 test속성 값");
	application.setAttribute("test","application객체의 test속성 값");
	%>
	<h3>JSP의 스크립트를 이용하여 파라미터와 속성값 출력</h3>
	pageContext test 속성값 : <%=pageContext.getAttribute("test") %><br>
	session test 속성값 : <%=session.getAttribute("test") %><br>
	today 속성값 : <%=session.getAttribute("today") %><br>
	name 파라미터 값 : <%=request.getParameter("name") %><br>
	tel 변수값 : <%=tel%><br>
	tel 속성값 : <%=pageContext.getAttribute("tel") %><br>
	noAttr 속성값 : <%=pageContext.getAttribute("noAttr")%><br><br>
	noParam 파라미터값 : <%=request.getParameter("noParam")%><br><br>
	
	
	<h3>JSP의 EL(표현)을 이용하여 파라미터와 속성값 출력</h3>
	<%--
		EL(표현언어) : script중에 표현식을 대체할 수 있는 언어
					 ${값}
					 변수값은 표현 못함 => 속성이나 파라미터만 표현가능
	--%>
	<%-- ${test} : 영역담당 객체에 저자오딘 속성 중 이름 test인 값을 리턴
			page : pageContext
			request : request
			session : session
			application : application
		1. pageContext 객체에 등록된 속성 중 이름이 test인 속성의 값을 리턴
		2. 1번에 해당하는 속성이 없는 경우
			request 객체에 등록된 속성 중 이름이  test인 속성의 값을 리턴
		3. 2번에 해당하는 속성이 없는 경우
			session 객체에 등록된 속성 중 이름이  test인 속성의 값을 리턴
		4. 3번에 해당하는 속성이 없는 경우
			application 객체에 등록된 속성 중 이름이  test인 속성의 값을 리턴
		5. 4번에 해당하는 속성이 없는 경우
			null이 아니고 아무것도 출력하지 않음. 오류발생도 없음
			
		- 직접 영역 담당 객체를 지정하여 출력하기
			pageContext 객체의 속성 : ${pageScope.test}
			request 객체의 속성 : ${requestScope.test}
			session 객체의 속성 : ${sessionScope.test}
			application 객체의 속성 : ${applicationScope.test}
		
	 --%>
	pageContext test 속성값 : ${test}<br> <%--test이름을 가진 속성값을 가져옴 --%>
	session test 속성값 : ${sessionScope.test}<br> <%--session에있는 test --%>
	today 속성값 : ${today} <br> <%--page,request,session,application순으로 찾음  --%>
	name 파라미터 값 : ${param.name}<br> <%--파라미터값으로 받아옴 --%>
	tel 변수값 : EL로 표현 못함  <%=tel%><br> <%--변수값 직접 가져올 수 없음 --%>
	tel 속성값 : ${tel}<br>
	noAttr 속성값 : ${noAttr}<br>
	noParam 속성값 : ${param.noparam}<br><br>
	
	<h3>영역을 설정하여 test 속성값 출력</h3>
	\${test}=${test}<br>
	\${pageScope.test}=${pageScope.test}<br>
	\${requestScope.test}=${requestScope.test}<br>
	\${sessionScope.test}=${sessionScope.test}<br>
	\${applicationScope.test}=${applicationScope.test}<br>
	\${requestScope.today}=${requestScope.today}<br>
	
</body>
</html>