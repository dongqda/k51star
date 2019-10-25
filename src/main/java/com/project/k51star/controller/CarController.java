package com.project.k51star.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.k51star.dto.CarInfoDto;
import com.project.k51star.service.CarService;
import com.project.k51star.service.MemberService;

@Controller
public class CarController {
	
    @Resource(name = "com.project.k51star.CarService")
    CarService service;
    
    @Resource(name="com.project.k51star.Service.MemberService")
    MemberService memservice;
	
	@RequestMapping(value = "/car")
	public void car() {}
	
	@RequestMapping(value = "/car/fuel")
	@ResponseBody
	public List<String> categoryFuel() {
		List<String> fuelList = service.categoryFuel();
		return fuelList;
	}
	
	@RequestMapping(value = "/car/search")
	@ResponseBody
	public List<CarInfoDto> searchByModel(@Validated String fuel, @Validated String car_model) {
		Map<String,String> map = new HashMap<String, String>();
		map.put("fuel", fuel);
		map.put("car_model",car_model);
		
		List<CarInfoDto> carList = service.searchModel(map);
		return carList;
	}
	
	@RequestMapping(value="/car/info", method=RequestMethod.GET)
	public String regCarInfo(@Validated int car_id, @Validated int member_id) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("member_id", member_id);
		map.put("car_id",car_id);
		if(memservice.searchMemberById(member_id) != 0) {
			service.updateCarInfo(map);
		}else {
			service.insertCarInfo(map);
		}
		return "myPage";
	}
	
}
