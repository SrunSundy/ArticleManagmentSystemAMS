package com.hrd.article.controller;

import java.sql.SQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/admin/")
public class AdminController {

/*	@Autowired
	private CategoryService categoryService;*/
	
	@RequestMapping ( value = {"/category"}, method = RequestMethod.GET)
	public String homePage() {
		
		return "admin/category";
	}
	@RequestMapping( value={"/article"})
	public String gotoArticle(ModelMap model) throws SQLException{
			
		model.addAttribute("message","Hellosdfsf");
		return "admin/article";
		
	}
	@RequestMapping( value={"/viewlistarticle"})
	public String gotoListArticle(ModelMap model) throws SQLException{
			
		model.addAttribute("message","Hellosdfsf");
		return "admin/listarticle";
		
	}
	
	/*User Controller*/
	@RequestMapping(value="/listuser")
	public String listUser(){
		return "admin/listuser";
	}
}
