<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/myPageInfo.css">
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>My Page Info</title>
</head>
<body>
	<header>
		<div id=top>
			<div class=profile>Profile</div>
		</div>
		<div id=topbg>
            
        </div>
		<div id="topcenprowrap">
            <div id=topcenpro>
                <p class="profile_img"><span><img alt="${user.getM_NNAME()}" src="111.jpg"></span></p>
                <p class="username"><span>${user.getM_NNAME()}</span></p>
            </div>
        </div>
	</header>
    <main>
        <div id="wrap">
            <div id="innerwrap">
                <div class="joinday">가입일 : 2000-00-00</div>
                <div id="formContainer">
                    <form action="" name="memberinfo" class="info" id="infoF" method="post">
                        <table id="userTable">
                            <tr>
                                <th>닉네임</th>
                                <td>
                                    <input type="text" name="name" value="usernickname">
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td class="pwdtd">
                                    <input type="password" name="userpwd">
                                    <button type="button" class="btn" onclick="openPwd()">수정</button>
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td class="emailtd">
                                    <input type="text" name="userid"  value="useremail" readonly>
                                    <button type="button" class="btn" onclick="openEmail()">수정</button>
                                </td>
                            </tr>
                        </table>
    
                    </form>
                </div>
                <div id="bottomContainer">
                    <div id="formBottom">
                        <button type="submit">수정완료</button>
                        <button type="button" onclick="openOut()">회원탈퇴</button>
                    </div>
                </div>
                
            </div>
        </div>
    </main>
</body>
</html>