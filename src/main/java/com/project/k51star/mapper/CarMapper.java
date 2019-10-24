package com.project.k51star.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.project.k51star.dto.CarInfoDto;

@Repository("com.project.k51star.mapper.CarMapper")
public interface CarMapper {
	
	public List<String> categoryFuel();
	
	//모델로 차량 검색
	public List<CarInfoDto> searchModel(Map<String, String> map);
	
}