function moveLocation(id) {
	location.href = `portfolio.jsp?id=${id}`;
}

function goToPage(id) {
	location.href = `main.jsp?page=${id}`;
}

function deleteShare(id, pfId) {
	location.href = `../service/shared/delete_shared_process?id=${id}&pf_id=${pfId}`;
}