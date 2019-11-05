package com.project.k51star.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.project.k51star.mapper.RootMapper;

@Service("com.project.k51star.service")
public class RootService {
	@Resource(name = "com.project.k51star.mapper.RootMapper")
    RootMapper mapper;

    public String areaCode(String area_name){
        return mapper.areaCode(area_name);
    }
}
