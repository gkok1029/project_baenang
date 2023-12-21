<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>
<html>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 외부 CSS 파일 참조 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>

	$(document).ready(function() {
	    // 페이지 로드 시 초기 추천 기능 실행
	    rec();
	});
	
	function rec(){
		$.ajax({
			type:'get',
			dataType:'json',
			url:'rec',
			cache:false,
			processData:true,
			success:function(res){
				alert("최근 트렌드 관광지 추천 : "+res.title);
				$('#recommand').append(res.title);
			},
			error:function(err){
				alert('error: '+err.status);
			}
		})
	}
	
	function openPopup(cityId) {
	    // 팝업으로 띄울 페이지의 URL
        var popupUrl = "/city?cityId=" + cityId;

	    // 팝업 창 옵션 설정
	    var popupOption = "width=800, height=600, resizable=no, scrollbars=no, status=no;";

	    // 팝업 창 열기
	    window.open(popupUrl, "CitySearchPopup", popupOption);
	}
</script>



<head>
    <meta charset="UTF-8">
    <title>메인페이지</title>
</head>

<body>

	<%
		// 세션을 가져옵니다
		HttpSession currentSession = request.getSession();
		
		// 사용자가 로그인했는지 확인합니다
		String userId = (String) currentSession.getAttribute("userName");
		System.out.println("'"+userId+"'님 반갑습니다~!");
    	boolean isLoggedIn = userId != null;
	%>

	<div id="navi" class="navi">
		<a href="#">여행지</a>
		<a href="/blog/bloghub">블로그</a><!-- 블로그페이지 허브로 이동 -->
		<a href="/plan">스케쥴</a><!-- 여행계획페이지 일정선택으로 이동 -->
    <%-- 사용자가 로그인한 경우 적절한 링크를 보여줍니다 --%>
    <% if (isLoggedIn) { %>
    	<a href="/user/mypage">마이페이지</a>
        <a href="/logout">로그아웃</a>
    <% } else { %>
        <a href="/login">로그인</a>
    <% } %>

	</div>
	
	<div class="navi">
		<a href="../">Home</a>
		<a href="../dbbutton">DBDownload</a>

	</div>

    <div id="search-container" class="justify-content-center align-items-center">
		<div>
        	<h1>어디로 여행을 떠나시나요?</h1>
		</div>
		<div>
	        <form action="search.jsp" method="GET">
	        		<input type="text" id="search-box" name="keyword" placeholder="도시명을 검색해보세요."
				       class="form-control dropdown-toggle" data-toggle="dropdown" 
				       aria-haspopup="true" aria-expanded="false">
	            
	           	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" href="#" id="recommand"></a>
				    <a class="dropdown-item" href="#">최근 트렌드 순위 2</a>
				    <a class="dropdown-item" href="#">최근 트렌드 순위 3</a>
				    <a class="dropdown-item" href="#">최근 트렌드 순위 4</a>
				    <a class="dropdown-item" href="#">최근 트렌드 순위 5</a>
				</div>
	            
	            <button type="submit" id="search-button">검색</button>
	        </form>
        </div>
    </div>

<%-- --------------- 블로그 썸네일을 가져와 보여주는 기능 ------------------- --%>
<%
    // 이미지 파일이 있는 폴더 경로
    String imgFolderPath = getServletContext().getRealPath("/resources/img");
    
    // 폴더 내의 파일 목록을 가져옴
    File imgFolder = new File(imgFolderPath);
    String[] imgFiles = imgFolder.list();
    
    // 이미지 파일 목록을 JSP 페이지로 전달
    request.setAttribute("imageFiles", imgFiles);
%>

<div id="blog-container">
    <p>블 로 그</p>
	
	<div class="blog-con">

        <c:forEach var="imageFile" items="${imageFiles}">
            
            	<% 
			        for (String imageFile : imgFiles) {
			    %>
			        <a href="#" id="item"><img src="${pageContext.request.contextPath}/resources/img/<%= imageFile %>"></a>
			    <% 
			        }
			    %>
            
        </c:forEach>
       
	</div>
</div>

<%-- --------------------------------------------------------------- --%>

<%-- --------------- 특정 도시에 대한 이미지와 정보를 보여주는 팝업창으로 이동시켜주는 기 ------------------- --%>
<div>
    <a href="#" id="Seoul" name="Seoul" class="city" onclick="openPopup('Seoul')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Seoul.png" alt="Seoul Image">
	</a>
	<a href="#" id="Busan" name="Busan" class="city" onclick="openPopup('Busan')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Busan.png" alt="Seoul Image">
	</a>
	<a href="#" id="Daejeon" name="Daejeon" class="city" onclick="openPopup('Daejeon')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Daejeon.png" alt="Seoul Image">
	</a>
	<a href="#" id="Incheon" name="Incheon" class="city" onclick="openPopup('Incheon')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Incheon.png" alt="Seoul Image">
	</a>
	<a href="#" id="Gwangju" name="Gwangju" class="city" onclick="openPopup('Gwangju')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Gwangju.png" alt="Seoul Image">
	</a>
	<a href="#" id="Gangwon" name="Gangwon" class="city" onclick="openPopup('Gangwon')">
    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Gangwon.png" alt="Seoul Image">
	</a>
</div>
<%-- --------------------------------------------------------------------------------------- --%>
</body>
</html>