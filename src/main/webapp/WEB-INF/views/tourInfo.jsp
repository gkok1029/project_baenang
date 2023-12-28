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
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<body>
	<div>
		<div id="cityname">
			<h1> ${vo.title}</h1>
		</div>
		
		<div id="gaeyo"><p> 개 요 </p></div>
		
		<div id="container">
			<div id="overview">
				${vo.overview}
			</div>
			<div id="imgcontainer"><img alt="picture" src="${vo.firstimage}"></div>
		</div>
		
		<div id="gotoplan">
			<button class=""> 여행계획 만들기 </button>
		</div>
		
				
	</div>
</body>
</html>











