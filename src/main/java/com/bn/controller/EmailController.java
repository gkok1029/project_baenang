package com.bn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.bn.service.EmailService;

@RestController
public class EmailController {

    private final EmailService emailService;

    @Autowired
    public EmailController(EmailService emailService) {
        this.emailService = emailService;
    }

    @PostMapping("/sendVerificationCode")
    public String sendVerificationCode(String userEmail) {
    	int n = emailService.checkEmail(userEmail);
    	if(n==0) {
    	emailService.sendVerificationCode(userEmail);
    	return "success";
    	}
    	return "failed";
    }

    @PostMapping("/verifyCode")
    public String verifyCode(String userEmail, String code) {
        boolean isVerified = emailService.verifyCode(userEmail, code);
        if (isVerified == true) {
            return "verified";
        } else {
            return "failed";
        }
    }
}

