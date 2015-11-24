package com.hrd.article.services;

import java.util.List;

import com.hrd.article.entities.ArticleDTO;

public interface ArtitcleServices {
	

	public List<ArticleDTO> listArticles(int page,String key);
	
	public int insertArticle(ArticleDTO article);
	
	public int updateArticle(ArticleDTO article);
	
	public int deleteArticle(int id);
	
	public ArticleDTO listArticle(int id);
	
	public int toggleArticle(int id);
	

	
}
