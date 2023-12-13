package com.bn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class PlanController {
	
	@RequestMapping("/plan")
	public String showMap(Model model) {
		
		return "plan";
	}
	
	
}
