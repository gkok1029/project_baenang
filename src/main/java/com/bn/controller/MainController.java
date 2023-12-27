package com.bn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.CityVo;
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
	 @GetMapping("/msearch")
	 public String[] search(@RequestParam String keyword) {
		List<CityVo> result = null;
		
		try {
			result = msi.search(keyword);
		}catch(Exception e) {
			
		}
		 
		 System.out.println("Controller : "+result);
		 
		 List<CityVo> searchList = result; // 諛쏆븘�삩 �뜲�씠�꽣瑜� searchList�뿉 �븷�떦
		
		String[] cityNameList = new String[5]; //jsp�뿉 .append濡� �꽔�쓣 �닔 �엳寃� �뒪�듃留곹��엯�쓽 諛곗뿴�쓣 �깮�꽦 
		
		 for (int i = 0; i < searchList.size(); i++) {
			 CityVo content = searchList.get(i); 
		     String cityName = content.getCITYNAME(); // Vo�겢�옒�뒪�쓽 getter 硫붿꽌�뱶瑜� �궗�슜�븯�뿬 CITYNAME�쓽 媛믩쭔 異붿텧 
		     cityNameList[i]=cityName;
		     System.out.println("cityNameList["+i+"] : " + cityNameList[i]);
		 }
		 
		 return cityNameList;
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
