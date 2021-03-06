/*********************** LISTY TREE LIST **********************************************/
$(function(){
	$(".listy-tree .listy-tree-list-header").click(listyTreeListHeaderClick);
});

function listyTreeListHeaderClick() {
	var list = $(this).siblings("ul");
	toggleListyTreeList(list);
	return false;
}

function toggleListyTreeList(list) {
	toggleListyTreeList(list, 200);
}

function toggleListyTreeList(list, duration) {
	
	var header = list.siblings(".listy-tree-list-header");
	if(list.is(":visible")) {
		list.slideUp(duration);
		header.removeClass("listy-list-header-expanded");
		header.addClass("listy-list-header-collapsed");
	}
	else {
		list.slideDown(duration);
		header.addClass("listy-list-header-expanded");
		header.removeClass("listy-list-header-collapsed");
	}
}

function autoCollapseAllListyBranchesBut(headerName, tree) {
	jQuery.each(tree.children("li"), function(){
		
		var listHeaderText = $(this).children(".listy-tree-list-header").html();
		if(headerName != listHeaderText) {
			toggleListyTreeList($(this).children(".listy-tree-list-header").siblings("ul"), 0);
		}
		
	});
}

/*********************** LISTY SHOW-MORE LIST ******************************************/
$(function(){
	$(".listy-show-more-link").click(toggleListyShowMoreList);
});

function toggleListyShowMoreList() {
	toggleMoreList(200);
	return false;
}

function toggleListyShowMoreList(duration) {
	var showMoreList = $(this).siblings(".listy-show-more-list");
	if(showMoreList.is(":visible")) {
		showMoreList.slideUp(duration);
		$(this).html("Show More");
	}
	else {
		showMoreList.slideDown(duration);
		$(this).html("Show Less");
	}
	return false;
}