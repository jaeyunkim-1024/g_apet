var cookieNm = "DCGSearch";

$(document).ready(
		function() {

			// 인기검색어 노출
			// getHotkeywordView();

			$('body').click(function(e) {
				if ($(".search_wrap .close").css("display") === "block") {
					if (!$(".search_wrap").has(e.target).length) {
						$(".search_wrap .close").hide();
					}
				}
			});

			// 검색창 포커스 시 최근 검색어 없으면 인기검색어 노출
			$("#top-search").on(
					"focus",
					function() {
						$(".search_wrap .close").show();
						var cookieData = getCookie("DCGSearch");
						if (cookieData === "") {
							$(".search_kind_wrap .searchKind").children("li")
									.removeClass("active");
							$(".search_kind_wrap .searchKind").children("li")
									.eq(1).addClass("active");
							$(".searchKindSub").hide();
							$(".searchKindSub").eq(1).show();
						}

					});

			// 인기검색어 클릭시 검색
			$(".unified_search_wrap").find(".popular > ul > li").on("click",
					function() {
						var query = $(this).data("value");
						goDirectSearch(query);
					});

			// 최근검색어 클릭시 검색
			$(".unified_search_wrap").find(".recent > ul > li").on("click",
					function() {
						var query = $(this).data("value");
						goDirectSearch(query);
					});
		});

/* 검색 */
function goSearch() {
	var search = $("#top-search").val();
	if (search !== "") {
		setSearchCookie(search, cookieNm);
		$("#searchForm").submit();
	} else {
		alert("검색어를 입력해주세요.");
		$("#top-search").focus();
		return false;
	}
	return true;
}

/* 최신,인기검색어 검색 */
function goDirectSearch(val) {
	$("#top-search").val(val);
	setSearchCookie(val, cookieNm);
	$("#searchForm").submit();
}

/**
 * 내가 찾은 검색어 쿠키 셋팅
 */
function setSearchCookie(searchQuery, c_name) {
	var cookieValue = searchQuery;
	var i, x, y, ARRcookies = document.cookie.split(";");

	for (i = 0; i < ARRcookies.length; i++) {
		x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
		x = x.replace(/^\s+|\s+$/g, "");

		if (x === c_name) {
			var tempValue = unescape(y);
			if (tempValue !== "") {
				var tempArr = tempValue.split(":&");

				for (var j = 0; j < tempArr.length; j++) {
					if (tempArr[j] === searchQuery) {
						tempValue = tempValue.replace(
								":&" + searchQuery + ":&", ":&");
						if (tempValue === searchQuery) {
							tempValue = "";
						}
						if (tempValue.indexOf(searchQuery + ":&") === 0) {
							tempValue = tempValue.substr(
									searchQuery.length + 2, tempValue.length);
						}

						if ((tempValue.length - tempValue.lastIndexOf(":&"
								+ searchQuery)) === (searchQuery.length + 2)) {

							tempValue = tempValue.substr(0, tempValue
									.lastIndexOf(":&" + searchQuery));
						}

					}
				}
				cookieValue = cookieValue + ":&" + tempValue;
			}
		}
	}
	setCookie2(c_name, cookieValue, "1");
}

/**
 * 내가 찾은 검색어 쿠키 생성/삭제
 */
function setCookie2(c_name, value, exdays) {
	var type = true;
	if (exdays < 0) {
		var str = "모두 삭제하시겠습니까?";
		type = confirm(str);
	}

	if (type === true) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var c_value = escape((value)) + "; path=/; "
				+ ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());

		document.cookie = c_name + "=" + c_value;
		if (exdays < 0) {
			displayCookie(c_name);
		}
	}
}

/**
 * 내가 찾은 검색어 쿠키 확인
 */
function getCookie(cName) {
	cName = cName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cName);
	var cValue = '';
	if (start !== -1) {
		start += cName.length;
		var end = cookieData.indexOf(';', start);
		if (end === -1)
			end = cookieData.length;
		cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}

/**
 * 내가 찾은 검색어 쿠키 개별 삭제
 */
function goDeleteCookie(num, c_name) {
	var delkeyword = "";
	var cookieValue = "";
	var i, x, y, ARRcookies = document.cookie.split(";");

	for (i = 0; i < ARRcookies.length; i++) {
		x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
		y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
		x = x.replace(/^\s+|\s+$/g, "");

		if (x === c_name) {
			var tempValue = unescape(y);
			if (tempValue !== "") {
				var tempArr = tempValue.split(":&");
				var tempVal = "";

				for (var j = 0; j < tempArr.length; j++) {
					if (j !== num) {
						tempVal = tempArr[j];
						if (cookieValue !== "") {
							cookieValue = cookieValue + ":&" + tempVal;
						} else {
							cookieValue = tempVal;
						}
					} else {
						delkeyword = tempArr[j];
					}
				}
			}
		}
	}

	var type = true;
	var str = "'" + delkeyword + "' 검색어를 삭제하시겠습니까?";
	type = confirm(str);
	if (type === true) {
		setCookie2(c_name, cookieValue, "1");
		displayCookie(c_name);

	}
}

/**
 * 내가 찾은 검색어 노출
 */
function displayCookie(c_name) {

	var cookieData = getCookie(c_name);
	var cookieDiv = document.getElementById("searchKind1");
	var cookieArr = cookieData.split(":&");
	var cookieKey = "";
	var text = "";
	var tempCount = cookieArr.length;
	if (tempCount > 10) {
		tempCount = 10;
	}
	if (cookieData === "") {
		tempCount = 0;
	}

	if (tempCount > 0) {
		text += "<ul>";
		for (var i = 0; i < tempCount; i++) {
			cookieKey = cookieArr[i].replace(/"/g, "&#34;").replace(/\\/g,
					"\\\\").replace(/'/g, "\\'");
			if (cookieArr[i] !== '') {
				text += "<li data-value=\"" + cookieKey + "\">";
				text += "<a href=\"javascript:goDirectSearch('"
						+ cookieKey
						+ "');\" title=\""
						+ cookieKey
						+ "\" >"
						+ cookieArr[i]
						+ "</a><button type=\"button\" class=\"close\" onclick=\"goDeleteCookie('"
						+ i + "','" + c_name + "');\" title=\"내가 찾은 검색어 '"
						+ cookieKey + "'(을)를 삭제합니다.\"><span>삭제</span></button>";
				text += "</li>";
			}
		}

		text += "</ul>";
		text += "<div class=\"info_msg\">"
		text += "<button type=\"button\" class=\"close\" onclick=\"setCookie2('"
				+ cookieNm + "','','-1');\">전체삭제 <span>전체삭제</span></button>"
		text += "</div>"
	} else {
		text += "<ul>";
		text += "<li>";
		text += "<p>최근 검색내역이 없습니다.</p>";
		text += "</li>";
		text += "</ul>";
	}
	cookieDiv.innerHTML = text;
	/* var unifiedSearch=new UnifiedSearch(); */
}

/*
 * 인기검색어 노출
 */
function getHotkeywordView() {
	$.ajax({
		type : "post",
		url : "/search_new/hotkeyword",
		dataType : "html",
		async : false,
		success : function(data) {
			$("#searchKind2").html(data);
		},
		error : function(data) {
			alert("에러");
		}
	});
}
