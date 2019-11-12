<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>EL jstl</title>
</head>
<body>
	<form method="post">
	x:<input type="text" name="x" value="${param.x}" size="5">
	<select name="f">
		<option>+</option>
		<option>-</option>
		<option>*</option>
		<option>/</option>
	</select>
	<script>
		var op = '${param.op}'
		if(op=='') 
			op = '+'
		document.f.op.value=op
	</script>
	y:<input type="text" name="y" value="${param.y}" size="5">
	<input type="submit" value="=">
	</form>
	<c:choose>
		<c:when test="${param.f=='+'}">
			 <h3>${param.x} ${param.f} ${param.y}= ${param.x+param.y}</h3>
		</c:when>
		<c:when test="${param.f=='-'}">
			 <h3>${param.x} ${param.f} ${param.y}= ${param.x-param.y}</h3>
		</c:when>
		<c:when test="${param.f=='*'}">
			 <h3>${param.x} ${param.f} ${param.y}= ${param.x*param.y}</h3>
		</c:when>
		<c:when test="${param.f=='/'}">
			 <h3>${param.x} ${param.f} ${param.y}= ${param.x/param.y}</h3>
		</c:when>
	</c:choose>
</body>
</html>