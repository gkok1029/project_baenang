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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/calendarModule.js"></script>
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
	body{
    height: 100%;
    width: 100%;
    margin: 0;
    padding:0;
}
.container {
    display: flex;
    flex-direction: row;
    margin:0;
    padding:0;
    width: 100%;
    height: 100%;
    max-width:2400px;        
}
.container img {
    width: 100%;
    height: 100%;
    object-fit: cover; /* 이미지 비율 유지 및 가득 채움 */
}
#sidebar {
    flex : 1;
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
#btn-step1{
    color: skyblue;
    opacity: 1;
    font-size: 16px;
}
.traveld{
    width: 250px;
    height: 100px;
    display: flex;
   
}
.travelimg{
    margin-top: 8px;
    margin-left: 12px;
    margin-bottom: 8px;
    margin-right: 8px;
    width: 90px;
    height: 90px;
}
.traveltext{
    width: 88px;
    height: 45px;
}
.linea{
    width: 88px;
    height: 20px;
    font-size: 16px;
    margin-top: 11px;
}
.lineb{
    width: 88px;
    height: 9px;
    font-size: 8px;
}
.linec{
    width: 88px;
    height: 4px;
    font-size: 4px;
}
.logo {
    margin-bottom: 20px;
    width: 150px; /* 濡쒓퀬 �겕湲� 議곗젅 */
}

.sidebar-button {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    background-color: white;
    color : gray;
    font-weight:bold;
    text-align: center;
    text-decoration: none;    
    border: none;
    cursor: pointer;
    opacity: 0.5;
    font-size: 12px;
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

#date{
	display: flex;
}

.place-container {
    display: flex;
    justify-content: space-between; 
   align-items: center; 
   margin-bottom: 20px; 
}

#catButtons{
    display:flex;
}

.place-img{
    width: 60px;
    height: 60px
}

.place-details {
    flex: 1;
    margin-left: 10px;        
    flex-direction: column; 
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

.places {
    width: 300px; 
   height: 621px; 
   overflow-y: auto;
   padding: 10px;
}

.modal{
    position:absolute;
    width:100%; height:100%;
    background: white;
    top:0; left:0;
    display:none;
}

#second-frame{
    margin-right: 10px;
    min-width: 300px;
}

#second-frame-container{
    height: 100%;
    width: 100%;
}

#view{
    width: 500px;
    
    
}

.basket-frame{
    width: 400px;
}

#map{
    flex:1;
}

#btn-skyscanner{
    width: 100%;
}

/* #calender-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);        
    background-color: white;
    border: 1px solid #ccc;
    
}

#calender-container {
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    padding: 20px;
}

#calender-header {
    font-size: 20px;
    margin-bottom: 10px;
    width: 100%;
}

#calender-body {	
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.calender{
	flex:1;
	border: 1px solid #ccc;
    height: 48%;
    padding: 10px;
}
#calender-footer {
    margin-top: 10px;
    text-align: right;
} */
	
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
	<div id="calendar-modal" >
		
	</div>

<script>

	$(document).ready( function(){
		
		SidebarModule.initialize();
		MapModule.initializeMap();
		ViewPageModule.viewPageLoding();		 
		DateModalModule.initializeDateModal();
		ViewPageModule.showView(".view1","#btn-step1");
		//프레임 감추기
        CalendarModule.createCalendar();
		$("#calender-modal").modal('hide');
        
		
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
</html>