<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>날짜 차이 계산기</title>
    <!-- jQuery 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column; /* 세로로 정렬 */
        }
        /* 스타일링을 위한 추가된 CSS */
        .container {
            display: flex;
            flex-wrap: nowrap; /* 가로로만 래핑 */
        }
        /* 스타일링을 위한 추가된 CSS */
        .dummy-data,
        .day-div,
        .sub-div {
            margin-top: 5px;
            padding: 5px;
            border: 1px solid #ccc;
            width: 50px; /* 수정된 스타일: 폭을 50px로 지정 */
        }
        /* 스타일링을 위한 추가된 CSS */
        .dummy-data {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
        }
        /* 스타일링을 위한 추가된 CSS */
        .day-div {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
        }
    </style>
    <!-- Datepicker 초기화 스크립트 -->
    <script>
        let x = 1;
        let y = 1;
        let days = 0;
        function calculateDateDifference() {
            var startDateStr = $("#start_date").val();
            var endDateStr = $("#end_date").val();
            if (startDateStr && endDateStr) {
                var startDate = new Date(startDateStr);
                var endDate = new Date(endDateStr);
                var timeDiff = endDate - startDate;
                var nights = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                days = nights + 1;
                $("#result").text("총 " + nights + "박 " + days + "일 일정입니다.");
                let dayctn=$('<div>').attr('id','daycontainer');
                $('body').append(dayctn);
                for (var i = 1; i <= days; i++) {
                    var dayDiv = $("<div class='day-div' id='day" + i + "'>Day " + i + "</div>");
                    $("#daycontainer").append(dayDiv);
                }
                var completeButton = $("<button class='complete-button' style='display:none;' onclick='completeDay()'>1일차 완료</button>");
                $("#dpctn").append(completeButton);
                completeButton.show();
             // 드롭다운 메뉴 생성
                let dropdown = $("<select class='dropdown' id='dayDropdown'></select>");
                for (let i = 1; i <= days; i++) {
                    dropdown.append("<option value='" + i + "'>" + i + "일차 수정</option>");
                }
                $("#dpctn").append(dropdown);

                // 일정 생성 버튼 클릭 시 해당 날짜로 이동
                dropdown.change(function () {
                    let selectedDay = $(this).val();
                    moveToDay(selectedDay);
                });
            } else {
                alert("시작 날짜와 종료 날짜를 입력하세요.");
            }
        }
        function moveToDay(selectedDay) {
            x = parseInt(selectedDay);
            $("button.complete-button").text(selectedDay + "일차 완료");
            y = 1;
           var p ='day'+x;
           triggerClickEvents(p);
        }

        function movedp(button) {
            if ($('.day-div').length > 0) {
                let sourceDiv = $(button).parent();
                let targetDiv = $('#day' + x);
                let newDiv = sourceDiv.clone();
                newDiv.find('button').attr('onclick', 'removedp(this)');
                targetDiv.append(newDiv);
                sourceDiv.remove();
                y++;
            }
            if(y==7)completeDay();
        }
		
        function removedp(button) {
            let parentDiv = $(button).parent();
            let targetDiv=$('#dpctn');
            let newDiv=parentDiv.clone();
            newDiv.find('button').attr('onclick','movedp(this)');
            let completeButton = targetDiv.find('.complete-button');
            newDiv.insertBefore('.complete-button');
            parentDiv.remove();
            
            y--;
        }
	
		function completeDay() {
		    x++;
		    if (x < days) {
		        $("button.complete-button").text(x + "일차 완료");
		    }else if(x==days){
		        $("button.complete-button").text("일정 생성");
		    }else{
		    	sendreq();
		    }
            y = 1;
        };
        
       
	 
        
       function sendreq(){ 
    	   let dpvoList;
    	   let data={ m_id:${m_id} ,
   	        	p_name: "더미 여행"};
        $.ajax({
            type: "POST", // 메서드 타입 (POST)
            url: "/plan", // 요청 보낼 URL
            contentType: "application/json", // 전송하는 데이터의 타입 (JSON)
            data: JSON.stringify(data), // JSON 형식으로 데이터 변환
            success: function(response) {
                // 성공적으로 응답을 받았을 때 실행되는 부분
                console.log('플랜저장성공');
				
                
            },
            error: function(error) {
                // 요청이 실패하면 실행되는 부분
                console.log(error);
            }
        });
       
       let dpvoList=createdpList();
        $.ajax({
            type: "POST", // 메서드 타입 (POST)
            url: "/dpsave", // 요청 보낼 URL
            contentType: "application/json",
            data: JSON.stringify(dpvoList), // POST 데이터 설정
            success: function(res) {
                // 성공적으로 응답을 받았을 때 실행되는 부분
                console.log('dp저장성공');
            },
            error: function(error) {
                // 요청이 실패하면 실행되는 부분
                console.error("Error:", error);
            }
        });
    
    }
        function createdpList(){
        // 데이터를 저장할 List
        var dpvoList = [];

        // 컨테이너 div 선택
        var container = $("#daycontainer");
        container.children().each(function () {
            // 하위 div의 id를 가져오기 (예: day1, day2, ...)
            
            var dayId = $(this).attr('id');

            // 데이터 div 선택
            var dataDivs = $(this).find('.dummy-data');
            var n = parseInt(dayId.replace('day', ''), 10);
            // 데이터 div에 대한 반복문
            dataDivs.each(function (index) {
                // 각 데이터의 텍스트 가져오기
                var dataText = $(this).text();
                // 데이터 구조로 만들어서 List에 추가
               console.log(p_id);
				console.log(n);
                var dpvo = {
                    p_id: p_id,
                    dp_day: n,
                    dp_num: index + 1,  // 인덱스는 0부터 시작하므로 1을 더해줌
                    contentid: dataText,
                    dp_start:'2023-12-20',
                    dp_end:'2023-12-23'
                    	
                };
                dpvoList.push(dpvo);
            });
        });
        return dpvoList;
        }

        // 더미 데이터 생성
        $(document).ready(function () {
        	let dummyctn=$('<div>').addClass("container").attr("id","dpctn");
        	$("body").append(dummyctn);
            <% for (int i = 1; i <= 15; i++) { %>
                let dummyDiv<%=i%> = $("<div>").addClass("dummy-data").attr("id", "dp<%= i %>");
                dummyDiv<%=i%>.html("더미 데이터 <%=i%><br><button onclick='movedp(this)'>Click me</button>");
                $("#dpctn").append(dummyDiv<%=i%>);
            <% } %>
            
        });
        function triggerClickEvents(parentId) {
            var parentElement = document.getElementById(parentId);
            if (parentElement) {
                var childButtons = parentElement.querySelectorAll("button");
                for (var i = 0; i <childButtons.length; i++) {
                    var button = childButtons[i];
                    // 각 버튼의 클릭 이벤트를 발생시킴
                    simulateClick(button);
                }
            }
        }
        function simulateClick(element) {
            var event = new Event("click", { bubbles: true });
            element.dispatchEvent(event);
        }
        
    </script>
</head>
<body>
    <div class="container">
        <h2>날짜 차이 계산기</h2>
        <label for="start_date">시작 날짜:</label>
        <input type="text" id="start_date" value="2023.12.20" readonly>
        <label for="end_date">종료 날짜:</label>
        <input type="text" id="end_date" value="2023.12.23" readonly>
        <button onclick="calculateDateDifference()">날짜 차이 계산</button>
    </div>
    <div id="result"></div>
</body>
</html>
