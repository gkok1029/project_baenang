<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지입니다.</title>
<link href="/resources/css/login.css" rel="stylesheet">
<!-- jQuery 추가 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- jQuery UI 추가 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>
	$(function() {
		$("#signup-birthdate").datepicker({
			dateFormat : 'yy-mm-dd',
			changeMonth : true,
			changeYear : true,
			yearRange : "-100:+0" // 100년 전부터 오늘까지 선택 가능하도록 설정
		});
	});
</script>
</head>
<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label
				for="tab-1" class="tab">로그인</label> <input id="tab-2" type="radio"
				name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
			<div class="login-form">
				<form id="login-form" action="/loginCheck" method="post">
					<div class="sign-in-htm">
						<div class="group">
							<label for="login-user" class="label">이메일</label> <input
								id="login-user" name="M_EMAIL" type="text" class="input">
						</div>
						<div class="group">
							<label for="login-pass" class="label">비밀번호</label> <input
								id="login-pass" name="M_PWD" type="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<input type="submit" class="button" value="로그인">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<a href="#forgot">비밀번호를 잊으셨나요?</a>
						</div>
					</div>
				</form>
				<form id="signup-form" action="/signup" method="post">
					<div class="sign-up-htm">
						<div class="group">
							<label for="signup-email" class="label">이메일</label> <input
								id="signup-email" name="M_EMAIL" type="text" class="input">
							<input type="button" class="button" value="이메일 인증하기"
								onclick="sendEmailVerification()">
						</div>
						<!--  -->
						<div class="group">
							<label for="verification-code" class="label">인증 코드</label> <input
								id="verification-code" name="verification-code" type="text"
								class="input"> <input type="button" class="button"
								value="확인" onclick="verifyEmailCode()">
						</div>
						<!--  -->
						<div class="group">
							<label for="signup-nickname" class="label">닉네임</label> <input
								id="signup-nickname" name="M_NNAME" type="text" class="input">
						</div>
						<div class="group">
							<label for="signup-password" class="label">비밀번호</label> <input
								id="signup-password" name="M_PWD" type="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<label for="signup-confirm-password" class="label">비밀번호
								재확인</label> <input id="signup-confirm-password" name="M_PWD_CONFIRM"
								type="password" class="input" data-type="password">
						</div>
						<div class="group">
							<label for="signup-birthdate" class="label">생년월일</label> <input
								id="signup-birthdate" name="M_BIRTH" type="text" class="input">
						</div>
						<div class="group">
							<label for="signup-gender" class="label">성별</label><br> <input
								id="male" name="M_GEN" type="radio" value="male"> <label
								for="male">남자</label> <input id="female" name="M_GEN"
								type="radio" value="female"> <label for="female">여자</label>
						</div>
						<div class="group">
							<input type="submit" class="button" value="회원가입">
						</div>
						<div class="hr"></div>
						<div class="foot-lnk">
							<label for="tab-1">이미 회원이신가요?</label>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script>
