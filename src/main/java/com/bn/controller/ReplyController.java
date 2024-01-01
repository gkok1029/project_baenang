package com.bn.controller;

import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.bn.model.ReplyVo;
import com.bn.service.MemberService;
import com.bn.service.PostService;
import com.bn.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService replyservice;
	
	@Autowired
	private PostService service;
	
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String posttWirte(ReplyVo vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		replyservice.register(vo);
		String userEmail =  (String)session.getAttribute("userEmail");
		int n = replyservice.searchPid(userEmail);
		vo.setM_id(n);
		rttr.addFlashAttribute("results", vo.getP_id());
		
		return "redirect:/blog/get?p_id=" + vo.getP_id();
	}
	
	@PostMapping("/remove")
	public String remove(ReplyVo vo, @RequestParam("r_id") int r_id, RedirectAttributes rttr) {
		
		log.info("remove......." + r_id);
		
		if(service.remove(r_id)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/blog/get?p_id=" + vo.getP_id();
	}
	
}