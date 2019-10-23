package com.project.k51star.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.k51star.dto.CarInfoDto;
import com.project.k51star.service.CarService;

@Controller
public class CarController {
	
    @Resource(name = "com.project.k51star.CarService")
    CarService service;
	
	@RequestMapping(value = "/car")
	public void car() {}
	
	@RequestMapping(value = "/car/search")
	@ResponseBody
	public List<CarInfoDto> searchByModel(@Validated String car_model) {
		System.out.println(car_model);
		List<CarInfoDto> carList = service.searchByModel(car_model);
		for(int i=0;i<carList.size();i++) {
			System.out.println(carList.get(i));
		}
		return carList;
	}
	
	@RequestMapping(value = "/car/fuel")
	@ResponseBody
	public List<String> categoryFuel() {
		List<String> fuelList = service.categoryFuel();
		return fuelList;
	}
}
