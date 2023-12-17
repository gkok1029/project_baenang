<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<title>Plan Page</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId="></script>


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
	     margin-botton:10px;
	     width: 80%;
	     padding: 10px;
	     background-color: #555;
	     color: #fff;
	     text-align: center;
	     text-decoration: none;
	     border: none;
	     cursor: pointer;
	}
	.search_frame{
		margin-right: 10px;
		width: 250px;
	}
	    
	#btn_step1{
		color: skyblue;
		font-size:16px;
	}
	#btn_step2{
		color: gray;
		opacity:'0.5';
		font-size:12px;
	}
	#btn_step3{
		color: gray;
		opacity:'0.5';
		font-size:12px;
	}
	table{
		width:100%;
	}
	th, td{
		border:1px solid;
		text-align: center;
	}
	.view1{
		display: block;	
	}
	.view2{
		display : none;
	}
	.view3{
		display : none;
	}
</style>

</head>
<body>

	

	<!-- 컨테이너  -->
	<div class="container">
		<!-- 사이드바 -->
		<div id="sidebar">
			<!-- 메인 로고 -->
			<img class="logo" src="" alt="Main Logo"/>
			<br>
			<!-- 스탭 1,2,3 버튼 -->
			<button class="sidebar_button" id="btn_step1" onclick="handleButtonClick('btn_step1')">STEP 1<br>날짜확인</button>
			<br>
			<button class="sidebar_button" id="btn_step2" onclick="handleButtonClick('btn_step2')">STEP 2<br>장소확인</button>
			<br>
			<button class="sidebar_button" id="btn_step3" onclick="handleButtonClick('btn_step3')">STEP 3<br>숙소설정</button>
			<br>
			
			<!-- 하단 다음버튼 -->
			<button class="bottom-button">다음</button>
		</div>
		<!-- 두번째 프레임 -->
		<div id="search_frame">
			<!-- Step1 날짜 확인 -->
			<div id="view1" style={display:block}>
				<div>
					<b>제주</b>	
				</div>
				<div>
					<div><b>2023.12.18(월) - 2023.12.20(수)</b></div>
					<div>
						<button type="button" class="btn_calender" data-toggle="modal" data-target="#calendarModal">
        					<i class="far fa-calendar-days"></i>
    					</button>
    				</div>
				</div>
				<div>
					<a href="https://www.naver.com"><button>항공권</button></a>
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
			<div id="view2">
				<br>
				제주
				<br>
				2023.12.04 - 2023.12.05 <div><i class="fa-regular fa-calendar-days" onclick="alert('달력클릭')"></i></div>
				<br>
				<button>여행장소선택</button>
				<button>새로운 장소 등록</button>
				<br>
				<input type="text"  placeholder="내용을 입력하세요"></input>
				<br>
				<div class="btns_cat">
					<button>추천</button>
					<button>명소</button>
					<button>식당</button>
					<button>카페</button>
				</div>
			</div>
			<!-- STEP 3 숙소설정 -->
			<div id="view3"></div>
		
		
		</div>
		<!-- 지도 -->
		<div id="map" style="flex: 1;"></div>
	</div>
	    <!-- calendarModal -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="modal-title" id="calendarModalLabel">여행 기간이 어떻게 되시나요?</p>                
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    
                </div>
                <div>
	                <div class="modal-body">
	                    <div>달력1</div>
	                    <div>달력2</div>
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal">선택</button>
	                </div>
                </div>
            </div>
        </div>
    </div>
	
	<script>
	    // 윈도우가 로드될 때 initializeMap 함수 실행
	    
	    $(document).ready(function(){
	    	initializeMap();
	    	$('#view1').show();
			$('#view2').hide();
			$('#view3').hide();
    		$("#btn_step1").click(function(){
    			$('#view1').show();
    			$('#view2').hide();
    			$('#view3').hide();
    			$('#btn_step1').css({
    				'color' : 'skyblue',
    				'opacity' : '1',
    				'fontSize' : '16px'
    			});
    			$('#btn_step2').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    			$('#btn_step3').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    		});
    		$("#btn_step2").click(function(){    			
    			$('#view1').hide();
    			$('#view2').show();
    			$('#view3').hide();
    			
    			$('#btn_step1').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    			$('#btn_step2').css({
    				'color' : 'skyblue',
    				'opacity' : '1',
    				'fontSize' : '16px'
    			});
    			$('#btn_step3').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    		});
    		$("#btn_step3").click(function(){    			
    			$('#view1').hide();
    			$('#view2').hide();
    			$('#view3').show();
    			
    			$('#btn_step1').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    			$('#btn_step2').css({
    				'color' : 'gray',
    				'opacity' : '0.5',
    				'fontSize' : '12px'
    			});
    			$('#btn_step3').css({
    				'color' : 'skyblue',
    				'opacity' : '1',
    				'fontSize' : '16px'    				
    			});
    		});
    	})
	    
	    /* 사이드바 버튼 클릭에따른 스타일변화 */
	    function handleButtonClick(buttonId){	
	    	/* 변수에 버튼저장 */
	    	var btn1 =document.getElementById('btn_step1');
	    	var btn2 =document.getElementById('btn_step2');
	    	var btn3 =document.getElementById('btn_step3');
	    	var view1 = document.getElementById('view1');
	    	var view2 = document.getElementById('view2');
	    
	    
	    	
	    	/* 클릭 시 조건문 생성 */
	    	if(buttonId === 'btn_step2'){
	    		/* 색상변경 */
	    		btn1.style.color = 'gray';
                btn2.style.color = 'skyblue';
                btn3.style.color = 'gray';
                /* 투명도조절 */
                btn1.style.opacity='0.5';
                btn2.style.opacity='1';
                btn3.style.opacity='0.5';
                /* 폰트사이즈조절 */
                btn1.style.fontSize='12px';
                btn2.style.fontSize='16px';
                btn3.style.fontSize='12px';

	    	}else if(buttonId === 'btn_step3'){
	    		/* 색상변경 */
	    		btn1.style.color = 'gray';
                btn2.style.color = 'gray';
                btn3.style.color = 'skyblue';
                /* 투명도조절 */
                btn1.style.opacity='0.5';
                btn2.style.opacity='0.5';
                btn3.style.opacity='1';
                /* 폰트사이즈조절 */
                btn1.style.fontSize='12px';
                btn2.style.fontSize='12px';
                btn3.style.fontSize='16px';
	    	}
	    }	    
	</script>
	<!-- Bootstrap JS (must be placed at the end of the body for faster page loading) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>	
</body>
</html>