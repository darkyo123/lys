/*******************************/
/*  Publisher olibu. Front-js.js   */
/*******************************/
//GNB Mouse on,oveer end
$(document).ready(function() {

	
// 스크롤 앵커이동
$('a.ps').click(function(){
$('html, body').animate({
scrollTop: $( $.attr(this, 'href') ).offset().top -80
}, 500);
return false;
});

/* 위로
스크롤이 특정 위치로 이동하면 위로버튼이 나타난다.
위로버튼을 클릭하면 상단으로 이동
*/
function btn_mv_up(oj) {
 if(!oj) return false;
 var o = $(oj);
 var p = $(window).scrollTop();
 if(p > 300){ o.fadeIn('slow'); }    // 위로버튼이 나타나는 위치 지정
 else if(p < 300){ o.fadeOut('slow'); }    // 위로버튼을 숨기는 위치 지정
}

 

// 위로 버튼
$(document).scroll(function() {
  btn_mv_up('.btn_up_layer');
 }).on('click', '.btn_up_layer', function() {
  $("html, body").animate({scrollTop:0}, 'slow');
});
	

/* */

/* tab */
   //Default Action
	/*$(".tab_content").hide(); //Hide all content
	$(".summary_tab ul li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content
	
	//On Click Event
	$(".summary_tab ul li").click(function() {
		$(".summary_tab ul li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active content
		return false;
	});*/
	
/* tab end */

//Default Action
$(".stat_content").hide(); //Hide all content
$(".stat_tab ul li:first").addClass("active").show(); //Activate first tab
$(".stat_content:first").show(); //Show first tab content

//On Click Event
$(".stat_tab ul li").click(function() {
	$(".stat_tab ul li").removeClass("active"); //Remove any "active" class
	$(this).addClass("active"); //Add "active" class to selected tab
	$(".stat_content").hide(); //Hide all tab content
	var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
	$(activeTab).fadeIn(); //Fade in the active content
	return false;
});

	//Default Action
$(".report_content").hide(); //Hide all content
$(".report_tab ul li:first").addClass("active").show(); //Activate first tab
$(".report_content:first").show(); //Show first tab content

//On Click Event
$(".report_tab ul li").click(function() {
	$(".report_tab ul li").removeClass("active"); //Remove any "active" class
	$(this).addClass("active"); //Add "active" class to selected tab
	$(".report_content").hide(); //Hide all tab content
	var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
	$(activeTab).fadeIn(); //Fade in the active content
	return false;
});

$('.btn-roll').on('click', function(){
        $(this).siblings('.roll-content').stop().slideToggle('300');
		//$(".btn-roll").hide();
		//$(".btn-roll-on").show();
    })	
	
//$('.btn-roll-on').on('click', function(){
    //    $(this).siblings('.roll-content').stop().slideToggle('300');
	//	$(".btn-roll").show();
//		$(".btn-roll-on").hide();
  //  })	



/* rolling end */
/* 좌우 높이조절 */
//if (jQuery(window).width() > 768) {
//    $('.left_area').height($('.right_area').outerHeight());
//	}
	
	
});	
	
