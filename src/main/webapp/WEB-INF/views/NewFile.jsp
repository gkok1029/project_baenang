<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bn.model.ContentVo" %>
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
        align-items: center; /* 가로 중앙 정렬 */
    }

    /* 스타일링을 위한 추가된 CSS */
    .container {
        display: flex;
        flex-wrap: nowrap; /* 가로로만 래핑 */
    }

    /* 스타일링을 위한 추가된 CSS */
    .dummy-data, .day-div, .sub-div,.night {
        margin-top: 5px;
        padding: 5px;
        border: 1px solid #ccc;
         
    }

    /* 스타일링을 위한 추가된 CSS */
    .dummy-data,.night {
        margin-top: 10px;
        padding: 10px;
        border: 1px solid #ddd;
        width: 100px; /* 수정된 스타일: 폭을 100px로 지정 */
        height: 200px;
        display: flex;
        flex-direction: column;
        align-items: center; /* 가로 중앙 정렬 */
        text-align: center; /* 텍스트 가운데 정렬 */
    }
	#daycontainer{
		width:70%;
	}
    /* 스타일링을 위한 추가된 CSS */
    .day-div {
        margin-top: 10px;
        padding: 10px;
        border: 1px solid #ddd;
        width: 100%;
        display: flex;  /* 가로로 나열하도록 설정 */
        flex-wrap: nowrap;  /* 넘치는 경우 줄 바꿈을 방지합니다. */
        overflow-x: auto;   /* 넘치는 경우 스크롤바 표시 */
    }

    .content-image {
        width: 100px;
        height: auto;
    }

    .content-title {
        font-weight: bold;
    }

    .dummy-data img {
        max-width: 100%;
        height: auto;
    }

    .complete-button,
    .dropdown {
        margin-top: 10px;
    }
