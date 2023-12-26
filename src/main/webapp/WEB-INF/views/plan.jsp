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
	.no-close .ui-dialog-titlebar-close {
		display: none;
	}
	.ui-widget-overlay{
		position: fixed;
	}
	.custom-dialog{
		background-color: white;
	}
</style>
</head>
<body>

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
	<div id="calender-modal" >		
		<div id="calender-container">
			<div id="calender-header">날짜 선택</div>
			<div id="calender-body">
				<div class="calender" id="calender1">달력1</div>
				<div class="calender" id="claender2">달력2</div>
			</div>						
		</div>
	</div>

<script>
	    
	$(document).ready( function(){
		
		SidebarModule.initialize();
		MapModule.initializeMap();
		ViewPageModule.viewPageLoding();		
		DateModalModule.initializeDateModal();
		
		
		//프레임 감추기
		$(".basket-frame").hide();
		
	});
	$('.btn btn-primary').click(function(){
		DateModalModule.saveDates();
	});

	$( function() {
		$( "#calender-modal" ).dialog({			
			title:"날짜 선택",
			dialogClass: "no-close",
			closeOnEscape: false,
			resizable:false,			
			modal : true,
			autoOpen : false,
			width:'600',
			height:'600',
			show : {
				effect: 'blind',
				duration: 100
			},
			hide : {
				effect: 'explode',
				duration: 100
			},
			buttons:{
				"선택" : function(){
					$(this).dialog("close");
				}
			},
			position : { my: "right bottom", at: "right bottom", of: window },
			options :{ 
				
			}
		});
		
	
		$( ".btn-calender" ).on( "click", function() {
			$( "#calender-modal" ).dialog("open");
			$("body")
		});
  	});
	
</script>
	<!-- Bootstrap JS (must be placed at the end of the body for faster page loading) -->    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>    

</body>
<script>
let x;
let y;

	//맵모듈
	function handleEnterKey(event) {
		if (event.key === "Enter") {
			submitForm(); // 엔터 키를 눌렀을 때 submitForm 함수 호출
		}
	}

	// 폼 제출 함수
	function submitForm() {
		
		var inputValue = document.querySelector('input[type="text"]').value;
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'search?addr=' + inputValue,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.tour(res.x, res.y);
				x=res.x;
				y=res.y;
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})

	}	
	
	function lodging(lat, len) {
		let x = lat;
		let y = len;
		var ctype="32";

		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'tour?x=' + x + '&y=' + y + '&ctype=' +ctype,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.displayLodgingInformation(res.contentList,x,y);

			},
			error : function(err) {
				alert('error: ' + err.status);
			}
		})
	}
	function restaurant(){
		var ctype="39";
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'tour?x=' + x + '&y=' + y + '&ctype=' +ctype,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.displayTourInformation(res.contentList,x,y);

			},
			error : function(err) {
				alert('error: ' + err.status);
			}
		})
	}
	function cafe(){
		var cat="A05020900";
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'tour?x=' + x + '&y=' + y + '&cat=' +cat,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.displayTourInformation(res.contentList,x,y);

			},
			error : function(err) {
				alert('error: ' + err.status);
			}
		})
		
	}
	function attraction(){
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'tour?x=' + x + '&y=' + y,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.displayTourInformation(res.contentList,x,y);

			},
			error : function(err) {
				alert('error: ' + err.status);
			}
		})
		
	}
</script>
</html>