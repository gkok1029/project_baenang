package com.bn.controller;

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
	
	@RequestMapping("/posts") 
 	public String listingPosts(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList(0));
		
		return "/blog/posts";
	} 
	
	@GetMapping("/addpost")
	public void addPost() {
		
	}
	
	@RequestMapping("/addpost")
	public String addPost(PostVo post, RedirectAttributes rttr) {
		log.info("posting: " + post);
		
		service.register(post);
		
		rttr.addFlashAttribute("results", post.getP_id());
		
		return "redirect:/blog/posts";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("p_id") int p_id, Model model) {
		log.info("/get or /modi");
		model.addAttribute("post", service.get(p_id));
	}
	
	@PostMapping("/modify")
	public String modiPost(PostVo post, RedirectAttributes rttr) {
		log.info("modifying: " + post);
		
		if(service.modify(post)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/blog/posts";
	}
	
	@RequestMapping("/bloghub") 
 	public String showBloghub(Model model) { 
		
		log.info("posts");
		model.addAttribute("posts", service.getList(0));
		
		return "/blog/bloghub";
	}
	
}