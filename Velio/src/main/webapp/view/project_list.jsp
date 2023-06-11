<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/project_list.css">
<script src="../resources/javascript/project_list.js"></script>

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<%@ page import="java.util.ArrayList, bean.dto.*" %>
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />

	<%
		request.setCharacterEncoding("utf-8");
		int userId = Integer.parseInt(request.getParameter("id"));
	%>

	<div class="container_project">
		<div class="header_project">
		    <h1>내 프로젝트 목록</h1>
		    <button class="add-button" onclick=createProject(<%= userId%>)>프로젝트 추가</button>
		</div>
		<div class="post-list">
		<% 

		ArrayList<ProjectDto> projects = projectDao.getProjectList(userId);
		
		for(ProjectDto project : projects) {
		%>
			<div class="post-item">
				<input type=hidden name="proId" value="<%= project.getId() %>">
				<div class="image-container">
					<img src="../imagePath/<%= project.getImagePath() %>" alt="미리보기">
				</div>
				<div class="post-content">
					<h2 class="post-title"><%= project.getTitle() %></h2>
					<p class="post-description"><%= project.getContent() %></p>
				</div>
				<div class="post-actions">
					<button class="edit-button" onclick="editProject('<%= userId%>', '<%= project.getId() %>')">수정</button>
					<button class="delete-button" onclick=deleteProject(<%= project.getId() %>)>삭제</button>
				</div>
			</div>
		<%
		}
		%>
		</div>
	</div>
</body>
</html>