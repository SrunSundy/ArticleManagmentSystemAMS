package com.hrd.article.controller.restcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value={"/api/logout"})	
public class LogoutRestController {

	@RequestMapping ( value = {"/"}, method = RequestMethod.GET )
	public ResponseEntity<Map<String,Object>> getCategory(HttpServletRequest rs){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		HttpSession session=rs.getSession();
		session.removeAttribute("userObj");
		
		map.put("MESSAGE", "LOGOUT SUCCESS");
		map.put("STATUS", HttpStatus.OK.value());
		
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	
}
