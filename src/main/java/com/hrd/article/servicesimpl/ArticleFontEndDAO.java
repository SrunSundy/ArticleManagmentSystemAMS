package com.hrd.article.servicesimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.hrd.article.entities.ArticleDTO;
import com.hrd.article.entities.CategoryDTO;
import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.ArticleFrontEndService;



@Repository
public class ArticleFontEndDAO implements ArticleFrontEndService{
	

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<ArticleDTO> listArticle(int page, String key, int category, int user) {
		int limit = ( page * 10 );
		System.err.println("limit"+limit+"page"+page+"key"+key+"cate"+category+"User"+user);
		if(key.equals("*")){
			key="%";	
		}
		if(category==0 && user==0){
			
			return jdbcTemplate.query("SELECT * FROM tbnews n LEFT JOIN tbuser u ON n.nuid=u.uid LEFT JOIN tbcategory c ON c.cid=n.ncid WHERE UPPER(n.ntitle) LIKE UPPER(?) ORDER BY n.nid LIMIT ? ",
					   new Object[]{"%"+key+"%", limit}, new ArticleMapper());
		}else if(category!=0 && user==0){
			System.err.println("category !=0 && user==0");
			return jdbcTemplate.query("SELECT * FROM tbnews n LEFT JOIN tbcategory c ON c.cid=n.ncid "
						+"LEFT JOIN tbuser u on n.nuid=u.uid "
						+"WHERE UPPER(n.ntitle) LIKE UPPER(?) and n.ncid=?   ORDER BY n.nid limit ? ",
					   new Object[]{"%"+key+"%",category, limit}, new ArticleMapper());
		}
		else if(category==0 && user!=0){
			return jdbcTemplate.query("SELECT * FROM tbnews n LEFT JOIN tbcategory c ON c.cid=n.ncid "
					+"LEFT JOIN tbuser u on n.nuid=u.uid "
					+"WHERE UPPER(n.ntitle) LIKE UPPER(?) and n.nuid=?   ORDER BY n.nid limit ? ",
				   new Object[]{"%"+key+"%",user, limit}, new ArticleMapper());
		}
		else if(category!=0 && user!=0){
			return jdbcTemplate.query("SELECT * FROM tbnews n LEFT JOIN tbcategory c ON c.cid=n.ncid "
					+"LEFT JOIN tbuser u on n.nuid=u.uid "
					+"WHERE UPPER(n.ntitle) LIKE UPPER(?) and n.nuid=? and n.ncid=?   ORDER BY n.nid limit ? ",
				   new Object[]{"%"+key+"%",user,category, limit}, new ArticleMapper());
		}
		
		return null;
		
	}

	public List<CategoryDTO> listCategory(int page) {
		int limit = (page * 10);
		List<CategoryDTO> lst = new ArrayList<CategoryDTO>();

		String sql = "SELECT cid, cname, cdescription, cstatus FROM tbcategory ORDER BY cid DESC LIMIT ? ";
		lst = jdbcTemplate.query(sql, new Object[] { limit }, new CategoryRowMapper());

		return lst;
	}
	private static final class CategoryRowMapper implements RowMapper<CategoryDTO> {

		public CategoryDTO mapRow(ResultSet rs, int arg1) throws SQLException {
			CategoryDTO category = new CategoryDTO();
			category.setId(rs.getInt("cid"));
			category.setName(rs.getString("cname"));
			category.setDescription(rs.getString("cdescription"));
			category.setStatus(rs.getInt("cstatus"));

			return category;
		}
	}

	
	private static final class ArticleMapper implements RowMapper<ArticleDTO>{		
		public ArticleDTO mapRow(ResultSet rs, int rowNumber) throws SQLException {
			ArticleDTO article = new ArticleDTO();
			
			article.setId(rs.getInt("nid"));
			article.setTitle(rs.getString("ntitle"));
			article.setDescription(rs.getString("ndescription"));
			article.setImage(rs.getString("nimage"));
			article.setPostdate(rs.getDate("npostdate"));
			article.setContents(rs.getString("ncontents"));
			article.setStatus(rs.getInt("nstatus"));
			
			UserDTO user = new UserDTO();
			user.setUid(rs.getInt("uid"));

			user.setUname(rs.getString("uname"));
			user.setUtype(rs.getInt("utype"));
			user.setUimage(rs.getString("uimage"));
			

			CategoryDTO category = new CategoryDTO();
			category.setId(rs.getInt("cid"));
			category.setName(rs.getString("cname"));
			
			article.setUser(user);
			article.setCategory(category);
			
			return article;
		}
	}

}
