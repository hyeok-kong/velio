<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/portfolio.css">

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<%@ page import="bean.dto.*, java.util.*" %>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
		
	<%
	request.setCharacterEncoding("utf-8");
	
	int id = Integer.parseInt(request.getParameter("id"));
	PortfolioDto portfolio = portfolioDao.getPortfolio(id);
	
	Cookie[] cookies = request.getCookies();
	String uid = "";
	
	boolean isAdmin = false;
	
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("VelioID")) {
			uid = cookie.getValue();
		}
		if(cookie.getName().equals("VelioRole")) {
			if(cookie.getValue().equals("admin")) isAdmin = true;
		}
	}
	
	int loginUserId = userDao.findUserIdByUid(uid);
	
	portfolioDao.increaseViewCount(id);
	%>
	
	<main>
		<div class="post-container">
		    <div class="post-header">
		        <h1 class="post-title"><%= portfolio.getTitle() %></h1>
		        <div class="post-meta">
		            <span class="post-views">조회수 : <%= portfolio.getViews() %></span>
		            <span class="post-shares">공유수 : <%= portfolio.getShared() %></span>
		        </div>
		    </div>
		   
		    
			<div class="post-header">
			    <div class="post-author">
			    	작성자 : <%= portfolio.getUser().getNickname() %>, 이메일 : <%= portfolio.getUser().getEmail() %>
			    </div>
			    
			    <%
			   	if(portfolio.getUser().getUid().equals(uid) || isAdmin) {
			   	%>
			   	<div class="post-edit">
			    	<a href=edit_portfolio.jsp?pf_id=<%= portfolio.getId() %>>수정</a>
			    	<a href="../service/portfolio/delete_portfolio_process.jsp?pf_id=<%= portfolio.getId()%>">삭제</a>

			    <%
			    	if(isAdmin) {
			    %>
					<a href="../service/user/delete_user_process.jsp?id=<%= portfolio.getUser().getId()%>">회원 추방</a>
			    <%
			    	}
			    %>
			    </div>
			   	<%
			   	} else if(uid.length() > 2) {
			   	%>
			   	<div class="post-edit">
			    	<a href="../service/shared/insert_shared_process.jsp?id=<%= loginUserId%>&pf_id=<%=id %>">즐겨찾기</a>
			    </div>
			   	<%	
			   	}
			    %>
			    
			</div>
		    <hr class="post-divider">
		    
		    <div class="post-content"><%= portfolio.getContent() %></div>
		    
		    <hr class="post-divider">
		    
		    <div class="post-interests">
		    	<div class = "small-title">관심분야<br></div>
			<%
				for(String interest : portfolio.getInterArray()) {
			%>
				<span><a href="#"><%= interest %></a></span>
			<%
				}
			%>
		    </div>
		    
		    <hr class="post-divider">
		    
		    <div class="post-certifications">
		    	<div class="small-title">
		    		스펙
		    	</div>
		    	<%
		    		for(String spec : portfolio.getSpecArray()) {
		    	%>
		    			<span>&nbsp;&nbsp;&nbsp;&nbsp;<%= spec %></span><br>
		    	<%
		    		}
		    	%>
		    </div>
		    
		    <hr class="post-divider">
		    
		    <div class="container_project">
		    	<div class="header_project">
		    		<h2>프로젝트 목록</h2>
		    	</div>
			    <div class="post-list">
				<% 
		
				int userId = portfolio.getUser().getId();
				
				ArrayList<ProjectDto> projects = projectDao.getProjectList(userId);
				
				for(ProjectDto project : projects) {
				%>
					<div class="post-item">
						<div class="image-container">
							<img src="../imagePath/<%= project.getImagePath() %>" alt="미리보기">
						</div>
						<div class="post-content">
							<h2 class="post-title"><%= project.getTitle() %></h2>
							<p class="post-description"><%= project.getContent() %></p>
						</div>
					</div>
				<%
				}
				%>
				</div>
			</div>
		</div>
	</main>
</body>
</html>