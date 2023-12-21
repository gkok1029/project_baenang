<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 모듈파일 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mapModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/viewPageModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateModalModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sideBarModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planModule.js"></script>
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- DatePicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<title>Plan Page</title>

<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${NAVER_MAPS_KEY}"></script>
<!-- 외부 CSS파일 참조  -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/planViewPage.css">

</head>
<body>

	<!-- 컨테이너  -->
	<div class="container">
		<!-- 두번째 프레임 -->
		<div id="search_frame">
			<div class="wrap-search-frame">
				<!-- Step1 날짜 확인 -->
				<div class="view" id="view1" >
					<div class="warp-view">
						<b>제주</b>	
					</div>
					<div>
						<div><b>2023.12.18(월) - 2023.12.20(수)</b></div>
						<div>
							<button type="button" class="btn-calender" data-toggle="modal" data-target="#calendarModal">
	        					<i class="far fa-calendar-days"></i>
	    					</button>
	    				</div>
					</div>
					<div>
						<a href="https://www.skyscanner.co.kr/transport/flights/sela/cju/231218/231220/?adultsv2=1&cabinclass=economy&childrenv2=&inboundaltsenabled=false&outboundaltsenabled=false&preferdirects=false&ref=home&rtn=1">
							<button>항공권</button>
						</a>
					</div>
					<div>
						입력하신 여행기간이 시차를고려한 등등 대충 내용 적기
					</div>
					<div>
						<table>
							<tr>
								<td>일지</td>
								<td>요일</td>
								<td>시작시간</td>
								<td>종료시간</td>
							</tr>
							<tr>
								<td>12/18</td>
								<td>월</td>
								<td>오전 10:00</td>
								<td>오후 10:00</td>
							</tr>
							<tr>
								<td>12/19</td>
								<td>화</td>
								<td>오전 10:00</td>
								<td>오후 10:00</td>
							</tr>
							<tr>
								<td>12/20</td>
								<td>수</td>
								<td>오전 10:00</td>
								<td>오후 10:00</td>
							</tr>
						</table>
					</div>				
					<div>
						<button>시간 설정 완료</button>
					</div>
				</div>
				
				<!-- Step2 장소확인 --> 
				<div class="view" id="view2">
					<div>
						<div>
						<div><b>제주</b></div>				
						<div>
							<div><b>2023.12.04 - 2023.12.05</b></div>
							<div>
								<button type="button" class="btn-calender" data-toggle="modal" data-target="#calendarModal">
								<i class="far fa-calendar-days"></i>
	    						</button>
	    					</div>
						</div>
					</div>
					<button id="">여행장소선택</button>
					<button id="">새로운 장소 등록</button>
					<input type="text"  placeholder="내용을 입력하세요" onkeydown="handleEnterKey(event)"></input>				
					<div class="btns_cat">
						<button id="recomend">추천</button>
						<button id="" onclick="PlanModule.removeDiv()">명소</button>
						<button id="">식당</button>
						<button id="">카페</button>
					</div>
					<!-- 장소검색 -->
					<div class="places" id="places">
						<!-- <ul>
							장소 하나하나
							<li>
								<div class="place-container">
									이미지
									<div><img class="place-img" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzExMTRfMzYg%2FMDAxNjk5OTY4OTc2Mzk2.bYxC69S-RhRfWsVazjOSlsj23s3MOwMwJud2pUM2_Fwg.JK9kuLGKJXE2yslbx3Z_9qnrzriouNd0sH0v3acREkUg.JPEG.okayall%2F20231110_163451.jpg&type=sc960_832"></div>
									내용
									<div class="place-details">
										<div>이름</div>
										<div class="place-info">
											<div>카테고리</div>
											<div>주소</div>
										</div>
										<div class="place-icons">
											<div>하트</div>
											<div>별</div>
										</div>
									</div>
									<div><i class="fa-regular fa-square-plus"></i></div>
								</div>							
							</li>
						</ul> -->
					</div>
					</div>					
				</div>
				
				<!-- STEP 3 숙소설정 -->
				<div class="view view-step3" id="view3">
					<div>
						<div>
						<div><b>제주</b></div>				
						<div>
							<div><b>2023.12.04 - 2023.12.05</b></div>						
						</div>
					</div>
					<button>숙소 설정</button>
					<button>신규 숙소 등록</button>
					<input type="text"  placeholder="숙소명을 입력하세요"></input>				
					<div class="btns_cat">
						<button>추천 숙소</button>					
					</div>
					<!-- 장소검색 -->
					<div class="hotels">
						<ul>
							<!-- 장소 하나하나 -->
							<li>
								<div class="hotel-container">
									<!-- 이미지 -->
									<div>
										<img class="hotel-img" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzExMTRfMzYg%2FMDAxNjk5OTY4OTc2Mzk2.bYxC69S-RhRfWsVazjOSlsj23s3MOwMwJud2pUM2_Fwg.JK9kuLGKJXE2yslbx3Z_9qnrzriouNd0sH0v3acREkUg.JPEG.okayall%2F20231110_163451.jpg&type=sc960_832">
									</div>
									<!-- 내용 -->
									<div class="hotel-details">
										<div>호텔이름</div>
											<div class="hotel-info">
												<div>숙소</div>
												<div>
													<a href="https://www.booking.com/searchresults.ko-gb.html?aid=8071577&lang=ko&lang_changed=1&sb=1&dest_type=hotel&selected_currency=KRW&sid=8d1dd704915dad29b671b8e421e6dfb6&ss=Taichung%20%EB%8D%94%20%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C%20%ED%98%B8%ED%85%94(The%20Cloud%20Hotel)">
														예약하기
													</a>
												</div>
											</div>
											<div class="hotel-icons">
												<div>하트</div>
												<div>별</div>
											</div>
										</div>
										<div><i class="fa-regular fa-square-plus"></i></div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="basket-frame">
					<div class="basket-container">
						<div>
							<div>
								<div>
									<div>
										<div>갯수</div>
										<div>시간</div>
									</div>
									
									<div>
										<button>장소 설정 초기화</button>
									</div>
								</div>
							</div>
							<div>
								<div class="places">
									<div class="place">
										<div>숫자</div>
										<div>
											<div>이미지</div>
											<div id="place-info">
												<div>이름</div>
												<div>
													<div>카테고리</div>
													<div>주소</div>
												</div>
											</div>
											<div>
												머무는시간
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div>
							<button>토글버튼</button>
						</div>
					</div>
				</div>
			</div><!-- wrap-search-frame -->
		</div><!-- Search frame -->
			
		<!-- 지도 -->
		<div id="map" style="flex: 1;"></div>
		
	</div>
	    <!-- calendarModal -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
  		<div class="modal-dialog" role="document">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="calendarModalLabel">날짜 선택</h5>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          				<span aria-hidden="true">&times;</span>
        				</button>
      			</div>
      			<div class="modal-body">
        			<!-- 출발 날짜 -->
        			<div class="form-group">
          				<label for="startDate">출발 날짜</label>
          				<input type="text" id="startDate" class="form-control" placeholder="날짜 선택">
        			</div>
        			<!-- 도착 날짜 -->
        			<div class="form-group">
          				<label for="endDate">도착 날짜</label>
          				<input type="text" id="endDate" class="form-control" placeholder="날짜 선택">
        			</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal">저장</button>
      			</div>
    		</div>
  		</div>
	</div>

