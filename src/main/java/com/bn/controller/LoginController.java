package com.bn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.MemberVo;
import com.bn.service.SignupService;

@Controller
public class LoginController {

	@Autowired
	private SignupService signupService;
	
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


	
	
	
	
	
	
	
	
	
	@RequestMapping("/login")
	public String Login() {
		
		return "login";
	}
	
}