/* ========================================회원 가입 관련 스크립트============================================== */
isEmailVerified = false;
function sendEmailVerification() {
    var email = document.getElementById('signup-email').value;

    function validateEmail(email) {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
    }

    if (validateEmail(email) && email.trim() !== '') {
        $.ajax({
            url: '/sendVerificationCode',
            method: 'POST',
            data: {
                userEmail: email
            },
            success: function (response) {
                if (response === 'success') {
                    alert('이메일이 성공적으로 전송되었습니다.');
                    // 성공적으로 이메일을 받았을 때 추가적인 동작을 수행할 수 있습니다.
                    // 예를 들어, 이메일 전송 후 다음 단계로 넘어가는 등의 로직을 추가할 수 있습니다.
                } else if (response === 'failed') {
                    alert('중복된 이메일입니다.');
                }
            },
            error: function (error) {
                alert('서버 오류로 이메일 인증을 완료할 수 없습니다.');
            }
        });
    } else {
        alert('유효한 이메일 주소를 입력해주세요.');
    }
}

	function verifyEmailCode() {
        var enteredCode = document.getElementById('verification-code').value;
        var userEmail = document.getElementById('signup-email').value;
	
        if (enteredCode.trim() === '' || userEmail.trim() === '') {
            alert('이메일과 인증 코드를 입력해주세요.');
            return;
        }

        $.ajax({
            url: '/verifyCode', // 서버의 코드 검증 엔드포인트
            method: 'POST',
            data: { userEmail: userEmail, code: enteredCode },
            success: function(response) {
                if (response === "verified") {
                	isEmailVerified = true;
                    alert('이메일 인증이 완료되었습니다.');
                } else {
                    alert('유효하지 않은 코드입니다.');
                }
            },
            error: function(error) {
                alert('서버 오류로 인증을 완료할 수 없습니다.');
            }
        });
    }
	function validateForm() {
		var email = document.getElementById('signup-email').value;
		var nickname = document.getElementById('signup-nickname').value;
		var password = document.getElementById('signup-password').value;
		var confirmPassword = document
				.getElementById('signup-confirm-password').value;
		var birthdate = document.getElementById('signup-birthdate').value;
		var gender = document.querySelector('input[name="M_GEN"]:checked');

		if (email.trim() === '' || nickname.trim() === ''
				|| password.trim() === '' || confirmPassword.trim() === ''
				|| birthdate.trim() === '' || gender === null) {
			return false; // 폼 전송을 막음
		}

		if (password !== confirmPassword) {
			alert('비밀번호와 확인란이 일치하지 않습니다.');
			return false; // 폼 전송을 막음
		}

		return true; // 모든 필드가 채워지고 비밀번호 확인이 일치하면 폼 제출
	}

	document.getElementById('signup-form').addEventListener('submit', function(event) {
	    event.preventDefault(); // 폼 전송 기본 동작 막음
	    if (isEmailVerified === false) {
	        alert('이메일 인증을 먼저 완료해주세요.');
	    } else if (validateForm()) {
	        // AJAX를 이용한 회원가입 요청
	        var formData = $(this).serialize(); // 폼 데이터 직렬화
	       
	        $.ajax({
	            url: '/signup', // 회원가입 처리 URL
	            method: 'POST',
	            data: formData,
	            success: function(response) {
	                if (response === 'success') {
	                    // 성공적으로 회원가입 처리된 경우
	                    alert('회원가입에 성공했습니다.');
	                    window.location.href = '/login';
	                    // 여기서 추가적인 작업을 할 수 있습니다.
	                } else if (response ==='failed'){
	                    alert('회원가입에 실패했습니다.');
	                    window.location.href = '/login';
	                }
	            },
	            error: function(error) {
	                // 회원가입 처리 중 오류 발생한 경우
	                alert('서버에 문제가있어 회원가입에 실패했습니다.');
	            }
	        });
	    } else {
	        alert('모든 필드를 올바르게 입력해주세요.');
	    }
	});
/* ========================================회원 가입 관련 스크립트============================================== */
 
/* ========================================로그인 스크립트============================================== */
document.getElementById('login-form').addEventListener('submit', function(event) {
    event.preventDefault(); // 기본 제출 동작 막기

    var email = document.getElementById('login-user').value;
    var password = document.getElementById('login-pass').value;

    if (email.trim() === '' || password.trim() === '') {
        alert('이메일과 비밀번호를 입력해주세요.');
    } else { 
        var formData = {
            M_EMAIL: email,
            M_PWD: password
        };

        $.ajax({
            url: '/loginCheck',
            method: 'POST',
            data: formData,
            success: function(response) {
                if (response === 1) {
                    alert('로그인에 성공했습니다.');
                    window.location.href = '/main';
                } else if (response === 0) {
                    alert('이메일 또는 비밀번호가 올바르지 않습니다.');
                }
            },
            error: function(error) {
                alert('서버 오류로 로그인에 실패했습니다.');
            }
        });
    }
});

 /* ========================================로그인 스크립트============================================== */
</script>
</html>
