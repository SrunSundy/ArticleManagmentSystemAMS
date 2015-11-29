package com.hrd.article.controller.restcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.LoginFormService;

@Controller
@RequestMapping(value={"/api/login/"})
public class LoginRestController {
	
	@Autowired
	private LoginFormService loginFormService;
	
	/**
	 * 
	 * Login Form
	 */
	@RequestMapping ( value = {"/"}, method = RequestMethod.POST )
	public ResponseEntity<Map<String,Object>> getCategory(@RequestBody UserDTO userDTO  , HttpServletRequest rs){

		UserDTO user = loginFormService.getUser(userDTO.getUemail(), userDTO.getUpassword());
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = rs.getSession();
		if ( user != null ){
			
			session.setAttribute("userObj", user );
			
			System.out.println(session.getAttribute("userObj"));

			map.put("MESSAGE", "SUCCESS");
			map.put("STATUS", HttpStatus.OK.value());
			map.put("RESPONSE_DATA" , user);
			map.put("REDIRECT", "admin/viewlistarticle");
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
		
		session.setAttribute("userObj", null );
		map.put("MESSAGE", "FAIL");
		map.put("STATUS", HttpStatus.NOT_FOUND.value());
		map.put("RESPONSE_DATA", null);
		map.put("REDIRECT", null);
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
	}
	
}
