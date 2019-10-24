package com.project.k51star.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.project.k51star.dto.Account;

// 기선님의 아무고나 소스 참조함.
public class UserDetailsImpl extends User {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String name;
	private String email;
	public String getName() { return name;}
	public String getEmail() { return email;}
	public void setName(String name) {this.name = name; }
	public void setEmail(String email) {this.email = email; }
	
	public UserDetailsImpl(Account account) {
		super(account.getEmail(), account.getPassword(), authorities(account));
		this.name = account.getName(); 
		this.email = account.getEmail(); 
	}

	private static Collection<? extends GrantedAuthority> authorities(Account account) {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(account.getRole()));
		return authorities;
	}

	
	
	
}
