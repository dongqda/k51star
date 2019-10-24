package com.project.k51star.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.project.k51star.dto.Account;
import com.project.k51star.mapper.MemberMapper;

@Service("com.project.k51star.Service.MemberService")
public class MemberService {
	@Resource(name = "com.project.k51star.mapper.MemberMapper")
    MemberMapper memberMapper;

    public Account selectMember(String email){
        return memberMapper.selectMember(email);
    }
    public void updateMember(Account account){
    	memberMapper.updateMember(account);
    }
    public void deleteMember(String email){
    	memberMapper.deleteMember(email);
    }
}
