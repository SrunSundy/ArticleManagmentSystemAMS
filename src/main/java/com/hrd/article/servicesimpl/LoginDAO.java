package com.hrd.article.servicesimpl;





import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
import com.hrd.article.entities.UserDTO;
import com.hrd.article.services.LoginFormService;
@Repository
public class LoginDAO implements LoginFormService{
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}

	public UserDTO getUser(String name, String pwd) {
		
		String sql = "SELECT uid, uname, upassword, uimage, ustatus, ugender, utype, uemail FROM tbuser WHERE ustatus = 1 AND ( UPPER(uemail) = UPPER(?) AND UPPER(upassword) = UPPER(?) ) ";
		Object[] obj = { name , pwd };
		return jdbcTemplate.query(sql, obj , new UserResultSetExtractor());
	}

	private static final class UserResultSetExtractor implements ResultSetExtractor<UserDTO>{

		public UserDTO extractData(ResultSet rs) throws SQLException, DataAccessException {
			
			while(rs.next()){
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
			return null;
	
		}
		
	}
	

}
