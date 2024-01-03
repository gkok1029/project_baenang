<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/myPage.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<style>
#myschedulewrap {
	width: 100%;
	height: 700px; /* 스크롤 영역의 높이 설정 */
	overflow-y: auto; /* 세로 스크롤이 발생하도록 설정 */
	padding-right: 100px;
}
</style>
<title>마이 페이지</title>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div id=topbg></div>
	<header>
		<div id="topcenprowrap">
			<div id=topcenpro>
				<p class="profile_img">
					<span><img alt="${user.getM_NNAME()}"
						src="/resources/profile/${user.getM_IMAGE()}"></span>
				</p>
				<p class="username">
					<span>${user.getM_NNAME()}</span>
				</p>
				<p class="profilemanage">
					<span><a href="/user/mypageinfo">프로필 관리</a></span>
				</p>
			</div>
		</div>
	</header>
	<main>
		<div id="wrap">
			<div id="innerwrap">
				<div class="category">
				</div>
				<div id="myschedulewrap">
					<div class="myschedule">나의 일정</div>
					<div class="myschedule2">
						<span id="total_sche" class="cursor">전체 일정</span> <span
							class="cursor">
							<form name="frm" action="mypage">
								<input type="hidden" name="mode" id="mode" value="up"> <select
									id="filter" name="filter" onchange="submit()">
									<option id="recentday" value="recentday1"
										<c:if test="${param.filter=='recentday1' or param.filter=='recentday2'}">selected</c:if>>최근
										수정일 순</option>
									<option id="travelday" value="travelday1"
										<c:if test="${param.filter=='travelday1' or param.filter=='travelday2'}">selected</c:if>>여행
										임박 순</option>
								</select> <span id="updown" title="${param.mode}"
									style="padding-left: 5px;">&#8597</span>
							</form>
						</span>
					</div>
					<c:if test="${plan==null or  empty plan}">
						<div id="noplan">저장된 일정이 없습니다</div>
					</c:if>
					<c:if test="${plan!=null and not empty plan}">
						<div id="section" class="tot_sche">
							<c:forEach var="plan" items="${plan}">
								<div id="schedule">
									<div class="schedule_img"><img src="${plan.firstimage}" style="width :100%; height :174px;"></div>
									<div class="schedule_content">
										<p>
											<span class="d_day">D-day</span><span class="tripname">여행지
												이름</span>
										</p>
										<p class="schename">${plan.p_name}</p>
										<p>
											<span class="scheday"><fmt:formatDate
													value="${plan.dp_start}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
													value="${plan.dp_end}" pattern="yyyy-MM-dd" /></span> <span
												class="writeday">최근 수정일 <fmt:formatDate
													value="${plan.p_moddate}" pattern="yyyy-MM-dd" /></span>
										</p>
										<p class="schewritter">작성자: ${user.getM_NNAME()}</p>
										<div id="hamburger" class="cursor hamburger">
											<span></span><span></span><span></span>
										</div>
										<div id="hamburger_content" class="hamburger_content">
											<form action="/user/delplan" id="delF${plan.p_id}"
												name="delF">
												<input type="hidden" name="p_id" value="${plan.p_id}" />
												<p class="del">삭제</p>
											</form>
											<form action="/user/upplan" id="upF${plan.p_id}" name="upF">
												<input type="hidden" name="p_id" value="${plan.p_id}" />
												<p class="upplan" data-plan="${plan.p_id}">보기</p>
											</form>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
					<script type="text/javascript">
						$('.del').click(
								function() {
									let formId = $(this).closest('#schedule')
											.find('form').attr('id'); // 클릭한 삭제 버튼이 속한 폼의 ID 가져오기
									let x = confirm('정말 삭제 하시겠습니까?');
									if (x == true) {
										$('#' + formId).submit(); // 해당 폼 전송
									}
								});

						$('.upplan').click(function() {
							let pid = $(this).data('plan');
							$('#upF' + pid).submit();
						});

						$(".hamburger").click(
								function() {
									$(this).parent().children(
											"#hamburger_content").toggle();
								});
					</script>
				</div>
				<script>
					$('#updown').click(function(e) {
						let updown = $(this).attr('title');
						//alert(updown);
						if (updown == '' || updown == 'up') {
							$('#recentday').val('recentday2');
							$('#travelday').val('travelday2');
							$(this).attr('title', 'down');
							$('#mode').val('down');
						} else {
							$('#recentday').val('recentday1');
							$('#travelday').val('travelday1');
							$(this).attr('title', 'up');
							$('#mode').val('up');
						}
						;
						frm.submit();
					});

					$("#total_sche").click(function() {
						$("#section.tot_sche").show();
						$("#section.sha_sche").hide();
					});

					$("#share_sche").click(function() {
						$("#section.tot_sche").hide();
						$("#section.sha_sche").show();
					});
				</script>
				<script>
					$("#my1").click(function() {
						$("#myschedulewrap").show();
						$("#mycitylist").hide();
					});

					$("#my2").click(function() {
						$("#myschedulewrap").hide();
						$("#mycitylist").show();
					});
				</script>
			</div>
		</div>
	</main>
</body>
</html>