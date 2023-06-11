window.onload = function saveAsPDF(id) {
	html2canvas(document.body).then(function(canvas) {
		var imgData = canvas.toDataURL('image/png');
		var doc = new jsPDF();
		
		doc.addImage(imgData, 'PNG', 0, 0, doc.internal.pageSize.getWidth(), doc.internal.pageSize.getHeight());

		doc.save('portfolio.pdf');
	});
}