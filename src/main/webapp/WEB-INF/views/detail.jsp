<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.bn.model.DtailPlanVo" %>
<!DOCTYPE html>
<html>
<head>
													<!-- JS 모듈 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/sideBarModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/viewPageModule.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/planModule.js"></script>
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style type="text/css">

body {
    display: flex;
    justify-content: flex-start; /* 왼쪽 정렬 */
    align-items: flex-start; /* 위쪽 정렬 */
    height: 100vh;
    margin: 0;
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
	
    width : 300px ; height:100% ;
    flex-direction: column;
    align-items: flex-start;
    border: 1px solid black;
}

.body-container{
	display: flex;
	flex-direction: row;
	margin:0;
	padding:0;
	width: 100%;
	height: 100%;
}
.view{
	display: flex;
	flex-direction : column;
	height : 100%;
}

.logo {
	margin : 0px;
	padding : 0px;
	height: 100% ; width: 100%;
}
#main-logo{
	background-color : rgb(89,220,209);
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
.view-header{
	width : 100%;
	height : 100px;
}
.second-frame{
	display: flex;
	flex-direction : row;
	height : 100%;
	justify-content: flex-start;
	backgorund-color : blue;
}
#header-container{
	display : flex;
	flex-direction : row;
}
</style>

    <meta charset="UTF-8">
    <title>Your View Page</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<script type="text/javascript">
	let p_id = ${p_id};
</script>
<body>
	<div class="body-container">
		<div id="sidebar-container"></div>
		
		<div class="view" id="view5">
			<div class="view-header">
				<div id="header-container">
					<div id="p_name">${p_name}</div>
					<div id="p_dates"></div>
				</div>
			</div>
			<div class="second-frame">
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
			        	
			        	//get startDate, endDate from sessionStorage
			        	let dpStartArr;
			        	let dpEndArr;
			        	let strPlanDate;
			        	if("${dplvo[0].dp_start}" && "${dplvo[0].dp_end}"){
			        		dpStartArr = "${dplvo[0].dp_start}".split(" ");
			        		dpEndArr = "${dplvo[0].dp_end}".split(" ");
			        		
			        		//format dates
			        		strPlanDate = dpStartArr[5] + "." +getMonth(dpStartArr[1]) + "." + dpStartArr[2] + " ~ " +
							dpEndArr[5] + "." +getMonth(dpEndArr[1]) + "." + dpEndArr[2];
			        		
			        		let startDate =  dpStartArr[5] + "-" +getMonth(dpStartArr[1]) + "-" + dpStartArr[2];
			        		let endDate = dpEndArr[5] + "-" +getMonth(dpEndArr[1]) + "-" + dpEndArr[2];
			        		
			        		sessionStorage.setItem("startDate",startDate);
			        		sessionStorage.setItem("endDate",endDate);
			        	}else if( sessionStorage.getItem("startDate") && sessionStorage.getItem("endDate") ){
			        		dpStartArr = sessionStorage.getItem("startDate");
			        		dpEndArr = sessionStorage.getItem("endDate");
			        	}
			        	
			        	console.log("${dplvo}");
			        	
			        	
			        	$('#p_dates').text(strPlanDate);
			        	SidebarModule.initialize();
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
			        function getMonth(mon){
			        	switch(mon){
			        	case "Jan":
			        		return "01"
			        		break;
			        	case "Feb":
			        		return "02"
			        		break;
			        	case "Mar":
			        		return "03"
			        		break;
			        	case "Apr":
			        		return "04"
			        		break;
			        	case "May":
			        		return "05"
			        		break;
			        	case "Jun":
			        		return "06"
			        		break;
			        	case "Jul":
			        		return "07"
			        		break;
			        	case "Aug":
			        		return "08"
			        		break;
			        	case "Sep":
			        		return "09"
			        		break;
			        	case "Oct":
			        		return "10"
			        		break;
			        	case "Nov":
			        		return "11"
			        		break;
			        	case "Dec":
			        		return "12"
			        		break;
			        	}
			        }
			         
			        function getDPlanByDPid(dp_day){
			        	let p_id = "${p_id}";
			        	let url = '/dpretrieve'
			        	
			        	$.ajax({
			                type: 'GET',
			                url: url,
			                data: { dp_day: dp_day, p_id: p_id },
			                dataType: 'text',
			                success: function(res) {
			                    
			                },
			                error: function(xhr, status, error) {
			                    // 에러 처리
			                    console.log('Error: ' + error);
			                }
			            });
			        }
			    </script>
			</div>		
    </div>
</body>
</html>
