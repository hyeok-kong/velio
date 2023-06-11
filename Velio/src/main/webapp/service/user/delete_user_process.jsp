<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
	<%
	request.setCharacterEncoding("utf-8");
	
	String userId = request.getParameter("id");
	int id = 0;
	String uid = "";
	boolean isAdmin = false;
	
	if(userId != null) {
		id = Integer.parseInt(userId);
	}
	
	Cookie[] cookies = request.getCookies();
	
	for(Cookie cookie : cookies) {
		if(cookie.getName().equals("VelioID")) {
			uid = cookie.getValue();
		}
		if(cookie.getName().equals("VelioRole")) {
			if(cookie.getValue().equals("admin")) isAdmin = true;
		}
	}
	
	System.out.println("----------id : " + id);
	if(userId == null) {
		if(!userDao.isRightRequest(id, uid) || isAdmin) { 
			System.out.println("----------uid : " + id);			
	%>
		<script>
			alert("비정상적인 접근입니다.");
			history.back();
		</script>
	<%
		} 
	} else {
			id = Integer.parseInt(userId);
			
			System.out.println("-------result : " + userDao.deleteUser(id));
			
			for(Cookie cookie : cookies) {
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		%>
			<script>
				alert("회원 탈퇴가 완료되었습니다");
				location.href = "../../view/main.jsp"
			</script>
		<%
	}
	%>
</body>
</html>