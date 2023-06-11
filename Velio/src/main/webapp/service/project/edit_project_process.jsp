<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
	<%@page import="com.oreilly.servlet.MultipartRequest"%>
	
	<%@ page import="bean.dto.*" %>
	<jsp:useBean id="projectDao" class="bean.dao.ProjectDao" scope="page" />
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
	
	<%
		String uid = "";
	

		Cookie[] cookies = request.getCookies();
		
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("VelioID")) {
				uid = cookie.getValue();
			}
		}
	
		int userId = userDao.findUserIdByUid(uid);
		String uploadPath = "C:/Users/khb69/git/velio/Velio/src/main/webapp/imagePath";


		int maxFileSize = 5 * 1024 * 1024;
		
		String file = "";
		String originFile = "";
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String str = (String) files.nextElement();
			
		file = multi.getFilesystemName(str);
		originFile = multi.getOriginalFileName(str);

		String mode = multi.getParameter("mode");

		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String image = multi.getFilesystemName("image");
		String origImg = multi.getParameter("origImg");
		
		int usId = 0;
		int pid = 0;
		String prId = multi.getParameter("prId");
		if(prId != null) {
			pid = Integer.parseInt(prId);
		}
		
		ProjectDto dto = new ProjectDto();
		
		System.out.println("inserted data : " + userId + pid + title + content + image);
			
		dto.setTitle(title);
		dto.setContent(content);
		dto.setImagePath(image);
		dto.setId(pid);
		dto.setUserId(userId);
		
		if(mode.equals("create")) {
			projectDao.insertProject(dto);
			response.sendRedirect("../../view/project_list.jsp?id=" + userId);
		} else {
			System.out.println("mode : " + mode);
			boolean result = projectDao.updateProject(dto);
			
			// 기존 이미지 삭제 후 저장
			if(dto.getImagePath() != null && origImg.length() > 2) {
				String origFilePath = uploadPath + "/" + origImg;
				
				File origFile = new File(origFilePath);
				origFile.delete();
			}
			
			response.sendRedirect("../../view/project_list.jsp?id=" + userId);
		}
	%>

</body>
</html>