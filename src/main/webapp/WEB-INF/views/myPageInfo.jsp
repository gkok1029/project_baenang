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
			<div class=profile><a href="/user/mypage">Profile</a></div>
		</div>
		<div id=topbg>
            
        </div>
		<div id="topcenprowrap">
            <div id=topcenpro>
                <p class="profile_img"><span><img alt="${user.getM_NNAME()}" src="../resources/img/${user.getM_IMAGE()}"></span></p>
                <p class="username"><span>${user.getM_NNAME()}</span></p>
            </div>
        </div>
	</header>
    <main>
        <div id="wrap">
            <div id="innerwrap">
                <div class="joinday">가입일 : ${user.getM_RDATE()}</div>
                <div id="formContainer">
                    <form action="" name="memberinfo" class="info" id="infoF" method="post">
	                    <h3 class="pad">닉네임</h4>
	                	<div id="inputContainer" class="pad"><input type="text" name="name" value="${user.getM_NNAME()}"></div>
	                    <h3 class="pad">이메일</h4>
	                    <div id="inputContainer" class="pad"><input type="text" name="userid"  value="${user.getM_EMAIL()}" readonly></div>
                    </form>
                    <p id="pwdch" class=cursor onclick="openPwd()">비밀번호를 변경하시겠습니까?</p>
                </div>
                <div id="bottomContainer">
                    <div id="formBottom">
                        <button type="submit" onclick="submit()">수정완료</button>
                        <button type="button" onclick="openOut()">회원탈퇴</button>
                    </div>
                </div>
            </div>
        </div>
        
        <script type="text/javascript">
        	function openPwd(){
        		let url="../user/mypagepwdchange";
        		win=open(url,"myPagepwdChange","width=800, height=300, left=250, top=250")
        	}
        </script>
    </main>
</body>
</html>