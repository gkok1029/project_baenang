<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>간단한 홈 페이지</title>
</head>
<body>
    <h1>간단한 홈 페이지</h1>
    <% if (session.getAttribute("userName") != null) { %>
        <p>안녕하세요, <%= session.getAttribute("userName") %>님</p>
        <form action="/logout" method="post">
            <input type="submit" value="로그아웃">
        </form>
    <% } else { %>
        <form action="/loginCheck" method="post">
            <label for="username">사용자 이름:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
            <input type="submit" value="로그인">
        </form>
    <% } %>
</body>
</html>