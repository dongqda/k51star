package com.project.k51star.mapper;

import org.springframework.stereotype.Repository;

import com.project.k51star.dto.Account;

@Repository("com.project.k51star.mapper.MemberMapper")
public interface MemberMapper {
	
    public Account selectMember(String email); 
    public void updateMember(Account account); 
    public void deleteMember(String email); 
}