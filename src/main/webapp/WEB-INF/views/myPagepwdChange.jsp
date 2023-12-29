<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/myPagepwdChange.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>비밀번호 변경</title>
</head>
<body>
	<div id="wrap">
		<div id="innerwrap">
			<div id="formContainer">
				<form action="pwdchange" name="pwdchange" class="pwdf" id="pwdF"
					method="post">
					<table id="pwdTable">
						<tr>
							<th>현재 비밀번호</th>
							<td><input type="password" name="p1"></td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td><input type="password" name="p2"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input type="password" name="p3"></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="bottomContainer">
				<div id="formBottom">
					<button type="submit" onclick="pwdClose()">수정완료</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function pwdClose() {
			var newPassword = document.forms["pwdchange"]["p2"].value;
			var confirmPassword = document.forms["pwdchange"]["p3"].value;

			if (newPassword !== confirmPassword) {
				alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			pwdchange.submit();
		}
	</script>
</body>
</html>