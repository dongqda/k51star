package com.project.k51star.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.k51star.service.RootService;

@Controller
public class RootController {
	
    @Resource(name = "com.project.k51star.service")
    RootService service;
	
	@RequestMapping(value = "/")
	public String index(Model model) {
		model.addAttribute("testMessage","Hello world!");
		return "index";
	}
	
	@RequestMapping("/admin")
	public void admin() {}
	
	
	@RequestMapping("/login")
	public void login() {}
	
	@RequestMapping(value="/change/code", method=RequestMethod.GET)
	public String change(@Validated String area_name) {
		return service.areaCode(area_name);
	}
}