<script>
	    
	    $(document).ready(function(){
	    	
	    	SidebarModule.initialize();
			MapModule.initializeMap();
			ViewPageModule.showView('#view1', '#btn-step1');
			DateModalModule.initializeDateModal();
			
			//프레임 감추기
			$(".basket-frame").hide();
			
    	});
	    $('.btn btn-primary').click(function(){
	    	DateModalModule.saveDates();
	    });
    	
	</script>
	<!-- Bootstrap JS (must be placed at the end of the body for faster page loading) -->    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>    

</body>
<script>
	

	//맵모듈
	function handleEnterKey(event) {
		if (event.key === "Enter") {
			submitForm(); // 엔터 키를 눌렀을 때 submitForm 함수 호출
		}
	}

	// 폼 제출 함수
	function submitForm() {
		// 여기에 입력값을 처리하는 코드를 추가하면 됩니다.
		var inputValue = document.querySelector('input[type="text"]').value;
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'search?addr=' + inputValue,
			cache : false,
			processData : true,
			success : function(res) {
				MapModule.moveMap(res.x, res.y);
				PlanModule.tour(res.x, res.y);
				lodging(res.x,res.y);
				alert('투어로 간다');
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})

	}
	
	
	function lodging(lat, len) {
		var x = lat;
		var y = len;
		var ctype="32";

		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'tour?x=' + x + '&y=' + y + '&ctype=' +ctype,
			cache : false,
			processData : true,
			success : function(res) {
				
				//displayLodgingInformation(res.contentList);
				

			},
			error : function(err) {
				alert('error: ' + err.status);
			}
		})
	}
	
</script>
</html>