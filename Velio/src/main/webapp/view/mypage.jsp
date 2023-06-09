<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/mypage.css">

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<%@ page import="bean.dto.*" %>	
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />

	<%
	request.setCharacterEncoding("utf-8");
	int userId = Integer.parseInt(request.getParameter("id"));
	String uid = "";
	PortfolioDto portfolio = new PortfolioDto();
	UserDto user = new UserDto();
	
	if(!portfolioDao.isExist(userId)) {
		response.sendRedirect("edit_portfolio.jsp?user_id="+userId);
		return ;
	}

	Cookie[] cookies = request.getCookies();
	
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("VelioID")) {
			uid = cookie.getValue();
			break;
		}
	}
	
	portfolio = portfolioDao.getPortfolioByUserId(userId);
	
	if(!uid.equals(portfolio.getUser().getUid())) {
	%>
		<script>
			alert("비정상적인 접근입니다.");
			history.back();
		</script>
	<%
	}
	%>
	
	<div>
		<div class="portfolio">
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
				   	<div class="post-edit">
				    	<a href=portfolio_pdf.jsp?pf_id=<%=portfolio.getId() %> target="_blank">pdf저장</a>			   	
				    	<a href=edit_portfolio.jsp?pf_id=<%=portfolio.getId() %>>수정</a>
				    	<a href=../service/portfolio/delete_portfolio_process.jsp?pf_id=<%=portfolio.getId() %>>삭제</a>
				    	<a href=../service/user/delete_user_process.jsp?id=<%=portfolio.getUser().getId() %>>회원탈퇴</a>
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
			    			<span>&nbsp;&nbsp;&nbsp;&nbsp;<%= spec %></span><br>
			    	<%
			    		}
			    	%>
			    </div>
			</div>
		</div>
		
		<div class="else">
			<div class="calender-container">
				<iframe id="pageFrame" name="pageFrame" src="http://www.jobkorea.co.kr/Starter/calendar/sub/month" frameborder="0"
				width="95%" height="1000px" scrolling="auto"></iframe>
			</div>
		</div>
	</div>
</body>
</html>