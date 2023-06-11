<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/edit_project.css">
<script src="../resources/javascript/edit_project.js"></script>

</head>
<body>
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<%@ page import="bean.dto.*" %>
	<jsp:include page="../common/header.jsp" />

	<%
		request.setCharacterEncoding("utf-8");
	
		int projectId = 0;
		int userId = 0;
		String title = "";
		String content = "";
		String fullPath = "";
		String mode = "";
		
		String pr_id = request.getParameter("pr_id");
		String user_id = request.getParameter("id");

		if(user_id != null) {
			userId = Integer.parseInt(user_id);
			mode = "create";
		}
		
		
		
		if(pr_id != null) {
			projectId = Integer.parseInt(pr_id);
			mode = "edit";
			
			ProjectDto project = projectDao.getProject(projectId);

			title = project.getTitle();
			content = project.getContent();
			String image = project.getImagePath();
			
			fullPath = "../imagePath/" + image;
		}
		
		
		System.out.println(mode);
		System.out.println(pr_id);

		
	%>
    <div class="container">
        <div class="form-container">
            <div class="image-preview-container" onclick="triggerFileInput()">
                <img id="image-preview" class="image-preview" src="<%= fullPath %>" alt="미리보기">
            </div>
            <div class="input-container">
                <form action="../service/project/edit_project_process.jsp" method="post" enctype="multipart/form-data">
                <input type=hidden name="userId" value="<%= userId%>">
                <input type=hidden name="prId" value="<%= projectId%>">
                <input type=hidden name="mode" value="<%= mode%>">
                <input type=hidden name="origImg" value="<%=fullPath %>">
                    <div>
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" value="<%= title %>">
                    </div>
                    <div>
                        <label for="content"></label>
                        <textarea id="content" name="content"><%= content %></textarea>
                    </div>
                    <input type="file" id="image-upload" class="hidden-file-input" name="image" accept="image/*" onchange="previewImage(event)">
                    <input type="button" value="취소" onclick="history.back()">
               
                    <input type="submit" value="등록">
                </form>
            </div>
        </div>
    </div>
</body>
</html>