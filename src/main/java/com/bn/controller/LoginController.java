package com.bn.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.MemberVo;
import com.bn.service.EmailService;
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
	
	@ResponseBody
	@PostMapping("/loginCheck2")
	public String loginCheck2(MemberVo member, HttpSession session, HttpServletResponse response) {
		String name = loginService.loginCheck2(member, session);
		if(name != null) {
			 Cookie userCookie = new Cookie("sessionId", session.getId());
		        userCookie.setMaxAge(60*30); 
		        userCookie.setPath("/");
		        response.addCookie(userCookie);
		        session.setAttribute("userName", name);
			
			return "success";
		}else {
			return "failed";
		}
	}
	
	@RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // ���� �ʱ�ȭ (�α׾ƿ�)
        return "redirect:/login"; // �α׾ƿ� �� �α��� �������� �̵�
    }
	
	@RequestMapping("/login")
	public String Login() {
		
		return "login";
	}
	
	@RequestMapping("/forgot")
	public String goForgot() {
		
		return "forgot";
	}
	
	
	
	
	
	
	
}
