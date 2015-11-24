package com.hrd.article.services;

import java.util.List;

import com.hrd.article.entities.ArticleDTO;
import com.hrd.article.entities.CategoryDTO;

public interface ArticleFrontEndService {

	public List<ArticleDTO> listArticle(int page,String key,int category,int user);
	
	public List<CategoryDTO> listCategory(int page);
}
