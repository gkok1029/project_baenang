package com.bn.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ApiKeyService {
	@Value("${NAVER_MAPS_KEY}")
	private String apiKey;
}
