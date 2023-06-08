package bean.dao;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;

import bean.dto.UserDto;
import bean.util.Hashing;


public class UserDao {
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	public UserDao() {
		try {
			InitialContext ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void connect() {
		try {
			con = ds.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null) {
			try {
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 유저 생성
	public boolean insertUser(UserDto dto) {
		boolean result = false;
		
		connect();
		
		// 아이디, 패스워드, 이름, 닉네임, 이메일
		String sql = "insert into user(uid, pw, name, nickname, email) values (?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getUid());
			pstmt.setString(2, Hashing.encodeSHA256(dto.getPw()));
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getNickname());
			pstmt.setString(5, dto.getEmail());
			pstmt.executeUpdate();
			
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return result;
		} finally {
			disconnect();
		}
		return result;
	}
	
	
	public int findUserIdByUid(String uid) {
		int result = -1;
		
		connect();
		
		String sql = "select id from user where uid = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("id");
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	public UserDto findUserByUid(String uid) {
		connect();
		
		String sql = "select * from user where uid = ?";
		UserDto user = new UserDto();
		
		try {			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			user.setId(rs.getInt("id"));
			user.setUid(rs.getString("uid"));
			user.setName(rs.getString("name"));
			user.setNickname(rs.getString("nickname"));
			user.setEmail(rs.getString("email"));
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return user;
	}
	
	
	public UserDto findUserById(int id) {
		connect();
		
		String sql = "select * from user where id = ?";
		UserDto user = new UserDto();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user.setId(rs.getInt("id"));
				user.setUid(rs.getString("uid"));
				user.setName(rs.getString("name"));
				user.setNickname(rs.getString("nickname"));
				user.setEmail(rs.getString("email"));
				rs.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return user;
	}
	
	// 이름, 닉네임, 이메일 수정가능
	public boolean updateUser(UserDto dto) {
		boolean result = false;
		connect();
		String sql = "update user set name=?, nickname=?, email=? where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getEmail());
			pstmt.setInt(4, dto.getId());
			
			int res = pstmt.executeUpdate();
			
			if(res == 1) result = true;
		} catch(SQLException e) {
			e.printStackTrace();
			return result;
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	// 쿠키에 저장되어있는 아이디를 받아 유저 삭제
	public boolean deleteUser(String uid) {
		boolean result = false;
		connect();
		String sql = "delete from user where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			result = true;
		} catch(SQLException e) {
			e.printStackTrace();
			return result;
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	// 입력한 아이디와 비밀번호가 맞는지 검증
	public boolean validateUser(String uid, String pw) {
		boolean result = false;
		connect();
		String sql = "select pw from user where uid=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String realPw = rs.getString(1);
				
				if(realPw.equals(Hashing.encodeSHA256(pw))) result = true;
			}
			
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
			return result;
		} finally {
			disconnect();
		}
		return result;
	}
}
