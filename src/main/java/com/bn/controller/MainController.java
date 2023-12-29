package com.bn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.CityVo;
import com.bn.service.MainServiceImpl;
import com.bn.service.PostService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MainController {

	@Inject
	private MainServiceImpl msi;
	
	@Inject
	private PostService service;
	
	@RequestMapping("/main")
	public String onMain(Model model) {
		model.addAttribute("posts", service.getList(0));
		return "main";
	}
	
	@RequestMapping("/user/main")
	public String goMain() {
		
		return "main";
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
		 
		 List<CityVo> searchList = result; // 받아온 데이터를 searchList에 할당
		
		String[] cityNameList = new String[5]; //jsp에 .append로 넣을 수 있게 스트링타입의 배열을 생성 
		
		 for (int i = 0; i < searchList.size(); i++) {
			 CityVo content = searchList.get(i); 
		     String cityName = content.getCITYNAME(); // Vo클래스의 getter 메서드를 사용하여 CITYNAME의 값만 추출 
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
