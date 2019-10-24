package com.project.k51star.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.k51star.security.AccountRepository;
import com.project.k51star.service.MemberService;

@Controller
public class MemberController {
	
	@Resource(name = "com.project.k51star.Service.MemberService")
    MemberService memberService;

	@Autowired
	AccountRepository accountRepository;
	
	@RequestMapping(value ="/myPage", method = RequestMethod.GET)
	public String myPage(Model model,HttpServletRequest request) {
		String email=request.getParameter("email");
		model.addAttribute("user", memberService.selectMember(email));
		return "myPage";
	}
	
	@RequestMapping(value ="/userinformation", method = RequestMethod.GET)
	public void userinformation(Model model) {
		model.addAttribute("user", accountRepository.findMe());
	}
	
}
