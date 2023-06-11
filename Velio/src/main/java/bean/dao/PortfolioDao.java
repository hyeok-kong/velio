package bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import bean.dto.*;
import bean.dao.SharedDao;
import bean.util.Hashing;

public class PortfolioDao {
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	
	public PortfolioDao() {
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
	

	// 전체 포트폴리오 개수 반환
	// 페이징 처리를 위함
	public int getPortfolioCount() {
		int result = -1;
		connect();
		
		String sql = "select count(id) from portfolio";
		
		try {
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) result = rs.getInt(1);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	// 전체 포트폴리오 개수 반환
	// 페이징 처리를 위함
	public int getPortfolioCount(String keyword) {
		int result = -1;
		connect();
		
		String sql = "select count(id) from portfolio where locate(?, interests) > 0";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) result = rs.getInt(1);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	
	public ArrayList<PortfolioDto> getPortfolioList(int pageNum, int count, String keyword) {
		ArrayList<PortfolioDto> result = new ArrayList<>();
		connect();
		
		String sql = "select id, title, content, interests, views, shared, nickname "
				+ "from portfolio_user "
				+ "where locate(?, interests) > 0 "
				+ "order by id desc "
				+ "LIMIT ?, ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			pstmt.setInt(2, pageNum);
			pstmt.setInt(3, count);
			
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				PortfolioDto dto = new PortfolioDto();
				
				UserDto user = new UserDto();
				user.setNickname(rs.getString("nickname"));
				
				dto.setId(rs.getInt("id"));
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
	
	
	// pageNum = 현재 페이지 위치, count = 한 페이지에 몇개 출력할 지
	public ArrayList<PortfolioDto> getPortfolioList(int pageNum, int count) {
		ArrayList<PortfolioDto> result = new ArrayList<>();
		connect();
		
		String sql = "select id, title, content, interests, views, shared, nickname "
				+ "from portfolio_user "
				+ "order by id desc "
				+ "LIMIT ?, ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pageNum);
			pstmt.setInt(2, count);
			
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				PortfolioDto dto = new PortfolioDto();
				
				UserDto user = new UserDto();
				user.setNickname(rs.getString("nickname"));
				
				dto.setId(rs.getInt("id"));
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
	
	
	// 포트폴리오 생성
	public boolean createPortfolio(PortfolioDto dto, String uid) {
		UserDao userDao = new UserDao();

		return createPortfolio(dto, userDao.findUserIdByUid(uid));
	}
	
	// 포트폴리오 생성
	public boolean createPortfolio(PortfolioDto dto, int userId) {
		boolean result = false;

		connect();
		
		// 제목, 내용, 태그, 스펙, 조회수, 즐겨찾기 수, 작성한 유저
		String sql = "insert into portfolio(title, content, interests, spec, user_id)"
				+ " values (?, ?, ?, ?, ?)";
		
		UserDao userDao = new UserDao();

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getInterests());
			pstmt.setString(4, dto.getSpecs());
			pstmt.setInt(5, userId);
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
	
	
	// 유저의 포트폴리오가 존재하는지 검증
	public boolean isExist(int id) {
		boolean result = false;
		
		connect();
		
		String sql = "select exists (select id from portfolio where user_id = ?) as success";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("success").equals("1")) result = true;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	// 유저 아이디로 포트폴리오 찾기
	public PortfolioDto getPortfolioByUserId(int id) {
		PortfolioDto dto = new PortfolioDto();
		UserDto user = new UserDto();

		connect();
		
//		String sql = "select p.id, p.title, p.content, p.interests, p.spec, p.views, p.shared, p.user_id, "
//				+ "u.nickname, u.email "
//				+ "from portfolio as p "
//				+ "left join user as u "
//				+ "on p.id = u.id "
//				+ "where p.id = ?";

		// 뷰 생성 후 조회
		String sql = "select * from portfolio_user where user_id = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				user.setId(rs.getInt("user_id"));	
				user.setUid(rs.getString("uid"));
				user.setName(rs.getString("name"));
				user.setNickname(rs.getString("nickname"));
				user.setEmail(rs.getString("email"));
								
				dto.setId(rs.getInt("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setInterests(rs.getString("interests"));
				dto.setSpecs(rs.getString("spec"));
				dto.setViews(rs.getInt("views"));
				dto.setShared(rs.getInt("shared"));
				dto.setUser(user);
				
				rs.close();
				
//				increaseViewCount(id);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return dto;
	}

	
	// 단일 포트폴리오 객체 반환
	public PortfolioDto getPortfolio(int id) {
		PortfolioDto dto = new PortfolioDto();
		UserDto user = new UserDto();

		connect();
		
//		String sql = "select p.id, p.title, p.content, p.interests, p.spec, p.views, p.shared, p.user_id, "
//				+ "u.nickname, u.email "
//				+ "from portfolio as p "
//				+ "left join user as u "
//				+ "on p.id = u.id "
//				+ "where p.id = ?";

		// 뷰 생성 후 조회
		String sql = "select * from portfolio_user where id = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				user.setId(rs.getInt("user_id"));	
				user.setUid(rs.getString("uid"));
				user.setName(rs.getString("name"));
				user.setNickname(rs.getString("nickname"));
				user.setEmail(rs.getString("email"));
								
				dto.setId(rs.getInt("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setInterests(rs.getString("interests"));
				dto.setSpecs(rs.getString("spec"));
				dto.setViews(rs.getInt("views"));
				dto.setShared(rs.getInt("shared"));
				dto.setUser(user);
				
				rs.close();
				
//				increaseViewCount(id);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return dto;
	}
	
	
	// 포트폴리오 업데이트
	// 제목, 내용, 관심분야, 자격증 수정 가능
	public boolean updatePortfolio(PortfolioDto dto) {
		boolean result = false;
		connect();
		
		String sql = "update portfolio set title=?, content=?, interests=?, spec=? where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getInterests());
			pstmt.setString(4, dto.getSpecs());
			pstmt.setInt(5, dto.getId());
			
			if(pstmt.executeUpdate() == 1) result = true;
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	
	
	// 조회수 1 증가
	public boolean increaseViewCount(int id) {
		boolean result = false;
		connect();
		
		String sql = "update portfolio set views = views+1 where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			if(pstmt.executeUpdate() == 1) result = true;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return result;
	}
	

	public boolean updateSharedCount(int id) {
		SharedDao sharedDao = new SharedDao();
		boolean result = false;
		connect();
		
		String sql = "update portfolio set shared=? where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, sharedDao.getSharedCount(id));
			pstmt.setInt(2, id);
			
			if(pstmt.executeUpdate() == 1) result = true;

		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return result;
	}
	
	
	// 포트폴리오 삭제
	public boolean deletePortfolio(int id) {
		boolean result = false;
		connect();
		
		String sql = "delete from portfolio where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
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
}
