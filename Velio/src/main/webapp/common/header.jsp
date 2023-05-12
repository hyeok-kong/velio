<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/header.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="../resources/logo.png" alt="Logo">
        </div>
		
		<%! boolean isLoggedIn = false; %>
		<% request.setCharacterEncoding("EUC-KR"); %>
		
		<%
			Cookie[] cookies = request.getCookies();
			
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("VelioID")) {
					isLoggedIn = true;
				}
			}
			
			if(!isLoggedIn) {
		%>
        <div class="signup">
            <a class="button">회원가입</a>
            <a class="button">로그인</a>
        </div>
        <%
        	} else {
		%>
		<div class="user">
            <div class="dropdown">
                <button class="dropdown-btn"><span>권혁빈 님</span></button>
                <div class="dropdown-menu">
                    <a href="#">내 포트폴리오</a>
                    <a href="#">프로젝트 관리</a>
                    <a href="#">즐겨찾기</a>
                    <a href="#">로그아웃</a>
                </div>
            </div>
        </div>
        <%
        	}
		%>
		
    </header>
</body>
</html>