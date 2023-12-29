<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.bn.model.*" %>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 외부 CSS 파일 참조 -->
<link href="/resources/css/main.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
<script>

function dummy(){
	var contentid='129854';
	var url = "/tourInfo?contentid="+contentid;
	// 새 창에서 tourInfo.jsp를 팝업으로 열기
    window.open(url, "TourInfoPopup", "width=800, height=600, resizable=yes, scrollbars=yes");
}

<%-- ------------------------관광도시 검색 자동완성기능 ------------------------- --%>

// 검색 결과를 클릭했을 때 실행되는 함수
function onSearchResultClick(cityName) {
    // 동적으로 URL을 생성하고 요청을 보냄
    var url = "/plan?search=" + cityName;
    window.location.href = url;
}

// AJAX를 사용하여 검색어에 따른 결과를 가져오는 함수
function onKeywordInput() {
    var keyword = document.getElementById('search-box').value;

    // AJAX를 사용하여 서버에 요청
    $.ajax({
        type: 'get',
        url: 'msearch?keyword=' + keyword,
        cache: false,
        processData: true,
        success: function (cityNameList) {
            // 받은 결과를 dropdown에 표시
            for (var i = 0; i < cityNameList.length; i++) {
                // cityNameList[i]가 null이면 빈 문자열로 처리
                var cityName = cityNameList[i] !== null ? cityNameList[i] : '';

                // 기존 a 태그의 onclick 속성 제거
                $("#search_content" + (i + 1)).removeAttr('onclick');

                // 동적으로 생성된 a 태그에 클릭 이벤트 추가
                var dropdownItem = '<a class="dropdown-item" href="#" onclick="openPopup(\'' + cityName + '\')">' + cityName + '</a>';

                // 해당 id의 엘리먼트를 찾아 내용을 변경
                $("#search_content" + (i + 1)).empty().append(dropdownItem);
            }
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

<%-- <jsp:include page="/WEB-INF/views/top.jsp" />  --%>

<%-- -------------------------------- 탑 네비게이션 ------------------------------ --%>
	<%
		// 세션을 가져옵니다
		HttpSession ses = request.getSession();
		
		// 사용자가 로그인했는지 확인합니다
		String userId = (String) ses.getAttribute("userName");
        System.out.println("'"+userId+"'님 반갑습니다~!");
    	boolean isLoggedIn = userId != null;
	%>
	<div id="navi" class="navi">
		<a href="/dbbutton">dbdown</a>
		<button onclick="dummy()">call of dummy</button>
		<a href="/main">홈</a>
		<a href="/blog/bloghub">블로그</a><!-- 블로그페이지 허브로 이동 -->
		<a href="#" onclick="scrollToTravelInfo()">여행지</a>
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
	        	
        		<input type="text" id="search-box" name="search" placeholder="도시명을 검색해 주세요."
			       class="form-control dropdown-toggle" data-toggle="dropdown" 
			       aria	-haspopup="true" aria-expanded="false" oninput="onKeywordInput()">
			    <a href="/plan"><img src="${pageContext.request.contextPath}/resources/img/main/search.png" alt="search"></a>
	            
	           	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" id="search_content1" onclick="openPopup('서울')"><img alt="SeoulIMG" src="${pageContext.request.contextPath}/resources/img/cities/Seoul.png"> 서울 </a>
				    <a class="dropdown-item" id="search_content2" onclick="openPopup('대전')"><img alt="DaejeonIMG" src="${pageContext.request.contextPath}/resources/img/cities/Daejeon.png"> 대전 </a>
				    <a class="dropdown-item" id="search_content3" onclick="openPopup('제주')"><img alt="JejuIMG" src="${pageContext.request.contextPath}/resources/img/cities/Jeju.png"> 제주 </a>
				    <a class="dropdown-item" id="search_content4" onclick="openPopup('강릉')"><img alt="GangneungIMG" src="${pageContext.request.contextPath}/resources/img/cities/Gangneung.png"> 강릉 </a>
				    <a class="dropdown-item" id="search_content5" onclick="openPopup('부산')"><img alt="BusanIMG" src="${pageContext.request.contextPath}/resources/img/cities/Busan.png"> 부산 </a>
				</div>
	            
	        </form>
        </div>
    </div>
<%-- ----------------------------------------------------------------------------- --%>    

<br><br>

<%-- --------------- 블로그 썸네일을 가져와 보여주는 기능 ------------------- --%>
<%
    // 이미지 파일이 있는 폴더 경로
    String imgFolderPath = getServletContext().getRealPath("/resources/img/blog");
    
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
				            //System.out.println("확장자 : " + extension);
				         	// 추출한 파일명의 확장자 제외하고 출력하기
			                //System.out.println("파일명 (확장자 제외): " + imgFileName);
				        
                %>
        		<a href="<%= "/blog/get?p_id="+imgFileName %>" class="blogImg"><img src="${pageContext.request.contextPath}/resources/img/blog/<%= imageFile %>" 
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

<!-- ---------------------- 블로그 포스팅 카드 리스팅 ------------------------ -->
<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<c:forEach items="${posts}" var="post">
					<div class="col mb-5">
						<div class="card h-100">
							<a href='/blog/get?p_id=${post.p_id}' > <img
								class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
							<div class="card-body p-4">
								<div class="text-center">
									<h5 class="fw-bolder">
										<c:out value="${post.p_title}" />
									</h5>
									<c:out value="${post.m_id}" />
								</div>
							</div>
							<!-- Product actions-->
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
									<a class="btn btn-outline-dark mt-auto" href="#">View
										options</a>
								</div>
							</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

<link href="/resources/css/styles.css" rel="stylesheet" />

<!-- ---------------------------------------------------------------------- -->

<script>
	<%-- ------------------------------------- 스크롤 다운 기능 -------------------------------------- --%>
    function scrollToTravelInfo() {
        var travelInfoSection = document.getElementById('city');
        travelInfoSection.scrollIntoView({ behavior: 'smooth' });
    }
    <%-- --------------------------------------------------------------------------------------- --%>	

	<%-- --------------------- 도시사진을 누르면 해당 도시의 정보팝업창을 띄워주는 기능 ---------------------- --%>	
	function openPopup(cityname) {
	    // 팝업창이 뜨면서 기존페이지의 스크롤이 맨 위로 이동하는 현상을 방지 
	    event.preventDefault();
		
		// 팝업으로 띄울 페이지의 URL
        var popupUrl = "/cityInfo?cityname=" + cityname;

	    // 팝업 창 열기
	    window.open(popupUrl, "CityInfoPopup", "width=800, height=600, resizable=yes, scrollbars=no");
	}
	
	<%-- --------------------------------------------------------------------------------------- --%>	
</script>

<%-- ---------------------------- 특정 도시에 대한 이미지를 출력 --------------------------------- --%>

<!-- Add an anchor point for smooth scrolling -->
<div id="city-anchor"></div>
<div id="city">
    <h2> 지역별 여행 정보 </h2>
    <div>
        <%-- Assuming you have a method to retrieve city data from Oracle DB --%>
        <c:forEach var="city" items="${cvo}" varStatus="loop">
            <c:if test="${loop.index < 30}">
                <a href="#" id="${city.cityname}" name="${city.cityname}" class="city" onclick="openPopup('${city.cityname}')">
                    <img class="citiesImg" src="${city.c_image}" alt="${city.cityname} Image">
                </a>
            </c:if>
        </c:forEach>
    </div>
</div>

<%-- --------------------------------------------------------------------------------------- --%>

<%-- ---------------------------- 특정 도시에 대한 이미지를 출력 --------------------------------- 

<!-- Add an anchor point for smooth scrolling -->
<div id="city-anchor"></div>
<div id="city">
	<h2> 지역별 여행 정보 </h2>
	<div>
		<!-- CITY 테이블의 image(파일경로), overview(개요) 컬럼이 추가된 뒤 <img src="{image}">로 수정
		+ a태그의 id, name 수정하기 + 랜덤 and 갯수지정 후 출력하기 -->
	    <a href="#" id="Seoul" name="Seoul" class="city" onclick="openPopup('서울')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Seoul.png" alt="Seoul Image">
		</a>
		<a href="#" id="Busan" name="Busan" class="city" onclick="openPopup('부산')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Busan.png" alt="Seoul Image">
		</a>
		<a href="#" id="Daejeon" name="Daejeon" class="city" onclick="openPopup('대전')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Daejeon.png" alt="Seoul Image">
		</a>
		<a href="#" id="Incheon" name="Incheon" class="city" onclick="openPopup('인천')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Incheon.png" alt="Seoul Image">
		</a>
		<a href="#" id="Gwangju" name="Gwangju" class="city" onclick="openPopup('광주')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Gwangju.png" alt="Seoul Image">
		</a>
		<a href="#" id="Gangneung" name="Gangneung" class="city" onclick="openPopup('강릉')">
	    	<img class="citiesImg" src="${pageContext.request.contextPath}/resources/img/cities/Gangneung.png" alt="Seoul Image">
		</a>
	</div>
</div>

 --------------------------------------------------------------------------------------- --%>

	<%-- --------------------------- 페이지 로드 시 트렌드 관광지 출력기능 ------------------------------ 
	
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
	--------------------------------------------------------------------------------------- --%>	

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />

</body>
</html>