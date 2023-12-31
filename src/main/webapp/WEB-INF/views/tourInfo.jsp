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
	#closeContainer{
		text-align: center;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<body>
	<script>
	  function closeWindow() {
		    window.close();
		  }
	</script>
	<div>
		<div id="tourname">
			<h1> ${convo.title}</h1>
		</div>
		
		<div id="gaeyo"><p> 개 요 </p></div>
		
		<div id="container">
			<div id="overview">
				${convo.overview}
			</div>
			<div id="imgcontainer"><img alt="picture" src="${convo.firstimage}"></div>
		</div>
		
		<div id="closeContainer">
			<button class="btn btn-primary" onclick="closeWindow()"> 닫기 </button>
		</div>
	</div>
</body>
</html>











