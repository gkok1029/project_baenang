<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/myPage.css">
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>My Page</title>
</head>
<body>
	<header>
		<div id=top>
			<div class=profile>Profile</div>
		</div>
		<div id=topbg>
            
        </div>
		<div id="topcenprowrap">
            <div id=topcenpro>
            	<%-- ${user} --%>
                <p class="profile_img"><span><img alt="${user.getM_NNAME()}" src="../resources/img/${user.getM_IMAGE()}"></span></p>
                <p class="username"><span>${user.getM_NNAME()}</span></p>
                <p class="profilemanage"><span><a href="#">프로필 관리</a></span></p>
            </div>
        </div>
	</header>
    <main>
        <div id="wrap">
            <div id="innerwrap">
                <div class="category">
                    <div id="my1" class="cursor"><span>나의 일정</span></div>
                    <div id="my2" class="cursor"><span>나의 여행 도시 목록</span></div>
                </div>


                <!--나의 일정 블럭 시작-->
                <div id="myschedulewrap">
                    <div class="myschedule">나의 일정</div>
                    <div class="myschedule2">
                        <span id="total_sche" class="cursor">전체 일정</span>
                        <span id="share_sche" class="cursor">공유 일정</span>
                        <span class="cursor">
	                        <form name="frm" action="mypage">
	                            <select name="filter" onchange="submit()">
	                                <option value="recentday" <c:if test="${param.filter=='recentday'}">selected</c:if>>최근 수정일 순</option>
	                                <option value="travelday" <c:if test="${param.filter=='travelday'}">selected</c:if>>여행 임박 순</option>
	                            </select>
	                        </form>
                            
                        </span>
                    </div>
                    <script>
                        
                        $("#total_sche").click(function(){
                            $("#section.tot_sche").show();
                            $("#section.sha_sche").hide();
                        });
                        
                        $("#share_sche").click(function(){
                            $("#section.tot_sche").hide();
                            $("#section.sha_sche").show();
                        });
                        
                        
                        
                        
                        

                    </script>
                    
                    <c:if test="${plan==null or  empty plan}">
                    <div id="noplan">저장된 일정이 없습니다</div>
					</c:if>
                    <!--전체 일정 섹션-->
                    <c:if test="${plan!=null and not empty plan}">
                    <div id="section" class="tot_sche">
                    	<!-- 여행계획 body태그 -->
                    	<c:forEach var="plan" items="${plan}">
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">${plan.p_name}</p>
                                <p>
                                    <span class="scheday"><fmt:formatDate value="${plan.dp_start}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${plan.dp_end}" pattern="yyyy-MM-dd"/></span>
                                    <span class="writeday">최근 수정일  <fmt:formatDate value="${plan.p_moddate}" pattern="yyyy-MM-dd"/></span>
                                </p>
                                <p class="schewritter">작성자: ${user.getM_NNAME()}</p>
                                <div id="hamburger" class="cursor hamburger">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                                <div id="hamburger_content" class="hamburger_content">
                                    <p>삭제</p>
                                    <p class="invite">초대</p>
                                    <p>수정</p>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <!-- 여행계획 body태그 -->
                    </div>
                    </c:if>
                    <!--전체 일정 섹션-->


                    <!--공유 일정 섹션-->
                    <div id="section" class="sha_sche" style="display: none;">
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 길동</p>
                                <div id="hamburger" class="cursor hamburger">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                                <div id="hamburger_content" class="hamburger_content">
                                    <p>삭제</p>
                                    <p class="invite">초대</p>
                                    <p>수정</p>
                                </div>
                            </div>
                        </div>
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 윤정</p>
                                <div id="hamburger" class="cursor hamburger">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                                <div id="hamburger_content" class="hamburger_content">
                                    <p>삭제</p>
                                    <p class="invite">초대</p>
                                    <p>수정</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--공유 일정 섹션-->
                    <script>
                        $(".hamburger").click(function(){
                            $(this).parent().children("#hamburger_content").toggle();
                        });


                    </script>

                </div>
                <!--나의 일정 블럭 종료-->
                
                
                
                <!--나의 여행 도시 목록 시작-->
				<div id="mycitylist" style="display: none;">
					<div class="myschedule">나의 여행 도시 목록</div>
					<div class="citywrap">
						<div>도시</div>
						<div>도시</div>
						<div>도시</div>
						<div>도시</div>
                        <div>도시</div>
						<div>도시</div>
						<div>도시</div>
						<div>도시</div>
					</div>
				</div>
				<!--나의 여행 도시 목록 종료-->
				
				<script>
                        
                    $("#my1").click(function(){
                        $("#myschedulewrap").show();
                        $("#mycitylist").hide();
                    });
                    
                    $("#my2").click(function(){
                        $("#myschedulewrap").hide();
                        $("#mycitylist").show();
                    });
                    
                </script>
            </div>
        </div>
    </main>
</body>
</html>