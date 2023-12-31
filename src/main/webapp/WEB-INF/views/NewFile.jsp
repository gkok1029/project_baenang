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
    	let x=1;
    	let y=1;
    	let days=0;
    	
        // 날짜 차이 계산 함수
        function calculateDateDifference() {
            var startDateStr = $("#start_date").val();
            var endDateStr = $("#end_date").val();

            if (startDateStr && endDateStr) {
                var startDate = new Date(startDateStr);
                var endDate = new Date(endDateStr);

                var timeDiff = endDate - startDate;
                var nights = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                 days = nights + 1; // 체크아웃 날을 포함하기 위해 1을 더함

                $("#result").text("총 " + nights + "박 " + days + "일 일정입니다.");

                // days를 기준으로 div 생성
                for (var i = 1; i <= days; i++) {
                    var dayDiv = $("<div class='day-div' id='day"+i+"'>Day " + i + "</div>");
                    $("body").append(dayDiv);
                    
                    // Day Div 안에 8개의 하위 div 추가
                    for(var j=1; j<=8; j++){
                        var subDiv = $("<div class='sub-div' id='day"+i+"dp"+j+"'>Sub " + j + "</div>");
                        dayDiv.append(subDiv);
                    }
                }

                // "n일차 완료" 또는 "일정 생성" 버튼 추가
                var completeButton = $("<button class='complete-button' style='display:none;' onclick='completeDay()'>1일차 완료</button>");
                $(".container").append(completeButton);
                
                // "n일차 완료" 버튼을 표시
                completeButton.show();
            } else {
                alert("시작 날짜와 종료 날짜를 입력하세요.");
            }
        }

		// 더미 데이터 이동 함수
		function movedp(button) {
		    if ($('.day-div').length > 0) {
		        let sourceDiv = $(button).parent();
		        let targetDiv = $('#day' + x + 'dp' + y);
		        targetDiv.empty();
		        // 기존 버튼을 찾아서 삭제
		        sourceDiv.find('button').remove();

		        // 새로운 div를 만들고 내용과 클래스를 복사
		       
		        targetDiv.innerHTML = sourceDiv.html(); // jQuery의 html()을 사용하여 innerHTML 가져오기
		        

		        // 생성된 버튼의 호출 함수명 변경
		        let newButton = $("<button onclick='removedp(this)'>Click me</button>");

		        // 새로운 div에 버튼 추가
		        newDiv.appendChild(newButton[0]);

		        // 새로운 div를 대상 div에 추가하고 y를 증가
		         // targetDiv 안의 내용을 비움
		        
		        $('#dp' + y).remove();
		        y++;
		        console.log(y);
		    }
		}

		// "Click me" 버튼 클릭 시 동작하는 함수
		function removedp(button) {
    let parentDiv = $(button).parent();
    let pparentDiv = parentDiv.parent();
    parentDiv.remove();

    // 같은 sub-div에 있는 div들 조회 (첫 번째 요소부터)
    let subDivs = pparentDiv.siblings('.sub-div').first();

    // null 값이 있는 경우 뒤에 있는 div들을 앞으로 땡겨옴
    subDivs.each(function(index, element) {
        if (index < subDivs.length - 1 && ($(element).html() === null || $(element).html() === '')) {
            $(element).html(subDivs.first().html());
            subDivs.first().html('');
        }
    });

    y--;
    console.log(y);
}




		// "n일차 완료" 또는 "일정 생성" 버튼 클릭 시 동작하는 함수
		function completeDay() {
		    // x 변수를 1씩 증가
		    x++;
		    
		    // "n일차 완료" 버튼의 텍스트를 변경
		    if (x <= days) {
		        $("button.complete-button").text(x + "일차 완료");
		    } else {
		        $("button.complete-button").text("일정 생성");
		    }
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

    <!-- 의미 없는 더미 데이터 div 15개 추가 -->
    <div class="container" id="dpctn">
        <% for (int i = 1; i <= 15; i++) { %>
            <div class="dummy-data" id="dp<%= i %>">더미 데이터 <%= i %><br><button onclick='movedp()'>Click me</button></div>
        <% } %>
    </div>
</body>
</html>
