<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${apikey.clientId}"></script>
<meta charset="UTF-8">
<title>Plan Page</title>
</head>
<body>
	
		<script>
		var p_id="1";
		var m_id="1";
		var p_name="나는 바보야";
		var p_birth="2023-01-01";
		var p_moddate="2023-01-01";	
		</script>
	
<input onclick="memberplan()"></input>
</body>
<script>
	function myplan(){
		$.ajax({
			type :'get',
			dataType :'json',
			url : 'myplan?p_id=1',//p_id=1 1대신에 변수로 p_id값을 받는걸로대체
			cache: false,
			processData : true,
			success : function(response) {
				var vo=response.vo;
				//플랜아이디로 받아온 플랜정보를vo로 받고 처리할부분
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})

		
		
	}
	function memberplan(){
		$.ajax({
			type :'get',
			dataType :'json',
			url : 'memberplan?m_id=1',//p_id=1 1대신에 변수로 p_id값을 받는걸로대체
			cache: false,
			processData : true,
			success : function(response) {
				var lvo=response.lvo;
				
				console.log("플랜번호");
				console.log(lvo[0].p_id);
				
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})

		
		
	}
	function saveP(){
		$.ajax({
			type :'post',
			contentType:'application/json',
			dataType :'text',
			url : 'plan',
			data:JSON.stringify({
				 p_id: p_id,
	             m_id: m_id,
	             p_name: p_name,
	             p_birth: p_birth,
	             p_moddate: p_moddate
			}),
			cache: false,
			processData : true,
			success : function(response) {
				alert(response);
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})
		
	}
	
</script>
</html>