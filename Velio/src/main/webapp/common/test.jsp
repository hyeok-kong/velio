<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
		<% request.setCharacterEncoding("EUC-KR"); %>
		
		<%
			Cookie[] cookies = request.getCookies();
		
			out.print(cookies.length);
			
			for(Cookie cookie : cookies) {
				out.print("��Ű �̸� : " + cookie.getName() + "<br>");
				out.print("��Ű ���� : " + cookie.getValue() + "<br>");
			}
		%>
</body>
</html>