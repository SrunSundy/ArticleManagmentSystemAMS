package com.hrd.article.servicesimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.hrd.article.entities.ApiDTO;
import com.hrd.article.services.ApiService;

@Repository
public class ApiDAO implements ApiService{

	private JdbcTemplate jdbcTemplate;
	
	public List<ApiDTO> getAPI(String type) {
		return jdbcTemplate.query("SELECT * FROM tbapi WHERE UPPER(type) LIKE UPPER(?)",new Object[]{ "%"+type+"%" }, new ApiDocMapper());
	}

	private static final class ApiDocMapper implements RowMapper<ApiDTO>{		
		public ApiDTO mapRow(ResultSet rs, int rowNumber) throws SQLException {
			ApiDTO api = new ApiDTO();
			api.setId(rs.getInt("id"));
			api.setUrl(rs.getString("url"));
			api.setDescription(rs.getString("description"));
			api.setMethod(rs.getString("method"));
			
			return api;
		}
	}
	
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
