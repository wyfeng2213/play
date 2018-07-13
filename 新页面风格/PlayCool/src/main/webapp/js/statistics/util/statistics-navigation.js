var timeout = 500;
	var closetimer = 0;
	var ddmenuitem = 0;
	// open hidden layer
	function mopen(id) {
		// cancel close timer
		mcancelclosetime();

		// close old layer
		if (ddmenuitem)
			ddmenuitem.style.visibility = 'hidden';

		// get new layer and show it
		ddmenuitem = document.getElementById(id);
		ddmenuitem.style.visibility = 'visible';
	}
	// close showed layer
	function mclose() {
		if (ddmenuitem)
			ddmenuitem.style.visibility = 'hidden';
	}
	// go close timer
	function mclosetime() {
		closetimer = window.setTimeout(mclose, timeout);
	}
	// cancel close timer
	function mcancelclosetime() {
		if (closetimer) {
			window.clearTimeout(closetimer);
			closetimer = null;
		}
	}
	// close layer when click-out
	document.onclick = mclose;
	
	function navCss(item) {
		switch(item) {
		case 'day':
			$(".dayText").css('color','red');
			$(".weekText").css('color','');
			$(".monthText").css('color','');
			$(".seasonText").css('color','');
			$(".yearText").css('color','');
			break;
		case 'week':
			$(".dayText").css('color','');
			$(".weekText").css('color','red');
			$(".monthText").css('color','');
			$(".seasonText").css('color','');
			$(".yearText").css('color','');
			break;
		case 'month':
			$(".dayText").css('color','');
			$(".weekText").css('color','');
			$(".monthText").css('color','red');
			$(".seasonText").css('color','');
			$(".yearText").css('color','');
			break;
		case 'season':
			$(".dayText").css('color','');
			$(".weekText").css('color','');
			$(".monthText").css('color','');
			$(".seasonText").css('color','red');
			$(".yearText").css('color','');
			break;
		case 'year':
			$(".dayText").css('color','');
			$(".weekText").css('color','');
			$(".monthText").css('color','');
			$(".seasonText").css('color','');
			$(".yearText").css('color','red');
			break;
		}
	}