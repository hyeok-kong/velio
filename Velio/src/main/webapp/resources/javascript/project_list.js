function createProject(userId) {
	location.href = "edit_project.jsp?id=" + userId;
}


function editProject(userId, projectId) {
	location.href = `edit_project.jsp?id=${userId}&pr_id=${projectId}`;
}


function deleteProject(projectId) {
	if(!confirm("삭제하시겠습니까?")) {
		return;
	}
	
	location.href = `../service/project/delete_project_process.jsp?pr_id=${projectId}`;
}