<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
	<!-- /jspstudy2 (url정보들을 가지고있음) 절대경로로 설정-->
<!DOCTYPE html>
<html lang="en">
<title><decorator:title/></title>
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
	
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
html,body,h1,h2,h3,h4,h5,h6 {font-family: 'Jeju Gothic', serif;}
a{text-decoration:none;}
.w3-sidebar {
  z-index: 3;
  width: 250px;
  top: 43px;
  bottom: 0;
  height: inherit;
}
</style>
	<decorator:head/>
<body>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-theme w3-top w3-right-align w3-large">

	<a class="w3-opacity w3-bar-item w3-button w3-left w3-hide-large w3-hover-white w3-large w3-theme-l1" href="javascript:void(0)" onclick="w3_open()"><i class="fa fa-bars"></i></a>
<%--    <a href="#" class="w3-bar-item w3-button w3-theme-l1">Logo</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hover-white">About</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Values</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hover-white">News</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hover-white">Contact</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hide-medium w3-hover-white">Clients</a>
    <a href="#" class="w3-bar-item w3-button w3-hide-small w3-hide-medium w3-hover-white">Partners</a>
--%>
	<c:if test="${empty sessionSope.login }">
		<a href="${path }/model2/member/loginForm.me" >sign-in</a>
		<a href="${path }/model2/member/joinForm.me">sign-up</a>
	</c:if> 
	<c:if test="${!empty sessionSope.login}">
		${login }님이 로그인 하셨습니다.&nbsp;
		<a href="${path }/model2/member/logout.me" >로그아웃</a>
	</c:if>
  </div>
</div> 

<!-- Sidebar -->
<nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
    <i class="fa fa-remove"></i>
  </a>
  <h4 class="w3-bar-item"><b>Menu</b></h4>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/model2/member/main.me">회원관리</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/model2/board/list.do">게시판</a>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main" style="margin-left:250px">

  <div class="w3-row w3-padding-64">
    <div class="w3-twothird w3-container" style="width:100%; height:100%">
      <decorator:body />
    </div>
<%--
	<div class="w3-third w3-container">
      <p class="w3-border w3-padding-large w3-padding-32 w3-center">AD</p>
      <p class="w3-border w3-padding-large w3-padding-64 w3-center">AD</p>
    </div>
--%>
  </div>

  <footer id="myFooter"> 
    <div class="w3-container w3-theme-l2 w3-padding-10" style="">
      <h4>구디아카데미 Since 2016</h4>
    </div>

    <div class="w3-container w3-theme-l1">
      <p>Powered by <a href="http://www.gdu.co.kr/main/main.html" target="_blank">전서현</a></p>
    </div>
  </footer>

<!-- END MAIN -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

</body>
</html>
