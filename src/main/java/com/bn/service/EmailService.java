package com.bn.service;

public interface EmailService {
    void sendVerificationCode(String userEmail); //이메일 인증코드전송
    boolean verifyCode(String userEmail, String code); //이메일 인증코드 검증
    int checkEmail(String userEmail); //이메일 중복체크
}
