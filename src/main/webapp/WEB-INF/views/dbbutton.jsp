<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>Insert title here</title>
<style>
 body, html {
    margin: 0;
    padding: 0;
    height: 100%;
  }
#btn{
width:100%;
height:100%;
}
#download{
width:100%;
height:100%;
}
</style>
</head>
<body>
	<div id="btn">
	<button id="download" onclick=download()>dbload</button>
	</div>
</body>
<script>
function download(){
	alert('ㅎㅇ');
	$.ajax({
		type:'get',
		dataType:'json',
		url:'jdgdown',
		cache:false,
		processData:true,
		success:function(res){
			alert(res);
			
		},
		error:function(err){
			alert('error: '+err.status);
		}	
	})
	
}
</script>
</html>
