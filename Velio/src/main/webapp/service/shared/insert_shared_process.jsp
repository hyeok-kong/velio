<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:useBean id="sharedDao" class="bean.dao.SharedDao" scope="page" />
	<%@ page import="bean.dto.*" %>
	
	<%
	request.setCharacterEncoding("utf-8");
	
	String userId = request.getParameter("id");
	String portId = request.getParameter("pf_id");
	
	int uid = 0;
	int pid = 0;
	
	if(userId != null && portId != null) {
		uid = Integer.parseInt(userId);
		pid = Integer.parseInt(portId);
	} else {
	%>
		<script>
			alert("비정상적인 접근입니다.");
			history.back();
		</script>
	<%
	}
	
	SharedDto dto = new SharedDto();

	dto.setUser_id(uid);
	dto.setPort_id(pid);
	
	sharedDao.insertShared(dto);
	
	%>
	<script>
		alert("즐겨찾기 되었습니다.");
		location.href="../../view/portfolio.jsp?id=" + <%= pid%>;
	</script>
	<%
	%>
</body>
</html>