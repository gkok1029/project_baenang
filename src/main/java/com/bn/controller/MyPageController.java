package com.bn.controller;
import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	
	@RequestMapping(value = "/mypageinfopic")
	public String mypageInfo(Model m, HttpSession session, 
			@RequestParam("editmf") MultipartFile mf, MypageVo vo) {
		log.info("editmf: "+mf);
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			log.info("에러메세지: ");
			return "error";
		}
		
		//1. 파일 업로드 처리
		//[1] 업로드할 절대경로 얻어오기
		ServletContext app=session.getServletContext();
		String upDir=app.getRealPath("/resources/profile");
		log.info("upDir: "+upDir);
		
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();//업로드 디렉토리 생성
		}
		
		//[2] 업로드한 파일명,파일크기 알아내기
		if(!mf.isEmpty()) {//첨부했다면
			String fname=mf.getOriginalFilename();//원본파일명
			long fsize=mf.getSize();//파일크기
			//파일컨텐트타입
			//String ctype=mf.getContentType();
			UUID uuid=UUID.randomUUID();
			String filename=uuid.toString()+"_"+fname;//물리적 파일명
			log.info("fname: "+fname+", filename: "+filename);
			
			vo.setFilename(filename);//uuid_filename
			vo.setOriginFilename(fname);//filename
			vo.setFilesize(fsize);
		
			//[3] 업로드 처리--transferTo()
			try {
				mf.transferTo(new File(upDir, filename));
				
			} catch (Exception e) {
				log.error("파일 업로드 실패: "+e);
			}
		}//if-------------------
		
		
		MemberVo user = mypageService.getProfile(userName);
		
		
		vo.setM_id(user.getM_ID());
		
		int n=mypageService.updateProfileImage(vo);
		
		if(n>0) {
			
			return "redirect:/user/mypageinfo";
			
		}else {
			m.addAttribute("msg","사진을 선택하십시오");
			m.addAttribute("loc","javascript:history.back()");
			
			return "message";
		}
		
		
		
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
	
	@RequestMapping(value = "/out")
	public String mypageOutProcess(Model m, HttpSession session, String yes) {
		
		String userName= (String)session.getAttribute("userName");
		int n = mypageService.memberOut(userName);
		
		
		
		return "myPageOut";
	}
	
}