</style>
<!-- Datepicker 초기화 스크립트 -->
<script>
    let x = 1;
    let y = 1;
    let days = 0;
    let dpvoList = [];
    let p_id = ${p_id};
    var startday = "${startday}";  // 모델에서 받은 데이터 사용
    var endday = "${endday}";  // 모델에서 받은 데이터 사용

    // 더미 데이터 생성
    $(document).ready(function () {
        calculateDateDifference();

        let dummyctn = $('<div>').addClass("container").attr("id", "dpctn");
        $("body").append(dummyctn);

        <%
	     // places는 ContentVo의 리스트일 것이라고 가정합니다.
	     List<ContentVo> places = (List<ContentVo>) request.getAttribute("places");
	     if (places != null && places.size() > 0) {
	         for (int i = 0; i < places.size(); i++) {
	             ContentVo contentVo = places.get(i);
	             // 이미지 태그를 밖에서 선언
	     %>
	             let imgTag<%=i+1%> = $("<img>").addClass("content-image").attr("src", "<%= contentVo.getFirstimage() %>").attr("alt", "이미지");
	             let dummyDiv<%=i+1%> = $("<div>").addClass("dummy-data").attr("id", "<%= contentVo.getContentid() %>");
	             // 이미지 태그를 여기서 사용
	             dummyDiv<%=i+1%>.append(imgTag<%=i+1%>);
	             dummyDiv<%=i+1%>.append("<br><span class='content-title'>제목: <%= contentVo.getTitle() %></span>");
	             // contentid를 int값으로 바로 읽을 수 있도록 수정
	             dummyDiv<%=i+1%>.append("<br><button onclick='movedp(this)'>Click me</button>");
	             $("#dpctn").append(dummyDiv<%=i+1%>);
	     <%
	         }
	     }
	     %>
	     <%
    // hotels는 ContentVo의 리스트일 것이라고 가정합니다.
    List<ContentVo> hotels = (List<ContentVo>) request.getAttribute("hotels");
    
    if (hotels != null && hotels.size() > 0) {
        for (int i = 0; i < hotels.size(); i++) {
            ContentVo hotel = hotels.get(i);
            // 이미지 태그를 밖에서 선언
%>
            // 해당 호텔 데이터를 day+n의 마지막 자식으로 추가
            let hotelImgTag<%=i+1%> = $("<img>").addClass("content-image").attr("src", "<%= hotel.getFirstimage() %>").attr("alt", "호텔 이미지");
            let hotelDummyDiv<%=i+1%> = $("<div>").addClass("night").attr("id", "<%= hotel.getContentid()+1000000 %>");
            hotelDummyDiv<%=i+1%>.append(hotelImgTag<%=i+1%>);
            hotelDummyDiv<%=i+1%>.append("<br><span class='content-title'>제목: <%= hotel.getTitle() %></span>");

            // 현재 day+n의 마지막 자식으로 추가
            hotelDummyDiv<%=i+1%>.appendTo("#day" + <%=i+1%>);
            
            // 다음 day+(n+1)의 첫 번째 자식으로 추가
            <%
            if (i  < hotels.size()) {
             %> hotelImgTag<%=i+1%> = $("<img>").addClass("content-image").attr("src", "<%= hotel.getFirstimage() %>").attr("alt", "호텔 이미지");
                hotelDummyDiv<%=i+1%> = $("<div>").addClass("dummy-data").attr("id", "<%= hotel.getContentid()+1000000 %>");
                hotelDummyDiv<%=i+1%>.append(hotelImgTag<%=i+1%>);
                hotelDummyDiv<%=i+1%>.append("<br><span class='content-title'>제목: <%= hotel.getTitle() %></span>");

                // 다음 day+(n+1)의 첫 번째 자식으로 추가
                $("#day" + <%=i+2%>).prepend(hotelDummyDiv<%=i+1%>);
            
<%			}
        }
    }
%>


        var completeButton = $("<button class='complete-button' onclick='completeDay()'>1일차 완료</button>");
        $("#dpctn").append(completeButton);

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

    });

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
            let afterDiv = targetDiv.find('.night:last');
            let newDiv = sourceDiv.clone();
            newDiv.find('button').attr('onclick', 'removedp(this)');
            
            if (afterDiv.length > 0) {
                newDiv.insertBefore(afterDiv);
            } else {
                targetDiv.append(newDiv);
            }

            sourceDiv.remove();
            y++;
        }

        if (y == 7) {
            completeDay();
        }
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
        } else if(x==days){
            $("button.complete-button").text("일정 생성");
        } else {
            sendplan();
        }
        y = 1;
    };

    function sendplan() {
        let data = { m_id: ${m_id},
            p_name: "${pname}" };
        $.ajax({
            type: "POST", // 메서드 타입 (POST)
            url: "/plan", // 요청 보낼 URL
            contentType: "application/json", // 전송하는 데이터의 타입 (JSON)
            data: JSON.stringify(data), // JSON 형식으로 데이터 변환
            success: function (response) {
                // 성공적으로 응답을 받았을 때 실행되는 부분
                console.log('플랜저장성공');
                senddp();

            },
            error: function (error) {
                // 요청이 실패하면 실행되는 부분
                console.log(error);
            }
        });
    }

    function senddp() {
        makedpList();
        $.ajax({
            type: "POST", // 메서드 타입 (POST)
            url: "/dpsave", // 요청 보낼 URL
            contentType: "application/json",
            data: JSON.stringify(dpvoList), // POST 데이터 설정
            success: function (res) {
                // 성공적으로 응답을 받았을 때 실행되는 부분
                console.log('dp저장성공');

            },
            error: function (error) {
                // 요청이 실패하면 실행되는 부분
                console.error("Error:", error);
            }
        });
    }

    function makedpList() {
        dpvoList = [];
        var container = $("#daycontainer");
        container.children().each(function () {
            var dayId = $(this).attr('id');
            var dataDivs = $(this).find('.dummy-data');
            var n = parseInt(dayId.replace('day', ''), 10);
            dataDivs.each(function (index) {
                var dataText = $(this).text();
				startday=new Date(startday);
				endday=new Date(endday);
                // contentid를 직접 읽어와서 dpvo 객체에 추가
                var contentId = $(this).attr('id');
				console.log(contentId);
                var dpvo = {
                    p_id: p_id,
                    dp_day: n,
                    dp_num: index + 1,
                    contentid: contentId,
                    dp_start: startday,
                    dp_end: endday
                };
                dpvoList.push(dpvo);
            });
        });
    }

    function triggerClickEvents(parentId) {
        var parentElement = document.getElementById(parentId);
        if (parentElement) {
            var childButtons = parentElement.querySelectorAll("button");
            for (var i = 0; i < childButtons.length; i++) {
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

    function calculateDateDifference() {
        if (startday && endday) {
             startday = new Date(startday);
             endday = new Date(endday);
            var timeDiff = endday - startday;
            var nights = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
            days = nights + 1;
            $("#result").text("총 " + nights + "박 " + days + "일 일정입니다.");
            let daycontainer = $('<div>').attr('id', 'daycontainer');
            $('body').append(daycontainer);
            for (var i = 1; i <= days; i++) {
                var dayDiv = $("<div class='day-div' id='day" + i + "'>Day " + i + "</div>");
                $("#daycontainer").append(dayDiv);
            }
        } else {
            alert("시작 날짜와 종료 날짜를 입력하세요.");
        }
    }
</script>
</head>
<body>
    <div id="result"></div>
</body>
</html>
