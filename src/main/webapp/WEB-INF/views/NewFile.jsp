<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Divs with JSP</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<div id="dummyData" class="day">
    더미 데이터
    <button onclick="copyAndRemove()">Copy and Remove</button>
</div>

<div id="container">
    <%-- JSP 코드 삽입 --%>
    <%
        // 입력받은 숫자
        String inputNumber = request.getParameter("inputNumber");
        if (inputNumber == null) {
            // 기본값 설정
            inputNumber = "3";
        }

        // 입력받은 숫자만큼 반복
        for (int i = 1; i <= Integer.parseInt(inputNumber); i++) {
            // n일차 텍스트를 가진 div 생성
            out.println("<div class='day' id='day_" + i + "'>" + i + "일차");

            // 5개씩의 하위 div를 생성하여 추가
            for (int j = 1; j <= 5; j++) {
                out.println("<div class='sub' id='sub_" + (5 * (i - 1) + j) + "'>일련번호 " + (5 * (i - 1) + j) + "<button onclick='removeSub(this)'>Remove</button></div>");
            }

            out.println("</div>");
        }
    %>
</div>

<style>
    /* 스타일링을 위한 CSS 코드 */
    #container {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .day {
        border: 1px solid #ccc;
        padding: 10px;
        margin: 5px;
        text-align: center;
    }

    .sub {
        border: 1px solid #ddd;
        padding: 5px;
        margin: 3px;
        text-align: center;
    }

    #dummyData {
        border: 1px solid #ccc;
        padding: 10px;
        margin: 5px;
        text-align: center;
    }
</style>

<script>
    function copyAndRemove() {
        // 복사 대상인 div를 선택
        var targetDiv = $('#dummyData');

        // 복사 대상의 내용을 가져와서 새로운 div 생성
        var newDiv = $('<div>').addClass('sub').html(targetDiv.html());

        // 각각의 생성된 div에 id를 추가
        var newId = 'sub_' + ($('#container .sub').length + 1);
        newDiv.attr('id', newId);

        // 복사 대상을 삭제
        targetDiv.remove();

        // 아래 코드는 일련번호가 1인 .sub 클래스를 가진 div에만 추가합니다.
        $('#sub_1').append(newDiv);
    }

    function removeSub(button) {
        // button.parentNode는 클릭된 버튼의 부모 요소인 div를 나타냅니다.
        var clickedDiv = $(button.parentNode);
        var divId = clickedDiv.attr('id');

        // 해당 div를 삭제
        clickedDiv.remove();

        // 해당 div의 일련번호를 가져와서 "day" 클래스의 내용을 복원
        var subNumber = divId.split('_')[1];
        $('#day_' + Math.ceil(subNumber / 5)).html(Math.ceil(subNumber / 5) + '일차');
    }
</script>

</body>
</html>
