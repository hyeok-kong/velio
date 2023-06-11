<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/shared_list.css">
<script src="../resources/javascript/main.js"></script>
</head>
<body>
	<%@ page import="java.util.ArrayList, bean.dto.*" %>
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<jsp:useBean id="sharedDao" class="bean.dao.SharedDao" scope="page" />

	<jsp:include page="../common/header.jsp" />
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String userId = request.getParameter("id");
	int uid = 0;
	
	if(userId != null) {
		uid = Integer.parseInt(userId);	
	}
	
	ArrayList<SharedDto> portfolios = sharedDao.getSharedList(uid);
	%>
	
	<main>		

	<%
	for(SharedDto portfolio : portfolios) {
	%>
		<div class="card">
			<div style="cursor: pointer" onClick=moveLocation(<%=portfolio.getPort_id() %>)>
				<div class="card-header" >
					<div class="card-title"> <%= portfolio.getTitle() %></div>
					<div class="card-author"><%= portfolio.getUser().getNickname() %></div>
					<div class="card-like">
						<span class="card-like-count"><%= portfolio.getViews() %></span> <span>&#x1F441;</span>
						<span class="card-like-count"><%= portfolio.getShared() %></span> <span>&#x2B50;</span>
					</div>
				</div>
				<div class="card-content"> 
				<%= portfolio.getContent() %></div>
				<div class="card-tags">
				
			<%
					for(String interest : portfolio.getInterArray()) {
			%>
					<span><a href="main.jsp?keyword=<%= interest%>"><%= interest %></a></span>
			<%
					}
			%>
					<div class="post-actions">
						<span><a href="../service/shared/delete_shared_process.jsp?id=<%= portfolio.getUser_id()%>&pf_id=<%= portfolio.getPort_id()%>"> 즐겨찾기 삭제</a></span>
					</div>
				</div>

			</div>
		</div>
	<%
	}
	%>
	</main>
</body>
</html>