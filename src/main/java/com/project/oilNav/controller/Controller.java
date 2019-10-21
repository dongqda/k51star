package com.project.oilNav.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.project.oilNav.service.MainService;

//controller

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class Controller{
    
    @Resource(name = "com.project.oilNav.service")
    MainService service;
    
    @RequestMapping(value = "/change/code/{area_name}", method=RequestMethod.GET)
    private String changeAreaCode(@PathVariable String area_name){
        return service.areaCode(area_name);
    }
}