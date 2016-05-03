var menuTgl = false;

$(function () {
	var url = window.location;
	var path = url.href.split('/');
	var file_name = path.pop();
	
	if(file_name == "index.html" || file_name == "") 
		$('body').addClass("index");
});

$('button.search').click(function() {
	console.log("click");

	if(menuTgl == false) {
		$('nav').slideDown(150);
		$(this).toggleClass('close');
		// $('button.search').css('background-image', 'url(images/x_icon.png)');
		$('#menus').css('opacity', '0.2');
		//$('header').css('position', 'static');
		menuTgl = true;
	} else {
		$('nav').slideUp(200);
		$(this).toggleClass('close');
		// $('button.search').css('background-image', 'url(images/search_icon.png)');
		$('#menus').css('opacity', '1.0')
		//$('header').css('position', 'fixed');
		menuTgl = false;
	}
});

$('#menus').click(function() {
	if(menuTgl == true) {
		$('nav').slideUp(200);
		$('button.search').toggleClass('close');
		// $('button.search').css('background-image', 'url(images/search_icon.png)');
		$('#menus').css('opacity', '1.0')
		//$('header').css('position', 'fixed');
		menuTgl = false;
	}
});

$('.skip').click(function() { //テスト用
	window.location.href = 'menus';
}) 