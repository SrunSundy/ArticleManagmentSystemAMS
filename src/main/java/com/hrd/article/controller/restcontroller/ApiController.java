package com.hrd.article.controller.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hrd.article.entities.ApiDTO;
import com.hrd.article.services.ApiService;

@RestController
@RequestMapping("api/doc")
public class ApiController {

	@Autowired
	ApiService api;
	
	@RequestMapping("/{type}")
	public List<ApiDTO> help(@PathVariable String type) {
		return api.getAPI(type);
	}
}
