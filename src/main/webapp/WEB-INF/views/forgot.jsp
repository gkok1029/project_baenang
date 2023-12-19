<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>비밀번호 찾기</h1>
  <form action="/reset-password" method="POST">
    <label for="email">이메일:</label>
    <input type="email" id="email" name="email" required>
    <button type="submit">비밀번호 재설정 코드 요청</button>
  </form>
  
  <form action="/reset-password2" method="POST">
    <label for="email">코드:</label>
    <input type="text" id="code" name="code" required>
    <button type="submit">인증하기</button>
  </form>
</body>
</html>
