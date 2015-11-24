package com.hrd.article.servicesimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.hrd.article.entities.CategoryDTO;
import com.hrd.article.services.CategoryService;

@Repository
public class CategoryServiceImpl implements CategoryService {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	/**
	 * List All Category
	 */
	public List<CategoryDTO> listCategory(int page) {
		int offset = (page * 10) - 10;
		List<CategoryDTO> lst = new ArrayList<CategoryDTO>();

		String sql = "SELECT cid, cname, cdescription, cstatus FROM tbcategory ORDER BY cid DESC LIMIT 10 OFFSET ?;";
		lst = jdbcTemplate.query(sql, new Object[] { offset }, new CategoryRowMapper());

		return lst;

	}

	/**
	 * Get One Record Of Category
	 */
	public CategoryDTO getCategory(int id) {

		String sql = "SELECT cid, cname, cdescription, cstatus FROM tbcategory WHERE cid = ? ORDER BY cid DESC;";
		Object[] obj = { id };
		CategoryDTO category;
		category = jdbcTemplate.query(sql, obj, new CategoryResultSetExtractor());
		if (category != null) {
			return category;
		}
		return null;
	}

	/**
	 * Insert Category
	 */
	public boolean isInsertCategory(CategoryDTO category) {

		final String sql = "INSERT INTO tbcategory(cname, cdescription, cstatus) VALUES(?,?,?);";
		Object[] obj = { category.getName(), category.getDescription(), category.getStatus() };
		int result = jdbcTemplate.update(sql, obj);

		if (result > 0) {
			return true;
		}
		return false;
	}

	/**
	 * Delete Category
	 */
	public boolean isDeleteCategory(int id) {

		String sql = "DELETE FROM tbcategory WHERE cid = ? ";
		int result = jdbcTemplate.update(sql, id);
		if (result > 0) {
			return true;
		}
		return false;
	}

	/**
	 * Update Category
	 */
	public boolean isUpdateCategory(CategoryDTO category) {
		String sql = "UPDATE tbcategory SET cname = ?, cdescription = ?, cstatus = ? WHERE cid = ?;";
		Object[] obj = { category.getName(), category.getDescription(), category.getStatus(), category.getId() };
		int result = jdbcTemplate.update(sql, obj);

		if (result > 0) {
			return true;
		}
		return false;
	}

	/**
	 * Search Category By Category Name
	 */
	public List<CategoryDTO> searchCategoryByName(int page, String key) {
		
		int offset = (page * 10) - 10;
		
		if((page == 0 && key.equals("*")) || page == 0){
			if(page == 0 && key.equals("*")) key = "%";
			return jdbcTemplate.query("SELECT cid, cname, cdescription, cstatus FROM tbcategory WHERE UPPER(cname) LIKE UPPER(?) ORDER BY cid DESC",
				   new Object[]{"%"+key+"%"}, new CategoryRowMapper());
		}
		else if((page != 0 && key.equals("*")))
			key = "%";
		
		return jdbcTemplate.query("SELECT cid, cname, cdescription, cstatus FROM tbcategory WHERE UPPER(cname) LIKE UPPER(?) ORDER BY cid DESC LIMIT 10 OFFSET ?",
				   new Object[]{"%"+key+"%", offset}, new CategoryRowMapper());
	}

	/**
	 * Total Category Record
	 */
	public int getTotalCategory() {
		String sql = "SELECT COUNT(*) FROM tbcategory;";
		int total = jdbcTemplate.queryForObject(sql, Integer.class);
		return total;
	}

	/**
	 * Change Status Disable Category
	 */
	public boolean isStatusDisable(int id, int status) {
		String sql = "UPDATE tbcategory SET cstatus = ? WHERE cid = ? ;";

		Object[] obj = { status, id };

		int result = jdbcTemplate.update(sql, obj);
		if (result > 0) {
			return true;
		}
		return false;
	}

	/**
	 * Change Status Disable Category
	 */
	public boolean isStatusEnable(int id, int status) {
		String sql = "UPDATE tbcategory SET cstatus = ? WHERE cid = ? ;";

		Object[] obj = { status, id };

		int result = jdbcTemplate.update(sql, obj);
		if (result > 0) {
			return true;
		}
		return false;
	}

	/**
	 * 
	 * @author PC1 Extract Data One Row
	 */
	private static final class CategoryResultSetExtractor implements ResultSetExtractor<CategoryDTO> {

		public CategoryDTO extractData(ResultSet rs) throws SQLException, DataAccessException {
			while (rs.next()) {
				CategoryDTO category = new CategoryDTO();
				category.setId(rs.getInt("cid"));
				category.setName(rs.getString("cname"));
				category.setDescription(rs.getString("cdescription"));
				category.setStatus(rs.getInt("cstatus"));

				return category;
			}
			return null;
		}

	}

	/**
	 * 
	 * @author PC1 Map Row Of Category Get Data Multiple Rows
	 */
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

	public List<CategoryDTO> listCategoryAll() {
		List<CategoryDTO> lst = new ArrayList<CategoryDTO>();

		String sql = "SELECT cid, cname, cdescription, cstatus FROM tbcategory ORDER BY cid DESC ;";
		lst = jdbcTemplate.query(sql, new CategoryRowMapper());
		if (!lst.isEmpty()) {
			return lst;
		}
		return null;
	}

	public int toggleCategory(int id) {
		return jdbcTemplate.update("UPDATE tbcategory set cstatus=(select CASE WHEN cstatus = 0 THEN 1 ELSE 0 END from tbcategory WHERE cid=?) WHERE cid=?",
				  id,id);
	}
	

}
