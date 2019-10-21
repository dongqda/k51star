package com.project.oilNav.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.project.oilNav.mapper.Mapper;

@Service("com.project.oilNav.service")
public class MainService{

    @Resource(name = "com.project.oilNav.mapper.Mapper")
    Mapper mapper;

    public String areaCode(String area_name){
        return mapper.areaCode(area_name);
    }
}