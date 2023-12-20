<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 모듈파일 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mapModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/viewStyleModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateModalModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sideBarModule.js"></script>
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

<script type="text/javascript">
    // 지도 초기화 함수
    function initializeMap() {
        var mapOptions = {
            center: new naver.maps.LatLng(37.3595704, 127.105399),
            zoom: 10
        };

        var map = new naver.maps.Map('map', mapOptions);
        
        // 페이지 크기 변경시 지도 크기 조절
        function resizeMap() {
            var page = getCurrentPageSize();
            var height = page.height;
            var width = page.width;
            
            map.setSize(new naver.maps.Size(width, height));
            
        }

        // 초기화 후 지도 크기 조절
        resizeMap();

        // 윈도우 리사이즈 이벤트에 리사이즈 함수 연결
        window.addEventListener('resize', resizeMap);
    }
	//페이지 사이즈 얻는 함수
    function getCurrentPageSize() {
        var width = window.innerWidth ||
                    document.documentElement.clientWidth ||
                    document.body.clientWidth;

        var height = window.innerHeight ||
                    document.documentElement.clientHeight ||
                    document.body.clientHeight;

        return { width: width, height: height };
    }
</script>
<style type="text/css">
	body{
		height: 100%;
		width: 100%;
		margin: 0;
		padding:0;
	}
    .container {
        display: flex;
        margin:0;
        padding:0;
        width: 100%;
        height: 100%;
        max-width:2400px;        
    }
	#sidebar {
		height: 100vh;
		width: 100px;
		background-color: white;
        color: skyblue;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 20px;
        padding-right: 10px;
	}
	
	.logo {
		margin-bottom: 20px;
        width: 150px; /* 로고 크기 조절 */
	}

	.sidebar_button {
		width: 100%;
		border: 100px solid skyblue;
		border-radius:5px;
		padding: 10px;
		margin-bottom: 10px;
		background-color: white;
		font-weight:bold;
		text-align: center;
		text-decoration: none;
		border: none;
		cursor: pointer;
	}

	.bottom-button {
	     margin-top: auto;
	     margin-bottom:10px;
	     width: 80%;
	     padding: 10px;
	     background-color: #555;
	     color: #fff;
	     text-align: center;
	     text-decoration: none;
	     border: none;
	     cursor: pointer;
	}
	#search_frame{
		margin-right: 10px;
		width: 300px;
	}	
	table{
		width:100%;
	}
	th, td{
		border:1px solid;
		text-align: center;
	}
	li{
		list-style:none;
	}
	.place-container {
        display: flex;
        justify-content: space-between; /* 각 자식 요소를 최대한 넓게 배치합니다. */
        align-items: center; /* 자식 요소를 수직 중앙 정렬합니다. */
        margin-bottom: 20px; /* 각 place-container 사이에 간격을 주기 위한 마진 설정 */
    }
	.place-img{
		width: 60px;
		height: 60px
	}
	.place-details {
        flex: 1;
        margin-left: 10px;        
        flex-direction: column; /* 세로로 배치하도록 설정 */
        font-size: 13px;
    }

    .place-details > div {
        margin-bottom: 5px;
    }
    
    .place-info{
    	display:flex;	
    }
    
    .place-icons{
    	display: flex;
    	align-items: center;
    }
    .place-icons>div{
    	margin-rigth: 5px;
    }
    
    .places {
		width: 300px; /* 원하는 가로 크기 지정 */
		height: 621px; /* 원하는 세로 크기 지정 */
		overflow-y: auto; /* 세로 스크롤바 활성화 */
		padding: 10px; /* 내용과 테두리 사이의 간격 */
	}
	
	.hotel-container {
        display: flex;
        justify-content: space-between; /* 각 자식 요소를 최대한 넓게 배치합니다. */
        align-items: center; /* 자식 요소를 수직 중앙 정렬합니다. */
        margin-bottom: 20px; /* 각 place-container 사이에 간격을 주기 위한 마진 설정 */
    }
	.hotel-img{
		width: 60px;
		height: 60px
	}
	.hotel-details {
        flex: 1;
        margin-left: 10px;        
        flex-direction: column; /* 세로로 배치하도록 설정 */
        font-size: 13px;
    }

    .hotel-details > div {
        margin-bottom: 5px;
    }
    
    .hotel-info{
    	display:flex;    	
    }
    
    .hotel-icons{
    	display: flex;
    	align-items: center;
    }
    .hotel-icons>div{
    	margin-rigth: 5px;
    }
    
    .hotels {
		width: 300px; /* 원하는 가로 크기 지정 */
		height: 621px; /* 원하는 세로 크기 지정 */
		overflow-y: auto; /* 세로 스크롤바 활성화 */
		padding: 10px; /* 내용과 테두리 사이의 간격 */
	}
	.modal{
		position:absolute;
		width:100%; height:100%;
		background: white;
		top:0; left:0;
		display:none;
	}
	.wrap-search-frame{
		height: 100%;
		width: 100%;
		display: flex;
	}
	.add-frame{
		width: 300px;
	}
	 
    
