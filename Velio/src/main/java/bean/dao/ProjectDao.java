package bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import bean.util.Hashing;

import bean.dto.*;

public class ProjectDao {
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	public ProjectDao() {
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
	
	
	public boolean insertProject(ProjectDto dto) {
		boolean result = false;
		connect();
		

		String sql = "insert into project(title, content, image, user_id) value (?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getImagePath());
			pstmt.setInt(4, dto.getUserId());
	
			pstmt.executeUpdate();
			
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return result;
	}
	
	public ArrayList<ProjectDto> getProjectList(int userId) {
		ArrayList<ProjectDto> result = new ArrayList<>();
		connect();
		
		String sql = "select * from project where user_id=? order by id desc";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);

			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				ProjectDto dto = new ProjectDto();
								
				dto.setId(rs.getInt("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setImagePath(rs.getString("image"));
				dto.setCreated_date(rs.getTimestamp("created_date"));
				dto.setUserId(rs.getInt("user_id"));
				
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
	
	
	public ProjectDto getProject(int id) {
		ProjectDto result = new ProjectDto();
		connect();
		
		String sql = "select * from project where id = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);

			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result.setId(id);
				result.setTitle(rs.getString("title"));
				result.setContent(rs.getString("content"));
				result.setImagePath(rs.getString("image"));
				result.setCreated_date(rs.getTimestamp("created_date"));
				result.setUserId(rs.getInt("user_id"));	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return result;
	}
	
	public boolean updateProject(ProjectDto dto) {
		boolean result = false;
		connect();
		
		if(dto.getImagePath() != null) {
			String sql = "update project set title=?, content=?, image=? where id=?";
			try {
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getTitle());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getImagePath());
				pstmt.setInt(4, dto.getId());
				
				if(pstmt.executeUpdate() == 1) result = true;
			} catch(SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
		} else {
			String sql = "update project set title=?, content=? where id=?";
			try {
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getTitle());
				pstmt.setString(2, dto.getContent());
				pstmt.setInt(3, dto.getId());
				
				if(pstmt.executeUpdate() == 1) result = true;
			} catch(SQLException e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
		}	
		return result;
	}
	
	
	public boolean deleteProject(int id) {
		boolean result = false;
		connect();
		
		String sql = "delete from project where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
			result = true;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return result;
	}
}
