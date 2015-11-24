package com.hrd.article.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hrd.article.entities.CategoryDTO;
import com.hrd.article.services.CategoryService;

@Controller
public class CategoryController {

/*	@Autowired
	private CategoryService categoryService;*/
	
	@RequestMapping ( value = {"/","home" }, method = RequestMethod.GET)
	public String homePage() {
		//Category category = new Category();
		//boolean bool = categoryService.isInsertCategory(category);
		
/*		List<Category> list = categoryService.searchCategoryByName("sok");
		
		for (Category category : list) {
			System.out.println(category.getId() +"  "+ category.getName());
			
		}*/
		
		
/*		Category category = categoryService.getCategory(3);
		System.out.println(category.getId() +" "+ category.getName());*/

//		System.out.println("total is: " + categoryService.getTotalCategory());
		
		return "home";
	}
}
