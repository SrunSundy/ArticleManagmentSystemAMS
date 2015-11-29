package com.hrd.article.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

	@RequestMapping( value={"/"})
	public String getStudentList(ModelMap model) throws SQLException{
			
		model.addAttribute("message","Hellosdfsf");
		return "home";
		
	}
	
	
	@RequestMapping(value="/detail/{id}")
	public String detailPage(ModelMap model, @PathVariable int id){
		model.addAttribute("articleid",id);
		return "detail";
	}
	
	@RequestMapping( value="/help")
	public String helpPage(){
		return "help";
	}	
	@RequestMapping( value="/login")
	public String loginPage(){
		return "login";
	}	
	@RequestMapping( value="/logout")
	public void logoutPage( HttpServletRequest rs,HttpServletResponse response) throws IOException{
		HttpSession session=rs.getSession();
		session.removeAttribute("userObj");
		System.out.print("This is admin logout");
		response.sendRedirect("login");
	}	
	
	
	
}
