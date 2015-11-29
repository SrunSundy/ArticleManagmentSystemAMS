package com.hrd.article.controller.restcontroller;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
		map.put("ROW_COUNT", userService.rowCount("*"));
		map.put("RESPONSE_DATA",list);
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE","USER HAVE BEEN FOUND");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	
	//Get user by user id
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getUser(@PathVariable("id") int id){
		UserDTO user=userService.getUser(id);
		Map<String,Object> map=new HashMap<String, Object>();
		if(user==null){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE","USER NOT FOUND");
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
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
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
		map.put("ROW_COUNT", userService.rowCount("*"));
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "USER HAS BEEN FOUNDS");
		map.put("RESPONSE_DATA", list);
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	
	//User Status
	@RequestMapping(value="toggle/{id}",method=RequestMethod.PATCH)
	public ResponseEntity<Map<String,Object>> addUser(@PathVariable("id") int id) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.statusUser(id) == 0){
		    map.put("STATUS", HttpStatus.NOT_FOUND.value());
		    map.put("MESSAGE","FAILD TO ENABLE USERT");
		    return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
	
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","SUCCESS TO DISABLE USERT");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	
	//Insert User
	@RequestMapping(value="/",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> addUser(@RequestBody UserDTO user) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.insertUser(user) == 0){
		    map.put("STATUS", HttpStatus.NOT_FOUND.value());
		    map.put("MESSAGE","FAILD TO INSET USERT");
		    return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
	
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","SUCCESS TO INSET USERT");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	//Update User
	@RequestMapping(value="/",method=RequestMethod.PUT)
	public ResponseEntity<Map<String,Object>> upadteUser(@RequestBody UserDTO user) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.editUser(user) == 0){
		    map.put("STATUS", HttpStatus.NOT_FOUND.value());
		    map.put("MESSAGE","FAILD TO UPDATE USERT");
		    return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
	
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","SUCCESS TO UPDATE USERT");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	//change password
	@RequestMapping(value="changepassword",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>>changepassword(@RequestBody String data) throws ParseException {	
		Map<String,Object> map=new HashMap<String, Object>();
		//for get data from json string
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(data);
		// get a String from the JSON object
		String newpass = (String) jsonObject.get("newpass");
		String oldpass = (String) jsonObject.get("oldpass");
		String idd = (String) jsonObject.get("id");
		int id = Integer.parseInt(idd);
		if(oldpass.equals(userService.getCurrentPassword(id).getUpassword())){
			if(userService.changeUserPassword(newpass, id)==1){
				 map.put("STATUS", HttpStatus.OK.value());
				 map.put("MESSAGE","PASSWORD HAVE BEEN CHANGE");
				 return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			}else{
				map.put("STATUS", HttpStatus.NOT_FOUND.value());
				map.put("MESSAGE","PASSWORD FAILD TO UPDATE");
				return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			}
		}else{
			map.put("STATUS",HttpStatus.FOUND.value());
			map.put("MESSAGE","OLD PASSWORD DID NOT MARTCH");
		}
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);	
	}
	//get number of user
	@RequestMapping(value="/getrow/{key}",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getUser(@PathVariable("key") String key) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(userService.rowCount(key) == 0){
		    map.put("STATUS", HttpStatus.NOT_FOUND.value());
		    map.put("MESSAGE","NO RECORD FOUND ");
		    return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}
	    map.put("RESPONSE_DATA", userService.rowCount(key));
		map.put("STATUS", HttpStatus.FOUND.value());
		map.put("MESSAGE","RECORD FOUND");
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
	}
	@RequestMapping(value="/uploadimg", method= RequestMethod.POST )
	public ResponseEntity<Map<String,Object>> uploadImage( @RequestParam("file") MultipartFile file, HttpServletRequest request){
		Map<String, Object> map  = new HashMap<String, Object>();
		if(!file.isEmpty()){
			try{
				UUID uuid = UUID.randomUUID();
	            String originalFilename = file.getOriginalFilename(); 
	            String extension = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
	            String randomUUIDFileName = uuid.toString();
	            
	            String filename = originalFilename;
				byte[] bytes = file.getBytes();

				// creating the directory to store file
				String savePath = request.getSession().getServletContext().getRealPath("/resources/images/");
				System.out.println(savePath);
				File path = new File(savePath);
				if(!path.exists()){
					path.mkdir();
				}
				
				// creating the file on server
				File serverFile = new File(savePath + File.separator + filename );
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				
				System.out.println(serverFile.getAbsolutePath());
				System.out.println("You are successfully uploaded file " + filename);
				map.put("MESSAGE","UPLOAD IMAGE SUCCESS");
				map.put("STATUS", HttpStatus.OK.value());
				return new ResponseEntity<Map<String,Object>>
									(map, HttpStatus.OK);
			}catch(Exception e){
				System.out.println("You are failed to upload  => " + e.getMessage());
			}
		}else{
			System.err.println("File not found");
		}
		return null;
	}
	
}