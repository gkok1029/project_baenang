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
			//로그인하지 않은 경우==> 
			log.info("로그인 해야함");
			return "error";
		}
		
		// 회원 프로필 가져오기
		MemberVo un= mypageService.getProfile(userName);
		
		MypageVo my = new MypageVo();
		my.setM_nname(userName);
		my.setFilter(filter);
		my.setM_id(un.getM_ID());
		
		//회원의 전체여행일정 가져오기
		List<MypageVo> pl= mypageService.getPlanList(my);
		
		
		//회원의 공유여행일정 가져오기
		
		
		//일정 삭제하기
		
		m.addAttribute("user", un);
		m.addAttribute("plan", pl);
		return "myPage";
	}
	
	@RequestMapping(value = "/user/mypageinfo")
	public String mypageInfo(Model m, HttpSession session) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			//로그인하지 않은 경우==> 
			log.info("로그인 해야함");
			return "error";
		}
		
		// 회원 프로필 가져오기
		//MemberVo un= mypageService.getProfile(userName);
		
		//회원의 전체여행일정 가져오기
		//List<MypageVo> pl= mypageService.getPlanList(un.getM_ID());
		
		//회원의 공유여행일정 가져오기
		
		
		//일정 삭제하기
		
		//m.addAttribute("user", un);
		//m.addAttribute("plan", pl);
		return "myPageInfo";
	}
	
}