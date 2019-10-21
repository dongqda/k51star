package com.project.oilNav.mapper;

import org.springframework.stereotype.Repository;

@Repository("com.project.oilNav.mapper.Mapper")
public interface Mapper{

    //지역이름에 해당하는 코드 반환
    public String areaCode(String area_name);
}