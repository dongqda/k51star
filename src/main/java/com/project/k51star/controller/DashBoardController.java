package com.project.k51star.controller;

import java.io.IOException;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.k51star.service.Parser;

@Controller
public class DashBoardController {
	
    @Resource(name = "com.project.k51star.parser")
    Parser service;
	
	@RequestMapping(value="/parsing", method=RequestMethod.GET)
	@ResponseBody
	public JSONObject change(@Validated String requesturl) throws IOException {
		JSONObject jsonobj = service.parsing(requesturl);
		return jsonobj;
	}
	
	
}
