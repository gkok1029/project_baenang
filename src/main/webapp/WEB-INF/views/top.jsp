<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="../resources/css/top.css">
<header id=top>
	<div id="topL">
		<a href="/user/main"><img alt="LOGO" src="../resources/img/LOGO.png"></a>
	</div>
	<%-- -------------------------------- 탑 네비게이션 -------------------------------- --%>
	<%

		// 세션을 가져옵니다
		HttpSession currentSession = request.getSession();
		
		// 사용자가 로그인했는지 확인합니다
		String userId = (String) currentSession.getAttribute("userName");
    	boolean isLoggedIn = userId != null;
	%>
	<div id="navi" class="navi">
		<ul>
			<li class="navbar1"><a href="#">여행지</a></li>
			<li class="navbar2"><a href="/blog/bloghub">블로그</a><!-- 블로그페이지 허브로 이동 --></li>
			<li class="navbar3"><a href="/plan">스케쥴</a><!-- 여행계획페이지 일정선택으로 이동 --></li>
		</ul>
    	<%-- 사용자가 로그인한 경우 적절한 링크를 보여줍니다 --%>
	</div>
    
    <div id="topR">
    <% if (isLoggedIn) { %>
    	<a href="/user/mypage">마이페이지</a>
        <a href="/logout">로그아웃</a>
    <% } else { %>
        <a href="/login">로그인</a>
    <% } %>
    </div>
	<%-- ----------------------------------------------------------------------------- --%>
</header>