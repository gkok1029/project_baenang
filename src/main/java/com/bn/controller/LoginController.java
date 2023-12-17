package com.bn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.MemberVo;
import com.bn.service.LoginService;
import com.bn.service.SignupService;

@Controller
public class LoginController {

	@Autowired
	private SignupService signupService;
	
	@Autowired
	private LoginService loginService;
	
	@ResponseBody
	@PostMapping("/signup")
	public String Signup(MemberVo member) {
	boolean result = signupService.validateSignup(member);
		if(result == true) {
		signupService.signup(member);
		return "success";
		} 
		return "failed";
	}

	@ResponseBody
	@PostMapping("/loginCheck")
    public int loginCheck(MemberVo member) {
		System.out.println("MemberVo" + member);
		int result = loginService.loginCheck(member);
		System.out.println(result);
    	int failed = 0;
    	if(result == 1) {
    		return result;
    	}
    	return failed;
    }
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/login")
	public String Login() {
		
		return "login";
	}
	
}
