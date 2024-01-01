<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 모듈파일 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mapModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/viewPageModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sideBarModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/calendarModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/modalModule.js"></script>
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
<style>
    .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: auto;
            height: auto;
            background-color: white;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .modal-buttons {
            margin-top: 20px;
        }

        /* 버튼 스타일 (예제에서는 간단한 버튼 스타일 사용) */
        .open-modal-btn {
            padding: 10px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        

        .close-modal-btn, .confirm-btn {
            padding: 10px;
            background-color: #ddd;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
	
</style>
<script>
	let y='${cityvo.latitude}';
	let x='${cityvo.longitude}';
	let cityname='${cityvo.cityname}';
	let trip = {
		"title":"",
		"days":{
			
		}
	}	
	
</script>
</head>
<body class="body">

	<!-- 컨테이너  -->
	<div class="container">
		<!-- 사이드바 -->
		<div id="sidebar-container">
		
		</div>
		<!-- 두번째 프레임 -->
		<div id="second-frame">
			<div id="second-frame-container">
				
				<div class="view" id="view1" >

				</div>													<!-- view -->
			</div>														<!-- second-frame-container -->
		</div>															<!-- second-frame -->
		<div>
			<div id="map" style="flex: 1;"></div>							<!--지도-->
		</div>
		
		
	</div>																<!-- Container -->
    
	    <!-- calendarModal -->
	<div class="modal" id="calendar-modal" >
		
	</div>

    

<script>

	$(document).ready( function(){
		
		SidebarModule.initialize();
		MapModule.initializeMap();
		ViewPageModule.viewPageLoding();
		ViewPageModule.showView(".view1","#btn-step1");
		//프레임 감추기
        CalendarModule.createCalendar();
        /* ModalModule.initSaveCheckModal(); */
		
		
	});
    
	$('.btn btn-primary').click(function(){
		DateModalModule.saveDates();
	});
	
</script>
	<!-- Bootstrap JS (must be placed at the end of the body for faster page loading) -->    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>    

</body>
</html>