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
@RequestMapping("/user")
@Log4j
public class MyPageController {
	@Inject
	private MypageService mypageService;	
	
	@RequestMapping(value = "/mypage")
	public String mypage(Model m, HttpSession session, @RequestParam(defaultValue="recentday")String filter) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지:");
			return "error";
		}
		
		MemberVo un= mypageService.getProfile(userName);
		log.info("un===="+un+",, userName==="+userName);
		
		
		MypageVo my = new MypageVo();
		my.setM_nname(userName);
		my.setFilter(filter);
		my.setM_id(un.getM_ID());
		
		List<MypageVo> pl= mypageService.getPlanList(my);
		
		
		
		
		
		m.addAttribute("user", un);
		m.addAttribute("plan", pl);
		return "myPage";
	}
	
	@RequestMapping(value = "/mypageinfo")
	public String mypageInfo(Model m, HttpSession session, String nick) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지: ");
			return "error";
		}
		
		MemberVo user = mypageService.getProfile(userName);
		m.addAttribute("user", user);
		return "myPageInfo";
	}
	
	@RequestMapping(value = "/mypageinfosubmit")
	public String mypageInfosubmit(Model m, HttpSession session, String nick) {
		
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지: ");
			return "error";
		}
		
		MemberVo user = mypageService.getProfile(userName);
		
		MemberVo tmp = new MemberVo();
		tmp.setM_NNAME(nick);
		tmp.setM_ID(user.getM_ID());
		int nn= mypageService.updateNickname(tmp);
		if(nn>0) {
			user.setM_NNAME(nick);
			session.setAttribute("userName", nick);
		}
		m.addAttribute("user", user);
		return "myPageInfo";
	}
	
	@RequestMapping(value = "/mypagepwdchange")
	public String mypagepwdChange(Model m, HttpSession session) {
		
		String userName= (String)session.getAttribute("userName");
		
		
		return "myPagepwdChange";
	}
	
	
	
	@RequestMapping(value = "/pwdchange")
	public String mypagepwdChangeProcess(Model m, String p1, String p2, HttpSession session) {
		//p1: 예전 비번
		
		String userName= (String)session.getAttribute("userName");
		
		MemberVo user = mypageService.getProfile(userName);
		
		MemberVo tmp = new MemberVo();
		tmp.setM_PWD(p1);
		tmp.setM_EMAIL(user.getM_EMAIL());
		
		int p= mypageService.passwordCheck(tmp);
		
		if(p>0) {
			// 비번 일치=> 새 비번으로 수정 처리
			user.setM_PWD(p2);
			
			int n= mypageService.updatePwd(user);
			String msg=(n>0)?"비밀번호 수정 완료":"수정 실패";
			m.addAttribute("msg",msg);
			
			
			return "message2";
		} else {
			
			m.addAttribute("msg","비밀번호가 일치하지 않습니다");
			m.addAttribute("loc","javascript:history.back()");
			
			return "message";
		}
		
	}
	@RequestMapping(value = "/mypageout")
	public String mypageOut(Model m, HttpSession session) {
		return "myPageOut";
	}
	
}