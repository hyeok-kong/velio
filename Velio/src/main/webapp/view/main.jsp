<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>velio</title>
<link rel="stylesheet" href="../resources/css/main.css">
<script src="../resources/javascript/main.js"></script>
<!-- <script>
	function toggleLike() {
		const likeIcon = document.querySelector('.card-like-icon');
		likeIcon.classList.toggle('full-heart');
	}
</script>
-->
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<main>
	
	<%@ page import="java.util.ArrayList, bean.dto.*" %>
	<jsp:useBean id="portfolioDao" class="bean.dao.PortfolioDao" scope="page" />
	
		<%
		request.setCharacterEncoding("utf-8");
		
		
		
		String pageParam = request.getParameter("page");
		String keyword = request.getParameter("keyword");
		
		// 요청 페이지
		int pageNum;
		// 한 페이지당 출력할 포트폴리오 개수
		int count = 5;
		// 페이징 블록 단위
		int blockCount = 5;
		// 총 포트폴리오 개수
		int totalCount = 0;
		// 출력할 포트폴리오 리스트
		ArrayList<PortfolioDto> portfolios = new ArrayList<>();
		
		if(keyword == null) {
			totalCount = portfolioDao.getPortfolioCount();
		} else {
			totalCount = portfolioDao.getPortfolioCount(keyword);
		}
		
		if(pageParam == null || pageParam.length() == 0) {
			pageNum = 1;
		}
		
		try {
			pageNum = Integer.parseInt(pageParam);
		} catch(NumberFormatException e) {
			pageNum = 1;
		}
		
		int currentBlock = pageNum % blockCount == 0 ? pageNum / blockCount : (pageNum / blockCount) + 1;
		int startPage = (currentBlock - 1) * blockCount + 1;
		int endPage = startPage + blockCount - 1;
		
		int totalPages = totalCount % count == 0 ? totalCount / count : (totalCount / count) + 1;
		
		if(totalPages == 0) {
			totalPages = 1;
		}
		
		if(endPage > totalPages) {
			endPage = totalPages;
		}
		
		if(keyword == null) 
			portfolios = portfolioDao.getPortfolioList((pageNum - 1) * count, count);
		else 
			portfolios = portfolioDao.getPortfolioList((pageNum - 1) * count, count, keyword);
		
		if(portfolios.size() > 0) {
		%>

		<%
			for(PortfolioDto portfolio : portfolios) {
		%>
		<div class="card">
			<div style="cursor: pointer" onClick=moveLocation(<%=portfolio.getId() %>)>
				<div class="card-header" >
					<div class="card-title"> <%= portfolio.getTitle() %></div>
					<div class="card-author"><%= portfolio.getUser().getNickname() %></div>
					<div class="card-like">
						<span class="card-like-count"><%= portfolio.getViews() %></span> <span>&#x1F441;</span>
						<span class="card-like-count"><%= portfolio.getShared() %></span> <span>&#x2B50;</span>
					</div>
				</div>
				<div class="card-content"> 
				<%= portfolio.getContent() %></div>
				<div class="card-tags">
				
			<%
					for(String interest : portfolio.getInterArray()) {
			%>
					<span><a href="main.jsp?keyword=<%= interest%>"><%= interest %></a></span>
			<%
					}
			%>
				</div>
			</div>
		</div>
		<%
			}
		}
		%>
	</main>

	<section>
		<%-- 페이징 버튼을 포함할 div 요소 --%>
		<div id="pagination-container">
		    <%-- 페이지 버튼을 동적으로 생성하는 부분 --%>
		    <button class="page-button" onclick=goToPage(1)>First</button>
		    <%if(startPage < 6) {%>
				<button class="disabled-page-button" disabled>Previous</button>	    
		    <%
		    } else { %>	
		    	<button class="page-button" onclick=goToPage(<%= startPage - 1 %>)>Previous</button>
		    <%
		    }
		    %>
		    <% for (int i = startPage; i <= endPage; i++) { 
			    	if(i==pageNum) {
			%>
			        <button class="selected-page-button" onclick=goToPage(<%= i %>) disabled><%= i %></button>
			<%
			    	} else {
			%>
			        <button class="page-button" onclick=goToPage(<%= i %>)><%= i %></button>
			<% 
			    	}
		    	} 
		    %>
		    <%if(endPage == totalPages) {%>
				<button class="disabled-page-button" disabled>Next</button>	    
		    <%
		    } else { %>	
		    	<button class="page-button" onclick=goToPage(<%= endPage + 1 %>)>Next</button>
		    <%
		    }
		    %>
		    <button class="page-button" onclick=goToPage(<%= totalPages %>)>Last</button>
		    
		</div>
	</section>
	
</body>
</html>