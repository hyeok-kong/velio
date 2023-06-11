<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>portfolio</title>
<link rel="stylesheet" href="../resources/css/portfolio_pdf.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>

</head>

<body>
	<%@ page import="bean.dto.*, java.util.*" %>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
	<%
	request.setCharacterEncoding("utf-8");
	
	int id = Integer.parseInt(request.getParameter("pf_id"));
	PortfolioDto portfolio = portfolioDao.getPortfolio(id);
	 %>
	<main>
		<div class="post-container">
		    <div class="post-header">
		        <h1 class="post-title"><%= portfolio.getTitle() %></h1>
		    </div>
		   
		    
			<div class="post-header">
			    <div class="post-author">
			    	작성자 : <%= portfolio.getUser().getNickname() %>, 이메일 : <%= portfolio.getUser().getEmail() %>
			    </div>
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
		    			<span>&nbsp;&nbsp;&nbsp;&nbsp;- <%= spec %></span><br>
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
	
	<script src="../resources/javascript/portfolio_pdf.js"></script>
</body>
</html>