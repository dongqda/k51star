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
	//이미 등록된 차량이 있을 때 정보 업데이트
	public void updateCarInfo(Map<String, Integer> map);
	//처음 등록하는 경우
	public void insertCarInfo(Map<String, Integer> map);
	public CarInfoDto searchCarInfoByEmail(String email);
	
}