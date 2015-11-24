package com.hrd.article.services;

import java.util.List;

import com.hrd.article.entities.CategoryDTO;

public interface CategoryService {
	
	public List<CategoryDTO> listCategory(int page);
	public List<CategoryDTO> listCategoryAll();
	public CategoryDTO getCategory(int id);
	public boolean isInsertCategory(CategoryDTO category);
	public boolean isDeleteCategory(int id);
	public boolean isUpdateCategory(CategoryDTO category);
	public List<CategoryDTO> searchCategoryByName(int page, String name);
	public int getTotalCategory();
	public boolean isStatusEnable(int status,int id);
	public boolean isStatusDisable(int status,int id);
	public int toggleCategory(int id);
	
}
