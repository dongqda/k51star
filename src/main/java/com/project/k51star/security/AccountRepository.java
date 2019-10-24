package com.project.k51star.security;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.project.k51star.dto.Account;

public interface AccountRepository extends JpaRepository<Account, Long>{
	Account findByEmail(String email);

	@Query("select a from Account a where a.email = ?#{ principal.username }")
	Account findMe();

}
