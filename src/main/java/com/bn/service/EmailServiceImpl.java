package com.bn.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender javaMailSender;
    private final Map<String, String> verificationCodes = new HashMap<>();

    @Autowired
    public EmailServiceImpl(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    @Override
    public void sendVerificationCode(String userEmail) {
        String code ;
        code = generateVerificationCode();
        String subject = "이메일 인증 코드";
        String body = "인증 코드: " + code;
        sendEmail(userEmail, subject, body);
        verificationCodes.put(userEmail, code);
    }

    @Override
    public boolean verifyCode(String userEmail, String code) {
        if (verificationCodes.containsKey(userEmail) && verificationCodes.get(userEmail).equals(code)) {
            verificationCodes.remove(userEmail);
            return true;
        }
        return false;
    }

    private void sendEmail(String userEmail, String subject, String body) {
    	  try {
    	MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        String setFrom = "bnalsrms1029@gmail.com";
            helper.setFrom(setFrom);
            helper.setTo(userEmail);
            helper.setSubject(subject);
            helper.setText(body);
            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
}
