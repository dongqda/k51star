package com.project.k51star.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.project.k51star.dto.CarInfoDto;
import com.project.k51star.mapper.CarMapper;

@Service("com.project.k51star.CarService")
public class CarService {
	@Resource(name = "com.project.k51star.mapper.CarMapper")
    CarMapper mapper;
	
	public List<String> categoryFuel(){
		return mapper.categoryFuel();
	}
	
	public List<CarInfoDto> searchModel(Map<String, String> map) {
		return mapper.searchModel(map);
	}
	
	public void updateCarInfo(Map<String,Integer> map) {
		mapper.updateCarInfo(map);
	}
	
	public void insertCarInfo(Map<String,Integer> map) {
		mapper.insertCarInfo(map);
	}
}
