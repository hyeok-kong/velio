<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/header.css">
<link rel="stylesheet" href="../resources/css/header_button.css">
<script src="../resources/javascript/header.js"></script>
</head>
<body>
	<header>
	
	<jsp:useBean id="userDao" class="bean.dao.UserDao" scope="page" />
		<div class="logo">
			<a href="../view/main.jsp"><img src="../resources/logo.png" alt="Logo" ></a>
		</div>


		<%
		request.setCharacterEncoding("utf-8");
		%>

		<%
		Cookie[] cookies = request.getCookies();
		String nickname = "";
		String uid = "";
		
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("VelioNickname")) {

				nickname = cookie.getValue();
			}
			if (cookie.getName().equals("VelioID")) uid = cookie.getValue();
		}

		if (cookies.length < 2) {
		%>
		<div class="signup">
			<a class="button" onclick="openModal(`modal-register`)">회원가입</a> <a
				class="button" onclick="openModal(`modal-login`)">로그인</a>
		</div>

		<div id="modal-register" class="modal-overlay">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal(`modal-register`)">&times;</span>

				<div class="container">
					<h2>Sign Up</h2>
					<form action="../service/user/register_process.jsp" method="post">

						<input type="text" id="id" name="uid" placeholder="아이디를 입력하세요" required> 
						<input type="password" id="password" name="pw" placeholder="비밀번호를 입력하세요" required>
						<input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
						<input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요" required>
						<input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>

						<div class="button-container">
							<input type="submit" id="submit" value="회원가입"> <input
								type="reset" value="초기화">
						</div>
					</form>
				</div>
			</div>
		</div>

		<div id="modal-login" class="modal-overlay">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal(`modal-login`)">&times;</span>

				<div class="container">
					<h2>LOGIN</h2>
					<form name="login" method="post" action="../service/user/login_process.jsp">
						<input type="text" id="id" name="uid" placeholder="아이디를 입력하세요" required><br>
						<input type="password" id="password" name="pw" placeholder="비밀번호를 입력하세요" required><br>
						<input type="submit" value="로그인">
						<div class="button-group">
							<p class="signup-link">
								아직 가입을 안하셨나요? &nbsp; 
								<a onclick="changeModal(`modal-login`, `modal-register`)">회원가입</a>
							</p>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%
		} else {
			
		%>
		<div class="user">
			<div class="dropdown">
				<button class="dropdown-btn">
					<span><%= nickname %> 님</span>
				</button>
				<div class="dropdown-menu">
					<a href="../view/mypage.jsp?id=<%= userDao.findUserIdByUid(uid) %>">내 포트폴리오</a>
					<a href="#">프로젝트 관리</a>
					<a href="#">즐겨찾기</a>
					<a href="../service/user/logout_process.jsp" onClick="location.reload()">로그아웃</a>
				</div>
			</div>
		</div>
		<%
		}
		%>

	</header>
</body>
</html>