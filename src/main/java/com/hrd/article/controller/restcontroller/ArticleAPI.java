package com.hrd.article.controller.restcontroller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import com.hrd.article.entities.ArticleDTO;
import com.hrd.article.services.ArtitcleServices;

@RestController
@RequestMapping("api/article")
public class ArticleAPI {

	@Autowired
	private ArtitcleServices articleservice;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listArticles(){
		List<ArticleDTO> articles = articleservice.listArticles(0,"*");
		Map<String, Object> map = new HashMap<String,Object>();
		if(articles.isEmpty()){
			map.put("STATUS", HttpStatus.OK.value());
			map.put("MESSAGE", "ARTICLE NOT FOUND...");

			return new ResponseEntity<Map<String,Object>>
							(map,HttpStatus.OK);

		}	
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ARITCLE HAS BEEN FOUND");
		map.put("RESPONSE_DATA",articles);
		return new ResponseEntity<Map<String,Object>>
									(map,HttpStatus.OK);	
	}
	
	@RequestMapping(value="/{page}/{key}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listArticles(@PathVariable("page") int page , @PathVariable("key") String key){
		List<ArticleDTO> articles = articleservice.listArticles(page,key);
		Map<String, Object> map = new HashMap<String,Object>();
		if(articles.isEmpty()){
			map.put("STATUS", HttpStatus.OK.value());
			map.put("MESSAGE", "ARTICLE NOT FOUND...");
			return new ResponseEntity<Map<String,Object>>
										(map,HttpStatus.OK);
		}	
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ARITCLE HAS BEEN FOUND");
		map.put("RESPONSE_DATA",articles);
		return new ResponseEntity<Map<String,Object>>
									(map,HttpStatus.OK);	
	}
	
	
	@RequestMapping(value="/", method= RequestMethod.POST )
	public ResponseEntity<Map<String,Object>> insertArticle(@RequestBody ArticleDTO article){
	
		Map<String, Object> map  = new HashMap<String, Object>();
	
		if(articleservice.insertArticle(article)==1){
			
			map.put("MESSAGE","ARTICLE HAS BEEN INSERTED.");
			map.put("STATUS", HttpStatus.OK.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}else{
			map.put("MESSAGE","INSERT FAILS.");
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}
		
	}
	
	@RequestMapping(value="/uploadimg", method= RequestMethod.POST )
	public ResponseEntity<Map<String,Object>> uploadImage( @RequestParam("file") MultipartFile file, HttpServletRequest request){
		Map<String, Object> map  = new HashMap<String, Object>();
		System.err.println("HELLO");
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
	
	
	@RequestMapping(value="/", method= RequestMethod.PUT )
	public ResponseEntity<Map<String,Object>> updateArticle(@RequestBody ArticleDTO article){


		Map<String, Object> map  = new HashMap<String, Object>();
		if(articleservice.updateArticle(article)==1){
			map.put("MESSAGE","ARTICLE HAS BEEN UPDATED.");
			map.put("STATUS", HttpStatus.OK.value());
			map.put("REDIRECT", "viewlistarticle");
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}else{
			map.put("MESSAGE","UPDATE FAILS.");
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}
	}
	
	@RequestMapping(value="/{id}", method= RequestMethod.DELETE )
	public ResponseEntity<Map<String,Object>> deleteArticle(@PathVariable("id") int id){
		
		Map<String, Object> map  = new HashMap<String, Object>();
		if(articleservice.deleteArticle(id)==1){
			map.put("MESSAGE","ARTICLE HAS BEEN DELETED.");
			map.put("STATUS", HttpStatus.OK.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}else{
			map.put("MESSAGE","DELETE FAILS.");
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listArticle(@PathVariable("id") int id ){
		
		ArticleDTO article= articleservice.listArticle(id);
		System.err.println(article);
		Map<String, Object> map = new HashMap<String,Object>();
		if(article == null){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE", "ARTICLE NOT FOUND...");
			return new ResponseEntity<Map<String,Object>>
										(map,HttpStatus.OK);
		}
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ARITCLE HAS BEEN FOUND");
		map.put("RESPONSE_DATA", article);
		return new ResponseEntity<Map<String,Object>>
									(map,HttpStatus.OK);	
	}
	
	@RequestMapping(value="/toggle/{id}", method= RequestMethod.PATCH )
	public ResponseEntity<Map<String,Object>> toggleArticle(@PathVariable("id") int id){
		
		Map<String, Object> map  = new HashMap<String, Object>();
		if(articleservice.toggleArticle(id)==1){
			map.put("MESSAGE","STATUS IS CHANGED");
			map.put("STATUS", HttpStatus.OK.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}else{
			map.put("MESSAGE","FAIL TO CHANGE STATUS");
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<Map<String,Object>>
								(map, HttpStatus.OK);
		}
	}
	
	
	@RequestMapping(value="/getrow", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> getRow(){
		System.err.println("MY ROW");
		int rows = articleservice.getRow();
		Map<String, Object> map = new HashMap<String,Object>();
		if(rows==0){
			map.put("STATUS", HttpStatus.OK.value());
			map.put("MESSAGE", "ARTICLE HAS NO ROW...");
			return new ResponseEntity<Map<String,Object>>
										(map,HttpStatus.OK);
		}	
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ROW FOUND");
		map.put("RESPONSE_DATA",rows);
		return new ResponseEntity<Map<String,Object>>
									(map,HttpStatus.OK);	
	}
	
	
	
	
	//Phearun
	@RequestMapping(value="/listarticle", method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> listArticles(@RequestParam Map<String, String> Param){
		
		String key = Param.get("key");
		int page = Integer.parseInt(Param.get("page"));
		int uid = Integer.parseInt(Param.get("uid"));
		int cid = Integer.parseInt(Param.get("cid"));
		
		List<ArticleDTO> articles = articleservice.listArticles(page,key,uid,cid);
		
		Map<String, Object> map = new HashMap<String,Object>();
		if(articles.isEmpty()){
			map.put("STATUS", HttpStatus.NOT_FOUND.value());
			map.put("MESSAGE", "ARTICLE NOT FOUND...");
			return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}	
		map.put("STATUS", HttpStatus.OK.value());
		map.put("MESSAGE", "ARITCLE HAS BEEN FOUND");
		map.put("RESPONSE_DATA",articles);
		return new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);	
	}
}
