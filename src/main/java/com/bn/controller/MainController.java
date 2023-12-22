package com.bn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.service.MainServiceImpl;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MainController {

	@Inject
	private MainServiceImpl msi;
	
	@GetMapping("/sample")
	public String sample() {
		return "sample";
	}
	
	@RequestMapping("/main")
	public String onMain() {
		
		return "main";
	}
	
	@RequestMapping("/user/main")
	public String goMain() {
		
		return "main";
	}
	
	@RequestMapping(value = "/city")
	public String city() {
		return "city";
	}
	
	@ResponseBody
	@GetMapping("/rec")
	public ModelMap rec() {
		ModelMap map=new ModelMap();
		String contentid="1797757";
		String title=msi.rec(contentid);
		map.addAttribute("title", title);
		return map;
	}

	
	 @ResponseBody
	 @GetMapping("/search") public List<String> search(@RequestParam String keyword) {
		List<String> result = null;
		
		try {
			result = msi.search(keyword);
		}catch(Exception e) {
			
		}
		 
		 System.out.println(result);
		 return result;
	 }
	 
	
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/search") public String search(@RequestParam String keyword) {
	 * 
	 * return msi.search(keyword); }
	 */
	
}
