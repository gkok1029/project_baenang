package com.bn.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bn.model.MemberVo;
import com.bn.model.PageVo;
import com.bn.service.MemberService;
import com.bn.service.SignupService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MemberController {

	@Autowired
	private SignupService signupService;
	
	@Autowired
	private MemberService memberService;
	
	@ResponseBody
	@PostMapping("/signup")
	public String Signup(MemberVo member) {
	boolean result = signupService.validateSignup(member);
		if(result == true) {
		signupService.signup(member);
		return "success";
		} 
		return "failed";
	}

	@ResponseBody
	@PostMapping("/loginCheck2")
	public String loginCheck2(MemberVo member, HttpSession session, HttpServletResponse response) {
		String name = memberService.loginCheck2(member);
		int status = memberService.statusCheck(member.getM_EMAIL());
		if(name != null && status == 1) {
			 Cookie userCookie = new Cookie("sessionId", session.getId());
		        userCookie.setMaxAge(60*30); 
		        userCookie.setPath("/");
		        response.addCookie(userCookie);
		        session.setAttribute("userName", name);
		        session.setAttribute("userEmail", member.getM_EMAIL());
			return "success";
		}else if(status == -1){
			return "deleted";
		}else
			return "failed";
	}
	
	@RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // ���� �ʱ�ȭ (�α׾ƿ�)
        return "redirect:/login"; // �α׾ƿ� �� �α��� �������� �̵�
    }
	
	@RequestMapping("/login")
	public String Login() {
		
		return "login";
	}
	
	@RequestMapping("/forgot")
	public String goForgot() {
		
		return "forgot";
	}
	
	@RequestMapping(value = "/user/mypage")
	public String mypage(Model m, HttpSession session, @RequestParam(defaultValue="recentday")String filter) {
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			return "error";
		}
		MemberVo un= memberService.getProfile(userName);
		PageVo page = new PageVo();
		page.setM_nname(userName);
		page.setFilter(filter);
		page.setM_id(un.getM_ID());
		
		List<PageVo> pl= memberService.getPlanList(page);
		ServletContext app=session.getServletContext();
		String upDir=app.getRealPath("/resources/profile");
		log.info("upDir: "+upDir);
		
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		m.addAttribute("user", un);
		m.addAttribute("plan", pl);
		return "myPage";
	}
	
	@RequestMapping(value = "/user/mypageinfo")
	public String mypageInfo(Model m, HttpSession session, String nick) {
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			return "error";
		}
		MemberVo user = memberService.getProfile(userName);
		m.addAttribute("user", user);
		return "myPageInfo";
	}
	
	@RequestMapping(value = "/user/mypageinfopic")
	public String mypageInfo(Model m, HttpSession session, 
			@RequestParam("editmf") MultipartFile mf, PageVo page) {
		log.info("editmf: "+mf);
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			return "error";
		}
		ServletContext app=session.getServletContext();
		String upDir=app.getRealPath("/resources/profile");
		log.info("upDir: "+upDir);
		
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		if(!mf.isEmpty()) {
			String fname=mf.getOriginalFilename();
			int fsize=(int)mf.getSize();
			UUID uuid=UUID.randomUUID();
			String filename=uuid.toString()+"_"+fname;
			log.info("fname: "+fname+", filename: "+filename);
			page.setFilename(filename);
			page.setOriginFilename(fname);
			page.setFilesize(fsize);
		
			try {
				mf.transferTo(new File(upDir, filename));
				
			} catch (Exception e) {
			}
		}//if-------------------
		MemberVo user = memberService.getProfile(userName);
		page.setM_id(user.getM_ID());
		int n=memberService.updateProfileImage(page);
		
		if(n>0) {
			return "redirect:/user/mypageinfo";
		}else {
			m.addAttribute("msg","������ �����Ͻʽÿ�");
			m.addAttribute("loc","javascript:history.back()");
			return "message";
		}
	}
	
	@RequestMapping(value = "/user/mypageinfosubmit")
	public String mypageInfosubmit(Model m, HttpSession session, String nick) {
		String userName= (String)session.getAttribute("userName");
		
		if(userName==null) {
			return "error";
		}
		
		MemberVo user = memberService.getProfile(userName);
		MemberVo tmp = new MemberVo();
		tmp.setM_NNAME(nick);
		tmp.setM_ID(user.getM_ID());
		int nn= memberService.updateNickname(tmp);
		if(nn>0) {
			user.setM_NNAME(nick);
			session.setAttribute("userName", nick);
		}
		m.addAttribute("user", user);
		return "redirect:/user/mypage";
	}
	
	@RequestMapping(value = "/user/mypagepwdchange")
	public String mypagepwdChange(Model m, HttpSession session) {
		return "myPagepwdChange";
	}
	
	@RequestMapping(value = "/user/pwdchange")
	public String mypagepwdChangeProcess(Model m, String p1, String p2, HttpSession session) {
		String userName= (String)session.getAttribute("userName");
		MemberVo user = memberService.getProfile(userName);
		MemberVo tmp = new MemberVo();
		tmp.setM_PWD(p1);
		tmp.setM_EMAIL(user.getM_EMAIL());
		int p= memberService.passwordCheck(tmp);
		
		if(p>0) {
			user.setM_PWD(p2);
			
			int n= memberService.updatePwd(user);
			String msg=(n>0)?"��й�ȣ ���� �Ϸ�":"���� ����";
			m.addAttribute("msg",msg);
			
			return "message2";
		} else {
			
			m.addAttribute("msg","��й�ȣ�� ��ġ���� �ʽ��ϴ�");
			m.addAttribute("loc","javascript:history.back()");
			return "message";
		}
	}
	
	@RequestMapping(value = "/user/mypageout")
	public String mypageOut(Model m, HttpSession session) {
		return "myPageOut";
	}
	
	@RequestMapping(value = "/user/out")
	public String mypageOutProcess(Model m, HttpSession session) {
		String userName= (String)session.getAttribute("userName");
		MemberVo user = memberService.getProfile(userName);
		MemberVo tmp = new MemberVo();
		
		tmp.setM_ID(user.getM_ID());
		int n = memberService.memberOut(tmp);
		
		if(n>0) {
		 
			String msg = "ȸ�� Ż�� �Ϸ�";
			m.addAttribute("result",msg);
			m.addAttribute("loc","/login");
			session.invalidate();
			return "myPageOut";
		} else {
			String msg = "�����߻�<br>�����Ϳ� �����ϼ���";
		 	m.addAttribute("msg",msg);
		 	return "message2";
		}
		
	}
	
	@RequestMapping(value = "/user/delplan")
	public String delPlan(Model m, HttpSession session, PageVo page) {
		String userName= (String)session.getAttribute("userName");
		MemberVo user = memberService.getProfile(userName);
		page.setM_nname(userName);
		int nn= memberService.deleteDPlan(page);
		int n= memberService.deletePlan(page);
		
		if(n>0 & nn>0) {
			return "redirect:/user/mypage";
		} else {
			
			return "redirect:/user/mypage";
		}
	}
	
	@RequestMapping(value = "/user/upplan", method=RequestMethod.GET)//p_id�Ķ���� ���� �Ѱ���� �Ѵ�
	public String upPlan(Model m, HttpSession session, PageVo my) {
		String userName= (String)session.getAttribute("userName");
		MemberVo user = memberService.getProfile(userName);
		session.setAttribute("p_id",my.getP_id());
		return "redirect:/plan";
	}
}
