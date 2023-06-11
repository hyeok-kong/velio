<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="bean.dto.*" %>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String mode = request.getParameter("mode");
	UserDto user = new UserDto();
	PortfolioDto portfolio = new PortfolioDto();
	
	if(mode.equals("submit")) {
		int userId = Integer.parseInt(request.getParameter("userid"));
		user.setId(userId);
		user.setName(request.getParameter("name"));
		user.setNickname(request.getParameter("nickname"));
		user.setEmail(request.getParameter("email"));
		
		portfolio.setTitle(request.getParameter("title"));
		portfolio.setContent(request.getParameter("content"));
		portfolio.setInterests(request.getParameter("interests"));
		portfolio.setSpecs(request.getParameter("specs"));
		
		
		userDao.updateUser(user);
		portfolioDao.createPortfolio(portfolio, userId);

		
		response.sendRedirect("../../view/mypage.jsp?id=" + userId);
	} else {
		int userId = Integer.parseInt(request.getParameter("userid"));
		user.setId(userId);
		user.setName(request.getParameter("name"));
		user.setNickname(request.getParameter("nickname"));
		user.setEmail(request.getParameter("email"));
		
		int pfId = Integer.parseInt(request.getParameter("pfid"));
		portfolio.setId(pfId);
		portfolio.setTitle(request.getParameter("title"));
		portfolio.setContent(request.getParameter("content"));
		portfolio.setInterests(request.getParameter("interests"));
		portfolio.setSpecs(request.getParameter("specs"));
		
		
		userDao.updateUser(user);
		portfolioDao.updatePortfolio(portfolio);

		
		response.sendRedirect("../../view/mypage.jsp?id=" + userId);
	}
	%>
</body>
</html>