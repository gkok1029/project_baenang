package com.bn.service;

public interface EmailService {
    void sendVerificationCode(String userEmail);
    boolean verifyCode(String userEmail, String code);
}
