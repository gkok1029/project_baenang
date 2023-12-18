package com.bn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.PlanVo;
import com.bn.service.PlanService;


@PropertySource("classpath:/config/props/apiKey.properties")
@Controller
public class PlanController {
	
	@Value("${NAVER_MAPS_KEY}")
	private String NAVER_MAPS_KEY;

	@Value("${NAVER_MAPS_SECRET_KEY}")
	private String NAVER_MAPS_SECRET_KEY;
	
	@Inject
	private PlanService pservice;
	
	private PlanVo vo;
	
	@GetMapping("/plan")
	public String plan(Model model) {
		model.addAttribute("NAVER_MAPS_KEY", NAVER_MAPS_KEY);
		model.addAttribute("NAVER_MAPS_SECRET_KEY", NAVER_MAPS_SECRET_KEY);
		return "plan";
	}
	
	@ResponseBody
	@RequestMapping("/plan")
	public String saveplan(@RequestBody PlanVo vo) {
		System.out.println(vo);
		int n=pservice.insert(vo);
		String x="plan";
	
		
		return x;
	}
	
	@ResponseBody
	@RequestMapping("/myplan")
	public ModelMap myplan(@RequestParam("p_id") int p_id) {
		System.out.println(p_id);
		ModelMap map=new ModelMap();
		vo=pservice.selectPlan(p_id);
		map.addAttribute("vo",vo);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/memberplan")
	public ModelMap memberplan(@RequestParam("m_id") int m_id) {
		System.out.println(m_id);
		ModelMap map=new ModelMap();
		List<PlanVo> lvo=pservice.selectAll(m_id);
		map.addAttribute("lvo",lvo);
		return map;
	}
	
	
    
	
}


