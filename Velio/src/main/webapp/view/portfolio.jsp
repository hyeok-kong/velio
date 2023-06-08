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
	
	<%@ page import="bean.dto.PortfolioDto" %>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
		
	<%
	request.setCharacterEncoding("utf-8");
	
	int id = Integer.parseInt(request.getParameter("id"));
	PortfolioDto portfolio = portfolioDao.getPortfolio(id);
	
	Cookie[] cookies = request.getCookies();
	String uid = "";
	
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("VelioID")) {
			uid = cookie.getValue();
			break;
		}
	}
	
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
			    	작성자 : <%= portfolio.getUser().getNickname() %>
			    </div>
			    
			    <%
			   	if(portfolio.getUser().getUid().equals(uid)) {
			   	%>
			   	<div class="post-edit">
			    	<a href=edit_portfolio.jsp?pf_id=<%=id %>>수정</a>
			    	<a href=edit_portfolio.jsp>삭제</a>
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
		    		자격증
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
		    
		    <div class="post-project">
		    	<div class="small-title">
		    		프로젝트 목록
		    	</div>
		    </div>
		</div>
	</main>
</body>
</html>