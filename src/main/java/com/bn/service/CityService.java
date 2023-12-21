package com.bn.service;

import java.util.List;

import com.bn.model.CityVO;

public interface CityService {
    List<CityVO> getAllCities();
    public CityVO getCityById(String cityId);
}

