/**
 * @function Name : valid
 * @function Desc : 유효성 검사용 정규식
 * @작성일 : 2021.01.21
 * @작성자 : 이지희
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       이지희 : 2021. 01. 12 : : 신규 개발.
 */

var valid = {
	login_id : /^[a-zA-Z0-9!@@#$%^&*|\\\'\"\()\\[\];:\/?><,.{}+_=-]+$/,
	password : /^(?=.*[a-z]+)(?=.*[0-9]+).{5,12}$/,
	orderPswd : /^(?=.*[a-z]+)(?=.*[0-9]+).{4,10}$/,
	tel : /^0\d{1,2}-?\d{3,4}-?\d{4}$/,
	mobile : /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/,
	email : /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((([a-zA-Z]+\.)+[a-zA-Z]{3})|(([a-zA-Z]+\.)+[a-zA-Z]{2}\.[a-zA-Z]{2}))$/,
	url : /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/,
	url_website : /^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/,
	onlyNum : /^[0-9\ ]+$/,
	bizNo : /^\d{3}-?\d{2}-?\d{5}$/,
	acct : /^[0-9-]+$/, // 계좌번호
	ko : /^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/,
	checkEmail : function(email){
        var check = email.search(/[^0-9 a-z !@@#$%^&*|\\₩'₩"\()\\[\];:₩/?><,.{}+_=-]/gi);
        if(email.length < 4 || email.length > 30 || !this.checkSpace(email) 
        		|| email.search("@") < 0 || email.search("@") > email.search("\\.") || email.search("\\.")+1 == email.length  ){
        	return false;
        }
        return true;
	},
	/**
	 * 입력값을 Byte로 변환
	 *
	 * @param targetId
	 * @param valueId
	 * @param maxByte
	 */
	checkByte : function(targetId, valueObj, maxByte) {
		var result = 0;
		var strVal = $(valueObj).val();
		var strLen = strVal.length;
		var dLen = 0;
		if (strVal !== "") {
			for (var idx = 0; idx < strLen; idx++) {
				var c = escape(strVal.charAt(idx));

				if (c.length === 1)
					result++;
				else if (c.indexOf("%u") !== -1)
					result += 2;
				else if (c.indexOf("%") !== -1)
					result += c.length / 3;

				if (result <= maxByte)
					dLen = idx + 1;
			}

			if (result > maxByte) {
				alert(maxByte + "Byte를 초과 입력할 수 없습니다.");
				strVal = strVal.substr(0, dLen);
				$(valueObj).val(strVal);
				this.checkByte(targetId, valueObj, maxByte);
			} else {
				$("#" + targetId).html(result + "/" + maxByte + "Byte");
			}
		} else {
			$("#" + targetId).html(result + "/" + maxByte + "Byte");
		}
	},
	numberWithCommas : function(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	, checkSpace : function(str) {
		//공백 체크
		if(str.search(/\s/) !== -1) {
			return false;
		} else {
			return true;
		}
	}
};

/**
 * @function Name : pswdValid
 * @function Desc : 비밀번호 유효성검사
 * @작성일 : 2021.01.12
 * @작성자 : 이지희
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       이지희 : 2021.01.12 : : 신규(원코드에서 수정 중)
 * 예) 2개 문자 종류 조합 시 최소 10자리 이상
 *     3개 이상 문자 조합 시 최소 8자리 이상
 *     동일 또는 연속적인 숫자나 문자(4자리 이상), 생일, 전화번호 사용 제한
 *     단순 패스워드 기준은 8자 미만, 영 숫자 미혼용 등
 */
var pswdValid = {
	number : "0123456789"
	, lowerCase : "abcdefghijklmnopqrstuvwxyz"
	, upperCase : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	,checkPswd : function(pswd){
		//문자 조합 두종류 , 8~15byte
		var num = pswd.search(/[0-9]/g);
        var eng = pswd.search(/[a-z]/ig);
        var spe = pswd.search(/[~`!@@#$%^&*\\₩'₩"\()\\[\];:₩/?><,.{}+_=-]/gi); 

        if(pswd.length < 8 || pswd.length > 15 ) //|| (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (num < 0 && spe < 0)  )
        {
            //$("#newPwdErrMsg").text("8자 이상 15자 이하로 하되, 숫자와 영문자, 특수기호를 각각 1자 이상 입력해 주세요.");
            return "falseLength";
        }else if( !valid.checkSpace(pswd) || num < 0 || eng < 0 || spe < 0 ){
        	return "falseCheck" 
        }
        
		return "true";
	}
	/**
	 * 비밀번호 4자리 연속, 반복된 문자, 숫자 체크
	 * @param pswd
	 */
	, checkPswdMatch : function(pswd){
		//연속 문자 체크
		for(var i=0; i<this.number.length-2; i++){
			if(pswd.indexOf(this.number.substring(i,i+3)) > -1 || pswd.indexOf(this.reverse(this.number).substring(i,i+3)) >-1){
				return false;
			}
		}
		for(var j=0; j<this.lowerCase.length-2; j++){
			if(pswd.indexOf(this.lowerCase.substring(j,j+3)) >-1 || pswd.indexOf(this.reverse(this.lowerCase).substring(j,j+3)) >-1){
				return false;
			}
		}
		for(var k=0; k<this.upperCase.length-2; k++){
			if(pswd.indexOf(this.upperCase.substring(k,k+3)) >-1 || pswd.indexOf(this.reverse(this.upperCase).substring(k,k+3)) >-1){
				return false;
			}
		}
		//반복 문자 체크
		var sameTextCnt = 0;
		for(var l=0; l<pswd.length-1; l++){
			if(pswd.charCodeAt(l) === pswd.charCodeAt(l+1)){
				sameTextCnt++;
			}else{
				sameTextCnt = 0;
			}
			if(sameTextCnt >= 2){
				return false;
			}
			
		}

		return true;
	}
	, checkIncludeStr : function(pswd, str){
		//특정 문자 포함 체크
		if(str != null && str !== ''){
			if(pswd.indexOf(str) > -1) {
				return false;
			}
		}


		return true;
	} 
	, checkIncludeIdValue : function(pswd, str){
		//아이디 4자이상 포함 체크
		if(str == "") return true; //넣어야할까..? 혹시몰라서 넣음
		var cnt = 0;
		for(i=0; i<str.length-3; i++){
			tmp = str.charAt(i) + str.charAt(i+1) + str.charAt(i+2) + str.charAt(i+3);
			if(pswd.indexOf(tmp) > -1){
				cnt ++;
			}
		}
		if(cnt > 0){
		  return false;
		}

		return true;
	}
	
	, reverse : function(str){
		return str.split("").reverse().join("");
	}
}

/**
 * @function Name : spin
 * @function Desc : Jquery Spin 관련 함수
 * @작성일 : 2016.03.02
 * @작성자 : 신남원
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       신남원 : 2016. 03. 02 : : 신규 개발.
 */
var waiting = {
	start : function() {
		$.blockUI({
			message : '<img src="/_images/common/icon_loading_76.gif" alt="Loading..." />'
		});
	},
	stop : function() {
		$.unblockUI();
	},
	startId : function(id) {
		$.blockUI({
			message : $("#" + id)
		});
	},
	stopId : function() {
		$.unblockUI();
	}
};


if(typeof(String.prototype.replaceAll) == "undefined") {
	String.prototype.replaceAll = function(target, replacement) {
		return this.split(target).join(replacement);
	};
}

/**
 * @function Name : dialog
 * @function Desc : Jquery UI를 이용한 Dialog 관련 함수
 * @작성일 : 2016.03.02
 * @작성자 : 신남원
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       신남원 : 2016. 03. 02 : : 신규 개발.
 */
var dialog = {
	/**
	 * @function Name : dialog.create
	 * @function Desc : dialog 생성 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param targetId
	 * @param options
	 */
	create : function(targetId, options) {
		var dialogOption = {
			autoOpen : setDefaultIfNull(options.autoOpen, false),
			width : setDefaultIfNull(options.width, 500),
			height : setDefaultIfNull(options.height, 300),
			draggable : setDefaultIfNull(options.draggable, false),
			resizable : setDefaultIfNull(options.resizable, false),
			modal : options.modal,
			buttons : setDefaultIfNull(options.buttons, ''),

		};

		if (options.open != null) {
			dialogOption.open = options.open;
		}

		if (options.close != null) {
			dialogOption.close = options.close;
		}

		$('#' + targetId).dialog(dialogOption);

	},
	/**
	 * @function Name : dialog.open
	 * @function Desc : 생성된 dialog open 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param targetId
	 */
	open : function(targetId) {
		$('#' + targetId).dialog("open");
	},
	/**
	 * @function Name : dialog.close
	 * @function Desc : open된 dialog close 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param targetId
	 */
	close : function(targetId) {
		$('#' + targetId).dialog("close");
	},
	/**
	 * @function Name : dialog.destory
	 * @function Desc : 생성된 dialog 제거 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param targetId
	 */
	destroy : function(targetId) {
		$('#' + targetId).dialog("destroy");
	}

}

/**
 * @function Name : ajax
 * @function Desc : ajax 관련 함수
 * @작성일 : 2016.03.02
 * @작성자 : 신남원
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       신남원 : 2016. 03. 02 : : 신규 개발.
 */
var ajax = {
	/**
	 * @function Name : ajax.call
	 * @function Desc : ajax를 이용한 Data 요청
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 */
	call : function(options) {
		
		if($(".blockUI:visible", document).length == 0){
			waiting.start();
		} 
		
		jQuery.ajaxSettings.traditional = true;

		options.contentType = setDefaultIfNull(options.contentType, "application/x-www-form-urlencoded;charset=UTF-8");
		options.type = setDefaultIfNull(options.type, "POST");
		options.dataType = setDefaultIfNull(options.dataType, "json");
		options.async = (options.async == null || options.async) ? true : false;
		options.crossDomain = (options.crossDomain == null) ? false : options.crossDomain;
		options.isRemoveLoading  = (options.isRemoveLoading == null) ? true : options.isRemoveLoading;
		
		$.ajax({
			url : options.url
			, type : options.type
			, dataType : options.dataType
			, contentType : options.contentType
			, cache : false
			, data : options.data
			, async: options.async
			, crossDomain : options.crossDomain
		}).done(
			function(data, textStatus, jqXHR) {
				if(options.isRemoveLoading){
					waiting.stop();
				}
				if (data.exCode != null && data.exCode !== "") {
					if (options.fail !== undefined) {
						options.fail();
					}
					ui.alert("<div>"+data.exMsg+"</div>",{
						ycb:function(){
							$(".popAlert").remove();
						}
						,  ybt:"확인"
					});
				} else {
					options.done(data);
				}
		}).fail(
			function(jqXHR, textStatus, errorThrown) {
				waiting.stop();
				if (options.fail !== undefined) {
					options.fail();
				}
				if (jqXHR.status !== 0) {
					ajax.error(jqXHR.status, jqXHR.responseText);
				}
		});

	},
	/**
	 * @function Name : ajax.load
	 * @function Desc : ajax를 이용한 View 요청
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 */
	load : function(targetId, url, params, popId, callBackFn) {
		waiting.start();

		if (params == null) {
			params = {};
		}
		$("#" + targetId).load(
				url,
				params,
				function(response, status, xhr) {
					waiting.stop();

					if (status === "error") {

						if (xhr.status === 460) {

							if (popId != null && popId !== "") {
								dialog.destroy(popId);
								$("#" + popId).remove();
							}
						}

						ajax.error(xhr.status, xhr.responseText);
					}
					if (callBackFn != null && callBackFn !== "" && callBackFn !== undefined) {
						eval(callBackFn + "()");
					}
				});
	},
	/**
	 * @function Name : ajax.error
	 * @function Desc : ajax를 이용 시 오류 발생 처리
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 */
	error : function(status, data) {
		var url = "";
		if (data != null && data !== "" && data !== "{}")
			url = data.split("returnUrl=")[1];

		if (status === 450) {
			if (url === undefined || url === "")
				location.href = "/indexLogin?loginType=&returnUrl="
						+ encodeURIComponent($(location).attr('href'));
			else
				location.href = "/indexLogin?loginType=&returnUrl="
						+ encodeURIComponent(url);
		} else if (status === 451) {
			location.href = "/indexLogin?loginType=NMOD";
		} else if (status === 452) {
			location.href = "/indexLogin?loginType=NMODS";
		} else if (status === 460) {
			pop.login({
				loginType : ""
			});
		} else if (status === 461) {
			pop.login({
				loginType : "NMOD"
			});
		} else if (status === 462) {
			pop.login({
				loginType : "NMODS"
			});
		} else {
			alert("오류가 발생하였습니다. 관리자에게 문의하시기 바랍니다.");
		}
	}
};

/**
 * @function Name : calendar
 * @function Desc : Jquery UI를 이용한 Calendar 관련 함수
 * @작성일 : 2016.03.02
 * @작성자 : 신남원
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       신남원 : 2016. 03. 02 : : 신규 개발.
 */
var calendar = {
	/**
	 * @function Name : calendar.one
	 * @function Desc : 단일 Calendar 생성 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param targetId
	 * @param options
	 *            1. showButtonPanel : 하단 버튼영역 활성화 여부(true|false) 2. yearRange :
	 *            년도 범위(c-10:c+10)
	 */
	one : function(targetId, options) {

		$('#' + targetId).datepicker({
			showButtonPanel : false // 달력의 버튼 영역 활성화(Today, 확인)
			,
			dateFormat : 'yy-mm-dd',
			yearRange : setDefaultIfNull(options.yearRange, 'c-10:c+10'),
			changeYear : true // 년도 풀다운메뉴를 넣어 년도변경을 빠르게 도와준다.
			,
			changeMonth : true
			// 달력버튼 이미지
			,
			showOn : "button",
			buttonImage : "../../_images/common/common/icon_datepicker.gif",
			buttonImageOnly : true,
			buttonText : "Select date"
		});
	},
	/**
	 * @function Name : calendar.one
	 * @function Desc : 기간 설정이 가능한 Calendar 생성 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param fromId
	 *            적용할 시작일자 Tag Id
	 * @param toId
	 *            적용할 종료일자 Tag Id
	 * @param options
	 *            1. showButtonPanel : 하단 버튼영역 활성화 여부(true|false) 2. yearRange :
	 *            년도 범위(c-10:c+10)
	 */
	range : function(fromId, toId, options) {
		$("#" + fromId).datepicker({
			showButtonPanel : false // 달력의 버튼 영역 활성화(Today, 확인)
			,
			defaultDate : "+1w",
			changeYear : true,
			changeMonth : true,
			dateFormat : 'yy-mm-dd',
			yearRange : setDefaultIfNull(options.yearRange, 'c-10:c+10'),
			showOn : "button",
			buttonImage : "../../_images/common/common/icon_datepicker.gif",
			buttonImageOnly : true,
			buttonText : "Select date",
			onClose : function(selectedDate) {
				$("#" + toId).datepicker("option", "minDate", selectedDate);
			}
		});

		$("#" + toId).datepicker({
			showButtonPanel : false // 달력의 버튼 영역 활성화(Today, 확인)
			,
			defaultDate : "+1w",
			changeYear : true,
			changeMonth : true,
			dateFormat : 'yy-mm-dd',
			yearRange : options.yearRange || 'c-10:c+10',
			showOn : "button",
			buttonImage : "../../_images/common/common/icon_datepicker.gif",
			buttonImageOnly : true,
			buttonText : "Select date",
			onClose : function(selectedDate) {
				$("#" + fromId).datepicker("option", "maxDate", selectedDate);
			}
		});

	},
	/**
	 * @function Name : calendar.autoRange
	 * @function Desc : 현재일을 기준으로 지정한 기간만큼의 일자 설정 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param fromId
	 *            적용할 시작일자 Tag Id
	 * @param toId
	 *            적용할 종료일자 Tag Id
	 * @param period
	 *            자동생성할 기간
	 */
	autoRange : function(fromId, toId, period) {
		var fromYear, fromMonth, fromDate;
		var toYear, toMonth, toDate;

		var today = new Date();
		var fromday = new Date();

		fromday.setMonth(today.getMonth() - period);
		fromday.setDate(today.getDate() + 1);

		fromYear = fromday.getFullYear();
		fromMonth = fromday.getMonth() + 1;
		fromMonth = (fromMonth < 10) ? "0" + fromMonth : fromMonth;
		fromDate = fromday.getDate();
		fromDate = (fromDate < 10) ? "0" + fromDate : fromDate;

		toYear = today.getFullYear();
		toMonth = today.getMonth() + 1;
		toMonth = (toMonth < 10) ? "0" + toMonth : toMonth;
		toDate = today.getDate();
		toDate = (toDate < 10) ? "0" + toDate : toDate;

		$("#" + fromId).val(fromYear + "-" + fromMonth + "-" + fromDate);
		$("#" + toId).val(toYear + "-" + toMonth + "-" + toDate);
	},
	/**
	 * @function Name : calendar.autoRangeDay
	 * @function Desc : 현재일을 기준으로 지정한 기간만큼의 일자 설정 함수
	 * @작성일 : 2016.03.02
	 * @작성자 : 신남원
	 * @param fromId
	 *            적용할 시작일자 Tag Id
	 * @param toId
	 *            적용할 종료일자 Tag Id
	 * @param period
	 *            자동생성할 기간
	 */
	autoRangeDay : function(fromId, toId, period) {
		var fromYear, fromMonth, fromDate;
		var toYear, toMonth, toDate;

		var today = new Date();
		var fromday = new Date();

		fromday.setDate(today.getDate() - period);

		fromYear = fromday.getFullYear();
		fromMonth = fromday.getMonth() + 1;
		fromMonth = (fromMonth < 10) ? "0" + fromMonth : fromMonth;
		fromDate = fromday.getDate();
		fromDate = (fromDate < 10) ? "0" + fromDate : fromDate;

		toYear = today.getFullYear();
		toMonth = today.getMonth() + 1;
		toMonth = (toMonth < 10) ? "0" + toMonth : toMonth;
		toDate = today.getDate();
		toDate = (toDate < 10) ? "0" + toDate : toDate;

		$("#" + fromId).val(fromYear + "-" + fromMonth + "-" + fromDate);
		$("#" + toId).val(toYear + "-" + toMonth + "-" + toDate);
	},
	
	autoRangeOrder : function(fromId, toId, period) {
		var fromYear, fromMonth, fromDate;
		var toYear, toMonth, toDate;

		var today = new Date();
		var fromday = new Date();

		fromday.setMonth(today.getMonth() - period);
		fromday.setDate(today.getDate() + 1);

		fromYear = fromday.getFullYear();
		fromMonth = fromday.getMonth() + 1;
		fromMonth = (fromMonth < 10) ? "0" + fromMonth : fromMonth;
		fromDate = fromday.getDate();
		fromDate = (fromDate < 10) ? "0" + fromDate : fromDate;

		toYear = today.getFullYear();
		toMonth = today.getMonth() + 1;
		toMonth = (toMonth < 10) ? "0" + toMonth : toMonth;
		toDate = today.getDate();
		toDate = (toDate < 10) ? "0" + toDate : toDate;

		$("#" + fromId).val(fromYear + "." + fromMonth + "." + fromDate);
		$("#" + toId).val(toYear + "." + toMonth + "." + toDate);
	},
};

var form = {
	clear : function(formId) {
		var currentForm = $("#" + formId);

		var inputElement = currentForm.find("input").not(".no_clear");
		var selectElement = currentForm.find("select").not(".no_clear");
		var textareaElement = currentForm.find("textarea").not(".no_clear");
		var spanElement = currentForm.find("td > span").not(".no_clear");

		for (var l = 0; l < inputElement.length; l++) {
			if (inputElement[l].type === "checkbox"
					|| inputElement[l].type === "radio") {
				$(inputElement[l]).attr("checked", false);
			} else {
				$(inputElement[l]).val("");
			}
		}

		for (var i = 0; i < selectElement.length; i++) {
			$(selectElement[i]).val("");
		}

		for (var j = 0; j < textareaElement.length; j++) {
			$(textareaElement[j]).val("");
		}

		for (var k = 0; k < spanElement.length; k++) {
			$(spanElement[k]).html("");
		}
	}
};

var format = {
	tel : function(tel) {
		if (tel != null && tel !== "" && tel !== 'null') {
			if (tel.length === 8) {
				return tel.replace(/([0-9]{4})([0-9]{4})/, "$1-$2");
			} else {
				return tel.replace(
						/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
						"$1-$2-$3");
			}
		}
		return tel;
	},
	fax : function(fax) {
		if (fax != null && fax !== "" && fax !== 'null') {
			if (fax.length === 8) {
				return fax.replace(/([0-9]{4})([0-9]{4})/, "$1-$2");
			} else {
				return fax.replace(
						/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
						"$1-$2-$3");
			}
		}
		return fax;
	},
	mobile : function(no) {
		if (no != null && no !== "" && no !== 'null') {
			return no.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,
					"$1-$2-$3");
		}
		return no;
	},
	post : function(no) {
		if (no != null && no !== "" && no !== 'null') {
			return no.replace(/([0-9]{3})([0-9]{3})/, "$1-$2");
		}
		return no;
	},
	bizNo : function(no) {

		if (no != null && no !== "" && no !== 'null') {
			return no.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, "$1-$2-$3");
		}
		return no;
	},
	cprNo : function(no) {

		if (no != null && no !== "" && no !== 'null') {
			return no.replace(/([0-9]{6})([0-9]{7})/, "$1-$2");
		}
		return no;
	},
	num : function(n) {
		var reg = /(^[+-]?\d+)(\d{3})/; // 정규식
		n += ''; // 숫자를 문자열로 변환

		while (reg.test(n))
			n = n.replace(reg, '$1' + ',' + '$2');

		return n;
	},
	DateType : function(date, spar){		
		date = new Date(date);
		var year = date.getFullYear();              
	    var month = (1 + date.getMonth());          
	    month = month >= 10 ? month : '0' + month;  
	    var day = date.getDate();                   
	    day = day >= 10 ? day : '0' + day;          
	    return  year + spar + month + spar + day;       
	},
	DateType2 : function(date, flag, spar, spar2, spar3){
		date = new Date(date);
		var year = date.getFullYear();              
	    var month = (1 + date.getMonth());          
	    month = month >= 10 ? month : '0' + month;  
	    var day = date.getDate();                   
	    day = day >= 10 ? day : '0' + day;
	    if(flag != ""){
	    	var rtnVal = year + spar + month + spar2 + day + spar3
	    }else{
	    	var rtnVal =  month + spar2 + " " + day + spar3
	    }
	    return rtnVal;       
	},
	DateType3 : function(date, spar){		
		date = new Date(date);
		var year = date.getFullYear();              
	    var month = (1 + date.getMonth());          
	    month = month >= 10 ? month : '0' + month;  
	    var day = date.getDate();                   
	    day = day >= 10 ? day : '0' + day;
	    var hour = date.getHours();
	    var minutes = date.getMinutes();
	    return  year + spar + month + spar + day + " "+ hour + ":" + minutes;       
	},
};

$.fn.serializeJson = function() {
	var o = {};
	// var a = this.serializeArray();
	$(this)
			.find(
					'input[type="hidden"], input[type="text"], input[type="password"], input[type="checkbox"]:checked, input[type="radio"]:checked, select, textarea')
			.each(
					function() {
						if ($(this).attr('type') === 'hidden') { // if
							// checkbox
							// is checked do
							// not take the
							// hidden field
							var $parent = $(this).parent();
							var $chb = $parent
									.find('input[type="checkbox"][name="'
											+ this.name.replace(/\[/g, '\[')
													.replace(/\]/g, '\]')
											+ '"]');
							if ($chb != null) {
								if ($chb.prop('checked'))
									return;
							}
						}
						if (this.name === null || this.name === '')
							return;
						var elemValue = null;
						if ($(this).is('select'))
							elemValue = $(this).find('option:selected').val();
						else
							elemValue = this.value;

						// if (o[this.name] !== undefined) {
						// if (!o[this.name].push) {
						// o[this.name] = [o[this.name]];
						// }
						// o[this.name].push(elemValue || '');
						// } else {
						// o[this.name] = elemValue || '';
						// }
						// 배열 문제로 인하여 수정
						if (o[this.name]) {
							o[this.name] = o[this.name] + ',' + elemValue;
						} else {
							o[this.name] = elemValue;
						}

					});
	return o;
}

var tag = {
	/*
	 * 상품 이미지
	 */
	goodsImage : function(imgDomain, goodsId, imgPath, seq, size, alt, cls) {
		if (cls == null) {
			cls = "";
		}

		if (alt == null) {
			alt = "";
		}

		if (imgPath == null) {
			return "";
		}

		var ext = imgPath.substr(imgPath.lastIndexOf("."), imgPath.length);

		var imgSize = tag.getImgSize(size);
		var src = imgDomain + "/goods/" + goodsId + "/" + goodsId + "_" + seq
				+ "_" + imgSize[0] + "x" + imgSize[1] + ext;
		var onError = "/_images/mall/common/default_image.jpg";

		return '<img src="' + src + '" alt="' + alt + '" class="' + cls
				+ '" onerror="this.src=\'' + onError + '\'" />';
	},

	getImgSize : function(size) {
		if (size === 10)
			return [ "600", "600" ];
		else if (size === 20)
			return [ "440", "440" ];
		else if (size === 30)
			return [ "374", "374" ];
		else if (size === 40)
			return [ "315", "315" ];
		else if (size === 50)
			return [ "280", "280" ];
		else if (size === 60)
			return [ "224", "224" ];
		else if (size === 70)
			return [ "167", "167" ];
		else if (size === 80)
			return [ "77", "77" ];
		else
			return [ "0", "0" ];
	},

	/*
	 * 리스트 페이징
	 */
	listPage : function(recordPerPage, currentPage, totalRecord, indexPerPage) {
		var page = '';

		var block = parseInt(Math.ceil(currentPage / indexPerPage));
		var startPage = (block - 1) * indexPerPage + 1;
		var endPage = startPage + indexPerPage - 1;
		var totalPage = parseInt(Math.ceil(totalRecord / recordPerPage));

		if (endPage > totalPage)
			endPage = totalPage;
		var prevPage = currentPage - 1;

		if (currentPage === 1)
			prevPage = 1;
		var nextPage = currentPage + 1;

		if (nextPage > totalPage)
			nextPage = currentPage;

		if (currentPage > indexPerPage) {
			page += '<a href="javascript:goPage(1);" class="btn_paging first"><span>1</span></a>';
			page += '<a href="javascript:goPage(' + prevPage
					+ ');" class="btn_paging prev"><span>' + prevPage
					+ '</span></a>';
		}

		for (var i = startPage; i <= endPage; i++) {
			if (i === currentPage)
				page += '<strong class="current">' + i + '</strong>';
			else
				page += '<a href="javascript:goPage(' + i + ');"><span>' + i
						+ '</span></a>';
		}

		if (totalPage > endPage) {
			page += '<a href="javascript:goPage(' + nextPage
					+ ');" class="btn_paging next"><span>' + nextPage
					+ '</span></a>';
			page += '<a href="javascript:goPage(' + totalPage
					+ ');" class="btn_paging end"><span>' + totalPage
					+ '</span></a>';
		}

		return page;
	}
};

/**
 * 숫자만 입력받도록 한다.
 *
 * @param event
 * @returns {Boolean}
 */
function inputNumKey(event) {
	event = setDefaultIfNull(event, window.event);

	// shift 키를 누른 상태이면 false
	if (event.shiftKey)
		return false;

	var keyID = (event.which) ? event.which : event.keyCode;

	// 숫자키이거나, backspace(8) 또는 delete(46) 키 or tab(9)
	if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
			|| keyID === 8 || keyID === 9 || keyID === 46)
		return true;
	else
		return false;
}


function setDefaultIfNull(target, def){
	return target || def;
}

function logger(gb){
	if (gb === "oper"){
		window['console']['log'] = function() {};
		window['console']['debug'] = function() {};
	}
}


function specialCharlength(obj){
	var value = $(obj).val();    
	var oneChar = "";
	var totalByte = 0;
	var len = 0;
	var twoChar= "";
	
	for(var i=0;i<value.length;i++){
		oneChar = value.charAt(i);		
		if(escape(oneChar).length > 4){
			totalByte += 2;
		}else{
			totalByte ++;
		}
		
		if(totalByte <= 500){
			len = i +1;
		}	
	}	
	
	if(totalByte > 500){
		ui.toast('500자까지 입력 가능합니다.');
		twoChar = value.substr(0, len);
		$(obj).val(twoChar);
		$(obj).focus();
	}
}

//정규식 특수문자 제거하기(space키 가능)
function specialCharRemove(obj){
    var value = $(obj).val();
    //var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
    var pattern= /[~!#$^&*=+|:;?"<,.>'%@]/;
    if(pattern.test(value)){
  	  for(var i=0;i<value.length;i++){
  		  value=value.replace(pattern,"");
  	  }

  	  //특수문자는 입력하실 수 없습니다.
  	  alert('특수문자는 입력하실 수 없습니다.');
  	  $(obj).val(value.replace(pattern,""));
  	  $(obj).focus();
    }
}

	//정규식 특수문자 제거하기(sapce 불가) - 예금주
function specialCharRemoveSpace(obj) {
    var value = $(obj).val();

    var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9\u318D\u119E\u11A2\u2022\u2025a\u00B7\uFE55)]/gi;
    if(pattern.test(value)){
    	alert('특수문자는 입력하실 수 없습니다.');
    	$(obj).val(value.replace(pattern,""));
    	$(obj).focus();
    }
    //return $(obj).val();
}

//정규식 숫자만 입력하기(sapce 불가) - 계좌번호체크
function NumberOnly(obj) {
    var value = $(obj).val();
    var pattern = /[^(0-9)]/gi;
    if(pattern.test(value)){
    	alert('계좌번호는 숫자만 입력하실 수 있습니다.');
    	$(obj).val(value.replace(pattern,""));
    	$(obj).focus();
    }
    //return $(obj).val();
}

/*
 * 숫자 콤마 찍어주기
 */
function fnComma(param){
    if(param != null && param !=""){
         var numStr= param.toString().trim();
         var reg = /(^[+-]?\d+)(\d{3})/;
	 while(reg.test(numStr)){
             numStr = numStr.replace(reg,('$1,$2'))
         }
	 return numStr;
    }
    return 0;
}

/*
 * 휴대폰번호 형식 변경
 */
function fnMobilel(param){
	if(param != null){
         var numStr= param.toString().trim();
         numStr = numStr.replace("-","");
         var reg = /(\d{3})(\d{3,4})(\d{4})/;

         if(numStr.match(reg)){
             numStr = numStr.replace(reg, "$1-$2-$3");
         }
		 return numStr;
    }
	return param;
}

/*
 * 전화번호 형식 변경
 */
function fnTel(param){
	if(param != null){
         var numStr= param.toString().trim();
         numStr = numStr.replace("-","");
         var reg = /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/;

         if(numStr.match(reg)){
             numStr = numStr.replace(reg, "$1-$2-$3");
         }
		 return numStr;
	}
	return param;
}

function copyUrl(id) {
	var clipboard = new ClipboardJS('#' + id);
	clipboard.on('success');
	clipboard.on('error', function(e) {
		let alertData = {
				 title: ""
				,content : "다시 시도하여 주십시오." 
				,callback : "" 
				,btnText : "확인"
			};
			/* commonAlert(alertData);
			openLayer('commonAlert'); */
			alert('다시 시도하여 주십시오.')
	});
}

/*
 * IE 확인
 */
var agent = navigator.userAgent.toLowerCase();
var isIe = false;
if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	isIe = true;
}

/**
 *	네이버지도 생성(좌표)
 *	id : 지도를 삽입할 HTML 요소의 id
 *  lat : 검색할 위도
 * 	lng : 검색할 경도
 * 	zoom : 줌 설정 : 0~22, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 16
 *	zoomControl : 줌 컨트롤 표시(기본값 표시안함)
 *	mapTypeControl : 일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함)
 */
function coordMap(options){
	new naver.maps.Marker({
		position : new naver.maps.LatLng(options.lat, options.lng),
		map : new naver.maps.Map(options.id, {
 			center : new naver.maps.LatLng(options.lat, options.lng)
 			, zoom : options.zoom == null ? 16 : options.zoom
 			, zoomControl : options.zoomControl == null ? undefined : options.zoomControl
 			, mapTypeControl : options.mapTypeControl == null ? undefined : options.mapTypeControl
 		})
	});
}
 
/**
 *	네이버지도 생성(주소)
 *	id : 지도를 삽입할 HTML 요소의 id
 *  addr : 검색할 주소 
 * 	zoom : 0~22, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 16
 *	zoomControl : 줌 컨트롤 표시(기본값 표시안함)
 *	mapTypeControl : 일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함)
 */
function addrMap(options){
	naver.maps.Service.geocode({
		address: options.addr // String 타입의 주소값
	}, function(status, response) {
		if (status !== naver.maps.Service.Status.OK) {
			// 실행이 되지 않을 경우 
			return alert("주소를 확인후 다시 시도 바랍니다.");
		}
		
		var result = response.result, // 검색 결과의 컨테이너
        	items = result.items; // 검색 결과의 배열
        
        let lat = items[0].point.y; //위도
        let lng = items[0].point.x; //경도
		
		new naver.maps.Marker({
			position : new naver.maps.LatLng(lat, lng),
			map : new naver.maps.Map(options.id, {
	 			center : new naver.maps.LatLng(lat, lng)
	 			, zoom : options.zoom == null ? 16 : options.zoom
	 			, zoomControl : options.zoomControl == null ? undefined : options.zoomControl
 				, mapTypeControl : options.mapTypeControl == null ? undefined : options.mapTypeControl
	 		})
		});
	});
}

//검색 정제 (번지 빼기, 띄어쓰기)
function regExpCheckJuso(strKeyword)
{
	var tempKeyword = strKeyword;
	var charKeyword;  
	var tempLength;
	
	//주소일 경우 글자뒤에 번지 x, 주소와 숫자 사이에 한칸 띄우기
	var reqExp1 =/([0-9]|번지)$/;
	var reqExp2 =/번지$/;
	var checkChar =/^([0-9]|-|\.|\·)$/;
	var checkEng =/^[A-Za-z]+$/;

	if(reqExp1.test(strKeyword))
	{
		// 글자 뒤의 번지 삭제
		tempKeyword = strKeyword.split(reqExp2).join("");

		// 주소와 숫자 사이 한칸 띄우기
		tempLength = tempKeyword.length;

		for(var i=tempLength-1;i>=0;i--)
		{
			charKeyword = tempKeyword.charAt(i);
			
			if(!checkChar.test(charKeyword))
			{
				if(charKeyword != " " && !checkEng.test(charKeyword))
				{
					tempKeyword = insertString(tempKeyword,i+1,' ');			
				}
				break;
			}
		}
	}
	
	var regExp3 = /[0-9]*[ ]*(대로|로|길)[ ]+[0-9]+[ ]*([가-힝]|[ ])*[ ]*(로|길)/;
	var regExp4 = /[ ]/;

	var k = tempKeyword.match(regExp3) ;
	
	if (k != null) {
		var tmp = k[0].split(regExp4).join("");
		
		tempKeyword=tempKeyword.replace(regExp3, tmp);
	}
	
	return tempKeyword;
}

function insertString(key,index,string)
{
	if(index >0)
		return key.substring(0,index) + string + key.substring(index,key.length);
	else
		return string+key;
}

function validateJuso(value){
	value = value.replace(/(^\s*)|(\s*$)/g, ""); //앞뒤 공백 제거
  	return value.split(/[%]/).join("");  //특수문자제거
}

//특수문자, 특정문자열(sql예약어) 제거
function fncCheckSearchedWord(obj){
	//특수문자 제거
	if(obj.length >0){
		var expText = /[%=><]/ ;
		if(expText.test(obj.value) == true){
			obj = obj.split(expText).join(""); 
		}
		//체크 문자열
		var sqlArray = new Array( //sql 예약어
			"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION",  "FETCH", "DECLARE", "TRUNCATE"
		);
		
		var regex;
		var regex_plus ;
		for(var i=0; i<sqlArray.length; i++){
			regex = new RegExp("\\s" + sqlArray[i] + "\\s","gi") ;
			if (regex.test(obj.value)) {
				obj =obj.replace(regex, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
			regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
			if (regex_plus.test(obj.value)) {
				obj =obj.replace(regex_plus, "");
				alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
			}
		}
	}
	
	return obj = obj;
}

function moisPostList(targetId, callBack){
	$("#"+targetId).val(fncCheckSearchedWord($("#"+targetId).val())); // 특수문자 및 sql예약어 제거
	$("#"+targetId).val(validateJuso($("#"+targetId).val())); //공백 및 특수문자 제거
	$("#"+targetId).val(regExpCheckJuso($("#"+targetId).val()));
	
	var options = {
		url : "https://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"
		, type : "post"
		, dataType : "jsonp"
		, data : {
			confmKey : viewJsonData.fo_mois_post_confmKey, <!-- 신청시 발급받은 승인키 -->
			resultType : 4, //<!-- 도로명주소 검색결과 화면 출력유형 1 : 도로명, 2 : 도로명+지번+상세보기(관련지번, 관할주민센터), 3 : 도로명+상세보기(상세건물명), 4 : 도로명+지번+상세보기(관련지번, 관할주민센터, 상세건물명) -->
			currentPage : 1, //<!-- 현재 페이지 번호 -->
			countPerPage : 100, //<!-- 페이지당 출력할 결과 Row 수 -->
			resultType : "json", //<!-- 검색결과형식 설정(xml, json) -->
			keyword : $("#"+targetId).val() //<!-- 검색어 -->
		}
		, async:false
		, crossDomain:true
		, done : function(jsonStr) {
			var errCode = jsonStr.results.common.errorCode;
			var errDesc = jsonStr.results.common.errorMessage;
			
			if(errCode != "0"){
				alert(errDesc);
			}else{
				if(jsonStr != null){
					$(jsonStr.results.juso).each(function(){
						/*기존 사용하던 명칭으로 변경*/
						if(this.zipNo){
							this.zonecode = this.zipNo;
							delete this.zipNo;
						}
						if(this.roadAddr){
							this.roadAddress = this.roadAddr;
							delete this.roadAddr;
						}
						if(this.engAddr){
							this.roadAddressEnglish = this.engAddr;
							delete this.engAddr;
						}
						if(this.jibunAddr){
							this.jibunAddress = this.jibunAddr;
							delete this.jibunAddr;
						}
					});
					
					callBack(jsonStr.results);
				}
			}
		}
	}
	
	ajax.call(options)
}
var sgrKey;
function vodUpload(obj, callBack){
	var fileVariable =$(obj).val();
	var ext = $(obj).val().split('.').pop().toLowerCase();
	if (fileVariable != "" && fileVariable != null) {
		if (extChk(obj, 'video')) {
			var fd = new FormData();
			var targetName = $(obj).attr('name');
			sgrKey = sgrGenerate();
			fd.append(targetName, obj.files[0]);
			fd.append('iv_key', sgrKey);
			fd.append('upload_field_name', targetName);
			fd.append('channel_id', viewJsonData.vod_api_chnl_id_log);
			fd.append('playlist_id', viewJsonData.vod_group_default);
			
			waiting.start();
			$.ajax({
				type: 'POST',
				url: viewJsonData.vod_upload_api_url,
				data: fd,
				processData: false,
				contentType: false,
				dataType: 'json',
				success: function(data, status) {
					if(data.code==200) {
						callBack(data.result, obj);
					} else {
						waiting.stop();
						alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]");
					}
				},
				error: function(request,status,error) {
					waiting.stop();
					messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
				}
			});
		}
	}
}

//VOD 채널 리스트
function vodChnlList(authKey, callBack) {
	var options = {
		url : viewJsonData.vod_chnl_list_api_url
		, type : "post"
		, dataType : "json"
		, data : {
			iv_key : authKey
		}
		, done : function(data, status) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				alert(data.message);
			}
		}
	}

	ajax.call(options)
}

//VOD 그룹 리스트
function vodGroupList(option, callBack) {
	var options = {
		url : viewJsonData.vod_group_list_api_url + option.channel_id
		, type : "post"
		, dataType : "json"
		, data : {
			iv_key : option.authKey
		}
		, done : function(data, status) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				alert(data.message);
			}
		}
	}

	ajax.call(options)
}

//VOD 리스트
function vodList(option, callBack) {
	var options = {
		url: viewJsonData.vod_list_api_url + option.channel_id
		, type : "post"
		, dataType : "json"
		, data : {
			iv_key : option.authKey
			, playlist_id : option.playlist_id
			, row_count : option.row_count
			, order_col : option.order_col
			, order_type : option.order_type
		}
		, done : function(data, status) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				alert(data.message);
			}
		}
	}

	ajax.call(options)
}

//VOD Info
function vodInfo(option, callBack) {
	$.ajax({
		type: 'post',
		url: viewJsonData.vod_info_api_url + option.video_id,
		async: false,
		dataType: 'json',
		data : {
			iv_key : option.authKey
		},
		success: function(data) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				alert(data.message);
			}
		},
		error: function(request,status,error) {
			alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
}

//VOD move
function vodMove(option, callBack) {
	var options = {
		url: viewJsonData.vod_group_move_api_url
		, type : "post"
		, dataType : "json"
		, data : {
			iv_key : option.authKey
			, channel_id : option.channel_id
			, playlist_id : option.playlist_id
			, video_id : option.video_id
		}
		, done : function(data, status) {
			callBack(data.result);
		}
	}

	ajax.call(options)
}

function extChk(obj, type) {
	let fileVariable =$(obj).val();
	let ext = $(obj).val().split('.').pop().toLowerCase();
	let extArr = [];
	extArr = ['mp4', 'mov', 'avi'];
	
	
	if (type == 'image') {
		extArr = ['gif', 'png','jpg', 'jpeg'];
	}
	if($.inArray(ext, extArr) == -1) {
		alert('[ ' + extArr.join(' / ') + ' ] 파일만 업로드 가능합니다.');
		$('#' + objectId).val(''); 
		return false;
	} else {
		return true;
	}
};

//VOD Group Add
function vodGroupAdd(option, callBack) {
	$.ajax({
		type: 'POST',
		url: viewJsonData.vod_group_add_api_url,
		async: false,
		dataType: 'json',
		data : {
			iv_key : option.authKey
			, channel_id : option.channel_id
			, playlist_name : option.playlist_name
		},
		success: function(data) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]");
			}
		},
		error: function(request,status,error) {
			alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
}

function sgrGenerate() {
	let result;
	$.ajax({
		type: 'POST',
		url: "/common/getSgrAk",
		async: false,
		success: function(data) {
			result = data;
		},
		error: function(request,status,error) {
			alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
	return result;
}

String.prototype.formatComma=function(){var v=(this+'');var reg=/(^[+-]?\d+)(\d{3})/;var n= v.split(",").join("").replace(/^\s*|\s*$/g, '');while(reg.test(n)){n=n.replace(reg, '$1'+','+'$2');}return n;};
Number.prototype.formatComma=function(){if(this==0) return '0';var reg=/(^[+-]?\d+)(\d{3})/;var n=(this+'');while (reg.test(n)){n=n.replace(reg, '$1'+','+'$2');}return n;};
Date.prototype.addDay = function(day) { var date = new Date(this.valueOf()); date.setDate(date.getDate() + day); date.setHours(0); date.setMinutes(0); date.setSeconds(0);  return date; }
Date.prototype.addHour = function(hour) { var date = new Date(this.valueOf()); date.setHours(date.getHours() + hour);  return date; }
Date.prototype.addMonth = function(month) {   var date = new Date(this.valueOf()); date.setMonth(date.getMonth() + month); return date; }
Date.prototype.dateFormat=function(f){
	var d = this;
	var date = d.getFullYear()+'-'+(d.getMonth()+1).zeroformat(2)+'-'+(d.getDate()).zeroformat(2)+' '+(d.getHours()).zeroformat(2)+':'+(d.getMinutes()).zeroformat(2)+':'+(d.getSeconds()).zeroformat(2);
	return date.dateFormat(f);
};
String.prototype.zeroformat=function(len){  var s = (this+'');  while (s.length < len) {s = "0" + s;} return s;};
Number.prototype.zeroformat=function(len){return this.toString().zeroformat(len);};	
String.prototype.dateFormat=function(f,a){if (!this.valueOf()) return "";var t=(this+'').replaceAll('-','').replaceAll('.','').replaceAll(':','').replaceAll(' ','');if(t.substring(0,4)=='9999'){ return '무제한'; }var d=new Date();switch (t.length){case 6:d=new Date(d.getFullYear(), d.getMonth()+1, d.getDate(),  eval(t.substring(0,2)), eval(t.substring(2,4)), eval(t.substring(4,6)),0);break;case 8:d=new Date(eval(t.substring(0,4)), eval(t.substring(4,6))-1, eval(t.substring(6,8)), 0, 0, 0, 0);break;case 10:d=new Date(eval(t.substring(0,4)), eval(t.substring(4,6))-1, eval(t.substring(6,8)), eval(t.substring(8,10)), 0, 0, 0);break; case 12:d=new Date(eval(t.substring(0,4)), eval(t.substring(4,6))-1, eval(t.substring(6,8)), eval(t.substring(8,10)), eval(t.substring(10,12)), 0, 0);break;case 14:d=new Date(eval(t.substring(0,4)), eval(t.substring(4,6))-1, eval(t.substring(6,8)), eval(t.substring(8,10)), eval(t.substring(10,12)), eval(t.substring(12,14)), 0);break;default:break;}if(a){d.setTime(d.getTime()+1000*3600*24 * a);}var weekName1 = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];var weekName2 = ["일", "월", "화", "수", "목", "금", "토"]; var h; var result= f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi,function($1){switch ($1){case "yyyy": return d.getFullYear();case "yy": return (d.getFullYear() % 1000).zeroformat(2);case "MM": return (d.getMonth()+1).zeroformat(2);case "dd": return d.getDate().zeroformat(2);case "E": return weekName1[d.getDay()];case "e": return weekName2[d.getDay()];case "HH": return d.getHours().zeroformat(2);case "hh": return ((h=d.getHours() % 12) ? h : 12).zeroformat(2);case "mm": return d.getMinutes().zeroformat(2);case "ss": return d.getSeconds().zeroformat(2);case "a/p": return d.getHours() < 12 ? "오전" : "오후";default: return $1;}});return result;};
Number.prototype.dateFormat=function(f,a){
	if (!this.valueOf()) 
		return "";
	var d=new Date(this);
	if(a){d.setTime(d.getTime()+1000*3600*24 * a);}
	var weekName1 = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	var weekName2 = ["일", "월", "화", "수", "목", "금", "토"];
	var result = f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
		case "yyyy":
			return d.getFullYear();
		case "yy":
			return (d.getFullYear() % 1000).zeroformat(2);
		case "MM":
			return (d.getMonth() + 1).zeroformat(2);
		case "dd":
			return d.getDate().zeroformat(2);
		case "E":
			return weekName1[d.getDay()];
		case "e":
			return weekName2[d.getDay()];
		case "HH":
			return d.getHours().zeroformat(2);
		case "hh":
			return ((d.getHours() % 12) ? d.getHours() : 12).zeroformat(2);			
		case "mm":
			return d.getMinutes().zeroformat(2);
		case "ss":
			return d.getSeconds().zeroformat(2);
		case "a/p":
			return d.getHours() < 12 ? "오전" : "오후";
		}
		return $1;
	});
	return result;
};

//본인 인증
function okCertPopup( rqstCausCd ,mbrNo ) {  // [ rqstCausCd ] 00:회원가입, 01:성인인증, 02:회원정보 수정, 03:비밀번호 찾기, 04:상품구매, 99:기타(default)
	$("#okCertDiv").remove();
	// opner 함수 호출을 위한 지정
	window.name='mainwin';
	// 본인 인증 팝업 호출
	let setRqstCausCd = (rqstCausCd != null ) ? rqstCausCd : "99";
//	$.get("/common/okCertPop?rqstCausCd="+setRqstCausCd, function (html) { 
//		$("body").append(html);
//	}).done(function () {
//		jsSubmit();
//	});
	var userAgent = navigator.userAgent.toLowerCase();
	if (userAgent.indexOf('apet') == -1 ) {
		window.open('/common/okCertPop?popup=phone_popup2&rqstCausCd='+setRqstCausCd+'&mbrNo='+mbrNo , 'okCertPopup', 'width=430,height=640,scrollbar=yes');
	}else{
		// 데이터 세팅
		toNativeData.func = "onOrderPage";
		toNativeData.url = window.location.origin+'/common/okCertPop?popup=phone_popup2&rqstCausCd='+setRqstCausCd+'&mbrNo='+mbrNo;
		toNativeData.title = '본인인증';
		// 호출
		toNative(toNativeData);
	}
}

//펫TV 시청이력 저장
function petTvViewHist(vd_id, mbr_no, sec, step_no, cpltYn){
var cplt_yn = "";
if(cpltYn == "Y" || cpltYn == "N") cplt_yn = cpltYn;
	$.ajax({
		type: 'POST',
		url: '/tv/series/saveVdoViewHist',
		async: false,
		dataType: 'json',
		data : {
			vdId : vd_id //영상ID
			, mbrNo : mbr_no //회원번호
			, vdLnth : sec //시청길이
			, stepNo : step_no //단계번호
			, cpltYn : cplt_yn //펫스쿨 완료여부
		},
		success: function(data) {
			if(data.actGubun == "error"){
				
			} else {
				resetLoginTimeOut();
			}
		},
		error: function(request,status,error) {
			ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
}

//펫TV 좋아요, 찜 저장/해제
function petTvLikeDibs(obj, vd_id, mbr_no, gb, tvDetailAppYn){
	$.ajax({
		type: 'POST',
		url: '/tv/series/saveVdoLikeDibs',
		async: false,
		dataType: 'json',
		data : {
			vdId : vd_id
			, mbrNo : mbr_no
			, intrGbCd : gb
		},
		success: function(data) {
			var action = "";
			
			if(gb == "20"){
				var str = "";
				
				if(data.actGubun =='add'){
					if(tvDetailAppYn == "Y"){
						//펫TV 영상상세 > App일때만 Y가 넘어온다. 다른화면에서는 사용안됨.
						str = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="#" onclick="fncAppCloseMoveZzim(); return false;" class="lk" data-content="" data-url="/mypage/tv/myWishList">바로가기</a></div>';
					}else{
						str = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="/mypage/tv/myWishList" class="lk" data-content="" data-url="/mypage/tv/myWishList">바로가기</a></div>';
					}
					
					action = "interest"; //클릭 이벤트-찜
				}else if(data.actGubun =='remove'){
					str = "찜리스트에서 삭제되었어요";
					action = "interest_d"; //클릭 이벤트-찜 취소
				}else{
					str = "찜리스트 추가 또는 취소에 실패하였습니다.";
				}
				
				ui.toast(str, {
					bot:70
				});
			}else{
				$(obj).html(fnComma(data.likeCnt));
				
				if(data.actGubun =='add'){
					action = "like"; //클릭 이벤트-좋아요
				}else if(data.actGubun =='remove'){
					action = "like_d"; //클릭 이벤트-좋아요 취소
				}
			}
			
			//$(obj).toggleClass("on");
			
			if(data.actGubun =='add'){
				$(obj).addClass("on");
			}else if(data.actGubun =='remove'){
				$(obj).removeClass("on");
			}
			
			userActionLog(vd_id, action); //클릭 이벤트
		},
		error: function(request,status,error) {
			ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
}

//펫TV 공유하기 이력 저장
function petTvShare(objId, vd_id, chnlCd){
	if(objId != "null"){
		copyUrl(objId);
		
		ui.toast($("#"+objId).attr("data-message"), {
			bot:70
		});
	}
	
	userActionLog(vd_id, "share"); //클릭 이벤트-공유
	
	$.ajax({
		type: 'POST',
		url: '/tv/series/insertVdoShare',
		async: false,
		dataType: 'json',
		data : {
			vdId : vd_id //영상ID
			, shrChnlCd : chnlCd //공유채널코드 (30:URL)
		},
		success: function(data) {
			if(data.actGubun == "error"){
				
			}
		},
		error: function(request,status,error) {
			ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
		}
	});
}

var commonFunc = {
	insertCart : function(goodsIdStr, buyQtyStr, nowBuyYn, reloadYn, goodsCpInfos, cartYn){
		/*
		 * goodsIdStr - 'goodsId:itemNo:pakGoodsId:mkiGoodsYn:mkiGoodsOptContent'
		 * 		goodsId : 상품번호(옵션, 묶음상품일 경우 옵션/묶음 구성상품 아이디)
		 * 		itemNo : 아이템 번호
		 *		pakGoodsId : 묶음 or 옵션상품 아이디 (단품, 세트일 경우 빈값)
		 *		mkiGoodsYn : 주문 제작 상품 여부
		 *		mkiGoodsOptContent' : 주문 제작 내용
		 *
		 * buyQtyStr - 수량
		 * 		묶음상품일 경우 array
		 *
		 * nowBuyYn 
		 * 		Y - 바로구매
		 * 		N - 장바구니
		 * 
		 * reloadYn - 새로고침 여부
		 * 
		 * cartYn -  장바구니 -> 주문서 여부
		 * 
		 * 예)
		 * 단품, 세트 - commonFunc.insertCart(‘GI000054458:302610:’, 1, ‘N’); or commonFunc.insertCart(‘GI000054458:302610:::’, ‘N’);
		 * 옵션 - commonFunc.insertCart(‘GI000054458:302610:GS000012345’, 1, ‘N’); or commonFunc.insertCart(‘GI000054458:302610:GS000012345::’, ‘N’);
	     * 묶음상품 - commonFunc.insertCart([‘GI000054458:302610:GP000012345’,'GI000054458:302610:GP000012345’], [1,2], ‘N’);
	     * 
		 * */
		
		var goodsIdArr = new Array();
		var buyQtyArr = new Array();
		
		if(!Array.isArray(goodsIdStr)){
			goodsIdArr.push(goodsIdStr);
		}else{
			goodsIdArr = goodsIdStr;
		}
		
		if(!Array.isArray(buyQtyStr)){
			buyQtyArr.push(buyQtyStr);
		}else{
			buyQtyArr = buyQtyStr;
		}
		
		var freebieMsg = commonFunc.validFreebie(goodsIdArr, buyQtyArr, nowBuyYn);
	
		if(freebieMsg){
			ui.confirm(freebieMsg, {
				ycb : function(){
					commonFunc.excuteInsertCart(goodsIdArr, buyQtyArr, nowBuyYn, reloadYn, goodsCpInfos, cartYn);
				},
			    ybt:"예",
			    nbt:"아니오"
			});
		}else{
			commonFunc.excuteInsertCart(goodsIdArr, buyQtyArr, nowBuyYn, reloadYn, goodsCpInfos, cartYn);
		}
	}
	, excuteInsertCart : function(goodsIdStr, buyQtyStr, nowBuyYn, reloadYn, goodsCpInfos, cartYn){
		var options = {
			url : "/order/insertCart"
			, data : {
				goodsIdsStr : goodsIdStr
				, buyQtys : buyQtyStr
				, nowBuyYn : nowBuyYn // 바로구매 - Y, 장바구니 - N
				, goodsCpInfos : goodsCpInfos
				, cartYn : cartYn
			}
			, done : function(data){
				//data.rtnCode - "S" 인 경우 성공
				if(data.rtnCode == 'S'){
					if(nowBuyYn == "Y"){
						if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1 
								|| document.location.href.indexOf("/tv/school/indexTvDetail") > -1
								|| document.location.href.indexOf("/log/indexPetLogList") > -1){
							fncGoodsAppCloseMove("/order/indexOrderPayment");
						}else{
							location.href= "/order/indexOrderPayment";
						}
					}else{
						//장바구니 카운트 증가
						var $cartCntObj = $('.header .menu .cart').find('em');
						if($cartCntObj.length == 0){
							if(data.cartCnt != 0){
								var html = '<em class="n">'+data.cartCnt+'</em>';
								$('.header .menu .cart').html(html);
							}
						}else{
							if(data.cartCnt == 0){
								$cartCntObj.remove();
							}else{
								$cartCntObj.text(data.cartCnt);
							}
							
						}
						
						if(goodsIdStr.length > 0){
							//액션 로그 수집
							$.ajax({
								url : "/common/sendSearchEngineEvent"
								, data : {
									"section" : "shop"
									, "content_id" : goodsIdStr[0].split(":")[0]
									, "action" : "cart"
									, "url" : document.location.href
									, "targetUrl" : document.location.href
								}
							});
						}
						var onAddToCartData = {
							'func' : 'onAddToCart',
						}
						//Adbrix
						var productModels = new Array();
						//구글 애널리틱스 - GA
						var items = new Array();
						data.adbrixList.forEach(function(item){
							var cate = new Array();
							if(item.dispClsfNm1){
								cate.push(item.dispClsfNm1);
							}
							if(item.dispClsfNm2){
								cate.push(item.dispClsfNm2);
							}
							if(item.dispClsfNm3){
								cate.push(item.dispClsfNm3);
							}
							var goods = {
									'productId' : item.goodsId,
					    			'productName' : item.goodsNm,
					    			'price' : item.orgSalePrc,
					    			'quantity' : item.buyQty,
					    			'discount' : item.discount,
					    			'currency' : 1,		// 고정 1 , KRW
					    			'categorys' : cate
							}
							productModels.push(goods);
							
							//구글 애널리틱스 - GA
							var item = {
									'item_id' : item.goodsId,
					    			'item_name' : item.goodsNm,
					    			'affiliation' : item.compNm,
					    			'price' : item.orgSalePrc,
					    			'quantity' : item.buyQty,
					    			'discount' : item.discount,
					    			'item_category' : item.dispClsfNm3,
					    			'item_brand' : item.bndNm,
					    			'currency' : "KRW"
							}
							items.push(item);
							
						})
						
						onAddToCartData.productModels = productModels;
						//앱에서만 호출
						if (navigator.userAgent.toLowerCase().indexOf('apet') != -1 ) {
							toNativeAdbrix(onAddToCartData);
							
							toNativeData.func = 'onLogin';
							toNative(toNativeData);
						}
						var add_to_cart_data = {};
						add_to_cart_data.currency = "KRW";
						add_to_cart_data.items = items;
						// GA 호출
						//앱 심사로 주석
						sendGtag('add_to_cart');
						
						if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1 || document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
							var goUrl = "/order/indexCartList";
							ui.toast('<div class="link"><p class="tt">장바구니에 추가되었어요</p><a href="#" onclick="fncGoodsAppCloseMove(\''+goUrl+'\'); return false;" class="lk" data-content="" data-url="/order/indexCartList">바로가기</a></div>');
						}else{
							ui.toast('<div class="link"><p class="tt">장바구니에 추가되었어요</p><a href="/order/indexCartList" return false;" class="lk" data-content="" data-url="/order/indexCartList">바로가기</a></div>');
						}
						
						if(reloadYn && reloadYn == 'Y'){
							location.reload();
						}
					}
				}else{
					if(data.rtnCode == 'ORD0072'){
						if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1 || document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
							var goUrl = "/order/indexCartList";
							ui.toast('<div class="link"><p class="tt">'+data.rtnMsg+'</p><a href="#" onclick="fncGoodsAppCloseMove(\''+goUrl+'\'); return false;" class="lk" data-content="" data-url="/order/indexCartList">바로가기</a></div>');
						}else{
							ui.toast('<div class="link"><p class="tt">'+data.rtnMsg+'</p><a href="/order/indexCartList" class="lk" data-content="" data-url="/order/indexCartList">바로가기</a></div>');
						}
					}else if(data.rtnCode == 'ORD0071'){
						ui.alert(data.rtnMsg);
					}else{
						ui.toast(data.rtnMsg);
					}
				}
			}
		};

		ajax.call(options);
	}
	//사은품 체크
	, validFreebie : function(goodsIdStr, buyQtyStr, nowBuyYn){
		var msg;
		var options = {
			url : "/order/getValidFreebie"
			, async: false
			, data : {
				goodsIdsStr : goodsIdStr
				, buyQtys : buyQtyStr
			}
			, done : function(data){
				var rtn = data.rtn;
				/** 재고 체크 실패 코드 : 
				 * 10 : 사은품 품절
				 * 20 : 사은품 재고 부족
				 * 30 : 사은품 품절과 재고부족
				 * */
				if(!rtn.isOk){
					var freebie = rtn.freebie;
					if(rtn.rtnCode == '10'){
						if(nowBuyYn == 'Y'){
							msg = "사은품이 품절 되었어요<br/>사은품 없이 상품을 구매할까요?";
							/*msg = "사은품이 품절되어서 사은품 증정이 불가능합니다.<br/>이대로 상품을 구매하시겠습니까?";*/
						}else{
							msg = "사은품이 품절 되었어요<br/>사은품 없이 장바구니에 추가할까요?";
							/*msg = "사은품이 품절되어서 사은품 증정이 불가능합니다.<br/>이대로 상품을 장바구니 담으시겠습니까?";*/
						}
					}else if(rtn.rtnCode == '20'){
						if(nowBuyYn == 'Y'){
							msg = "사은품 재고가 부족해요<br/>사은품 없이 상품을 구매할까요?";
							/*msg = "사은품 재고가 "+freebie.qty+"개라서 사은품 증정이 불가능합니다.<br/>이대로 상품을 구매하시겠습니까?";*/
						}else{
							msg = "사은품 재고가 부족해요<br/>사은품 없이 장바구니에 추가할까요?";
							/*msg = "사은품 재고가 "+freebie.qty+"개라서 사은품 증정이 불가능합니다.<br/>이대로 상품을 장바구니 담으시겠습니까?";*/
						}
					}else if(rtn.rtnCode == '30'){
						if(nowBuyYn == 'Y'){
							msg = "사은품 재고가 부족해요<br/>사은품 없이 상품을 구매할까요?";
							/*msg = freebie.goodsNm+" 재고가 "+freebie.qty+"개라서 사은품 증정이 불가능합니다.<br/>이대로 상품을 구매하시겠습니까?";*/
						}else{
							msg = "사은품 재고가 부족해요<br/>사은품 없이 장바구니에 추가할까요?";
							/*msg = freebie.goodsNm+" 재고가 "+freebie.qty+"개라서 사은품 증정이 불가능합니다.<br/>이대로 상품을 장바구니 담으시겠습니까?";*/
						}
					}
				}
				
			}
		};

		ajax.call(options);
		
		return msg;
	}
}

function createFormSubmit(id, url, data) {
	$("#" + id + "Form").remove();
	var html = [];
	html.push("<form name=\""+id+"Form\" id=\""+id+"Form\" action=\""+url+"\" method=\"post\">");
	if(data != null) {
		if(data.constructor === Object){
			for(var name1 in data){
				html.push("<input type=\"hidden\" name=\""+name1+"\" value=\"" + data[name1] + "\">");
			}
		} else if(data.constructor === Array ){
			for(var i in data){
				for(var name2 in data[i]){
					html.push("<input type=\"hidden\" name=\""+name2+"\" value=\"" + data[i][name2] + "\">");
				}
			}
		}
	}
	html.push("</form>");
	$("body").append(html.join(''));
	$("#" + id + "Form").submit();
}

	$(document).ready(function(e) {
		$(document)
			.off("click", ".btn-with-prd, .log_connectTingWrap .btn_connectTing")
			.on("click", ".btn-with-prd, .log_connectTingWrap .btn_connectTing", function(e) {
				let $this = $(this);
				if($this.data("clicked") == "1") return;

				$(".prd-layer").remove();
				$("#goodsRelated").remove();
				$(".pop-relation-box").remove();
				$(".popconTing").remove();
				$this.data("clicked", "1");
				setTimeout(function() {
					$this.data("clicked", "0");
				}, 1000);
				if($this.hasClass("btn-with-prd")) {
					
					// $(this) jQuery객체의 data함수는 다른영상 클릭시(화면 reload아님.) 초기화 되지않늗다.
                    // 그래서 $(this) jQuery객체의 대상 엘리먼트($this[0])에서 dataset의 'content'이름의 속성값을 가져온다.
					// else 이하 getRelatedGoodsWithPetLog는 정상적으로 id 가져옴.
                    getRelatedGoodsWithTv($this, $this[0].dataset.content, "N");
				} else {
					getRelatedGoodsWithPetLog($this, $this.data("content"), "N");
				} 
			})
			.off("click", ".petTabHeader .uiTab button")
			.on("click", ".petTabHeader .uiTab button", function(e) {
				console.log('$(this).data("id"): '+$(this).data("id"));
				if( $(this).data("id") == "cart") {
					cartGoods.reloadMiniCart();
				}
			}).off("click", '[data-target="goods"][data-action="ioAlarm"]')
			.on("click", '[data-target="goods"][data-action="ioAlarm"]', function(e) {
				let $btn = $(this);
				let goodsId = $btn.data("goods-id") || $btn.data("content");
				var options = {
					url : "/goods/addIoAlarm",
					data : {goodsId : goodsId, almYn : "N"},
					done : function(data) {
						// console.log("data : " + JSON.stringify(data));
						if(data.message == "login") {
							ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?', { // 컨펌 창 옵션들
								ycb: function () {
									document.location.href = '/indexLogin?returnUrl=' + encodeURIComponent(document.location.href);
								},
								ncb: function () {
									return false;
								},
								ybt: "로그인", // 기본값 "확인"
								nbt: "취소"  // 기본값 "취소"
							});
						}else if(data.message == "changed") {
							ui.toast("상품정보가 변경되어 입고알림을 신청할 수 없어요",{
								bot: 74, //바닥에서 띄울 간격
								sec:  3000 //사라지는 시간
							});
						}else if(data.message == "add"){
							ui.toast("재입고 알림이 신청되었어요");
						}else if(data.message == "added"){
							ui.toast("이미 재입고 알림을 신청했어요",{
								cls : "added" ,
								bot: 74, //바닥에서 띄울 간격
								sec:  3000 //사라지는 시간
							});
						}
					}
				};
				ajax.call(options);
			}).off("click", '[data-target="goods"][data-action="interest"], #goodsSummary .btZZim, .cartNavs .btZZim')
			.on("click", '[data-target="goods"][data-action="interest"], #goodsSummary .btZZim, .cartNavs .btZZim ', function(e) {
				e.stopPropagation();
				e.stopImmediatePropagation();

				//if( $(".popToast").is(":visible") ) return;

				let $btn = $(this);
				let goodsId = $btn.data("content") || $btn.data("goods-id");
				console.log('[data-target="goods"][data-action="interest"] click '+"goodsId: "+goodsId);
				if(goodsId) {
					//insertWish($btn, goodsId);
					var options = {
						url : "/goods/insertWish",
						data : {goodsId : goodsId},
						done : function(data){
							if(data.actGubun =='login'){
								//비로그인 시 처리 기획 없음.
								ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?', { // 컨펌 창 옵션들
									ycb: function () {
										var url = encodeURIComponent(document.location.href);
										if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
											fncGoodsAppCloseMoveLogin(url);
										}else{
											document.location.href = '/indexLogin?returnUrl=' + url;
										}
									},
									ncb: function () {
										return false;
									},
									ybt: "로그인", // 기본값 "확인"
									nbt: "취소"  // 기본값 "취소"
								});
							}else if(data.actGubun =='add'){
								$btn.addClass("on");
								let msg = "";
								if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1 || document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
									var goUrl = "/mypage/shop/myWishList";
									msg = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="#" onclick="fncGoodsAppCloseMove(\''+goUrl+'\'); return false;" class="lk" data-content="" data-url="/mypage/shop/myWishList">바로가기</a></div>';
								}else{
									msg = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="/mypage/shop/myWishList" class="lk" data-content="" data-url="/mypage/shop/myWishList">바로가기</a></div>';
								}
								
								ui.toast(msg,{
									// sec:1500000,
									bot:77
								});
								// 찜 액션 로그
								userActionLog(goodsId, 'interest');
							}else if(data.actGubun =='remove'){
								$btn.removeClass("on");
								ui.toast("찜리스트에서 삭제되었어요", {
									bot:77
								});
								// 찜 취소 액션 로그
								userActionLog(goodsId, 'interest_d');
							}else{
								let act = $btn.hasClass("on") ? "취소" : "추가";
								ui.toast("찜 "+act+" 요청을 실패하였습니다", {
									bot:77
								});
							}
							
							if($btn.data("delyn") === "Y"){
								
								$btn.closest('li').remove();
								$(".petTabContent ul li.active .both-txt").text($('#boxShopPoint ul li').length);
								
								if($("#boxShopPoint ul li").length < 1 && $("#brandPage .brand a").length < 1){									
									$(".uiTab_content ul").css("height", "");
									$("#noneBoxShopPoint").css("display", "block");
									$("#boxShopPoint").css("display", "none");
									
								}
							}
						}
					};
					ajax.call(options);
				}
				e.preventDefault();
				return false;
			})			
			;
	});

function backToGoodsRelatedList() {
	console.log("backToGoodsRelatedList()");
	if($("#goodsRelatedBottomSheet>.con").length>1) {
		var targetGoodsId = $("#goodsWish").data("goodsId");
		var zzimYn = $("#goodsWish").hasClass("on");
		
		$("#goodsRelatedBottomSheet>.con:last").remove();
		$("#goodsRelatedBottomListNCart").show();
		//$("#goodsRelatedBottomSheet").removeClass("backMode").addClass("tabMode");
		$("#goodsRelatedBottomSheet").addClass("tabMode");
		$("#divHandHead").removeClass("pic").addClass("h2 bnone");
		$("#divSmallPic").css("opacity", "0");
		$("#divBackModeTit").css("opacity", "0");
		$("#divSmallPic").hide();
		$("#divBackModeTit").hide();
		$("#divTabModeTit").show();
		$("#btnBack").css("display", "none");
		$("#divBackModeTit").find("span").text("");
		$("#goodsRelatedBottomSheet").removeClass("goodsSummary");
		
		if(zzimYn){
			$("#btnZzim"+targetGoodsId).addClass("on");
		}else{
			$("#btnZzim"+targetGoodsId).removeClass("on");
		}
	}
	
}

function getRelatedGoodsWithTv($btn, vdId, tabMove) {
	$btn = $($btn);
	$("body").addClass("isCartNavs");
	callRelatedGoodAjax($btn, "/goods/popupGoodsRelated/tv/"+vdId, tabMove);
	//ui.dim.set();
}

function getRelatedGoodsWithPetLog($btn, petLogNo, tabMove) {
	$btn = $($btn);
	if(deviceGb != 'PC'){
		if($('#'+$btn.data('content')).find('.vthumbPlayBtns').css('display') == "none"){
			$('#'+$btn.data('content')).find('.vthumbPlayBtns').trigger('click');
		}
	}
	$("body").addClass("isCartNavs");
	//callRelatedGoodAjax($btn, "/goods/popupGoodsRelated/petLog/"+petLogNo);
	//ui.dim.set();
	if($("#goodsRelated").length > 0 && relatedGoodsCallback != undefined && typeof(relatedGoodsCallback) == 'function') {
		relatedGoodsCallback($btn, tabMove);
	}else{
		waiting.start();
		let options = {
			url : "/goods/popupGoodsRelated/petLog/"+petLogNo,
			//async : false,
			dataType: "html",
			done : function(data) {
				waiting.stop();
				
				$("#wrap").append(data);
				$('#goodsRelatedBottomSheet').css("bottom", "-100%");
				if(deviceGb != 'PC'){
					ui.popLayer.open("popconTing");
				}

				$("#popconTing").attr("data-idx", $btn.data("relatedPage").split('-')[0])
				$("#popconTing").attr("data-page", $btn.data("relatedPage").split('-')[1]);
				
				setTimeout(function() {
					relatedGoodsCallback($btn, tabMove);
					$btn.removeData("clicked");
					var imgSlide = new Array();
					
					var event = document.createEvent("Events");
					event.initEvent('keydown', true, true);
					event.keyCode = 27;
					document.getElementById('stop_gif').dispatchEvent(event);
					
					
					var h = ($(window).innerHeight() - $(".popconTing .img-slide").innerHeight() - 10) / ($(window).innerHeight() * 0.01);
					$(".commentBoxAp.popconTingBox").data({"priceh":h+"%","min":h});
					
					ui.commentBox.open('#goodsRelatedBottomSheet');
					
					$('.img-slide .swiper-container').each(function(i,n){
						imgSlide.push(new Swiper($(n), {
							slidesPerView: "auto",
							spaceBetween: 8,
							centeredSlides: true,
							on: {
								slideChangeTransitionEnd: function(){
									var bg = $(".img-slide .swiper-slide:eq("+(imgSlide[0].activeIndex)+") img").attr("src");
									$(".blur-background-area").css("background-image","url(" + bg + ")");
								},
							}
						}));
					});

					var vdId = $('#'+petLogNo).find('.vthumbs').attr('video_id');
					if($('.popconTing .vthumbs').length > 0){
						//$('#popconTing .blur-background-area').css('background', $('#popconTing .vthumbsCi').css('background'));
						if(deviceGb != 'PC'){
							setTimeout(function(){
								onThumbAPIReady();
								$('#'+petLogNo).find('#playbtn_'+vdId).attr('id', '-playbtn_'+vdId);
								$('#'+petLogNo).find('#video_'+vdId).attr('video_id', '-'+vdId);
							}, 300)
						}
					}else{
						$("#popconTing .blur-background-area").css("background-image","url(" + $(".img-slide .swiper-slide:eq(0) img").attr("src") + ")");
					}
					
				}, 0);
				
			},
			fail: function() {
				waiting.stop();
			}
		};
		ajax.call(options);
	}
}

function getRelatedGoodsWithLive($btn, goodsIds, tabMove) {
	$btn = $($btn);
	$("body").addClass("isCartNavs");

	if($("#goodsRelated").length > 0 && relatedGoodsCallback != undefined && typeof(relatedGoodsCallback) == 'function') {
		relatedGoodsCallback($btn, tabMove);
	}else{
		waiting.start();
		let options = {
			url : '/goods/popupGoodsRelated/live',
			data: {
				goodsIds: goodsIds
			},
			dataType: "html",
			done : function(data) {
				$("body").append(data);
				setTimeout(function() {
					relatedGoodsCallback($btn, tabMove);
					$btn.removeData("clicked");
				}, 0);
			},
			fail: function() {
			},
		};
		ajax.call(options);
	}
}

function fnHandHeadClose(obj){
	ui.commentBox.close(obj);
	ui.lock.using(false);	//2021.04.19 추가
	//ui.dim.close();
}
function fnHandHeadCloseLive(obj){
	ui.commentBox.close(obj);
	$('#goodsRelated').remove();
	$('#goodsRelatedBottomSheet').remove();
	ui.lock.using(false);	//2021.04.19 추가
	//ui.dim.close();
}

function callRelatedGoodAjax($btn, url, tabMove) {
	if($("#goodsRelated").length > 0 && relatedGoodsCallback != undefined && typeof(relatedGoodsCallback) == 'function') {
		relatedGoodsCallback($btn, tabMove);
	}else{
		waiting.start();
		let options = {
			url : url,
			//async : false,
			dataType: "html",
			done : function(data) {
				waiting.stop();
				
				$("body").append(data);
				setTimeout(function() {
					relatedGoodsCallback($btn, tabMove);
					$btn.removeData("clicked");
				}, 0);
			},
			fail: function() {
				waiting.stop();
				console.log("failt????? TT");
			}
		};
		ajax.call(options);
	}
}

function getGoodsSummary($btn) {
	let goodsId = $btn.data("content");
	console.log("getGoodsSummary goodsId: "+goodsId);
	let url = "/goods/popupGoodsSummary/"+goodsId;
	//let data = {"goodsId": goodsId};
	waiting.start();
	let options = {
		url : url,
		//data: data,
		dataType: "html",
		done : function(data) {
			waiting.stop();
			
			$("#goodsRelatedBottomSheet").append(data);
			$("#goodsRelatedBottomSheet").addClass("goodsSummary");
			setTimeout(function() {
				goodsSummaryCallback();
				$btn.removeData("clicked");
			}, 0);
		},
		fail: function() {
			waiting.stop();
			console.log("failt????? TT");
		}
	};
	ajax.call(options);
}

function goodsSummaryCallback() {
	$("#goodsRelatedBottomListNCart").hide();
	//$("#goodsRelatedBottomSheet").removeClass("tabMode").addClass("backMode");
	$("#goodsRelatedBottomSheet").removeClass("tabMode");
	$("#divHandHead").removeClass("h2 bnone").addClass("pic");
	$("#divSmallPic").show();
	$("#divBackModeTit").show();
	$("#divTabModeTit").hide();
	$("#btnBack").css("display", "block");

	/* 04.13 */
	var check = "up";
	var scrollWrap = $('.product-option.over-auto');
	var pic = scrollWrap.find('.pic');
	var tit = $(".tit.type-ab");
	var currentScroll = 0;
	var smallPic = $('.commentBoxAp .small-pic')
	var img = scrollWrap.find('.pic').children().clone();
	var point = 56;
	smallPic.empty();
	smallPic.append(img);
	tit.find("span").text($(".page.shop.view .pdInfos .names").text());
	
	scrollWrap.scroll(function(){
		
		var scroll = $(this).scrollTop();
		if(scroll > point && check == "up"){
			pic.stop().animate({
				opacity : 0,
			}, 100);
			tit.stop().animate({
				opacity : 1,
			}, 100);
			smallPic.stop().animate({
				opacity : 1,
			}, 100);
			check = "down";
		}else if(scroll <= point && check == "down") {
			smallPic.stop().animate({
				opacity : 0,
			}, 100);
			pic.stop().animate({
				opacity : 1,
			}, 100);
			tit.stop().animate({
				opacity : 0,
			}, 100);
			check = "up";
		}
		currentScroll = scroll;
	});
	/* // 04.13 */
	
}


function relatedGoodsCallback2($target, data, callback) {
	let html = $("#relatedGoodsWrap").html();
	let rowHtml = '';
	for(let key in data)  rowHtml += getTemplateRowByData(data[key]);
	console.log("$target.length: "+$target.length);
	$target.append(html.replaceAll("{data}", rowHtml));
	$(".prd-layer").css("bottom","-" + $(".prd-layer").height() + "px");
	if(arguments.length == 3 && callback != null && callback != undefined && typeof callback === "function") callback();
}

function getTemplateRowByData(_DATA) {
	let templateString = $("#relatedGoodsRow").html();
	
	// 장바구니 버튼이  2개의 key(soldOutYn, goodsStatCd)에 따라 display 유무가 결정됨. 그래서 cartBtnDisplayYn변수를  for문 위로 뺌.
	var cartBtnDisplayYn = "Y";
	
	for (let key in _DATA) {
		let val = "";
		if(key == "interestYn") {
			let zzimYnClass = "";
			if(_DATA["interestYn"] && _DATA["interestYn"] == "Y") {
				zzimYnClass = " on";
			}
			templateString = templateString.replaceAll("{zzimYnClass}", zzimYnClass);
		}
		if(key == "saleAmt") {
			let discount = '';
			console.log('_DATA["saleAmt"]: '+_DATA["saleAmt"]+', _DATA["orgSaleAmt"]: '+_DATA["orgSaleAmt"]);

			console.log('_DATA["saleAmt"] != _DATA["orgSaleAmt"]: '+(_DATA["saleAmt"] != _DATA["orgSaleAmt"])+', _DATA["saleAmt"] != null: '+(_DATA["saleAmt"] != null) +
				', _DATA["saleAmt"] != undefined: '+(_DATA["saleAmt"] != undefined) +
				', typeof _DATA["saleAmt"] === "number": '+(typeof _DATA["saleAmt"] === "number") +
				', _DATA["orgSaleAmt"] != null: '+(_DATA["orgSaleAmt"] != null) +
				', _DATA["orgSaleAmt"] != undefined: '+(_DATA["orgSaleAmt"] != undefined) +
				', typeof _DATA["orgSaleAmt"] === "number": '+(typeof _DATA["orgSaleAmt"] === "number"));


			if(_DATA["saleAmt"] != _DATA["orgSaleAmt"]
				&& _DATA["saleAmt"] != null
				&& _DATA["saleAmt"] != undefined
				&& typeof _DATA["saleAmt"] === "number"
				&& _DATA["orgSaleAmt"] != null
				&& _DATA["orgSaleAmt"] != undefined
				&& typeof _DATA["orgSaleAmt"] === "number"
			) {
				//var discount_rate = (Math.ceil((_DATA["orgSaleAmt"]-_DATA["saleAmt"])/_DATA["orgSaleAmt"]*100));
				var discount_rate = (Math.floor((_DATA["orgSaleAmt"]-_DATA["saleAmt"])/_DATA["orgSaleAmt"]*100));
				console.log('discount_rate: '+discount_rate);
				if(discount_rate>=1) {
					discount = '<strong class="discount">'+discount_rate+'%</strong>';
				}
			}
			templateString = templateString.replaceAll("{discount}", discount);
			_DATA["saleAmt"] = new Intl.NumberFormat().format(_DATA["saleAmt"]);
		}else if(key == "saleAmt") {
			_DATA["orgSaleAmt"] = new Intl.NumberFormat().format(_DATA["orgSaleAmt"]);
		}else if(key == "soldOutYn") {
			let soldOutHtml = '';
			if(_DATA['soldOutYn'] == "Y") {
				soldOutHtml = '<div class="soldouts"><em class="ts">입고 예정</em></div>';
				cartBtnDisplayYn = "N"; // 장바구니버튼 display YN
			}
			templateString = templateString.replaceAll("{soldOut}", soldOutHtml);
		}
		
		if ( key == "goodsStatCd" ) {
			// 상품상태가 판매중지(50), 판매종료(60) 일 경우  장바구니 버튼 안보이게 함.
			if ( _DATA['goodsStatCd'] == "50" || _DATA['goodsStatCd'] == "60") {
				cartBtnDisplayYn = "N";		
			}
		}

		templateString = templateString.replaceAll("{" + key + "}", (_DATA[key] ? _DATA[key] : '&nbsp;'));
	}
	
	if ( cartBtnDisplayYn == 'N' ) {
		templateString = templateString.replaceAll("{displayNoneCartBtn}", "style='display:none;'");
	} else {
		templateString = templateString.replaceAll("{displayNoneCartBtn}", "");
	}
	
	return templateString;
}

//경과 시간 표시
function elapsedTime(timeStamp, ymd) {
	let currentDate = new Date();
	let formatDate = new Date(timeStamp);
	let dateDif = currentDate.getTime() - formatDate.getTime();
	// 8일 이상일 경우 format
	let monthFormat = formatDate.getMonth()+1;
	let dateFormat = formatDate.getDate();
	if (monthFormat < 10) {
		monthFormat = "0" + monthFormat;
	}
	if (dateFormat < 10) {
		dateFormat = "0" + dateFormat;
	}

	let dateStr = monthFormat + "-" + dateFormat;
	if( currentDate.getFullYear() != formatDate.getFullYear() ) {
		dateStr = formatDate.getFullYear() + "-" + monthFormat + "-" + dateFormat;
	}
	if( ymd !== undefined && ymd == "년월일" ){
		dateStr = monthFormat + "월 " + dateFormat + "일";
		if( currentDate.getFullYear() != formatDate.getFullYear() ) {
			dateStr = formatDate.getFullYear() + "." + monthFormat + "." + dateFormat;
		}
	}
	
	// 현재날짜 - 댓글등록날짜 의 초/분/시/일
	let getSecond = dateDif / 1000;
	let getMinute = getSecond / 60;
	let getHour = getMinute / 60;
	let getDate = getHour / 24;
	
	if (getHour < 1) { // 1시간 미만 (몇분 전)
		if (Math.floor(getMinute) < 1) {
			dateStr = (Math.floor(getSecond) < 1 ? '1' : Math.floor(getSecond)) + "초 전";
		} else {
			dateStr = Math.floor(getMinute) + "분 전";
		}
	} else if (getDate < 1) { // 1일 미만 (몇시간 전)
		dateStr = Math.floor(getHour) + "시간 전";
	} else if (getDate < 8) { // 7일 미만 (몇일 전) : 7일 포함
		dateStr = Math.floor(getDate) + "일 전";
	}
	return dateStr;
}

function xssCheck(str, level) {
    if (level == undefined || level == 0) {
        str = str.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g,"");
    } else if (level != undefined && level == 1) {
        str = str.replace(/\</g, "&lt;");
        str = str.replace(/\>/g, "&gt;");
    }
    return str;
}

var getOutPage = sessionStorage.getItem("getOutPage");
if(getOutPage == null ){
	var thisLocation = location.href;
	if(thisLocation.indexOf(getOutPage) == -1){
		sessionStorage.removeItem('getOutPage');
	}else{
		history.back();
	}
}

//공통 코드 초기화
function fnInitCodeCache(){
	$.ajax({
		url : "/common/init-code"
		,   type : "POST"
		,   success : function(result){}
	});
}

function getQueryString(obj){
	var arr = [];
	if(obj != undefined && obj != null){
		if(typeof(obj) == "string"){
			return obj;
		}else if(typeof(obj) == "object"){
			for(var key in obj){
				if(isNaN(key)){
					arr.push(key + "=" + obj[key]);
				}
			}
			return arr.join("&");
		}else{
			return "";
		}
	}else{
		return "";
	}
}

var deepLinkApp = {
	deepLinkUrl : "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/YIP3MdGRkEqER6djusam5A?deeplink_custom_path=",
	aosCustomPath : "aboutpetadbrix://parameters?landingUrl=",
	iosCustomPath : "adbrixscheme://parameters?landingUrl=",
	customPath : "",
	call : function(options){
		console.log("## ["+options.osType+"] deepLinkUrl : "+this.deepLinkUrl);
		if(options.deviceGb != "PC"){

			if(options.osType == "10"){
				// Android
				this.customPath = encodeURIComponent(this.aosCustomPath+options.landingUri);
			}else if(options.osType == "20"){
				// Ios
				this.customPath = encodeURIComponent(this.iosCustomPath+options.landingUri);
			}
			this.deepLinkUrl = this.deepLinkUrl + this.customPath;
			location.href = this.deepLinkUrl;
		}else{
			console.log("## I don't care about device PC ... by DeepLink ##")
		}
	}
}