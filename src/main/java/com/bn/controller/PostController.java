package com.bn.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bn.model.PostVo;
import com.bn.service.PostService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/blog/*")
@AllArgsConstructor
public class PostController { 
	
	@Autowired
	private PostService service;
	
	@RequestMapping("/userposts") 
 	public String listingPosts(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList());
		
		return "/blog/userposts";
	} 
	
	@GetMapping("/addpost")
	public void addPost() {
		
	}
	
	@RequestMapping("/addpost")
	public String addPost(PostVo post, RedirectAttributes rttr, HttpSession session) {
		String userEmail =  (String)session.getAttribute("userEmail");
		int n = service.searchPid(userEmail);
		post.setM_id(n);
		service.register(post);
		rttr.addFlashAttribute("results", post.getP_id());
		log.info("posting: " + post);
		return "redirect:/blog/posts";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("p_id") int p_id, Model model) {
		log.info("/get or /modi");
		model.addAttribute("post", service.get(p_id));
		model.addAttribute("posts", service.getList());
	}
	
	@PostMapping("/modify")
	public String modify(PostVo post, RedirectAttributes rttr) {
		log.info("modifying: " + post);
		
		if(service.modify(post)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/blog/bloghub";
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("p_id") int p_id, RedirectAttributes rttr) {
		
		log.info("remove......." + p_id);
		
		if(service.remove(p_id)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/blog/bloghub";	// getListLink() 메서드를 이용하면 위 코드를 이렇게 바꿀 수 있다
	}
	@RequestMapping("/bloghub") 
 	public String showBloghub(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList());
		
		return "/blog/bloghub";
	}
	
	@RequestMapping("/bloghub7days") 
 	public String showBloghub7days(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList());
		
		return "/blog/bloghub7days";
	}
	@RequestMapping("/bloghub30days") 
 	public String showBloghub30days(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList());
		
		return "/blog/bloghub30days";
	}
	
	@RequestMapping("/mylikes") 
 	public String showMyLikes(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList());
		
		return "/blog/mylikes";
	}
}