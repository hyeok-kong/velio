// 패스워드 확인 일치하는지 확인
function checkPasswordMatch() {
	var password = document.getElementById("password").value;
	var confirmPassword = document.getElementById("confirm-password").value;
	var passwordCheck = document.querySelector(".password-check");

	if (password === confirmPassword) {
		passwordCheck.classList.add("match");
	} else {
		passwordCheck.classList.remove("match");
	}
}


function openModal(modalName) {
	const modal = document.getElementById(modalName);
	modal.style.display = "block";
}

function closeModal(modalName) {
	const modal = document.getElementById(modalName);
	const modalContent = modal.querySelector(".modal-content");
	modalContent.style.animation = "slide-out 0.3s ease";
	
	setTimeout(() => {
		modal.style.display = "none";
		modalContent.style.animation = "";
	}, 300);
}

function changeModal(modal1, modal2) {
	closeModal(modal1);

	openModal(modal2);
}
