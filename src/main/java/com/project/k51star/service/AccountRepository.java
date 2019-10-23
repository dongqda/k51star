package com.project.k51star.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.k51star.dto.Account;

public interface AccountRepository extends JpaRepository<Account, Long>{
	public Account findByEmail(String email);
}
