package com.project.k51star;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.project.k51star.dto.Account;
import com.project.k51star.security.AccountRepository;

@SpringBootApplication
public class K51starApplication {

	public static void main(String[] args) {
		SpringApplication.run(K51starApplication.class, args);
	}

	@Autowired 
	AccountRepository accountRepository;
   
	@Autowired
	PasswordEncoder passwordEncoder;
	
    @Bean
    InitializingBean insertFixtureUsers(){
		return ()->{
			Account admin = new Account();
			admin.setEmail("admin@admin.com");
			admin.setPassword(passwordEncoder.encode("1234"));
			admin.setRole("ROLE_ADMIN");
			admin.setName("관리자");
			accountRepository.save(admin);
			
			Account dongq = new Account();
			dongq.setEmail("dongq@dongq.com");
			dongq.setPassword(passwordEncoder.encode("1234"));
			dongq.setRole("ROLE_USER");
			dongq.setName("동규");
			accountRepository.save(dongq);
			
			Account beomhyun = new Account();
			beomhyun.setEmail("beomhyun@beomhyun.com");
			beomhyun.setPassword(passwordEncoder.encode("1234"));
			beomhyun.setRole("ROLE_USER");
			beomhyun.setName("범현");
			accountRepository.save(beomhyun);
			
			Account garden = new Account();
			garden.setEmail("garden@garden.com");
			garden.setPassword(passwordEncoder.encode("1234"));
			garden.setRole("ROLE_USER");
			garden.setName("정원");
			accountRepository.save(garden);
		};
	}
	
}
