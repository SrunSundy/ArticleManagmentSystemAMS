package com.hrd.article.entities;

import java.util.Date;

public class ArticleDTO {
	private int id;
	private String title;
	private String description;
	private String image;
	private String contents;
	private Date postdate;
	private int status;
	private UserDTO user;
	private CategoryDTO category;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	@Override
	public String toString() {
		return "ArticleDTO [id=" + id + ", title=" + title + ", description=" + description + ", image=" + image
				+ ", contents=" + contents + ", postdate=" + postdate + ", status=" + status + ", user=" + user
				+ ", category=" + category + "]";
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public UserDTO getUser() {
		return user;
	}
	public void setUser(UserDTO user) {
		this.user = user;
	}
	public CategoryDTO getCategory() {
		return category;
	}
	public void setCategory(CategoryDTO category) {
		this.category = category;
	}
}