</style>

</head>
<body>
	
		<script>
		var p_id="1";
		var m_id="1";
		var p_name="나는 바보야";
		var p_birth="2023-01-01";
		var p_moddate="2023-01-01";	
		</script>
	

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
					<button>여행장소선택</button>
					<button>새로운 장소 등록</button>
					<input type="text"  placeholder="내용을 입력하세요"></input>				
					<div class="btns_cat">
						<button>추천</button>
						<button>명소</button>
						<button>식당</button>
						<button>카페</button>
					</div>
					<!-- 장소검색 -->
					<div class="places">
						<ul>
							<!-- 장소 하나하나 -->
							<li>
								<div class="place-container">
									<!-- 이미지 -->
									<div><img class="place-img" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzExMTRfMzYg%2FMDAxNjk5OTY4OTc2Mzk2.bYxC69S-RhRfWsVazjOSlsj23s3MOwMwJud2pUM2_Fwg.JK9kuLGKJXE2yslbx3Z_9qnrzriouNd0sH0v3acREkUg.JPEG.okayall%2F20231110_163451.jpg&type=sc960_832"></div>
									<!-- 내용 -->
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
						</ul>
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
				<div class="add-frame">이건 추가되는 공간</div>
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
			ViewStyleModule.showView('#view1', '#btn-step1');
			DateModalModule.initializeDateModal();	
			
			//프레임 감추기
			$(".add-frame").hide();
			
    	});
	    $('.btn btn-primary').click(function(){
	    	DateModalModule.saveDates();
	    });
    		
	</script>
	<!-- Bootstrap JS (must be placed at the end of the body for faster page loading) -->    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>    

</body>
<script>
	$('#main-logo').click(function(){
		window.location.href='/main';
	});
	function myplan(){
		$.ajax({
			type :'get',
			dataType :'json',
			url : 'myplan?p_id=1',//p_id=1 1대신에 변수로 p_id값을 받는걸로대체
			cache: false,
			processData : true,
			success : function(response) {
				var vo=response.vo;
				//플랜아이디로 받아온 플랜정보를vo로 받고 처리할부분
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})		
	}
	function memberplan(){
		$.ajax({
			type :'get',
			dataType :'json',
			url : 'memberplan?m_id=1',//p_id=1 1대신에 변수로 p_id값을 받는걸로대체
			cache: false,
			processData : true,
			success : function(response) {
				var lvo=response.lvo;
				
				console.log("플랜번호");
				console.log(lvo[0].p_id);
				
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})
		
	}
	function saveP(){
		$.ajax({
			type :'post',
			contentType:'application/json',
			dataType :'text',
			url : 'plan',
			data:JSON.stringify({
				 p_id: p_id,
	             m_id: m_id,
	             p_name: p_name,
	             p_birth: p_birth,
	             p_moddate: p_moddate
			}),
			cache: false,
			processData : true,
			success : function(response) {
				alert(response);
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})
		
	}
	
</script>
</html>