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
    	<%-- 사용자가 로그인한 경우 적절한 링크를 보여줍니다 --%>
    
    <div id="topR">
	    <ul class="nav">
	    	<li><a href="/user/main">홈</a></li>
	    	<li><a href="/blog/bloghub">블로그</a></li>
	    	<% if (isLoggedIn) { %>
	    	<li><a href="/user/mypage">마이페이지</a></li>
	    	<li><a href="/logout">로그아웃</a></li>
	    	<% } else { %>
	    	<li><a href="/login">로그인</a></li>
	    	<% } %>
	    </ul>
	</div>	
	<%-- ----------------------------------------------------------------------------- --%>
</header>