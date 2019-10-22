package com.project.k51star.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RootController {
	
	@RequestMapping(value = "/")
	public String index(Model model) {
		model.addAttribute("testMessage","Hello world!");
		return "index";
	}
	
	@RequestMapping("/admin")
	public void admin() {}
	
	
	@RequestMapping("/login")
	public void login() {}
	
	
}
