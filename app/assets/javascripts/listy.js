/*********************** LISTY TREE LIST **********************************************/
$(function(){
	$(".listy-tree .listy-tree-list-header").click(listyTreeListHeaderClick);
});

function listyTreeListHeaderClick() {
	var list = $(this).siblings("ul");
	toggleList(list);
}

function toggleListyTreeList(list) {
	toggleListyTreList(200);
}

function toggleListyTreeList(list, duration) {
	
	var header = list.siblings(".listy-tree-list-header");
	if(list.is(":visible")) {
		list.slideUp(duration);
		header.children(".icon").html("<i class='icon-angle-right'></i>");
	}
	else {
		list.slideDown(duration);
		header.children(".icon").html("<i class='icon-angle-down'></i>");
	}
}

function autoCollapseAllBut(headerName, tree) {
	jQuery.each(tree.children("li"), function(){
		
		var listHeaderText = $(this).children(".list-header").children(".list-header-text").html();
		if(headerName != listHeaderText) {
			toggleList($(this).children(".list-header").siblings("ul"), 0);
		}
		
	});
}

/*********************** LISTY SHOW-MORE LIST ******************************************/
$(function(){
	$(".listy-show-more-link").click(toggleMoreList);
});

function toggleMoreList() {
	toggleMoreList(200);
	return false;
}

function toggleMoreList(duration) {
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