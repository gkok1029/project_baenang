<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/test.css">

<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${apikey.clientId}"></script>

    <title>나는 바보 멍청이</title>
  
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <div class="sidebar1">
                <a href="" target="_self">
                    <img src="resources/images/여행로고.PNG" class="logo">
                </a>
            </div>
            <div class="sidebar2">
                <button class="sidebtn1 btn-outline-info">
                    STEP 1<br>
                    날짜 확인
                </button>
            </div>
            <div class="sidebar3">
                    <button class="sidebtn2 btn-outline-info">    STEP 2<br>
                                장소 선택
                    </button>
            </div>
            <div class="sidebar4">
                <button class="sidebtn3 btn-outline-info">    STEP 3<br>
                            숙소 선택
                </button>
        </div>
        </div>
        <div class="content">
            <div class="date">
                2023.12.03~2023.12.05
            </div>
            <div class="btndiv">
                <button class="selbtn btn-outline-info">여행 장소 선택</button>
                <button class="rebtn btn-outline-info">새로운 장소 등록</button>
            </div>
            <div><input type="text" id="de" placeholder="장소명을 입력하세요" onkeydown="handleEnterKey(event)"></div>
            <div>
                <button class="cbtn1 btn-outline-primary" id="zz" onclick="initMap()">추천</button>
                <button class="cbtn2 btn-outline-info">명소</button>
                <button class="cbtn3 btn-outline-info">식당</button>
                <button class="cbtn4 btn-outline-info">카페</button>
            </div>

            <div id="travels-container">
            </div>
            
           
            
            
        
        </div>
        <div class="map" id="map"></div>
    </div>
</body>
<script>

var map = null;


function initMap() {
	if(map==null){
         map = new naver.maps.Map('map', {
             center: new naver.maps.LatLng(33.4996, 126.5312),
             zoom: 10
         });
	} 
	}
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
	 type:'get',
	 dataType:'json',
	 url:'search?addr='+inputValue,
	 cache:false,
	 processData:true,
	 success:function(res){
		moveMap(res.x,res.y);
		tour(res.x,res.y);
		alert('투어로 간다');
	 },
	 error:function(err){
			alert('error: '+err.status);
	 }
	   
   })
    
}
function moveMap(lat, len) {
    var mapOptions = {
        center: new naver.maps.LatLng(len, lat),
        zoom: 10,
        mapTypeControl: true
    };
    map = new naver.maps.Map('map', mapOptions);
}
function tour(lat,len){
	var x=lat;
	var y=len;

	$.ajax({
		 type:'get',
		 dataType:'json',
		 url:'tour?x='+x+'&y='+y,
		 cache:false,
		 processData:true,
		 success:function(res){
			 displayTourInformation(res.contentList);
	            
	            
		 },
			 error:function(err){
					alert('error: '+err.status);
			 }
	})
}

function displayTourInformation(contentList) {
	 var container = $('#travels-container'); // 새로운 container 추가

	    // 기존 내용 비우기
	    container.empty();

    // 최대 4개까지만 표시
   for (var i = 0; i < Math.min(contentList.length, 4); i++) {
        var content = contentList[i];

        // 새로운 div 동적으로 생성
        var newDiv = $('<div>').addClass('traveld');
        var imgDiv = $('<div>').addClass('travelimg');
        var textDiv = $('<div>').addClass('traveltext');
        var img = $('<img>').attr('src', content.firstimage || '/resources/images/noimage.PNG');
        var title = $('<div>').addClass('linea').text('Name: ' + content.title);
        var addr = $('<div>').addClass('lineb').text('Location: ' + content.addr);
        var heart = $('<div>').addClass('linec').text('하트 별');

        // 생성한 div에 정보 추가
        imgDiv.append(img);
        textDiv.append(title, addr, heart);
        newDiv.append(imgDiv, textDiv);
        container.append(newDiv);
    }
        
        // 추가로 필요한 정보는 여기에 계속 추가할 수 있습니다.
    }

</script>

</script>
</html>