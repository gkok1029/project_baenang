package com.bn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class TourInfoController {
	
	@RequestMapping("/tourInfo")
	public String tourInfo(@RequestParam String contentid, Model model) {
		
		String sightName="tourInfo";
		model.addAttribute("contentid",contentid);
		
		return sightName;
	}
	
}
