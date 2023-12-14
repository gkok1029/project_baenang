<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<button id="download">dbload</button>
	</div>
</body>
<script>
function download(){
	$.ajax({
		type:'get',
		dataType:'json',
		url:'jdgdown'
		cache:false,
		processData:true,
		success:function(res){
			
			
		},
		error:function(err){
			alert('error: '+err.status);
		}	
	})
	
}
</script>
</html>
