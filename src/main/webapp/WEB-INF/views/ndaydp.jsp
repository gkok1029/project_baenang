<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mapModule.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="map-container">
			<div id="map" style="flex: 1;"></div>							<!--지도-->
		</div>
</body>
<script>
let x='${cityvo.latitude}';
let y='${cityvo.longitude}';
MapModule.initializeMap();
</script>
</html>