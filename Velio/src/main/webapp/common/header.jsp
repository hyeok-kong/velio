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
            <a class="button">ȸ������</a>
            <a class="button">�α���</a>
        </div>
        <%
        	} else {
		%>
		<div class="user">
            <div class="dropdown">
                <button class="dropdown-btn"><span>������ ��</span></button>
                <div class="dropdown-menu">
                    <a href="#">�� ��Ʈ������</a>
                    <a href="#">������Ʈ ����</a>
                    <a href="#">���ã��</a>
                    <a href="#">�α׾ƿ�</a>
                </div>
            </div>
        </div>
        <%
        	}
		%>
		
    </header>
</body>
</html>