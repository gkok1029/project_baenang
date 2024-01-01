<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<style>
	div{
		padding:5px;
	}
	#infoContainer{
		width:760px;
		height:540px;
		margin:auto;
	}
	#cityname{
		height:15%;
		padding:10px;
		margin-left:15px;
	}
	#container{
		height:65%;
		display:flex;
	}
	#overview{
		width:60vw;
		padding:20px;
		overflow: auto; /* 스크롤을 만들어줌 */
	}
	#imgcontainer{
		width:40vw;
		padding:20px;
		margin:auto;
	}
	img{
		width:100%;
	}
	#gtplan{
		height:10%;
		display: flex;
	}
	#btgotoplan{
		width:45%;
	}
	#btclose{
		width:55%;
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
function closeWindow() {
    window.close();
  }
</script>
</head>

<body>
<br>
	<div id="infoContainer">
		<div id="cityname">
			<h1> ${civo.cityname}</h1>
		</div>
		
		<div id="container">
			<div id="overview">
				${civo.c_overview}
			</div>
			
			<div id="imgcontainer">
				<div><img alt="picture" src="${civo.c_image}"></div>
			</div>
		</div>
		<hr color="gray">
		<div id="gtplan">
				<div id="btgotoplan"><button class="btn btn-primary" onclick="closeAndPlanGo('${civo.cityname}')">Plan으로 이동</button></div>
				<div id="btclose"><button class="btn btn-primary" onclick="closeWindow()"> 닫기 </button></div>
		</div>
	</div>
</body>
</html>











