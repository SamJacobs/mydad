function poll() {
	$.get('/more', 
	  function(data) {
			$('#rest')[0].innerHTML = data;
			setTimeout(poll, 3500);
		}
	)
};

