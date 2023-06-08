<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	%>
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="request" />
	<jsp:useBean id="user" class="bean.dto.UserDto" scope="request" />
	
	<jsp:setProperty name="user" property="uid" />
	<jsp:setProperty name="user" property="pw" />
	<jsp:setProperty name="user" property="name" />
	<jsp:setProperty name="user" property="nickname" />
	<jsp:setProperty name="user" property="email" />
	<%
	userDao.insertUser(user);
	
	%>
	<script>
		alert('회원가입 되었습니다');
	</script>
	<%
	Cookie idCookie = new Cookie("VelioID", user.getUid());
	Cookie nameCookie = new Cookie("VelioNickname", user.getNickname());
	
	idCookie.setPath("/");
	nameCookie.setPath("/");
	
	response.addCookie(idCookie);
	response.addCookie(nameCookie);
	
	response.sendRedirect("../../view/main.jsp");
	%>
	
</body>
</html>