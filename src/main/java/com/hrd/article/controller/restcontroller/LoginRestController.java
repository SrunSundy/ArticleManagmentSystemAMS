package com.hrd.article.controller.restcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.LoginFormService;

@Controller
@RequestMapping(value={"/api/login/"})
public class LoginRestController {
	
	@Autowired
	private LoginFormService loginFormService;
	
	/**
	 * 
	 * Get One Row Category
	 */
	@RequestMapping ( value = {"/{email}/{password}"}, method = RequestMethod.GET )
	public ResponseEntity<Map<String,Object>> getCategory(@PathVariable("email") String email, @PathVariable("password") String pwd, HttpServletRequest rs){

		UserDTO user = loginFormService.getUser(email, pwd);
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = rs.getSession();
		if ( user != null ){
			
			session.setAttribute("userObj", user );
			/*UserDTO u = (UserDTO)rs.getSession().getAttribute("userObj");
			System.out.println("Your Email is : " + u.getUemail() );
			System.out.println("Your Password is : " + u.getUpassword() );*/
			
			map.put("MESSAGE", "SUCCESS");
			map.put("STATUS", HttpStatus.OK);
			map.put("RESPONSE_DATA" , user);
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
		
		session.setAttribute("userObj", null );
		map.put("MESSAGE", "FAIL");
		map.put("STATUS", HttpStatus.NOT_FOUND);
		map.put("RESPONSE_DATA", null);
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.NOT_FOUND);
		
	}
	
}
