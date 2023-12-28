<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<body>
	<div id="container">
		<div id="cityname">
			<h1> ${contentid}</h1>
		</div>
		<div id="overview">
			${vo.overview}
		</div>
		<div><img alt="picture" src="${vo.firstimage}"></div>
	</div>
</body>
</html>