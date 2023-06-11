<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<%@ page import="bean.dto.ProjectDto" %>
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String reqPrId = request.getParameter("pr_id");
	
	if(reqPrId == null) {
	%>
		<script>
			alert("비정상적인 접근입니다.");
			history.back();
		</script>
	<%	
	} else {
		int prId = Integer.parseInt(reqPrId);
		
		ProjectDto dto = projectDao.getProject(prId);
		
		
		// 저장된 파일 삭제
		String img = dto.getImagePath();
		String fullPath = "C:/Users/khb69/git/velio/Velio/src/main/webapp/imagePath/" + img;
		
		File origFile = new File(fullPath);
		origFile.delete();
		
		boolean result = projectDao.deleteProject(prId);

		response.sendRedirect("../../view/project_list.jsp?id=" + dto.getUserId());
	}
	%>
</body>
</html>