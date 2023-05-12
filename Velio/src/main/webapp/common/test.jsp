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
				out.print("쿠키 이름 : " + cookie.getName() + "<br>");
				out.print("쿠키 내용 : " + cookie.getValue() + "<br>");
			}
		%>
</body>
</html>