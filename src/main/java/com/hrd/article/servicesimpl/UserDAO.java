package com.hrd.article.servicesimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.UserServices;

@Repository
public class UserDAO implements UserServices {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<UserDTO> listUser() {
		return jdbcTemplate.query("SELECT * FROM tbuser ORDER BY uid ", new UserMapper());
	}

	public List<UserDTO> listUser(int page, String key) {
		int offset=(page*10)-10;
		if((page == 0 && key.equals("*")) || page == 0){
			if(page == 0 && key.equals("*"))
			return jdbcTemplate.query("SELECT * FROM tbuser ORDER BY uid ", new UserMapper());
		}
		else if((page != 0 && key.equals("*")))
			key = "%";
		    return jdbcTemplate.query("SELECT * FROM tbuser WHERE UPPER(uname) LIKE UPPER(?) ORDER BY uid LIMIT 10 OFFSET ? ", new Object[]{"%"+key+"%", offset}, new UserMapper());
	}

	public int insertUser(UserDTO user) {
		String sql="INSERT INTO tbuser(uname,upassword,uemail,ugender,utype,ustatus,uimage) VALUES(?,?,?,?,?,?,?)";
		Object[] obj={user.getUname(),user.getUpassword(),user.getUemail(),user.getUgender(),user.getUtype(),user.getUstatus(),user.getUimage()};
		return jdbcTemplate.update(sql,obj);
	}

	public int editUser(@RequestBody UserDTO user) {
		String sql="UPDATE tbuser SET uname=?,upassword=?,uemail=?,ugender=?,utype=?,ustatus=?,uimage=? WHERE uid=?";
		Object[] obj={user.getUname(),user.getUpassword(),user.getUemail(),user.getUgender(),user.getUtype(),user.getUstatus(),user.getUimage(),user.getUid()};
		return jdbcTemplate.update(sql,obj);
	}

	public UserDTO getUser(int id) {
		try{
			return jdbcTemplate.queryForObject("SELECT * FROM tbuser WHERE uid=?",new Object[]{id},new UserMapper());
		} catch (IncorrectResultSizeDataAccessException ex) {
            return null;
        }	
	}
	public int statusUser(int id) {
			String sql="UPDATE tbuser SET ustatus=(SELECT CASE WHEN ustatus = 0 THEN 1 ELSE 0 END FROM tbuser WHERE uid=?) WHERE uid=?";
			return jdbcTemplate.update(sql,id,id);
	}
	private static final class UserMapper implements RowMapper<UserDTO>{		
		public UserDTO mapRow(ResultSet rs, int rowNumber) throws SQLException {
			UserDTO user=new UserDTO();
			user.setUid(rs.getInt("uid"));
			user.setUname(rs.getString("uname"));
			user.setUemail(rs.getString("uemail"));
			user.setUpassword(rs.getString("upassword"));
			user.setUgender(rs.getString("ugender"));
			user.setUtype(rs.getInt("utype"));
			user.setUstatus(rs.getInt("ustatus"));
			user.setUimage(rs.getString("uimage"));
			return user;
		}
	}

	
}
