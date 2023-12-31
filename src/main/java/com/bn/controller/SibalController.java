package com.bn.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SibalController {

	@RequestMapping("/view5")
	public String sibal(Model m ,HttpSession session) {
		
		
		return "view5";
	}
}
