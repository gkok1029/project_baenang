package com.bn.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class myPageController {
	
	@RequestMapping(value = "/mypage")
	public String home() {
		
		return "myPage";
	}
	
	
}