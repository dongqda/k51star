package com.project.k51star.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.k51star.dto.CarInfoDto;

@Repository("com.project.k51star.mapper.CarMapper")
public interface CarMapper {
	
	//모델로 차량 검색
	public List<CarInfoDto> searchByModel(String car_model);
	
	public List<String> categoryFuel();
}