<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="request" />
	<jsp:useBean id="user" class="bean.dto.UserDto" scope="request" />
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String uid = request.getParameter("uid");
	String pw = request.getParameter("pw");
	
	if (!userDao.validateUser(uid, pw)) {
	%>
		<script>
			alert('아이디나 비밀번호가 틀렸습니다.');
			history.back();
		</script>
	<%
	} else {
		user = userDao.findUserByUid(uid);
		
		Cookie idCookie = new Cookie("VelioID", uid);
		Cookie nameCookie = new Cookie("VelioNickname", user.getNickname());
		
		idCookie.setPath("/");
		nameCookie.setPath("/");
		
		response.addCookie(idCookie);
		response.addCookie(nameCookie);
		
		response.sendRedirect("../../view/main.jsp");
	}
	%>
</body>
</html>