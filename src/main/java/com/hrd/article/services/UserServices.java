package com.hrd.article.services;


import java.util.List;

import com.hrd.article.entities.UserDTO;

public interface UserServices {
	
	public List<UserDTO> listUser();
	
	public List<UserDTO> listUser(int page,String key);
	
	public int insertUser(UserDTO user);
	
	public int editUser(UserDTO user);
	
    public int statusUser(int id);
	
	public UserDTO getUser(int id);
	
	public int changeUserPassword(String newpass,int id);
   
	public UserDTO getCurrentPassword( int i);
	
	public int rowCount();
}
