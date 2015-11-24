package com.hrd.article.controller.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hrd.article.entities.ArticleDTO;
import com.hrd.article.entities.CategoryDTO;
import com.hrd.article.services.ArticleFrontEndService;

@RestController("/")
public class ArticleFrontEnd {

	@Autowired
	private ArticleFrontEndService articlefrontendservice;
	
	@RequestMapping ( value = {"/listcate/{page}"}, method = RequestMethod.GET )
	public ResponseEntity<Map<String,Object>> listCategory(@PathVariable("page") int page){
		List<CategoryDTO> list = articlefrontendservice.listCategory(page);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		if ( !list.isEmpty() ){
			map.put("MESSAGE", "LIST CATEGORY SUCCESS...!");
			map.put("STATUS", HttpStatus.OK.value());
			map.put("RESPONSE_DATA" , list);
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
		map.put("MESSAGE", "LIST CATEGORY FAIL...!");
		map.put("STATUS", HttpStatus.NOT_FOUND.value());
		map.put("RESPONSE_DATA", null);
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="listarticle/{page}/{key}/{category}/{user}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listArticles(@PathVariable("page") int page,@PathVariable("key") String key,@PathVariable("category") int category,@PathVariable("user") int user){
		System.err.println("Testing");
		List<ArticleDTO> articles = articlefrontendservice.listArticle(page, key, category, user);
		System.err.println(articles);
		Map<String, Object> map = new HashMap<String,Object>();
		if(articles.isEmpty()){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE", "ARTICLE NOT FOUND...");
			return new ResponseEntity<Map<String,Object>>
										(map,HttpStatus.NO_CONTENT);
		}	
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ARITCLE HAS BEEN FOUND"+articles.size());
		map.put("RESPONSE_DATA",articles);
		return new ResponseEntity<Map<String,Object>>
									(map,HttpStatus.OK);	
	}
}
