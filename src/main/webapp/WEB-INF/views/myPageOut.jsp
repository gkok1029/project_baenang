<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/myPageOut.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>회원 탈퇴</title>
</head>
<body>
	<div id="wrap">
		<div id="innerwrap">
			<c:if test="${result == null }">
				<h2>정말 탈퇴 하시겠습니까?</h2>
				<div id="bottomContainer">
					<form action="/user/out" name="outf" id="outf" method="post">
						<button type="button" class="cursor" name="yes" onclick="Btn()">예</button>
						<button type="button" class="cursor" name="no"
							onclick="window.close()">아니오</button>
					</form>
				</div>
			</c:if>
			<c:if test="${result != null }">
				<h2>${result}</h2>
				<div id="bottomContainer">
					<button type="button" class="cursor" name="no" onclick="logout()">닫기</button>
				</div>
			</c:if>
		</div>
	</div>

	<script type="text/javascript">
		function Btn() {
			$('#outf').submit();
		}

		function logout() {
			opener.location.href = "/login";
			window.close();
		}
	</script>
</body>
</html>