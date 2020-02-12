/*******************************/
/*  Publisher olibu. default.js   */
/*******************************/

$(function() {
/*  슬라이드 메뉴 */
	
$("#lmenu").navgoco({
		caret: '<span class="caret"></span>',
		accordion: true,
		openClass: 'open',
		//save: true,
		//cookie: {
			//name: 'navgoco',
			//expires: false,
			//path: '/'
		//},
		slide: {
			duration: 400,
			easing: 'swing'
		}
	});
/* 슬라이드 메뉴  end */	

});


$(document).ready(function() {
	var currentMenu = $("input[name=currentMenu]").val();
	if($("#lmenu").find("#li"+currentMenu).find("ul").length == 0) {
		$("#lmenu").find("#li"+currentMenu).parent().parent().addClass("open");
		$("#lmenu").find("#li"+currentMenu).parent().show();
		$("#lmenu").find("#li"+currentMenu).addClass("active");
	} else {
		$("#lmenu").find("#li"+currentMenu).addClass("open");
		$("#lmenu").find("#li"+currentMenu).find("ul").show();
		$("#lmenu").find("#li"+currentMenu).find("ul").find("li").eq(0).addClass("active");
	}
});

/* popup */
needPopup.config.custom = {
				//'removerPlace': 'outside',
				'closeOnOutside': false,
				onShow: function() {
					console.log('needPopup is shown');
				},
				onHide: function() {
					console.log('needPopup is hidden');
				}
			};
			needPopup.init();