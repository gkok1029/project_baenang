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

	<%-- --------------------------- 페이지 로드 시 트렌드 관광지 출력기능 ------------------------------ --%>
	
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
				
				$('#search_content').empty();
				$('#search_content1').empty();
				$('#search_content2').empty();
				$('#search_content3').empty();
				$('#search_content4').empty();
				
				$('#search_content').append(res.title);
				$('#search_content1').append("추천2");
				$('#search_content2').append("추천3");
				$('#search_content3').append("추천4");
				$('#search_content4').append("추천5");
			},
			error:function(err){
				alert('error: '+err.status);
			}
		})
	}
	<%-- --------------------------------------------------------------------------------------- --%>	
	
	<%-- ------------------------------------- 스크롤 다운 기능 -------------------------------------- --%>	
    function scrollToTravelInfo() {
        var travelInfoSection = document.getElementById('city');
        travelInfoSection.scrollIntoView({ behavior: 'smooth' });
    }
    <%-- --------------------------------------------------------------------------------------- --%>	
	
	<%-- -------------------------- 도시사진을 누르면 해당 도시의 정보팝업창을 띄워주는 기능 ------------------------- --%>	
	function openPopup(cityId) {
	    // 팝업으로 띄울 페이지의 URL
        var popupUrl = "/city?cityId=" + cityId;

	    // 팝업 창 옵션 설정
	    var popupOption = "width=800, height=600, resizable=no, scrollbars=no, status=no;";

	    // 팝업 창 열기
	    window.open(popupUrl, "CitySearchPopup", popupOption);
	}
	<%-- --------------------------------------------------------------------------------------- --%>	
	
	<%-- ------------------------관광지 검색기능 ------------------------- --%>
	// #search-box 입력 시마다 호출되는 함수
	function onKeywordInput() {
	    var keyword = document.getElementById('search-box').value;

	    // AJAX를 사용하여 서버에 요청
	    $.ajax({
	        type: 'get',
	        //dataType: 'text',
	        url: 'msearch?keyword=' + keyword,
	        cache: false,
	        processData: true,
	        success: function (title) {
	            // 받은 결과를 dropdown에 표시
	           	//alert("반환된 값 : "+title.title);
	            //updateDropdown(title.title);
	            $("#search_content1").empty();
	            $("#search_content2").empty();
	            $("#search_content3").empty();
	            $("#search_content4").empty();
	            $("#search_content5").empty();
	            
	            $("#search_content1").append(title[0]);
	            $("#search_content2").append(title[1]);
	            $("#search_content3").append(title[2]);
	            $("#search_content4").append(title[3]);
	            $("#search_content5").append(title[4]);
	        },
	        error: function (err) {
	            console.error('Error: ' + err.status);
	        }
	    });
	}
	<%-- --------------------------------------------------------- --%>
	
</script>

<head>
    <meta charset="UTF-8">
    <title>메인페이지</title>
</head>

<body>

<%-- -------------------------------- 탑 네비게이션 -------------------------------- --%>
	<%
		// 세션을 가져옵니다
		HttpSession currentSession = request.getSession();
		
		// 사용자가 로그인했는지 확인합니다
		String userId = (String) currentSession.getAttribute("userName");
        System.out.println("'"+userId+"'님 반갑습니다~!");
    	boolean isLoggedIn = userId != null;
	%>
	<div id="navi" class="navi">
		<a href="#" onclick="scrollToTravelInfo()">여행지</a>
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
<%-- ----------------------------------------------------------------------------- --%>

<%-- ---------------------------- 검색 관련 뷰페이지 컨텐트 ---------------------------- --%>
    <div id="search-container" class="justify-content-center align-items-center">
		<div>
        	<h1>어디로 여행을 떠나시나요?</h1>
		</div>
		<div id="search_block">
	        <form action="/plan" method="GET">
	        	
        		<input type="text" id="search-box" name="keyword" placeholder="도시명을 검색해보세요."
			       class="form-control dropdown-toggle" data-toggle="dropdown" 
			       aria	-haspopup="true" aria-expanded="false" oninput="onKeywordInput()">
			    <a href="/plan"><img src="${pageContext.request.contextPath}/resources/img/main/search.png" alt="search"></a>
	            
	           	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" id="search_content1" href="#"></a>
				    <a class="dropdown-item" id="search_content2" href="#">최근 트렌드 순위 2</a>
				    <a class="dropdown-item" id="search_content3" href="#">최근 트렌드 순위 3</a>
				    <a class="dropdown-item" id="search_content4" href="#">최근 트렌드 순위 4</a>
				    <a class="dropdown-item" id="search_content5" href="#">최근 트렌드 순위 5</a>
				</div>
				
	            
	        </form>
        </div>
    </div>
<%-- ----------------------------------------------------------------------------- --%>    
<br><br>
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
    <h2>추 천 블 로 그</h2>
	<br>
	<div class="blog-con">

        <c:forEach var="imageFile" items="${imageFiles}">
            	<% 
			        for (String imageFile : imgFiles) {
			            
			            // 파일명에서 마지막 점의 위치 찾기
			            int extensionIndex = imageFile.lastIndexOf(".");
	            		
			            if (extensionIndex != -1) {
				            // 이미지 파일의 확장자 추출
				            String extension = imageFile.substring(extensionIndex + 1);
				         	// 확장자를 제외한 파일명 추출
			                String imgFileName = imageFile.substring(0, extensionIndex);
				         	
				            // 추출한 확장자 출력하기 
				            System.out.println("확장자 : " + extension);
				         	// 추출한 파일명의 확장자 제외하고 출력하기
			                System.out.println("파일명 (확장자 제외): " + imgFileName);
				        
                %>
        		<a href="<%= "/blog/get?p_id="+imgFileName %>" class="blogImg"><img src="${pageContext.request.contextPath}/resources/img/<%= imageFile %>" 
			        style="margin: 10px; width:200px; height:200px;"></a>
                <%
			            } else { //확장자가 없는 파일일때
			                System.out.println("확장자가 없는 파일입니다.");
			            }
			        }
			    %>
            
        </c:forEach>
       
	</div>
</div>
<%-- --------------------------------------------------------------- --%>
<br><br>
<%-- --------------- 특정 도시에 대한 이미지와 정보를 보여주는 팝업창으로 이동시켜주는 기능 -------------------

<!-- Add an anchor point for smooth scrolling -->
<div id="city-anchor"></div>
<div id="city">
	<h2> 지역별 여행 정보 </h2>
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
</div>

--------------------------------------------------------------------------------------- --%>
</body>
</html>