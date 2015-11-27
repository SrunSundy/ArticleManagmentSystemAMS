package com.hrd.article.services;

import com.hrd.article.entities.UserDTO;

public interface LoginFormService {

	public UserDTO getUser(String name,String pwd);
	
}
