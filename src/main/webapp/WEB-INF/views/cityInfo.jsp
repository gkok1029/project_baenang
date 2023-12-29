<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<style>
	div{
		border:1px solid red;
	}
	#gaeyo{
		margin-left:20px;
	}
	#container{
		display:flex;
	}
	#overview{
		width:60vw;
		padding:20px;
	}
	#imgcontainer{
		width:40vw;
		padding:20px;
	}
	img{
		width:100%;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function closeAndPlanGo(cityName) {
	// 팝업 닫기
	window.close();

	// 부모 창(main.jsp)의 Plan 페이지로 이동
	window.opener.location.href = "/plan?search="+cityName;
}
</script>
</head>

<body>
	<div>
		<div id="cityname">
			<h1> ${civo.cityname}</h1>
		</div>
		
		<div id="gaeyo"><p> 개 요 </p></div>
		
		<div id="container">
			<div id="overview">
				${civo.c_overview}
			</div>
			
			<div id="imgcontainer"><img alt="picture" src="${civo.c_image}"></div>
		</div>
		
		<div id="gtplan">
				<a href="#" onclick="closeAndPlanGo('${civo.cityname}')">Plan으로 이동</a>
		</div>
	</div>
</body>
</html>











