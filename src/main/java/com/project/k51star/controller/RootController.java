package com.project.k51star.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RootController {
	
	@RequestMapping(value = "/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/about")
	public void about() {}
	
	@RequestMapping("/contact")
	public void contact() {}
	
	@RequestMapping("/template")
	public void template() {}
	
	@RequestMapping("/dashBoard")
	public void dashBoard() {}
	
	@RequestMapping("/login")
	public void login() {}
	
	
}
