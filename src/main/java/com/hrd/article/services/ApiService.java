package com.hrd.article.services;

import java.util.List;

import com.hrd.article.entities.ApiDTO;

public interface ApiService {
	
	public List<ApiDTO> getAPI(String type);
	
}
