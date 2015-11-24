package com.hrd.article.controller;

import java.sql.SQLException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class VeiwArticleController {

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
}
