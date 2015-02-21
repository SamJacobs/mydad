(function() {
	window.moveTo(0, 0);
	window.resizeTo(screen.width, screen.height);
})();

function poll() {
	setTimeout(
		function() {
		$.get('/more', 
			  function(data) {
				console.log(data);
				$('#rest')[0].innerHTML = data;
				poll();
			}
		);},
	 	 
		3500);
};

