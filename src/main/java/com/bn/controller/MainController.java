package com.bn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.CityVo;
import com.bn.service.InfoServiceImpl;
import com.bn.service.MainServiceImpl;
import com.bn.service.PostService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MainController {

	@Inject
	private MainServiceImpl msi;
	
	@Inject
	private InfoServiceImpl isi;
	
	@Inject
	private PostService service;
	
	@RequestMapping("/main")
	public String onMain(Model model) {
		List<CityVo> cvo=isi.getAllCityData();
		model.addAttribute("cvo",cvo);
		model.addAttribute("posts", service.getList());
		
		return "main";
	}
	
	@RequestMapping("/user/main")
	public String goMain(Model model) {
		
		return "forward:/main";
	}
	
	@ResponseBody
	 @GetMapping("/**/csearch") 
	 public List<CityVo> citySearch(@RequestParam String keyword) {
		List<CityVo> result = null;
		
		try {
			result = msi.search(keyword);
		}catch(Exception e) {
			
		}
		 
		 return result;
	 }
	 
	/*
	@ResponseBody
	 @GetMapping("/msearch") 
	 public List<CityVo> search(@RequestParam String keyword) {
		List<CityVo> result = null;
		try {
			result = msi.search(keyword);
		}catch(Exception e) {
			
		}
		 
		System.out.println("Controller result : "+result);
		 
		 return result;
	 }
	*/
	 
	 
	
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/search") public String search(@RequestParam String keyword) {
	 * 
	 * return msi.search(keyword); }
	 */
	
}
