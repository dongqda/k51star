package com.project.k51star.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.k51star.service.RootService;

@Controller
public class RootController {
	
    @Resource(name = "com.project.k51star.service")
    RootService service;
	
	@RequestMapping(value = "/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/about")
	public void about() {}
	
	@RequestMapping("/contact")
	public void contact() {}
	
	@RequestMapping("/chart")
	public void chart() {}
	
	@RequestMapping("/dashBoard")
	public void dashBoard() {}
	
	@RequestMapping("/deleteMessage")
	public void deleteMessage() {}
	
	
	@RequestMapping(value="/change/code", method=RequestMethod.GET)
	@ResponseBody
	public String change(@Validated String area_name) {
		String area_code = service.areaCode(area_name);
		return area_code;
	}
}
