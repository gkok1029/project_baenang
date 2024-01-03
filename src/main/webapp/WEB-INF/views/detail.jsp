<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.bn.model.DtailPlanVo" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
body {
    display: flex;
    justify-content: flex-start; /* 왼쪽 정렬 */
    align-items: flex-start; /* 위쪽 정렬 */
    height: 100vh;
    margin: 0;
}

.container {
    display: flex;
    height:100%;
    flex-direction: column;
    align-items: flex-start;
    border: 2px solid black;
    padding: 10px;
}

.item {
    display: flex;
    justify-content: flex-start; /* 왼쪽 정렬 */
    margin-top: 10px;
   	width:250px;
   	height:100px;
}



.item>img {
    width: 100px;
    height: 70px; /* 높이를 자동으로 설정하여 종횡비 유지 */
}
.container{
	width:300px;
}
</style>


    <meta charset="UTF-8">
    <title>Your View Page</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<!-- List<DtailPlanVo> dplvo 반복문 -->
    <c:forEach var="dtailPlan" items="${dplvo}" varStatus="loop">
    <!-- 현재 반복이 첫번쨰인지 or 현재날짜가 이전날짜와 다른지 -->
        <c:if test="${loop.first || dtailPlan.dp_day ne dplvo[loop.index - 1].dp_day}">
            <!-- Start a new container div for each unique dp_day -->
            <div class="container" id="day_${dtailPlan.dp_day}">
                <h2>Day ${dtailPlan.dp_day}</h2>
             
        </c:if>

        <!-- Create a div for each dtailPlan, ordered by dp_id -->
        <div class="item" id="${dtailPlan.dp_id}">
            <p class="contentid-link" data-contentid="${dtailPlan.contentid}">
                contentid: ${dtailPlan.contentid}
            </p>
            <!-- Add other properties as needed -->
        </div>

        <c:if test="${loop.last || dtailPlan.dp_day ne dplvo[loop.index + 1].dp_day}">
            <!-- Close the container div when the dp_day changes -->
            </div>
        </c:if>
    </c:forEach>

    <script>
        $(document).ready(function() {
            $('.contentid-link').each(function() {
                // Get contentid from data attribute
                var contentid = $(this).data('contentid');
                var dp_id = $(this).parent().attr('id');
                // Send AJAX request to /contentload
                $.ajax({
                    type: 'GET',
                    url: '/contentload',
                    data: { contentid: contentid },
                    dataType:'json',
                    success: function(response) {
                        var title = response.title;
                        var firstImage = response.firstimage;

                        // Create an img element and set its src attribute
                        var imgElement = $('<img>').attr('src', firstImage);

                        // Create a p element for the title
                        var titleElement = $('<p>').text(title);
                        var targetElement = $('#' + dp_id);
                        // Append the img and title elements to an element with the id 'dp_id'
                        targetElement.empty();
                        targetElement.append(imgElement, titleElement);
                    },
                    error: function(xhr, status, error) {
                        // Handle errors if any
                        alert('Error: ' + error);
                    }
                });
            });
        });
    </script>
</body>
</html>
