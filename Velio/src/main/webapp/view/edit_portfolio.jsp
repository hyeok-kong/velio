<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/edit_portfolio.css">
</head>
<body>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
	
	<%@ page import="bean.dto.*" %>
	<jsp:include page="../common/header.jsp" />

	<%
	request.setCharacterEncoding("utf-8");
	
	String reqUser = request.getParameter("user_id");
	String reqPf = request.getParameter("pf_id");
	
	int userId = 0;
	int pfId = 0;
	
	String uid = "";
	String ruid = "";
	
	String name = "";
	String nickname = "";
	String email = "";
	
	String title = "";
	String content = "";
	String interests = "";
	String specs = "";
	
	
	if(reqUser != null) {
		userId = Integer.parseInt(reqUser);
		UserDto user = userDao.findUserById(userId);
		
		name = user.getName();
		nickname = user.getNickname();
		email = user.getEmail();
		
		userId = Integer.parseInt(reqUser);
	}
	
	if(reqPf != null) {
		pfId = Integer.parseInt(reqPf);
		
		PortfolioDto portfolio = portfolioDao.getPortfolio(pfId);
		
		ruid = portfolio.getUser().getUid();
		name = portfolio.getUser().getName();
		nickname = portfolio.getUser().getNickname();
		email = portfolio.getUser().getEmail();
		
		title = portfolio.getTitle();
		content = portfolio.getContent();
		interests = portfolio.getInterests();
		specs = portfolio.getSpecs();
		
		userId = portfolio.getUser().getId();
	}
	
	Cookie[] cookies = request.getCookies();
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("VelioID")) uid = cookie.getValue();
	}
	
	if(reqPf != null) {
		if(!uid.equals(ruid)) {
		%>
		<script>
			alert("비정상적인 접근입니다.");
			history.back();
		</script>
		<%
		}

	}
	%>
	
	<form method="POST" action="../service/portfolio/edit_portfolio_process.jsp">

		<%
		if(reqPf != null) {
		%>
		<input type=hidden name="pfid" value="<%= pfId%>">
		<input type=hidden name="mode" value="modify">
		<%} else {
			%>	
		
		<input type=hidden name="mode" value="submit">
		<%
		}
		 %>
		<input type=hidden name="userid" value="<%= userId%>">
		  <label for="name">이름</label>
		  <input type="text" id="name" name="name" value="<%= name %>">

		  <label for="nickname">닉네임</label>
		  <input type="text" id="nickname" name="nickname"value="<%= nickname %>">

		  <label for="email">이메일</label>
		  <input type="email" id="email" name="email" value="<%= email %>">

		  <label for="title">제목</label>
		  <input type="text" id="title" name="title" value="<%= title %>">

		  <label for="content">내용</label>
		  <textarea name="content" rows="10" cols="50"><%= content%></textarea>
		
		  <label for="email">관심분야</label>
		  <input type="text" id="interests" name="interests" value="<%= interests %>">

		  <label for="email">스펙</label>
		  <input type="text" id="specs" name="specs" value="<%= specs %>">

		  <input type="button" value="취소" onclick="history.back()">
		  <input type="submit" value="저장">
	</form>
</body>
</html>