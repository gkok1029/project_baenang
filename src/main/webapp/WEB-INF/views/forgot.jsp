<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기페이지</title>
<!-- jQuery CDN 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <h1>비밀번호 찾기</h1>
  <!-- 이메일 입력 폼 -->
  <form id="emailForm">
    <label for="email">이메일:</label>
    <input type="email" id="email" name="M_EMAIL" required>
    <button type="button" onclick="sendEmail()">비밀번호 재설정 코드 요청</button>
  </form>
  
  <!-- 코드 입력 폼 -->
  <form id="codeForm">
    <label for="code">코드:</label>
    <input type="text" id="code" name="code" required>
    <button type="button" onclick="verifyCode()">인증하기</button>
  </form>
</body>
</html>
<script>
isEmailSended = false;

function sendEmail() {
    var email = document.getElementById('email').value;

    function validateEmail(email) {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
    }

    if (validateEmail(email) && email.trim() !== '') {
        $.ajax({
            url: '/resetpassword',
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
                	isEmailSended = true;
                    alert('등록되지않은 이메일입니다.');
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

function verifyCode() {
    var enteredCode = document.getElementById('code').value;
    var userEmail = document.getElementById('email').value;

    if (enteredCode.trim() === '' || userEmail.trim() === '') {
        alert('이메일과 인증 코드를 입력해주세요.');
        return;
    }

    if (isEmailSended === false) {
        alert('비밀번호 재설정코드 요청을 먼저 해주세요.');
        return;
    }
    
    $.ajax({
        url: '/verifyCode2', // 서버의 코드 검증 엔드포인트
        method: 'POST',
        data: { userEmail: userEmail, code: enteredCode },
        success: function(response) {
            if (response !== null && response !== 'failed') {
                alert('Password는 ' + response + '입니다');
            } else {
                if (response === 'failed') {
                    alert('유효하지 않은 코드입니다.');
                } else {
                    alert('서버에서 비밀번호를 가져올 수 없습니다.');
                }
            }
        },
        error: function(error) {
            alert('서버 오류로 인증을 완료할 수 없습니다.');
        }
    });
}



</script>