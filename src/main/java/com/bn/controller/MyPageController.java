package com.bn.controller;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bn.model.MemberVo;
import com.bn.model.MypageVo;
import com.bn.service.MypageService;

import lombok.extern.log4j.Log4j;
@Controller
@Log4j
public class MyPageController {
	@Inject
	private MypageService mypageService;	
	
	@RequestMapping(value = "/user/mypage")
	public String mypage(Model m, HttpSession session, @RequestParam(defaultValue="recentday")String filter) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지:");
			return "error";
		}
		
		MemberVo un= mypageService.getProfile(userName);
		
		MypageVo my = new MypageVo();
		my.setM_nname(userName);
		my.setFilter(filter);
		my.setM_id(un.getM_ID());
		
		List<MypageVo> pl= mypageService.getPlanList(my);
		
		
		
		
		
		m.addAttribute("user", un);
		m.addAttribute("plan", pl);
		return "myPage";
	}
	
	@RequestMapping(value = "/user/mypageinfo")
	public String mypageInfo(Model m, HttpSession session) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지: ");
			return "error";
		}
		
		MemberVo user = mypageService.getProfile(userName);
		m.addAttribute("user", user);
		return "myPageInfo";
	}
	
	@RequestMapping(value = "/user/mypagepwdchange")
	public String mypagepwdChange(Model m, HttpSession session) {
		
		
		return "myPagepwdChange";
	}
	@RequestMapping(value = "/user/mypageout")
	public String mypageOut(Model m, HttpSession session) {
		return "myPageOut";
	}
	
}