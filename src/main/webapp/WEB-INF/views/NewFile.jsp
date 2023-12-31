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
                for (var i = 1; i <= days; i++) {
                    var dayDiv = $("<div class='day-div' id='day" + i + "'>Day " + i + "</div>");
                    $("body").append(dayDiv);
                }
                var completeButton = $("<button class='complete-button' style='display:none;' onclick='completeDay()'>1일차 완료</button>");
                $("#dpctn").append(completeButton);
                completeButton.show();
            } else {
                alert("시작 날짜와 종료 날짜를 입력하세요.");
            }
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
            let completeButton = targetDiv.find('.complete-button');
            newDiv.insertBefore('.complete-button');
            parentDiv.remove();
            
            y--;
        }

        function completeDay() {
            x++;
            if (x <= days) {
                $("button.complete-button").text(x + "일차 완료");
            } else {
                $("button.complete-button").text("일정 생성");
            }
            y = 1;
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
