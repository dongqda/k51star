package com.project.k51star.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.project.k51star.dto.CarInfoDto;
import com.project.k51star.mapper.CarMapper;

@Service("com.project.k51star.CarService")
public class CarService {
	@Resource(name = "com.project.k51star.mapper.CarMapper")
    CarMapper mapper;
	
	public List<CarInfoDto> searchByModel(String car_model) {
		return mapper.searchByModel(car_model);
	}
	
	public List<String> categoryFuel(){
		return mapper.categoryFuel();
	}
}
