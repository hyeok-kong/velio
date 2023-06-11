package bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import bean.dto.*;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SharedDao {
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	PortfolioDao portfolioDao = new PortfolioDao();

	public SharedDao() {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public boolean insertShared(SharedDto dto) {
		boolean result = false;
		connect();
		
		String sql = "insert into shared(user_id, port_id) value (?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getUser_id());
			pstmt.setInt(2, dto.getPort_id());
	
			pstmt.executeUpdate();
			
			result = true;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		portfolioDao.updateSharedCount(dto.getPort_id());
		
		return result;
	}
	
	
	public ArrayList<SharedDto> getSharedList(int id) {
		ArrayList<SharedDto> result = new ArrayList<>();
		connect();
		
		UserDao userDao = new UserDao();
		
		String sql = "select * from shared_list where user_id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);

			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				SharedDto dto = new SharedDto();
				UserDto user = userDao.findUserById(rs.getInt("writer"));
								
				dto.setUser_id(rs.getInt("user_id"));
				dto.setPort_id(rs.getInt("port_id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setInterests(rs.getString("interests"));
				dto.setViews(rs.getInt("views"));
				dto.setShared(rs.getInt("shared"));
				dto.setUser(user);
				
				result.add(dto);
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return result;
	}
	
	
	public boolean deleteShared(int uid, int pid) {
		boolean result = false;
		connect();
		
		String sql = "delete from shared where user_id=? and port_id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, uid);
			pstmt.setInt(2, pid);
			
			pstmt.executeUpdate();
			
			result = true;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		portfolioDao.updateSharedCount(pid);

		return result;
	}
	
	
	// 포트폴리오의 공유된 개수 구하기
	public int getSharedCount(int portId) {
		int result = -1;
		connect();
		
		String sql = "select count(id) as count from shared where port_id=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, portId);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("count");
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
}
