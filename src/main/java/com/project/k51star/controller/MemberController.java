package com.project.k51star.controller;

import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.k51star.dto.Account;
import com.project.k51star.security.AccountRepository;
import com.project.k51star.service.MemberService;

@Controller
public class MemberController {
	
	@Resource(name = "com.project.k51star.Service.MemberService")
    MemberService memberService;

	@Autowired
	AccountRepository accountRepository;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@RequestMapping(value ="/myPage", method = RequestMethod.GET)
	public String myPage(Model model,Principal principal) {
		String email = principal.getName();
		model.addAttribute("user", memberService.selectMember(email));
		return "myPage";
	}
	
	@RequestMapping(value ="/loginCheck", method = RequestMethod.GET)
	public @ResponseBody Account loginCheck(Model model,Principal principal) {
		Account account = new Account();
		try {
			String email = principal.getName();
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+email);
			account.setEmail(email);
			return account;
		} catch (Exception e) {
			System.out.println("error");
			return account;
		}
	}
	
	@RequestMapping(value="/deleteMember")
	public String deleteMember(Principal principal,HttpSession session) {
		String email = principal.getName();
		memberService.deleteMember(email);
		session.invalidate();
		return "redirect:/deleteMessage";
	}
	
	@RequestMapping(value="/updateMember")
	public String updateMember(Principal principal,HttpServletRequest request) {
		String email = principal.getName();
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		
		Account account = new Account();
		
		account.setEmail(email);
		account.setName(name);
		//암호화
		account.setPassword(passwordEncoder.encode(password));
		memberService.updateMember(account);
		return "redirect:/myPage";
	}

	@RequestMapping(value="/getKPL", method = RequestMethod.GET)
	public @ResponseBody float getKPL(Model model, Principal principal) {
		String email = principal.getName();
		float r = memberService.searchKPLByEmail(email);
		return r;
	}
}
