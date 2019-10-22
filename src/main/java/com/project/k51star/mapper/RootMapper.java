package com.project.k51star.mapper;

import org.springframework.stereotype.Repository;

@Repository("com.project.k51star.mapper.RootMapper")
public interface RootMapper {
	
	   //지역이름에 해당하는 코드 반환
    public String areaCode(String area_name);
}