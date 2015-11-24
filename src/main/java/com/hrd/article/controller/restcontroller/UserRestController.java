package com.hrd.article.controller.restcontroller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.UserServices;

@RestController
@RequestMapping("/api/user")
public class UserRestController {
	@Autowired
	private UserServices userService;
	
	//Get All user default
	@RequestMapping(value="/",method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listUser() {
		List<UserDTO> list=userService.listUser();
		Map<String,Object> map=new HashMap<String, Object>();
		if(list.isEmpty()){
			map.put("STATUS",HttpStatus.NOT_FOUND.value());
			map.put(" MESSAGE","USER HAVE NOT BEEN FOUND");
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.NOT_FOUND);
		}
		map.put("RESPONSE_DATA",list);
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","USER HAVE BEEN FOUND");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.FOUND);
	}
	
	//Get user by user id
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getUser(@PathVariable("id") int id){
		UserDTO user=userService.getUser(id);
		Map<String,Object> map=new HashMap<String, Object>();
		if(user==null){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE","USER NOT FOUND");
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.NOT_FOUND);
		}
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "USER HAS BEEN FOUNDS");
		map.put("RESPONSE_DATA", user);
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	//Get user with page and key
	@RequestMapping(value="/{page}/{key}",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getUser(@PathVariable("page") int page,@PathVariable("key") String key){
		List<UserDTO> list=userService.listUser(page, key);
		Map<String,Object> map=new HashMap<String, Object>();
		if(list.isEmpty()){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE","USER NOT FOUND");
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.NOT_FOUND);
		}
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "USER HAS BEEN FOUNDS");
		map.put("RESPONSE_DATA", list);
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	//User Status
	@RequestMapping(value="toggle/{id}",method=RequestMethod.PATCH)
	public ResponseEntity<Map<String,Object>> addUser(@PathVariable("id") int id) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.statusUser(id) == 0){
			    map.put("STATUS", HttpStatus.NOT_FOUND.value());
			    map.put("MESSAGE","FAILD TO ENABLE USERT");
				return new ResponseEntity<Map<String,Object>>(map,HttpStatus.NOT_FOUND);
		}
	
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","SUCCESS TO DISABLE USERT");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.FOUND);
	}
	
	//Insert User
	@RequestMapping(value="/",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> addUser(@RequestBody UserDTO user) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.insertUser(user) == 0){
			    map.put("STATUS", HttpStatus.NOT_FOUND.value());
			    map.put("MESSAGE","FAILD TO INSET USERT");
				return new ResponseEntity<Map<String,Object>>(map,HttpStatus.NOT_FOUND);
		}
	
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","SUCCESS TO INSET USERT");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.FOUND);
	}
	//Update User
		@RequestMapping(value="/",method=RequestMethod.PUT)
		public ResponseEntity<Map<String,Object>> upadteUser(@RequestBody UserDTO user) {
			Map<String,Object> map=new HashMap<String, Object>();
			if(userService.editUser(user) == 0){
				    map.put("STATUS", HttpStatus.NOT_FOUND.value());
				    map.put("MESSAGE","FAILD TO UPDATE USERT");
					return new ResponseEntity<Map<String,Object>>(map,HttpStatus.NOT_FOUND);
			}
		
			map.put("STATUS", HttpStatus.FOUND.value());
			map.put("MESSAGE","SUCCESS TO UPDATE USERT");
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.FOUND);
		}
	
}