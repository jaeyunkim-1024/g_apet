var waiting = {
	start : function(){
		$.blockUI({ message: '<img src="/images/ajax-loader-white.gif" alt="Loading..." />' });
	}
	, stop : function(){
		$.unblockUI();
	}
	, startId : function(id){
		$.blockUI({ message: $("#" + id) });
	}
	, stopId : function(){
		$.unblockUI();
	}
};

var gridFormat = {
	date : function(cellValue, options, rowObject) {
		if(options.colModel.dateformat != null && options.colModel.dateformat !== '') {
			if (options.colModel.dateformat === 'yyyyMMdd') {
				var val = cellValue == null ? '' : cellValue;
				return new Date([val.slice(0, 4), val.slice(4,6), val.slice(6,8)].join('-')).format(options.colModel.dateformat);
			} else {
				return new Date(cellValue).format(options.colModel.dateformat);
			}
		} else {
			return new Date(cellValue).format("yyyy-MM-dd HH:mm:ss");
		}
	}, // hjko  추가
	phonenumber : function(cellvalue, options, rowObject){
		if( cellvalue != null ){
			if(cellvalue.length === 8){
				return cellvalue.replace(/([0-9]{4})([0-9]{4})/,"$1-$2");
			}else{
				return cellvalue.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			}
		}else{
			return "";
		}
	},
	mbrId : function(cellvalue, options, rowObject){
		return cellvalue == null ? "" : cellvalue.substr(0, 2) + '*****';
	},
	rate: function(cellvalue, options, rowObject) {
		return cellvalue == null ? "" : cellvalue + '%';
	},
	switchTag : function(cellvalue, options, rowObject) {
		return cellvalue.replace(/</g,"&lt;").replace(/>/g,"&gt;");
	},
	datestring : function(cellvalue, options, rowObject){
		return cellvalue == null ? "" : cellvalue.replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,"$1-$2-$3");
	},
	numEstmCoreFormat : function(cellvalue, options, rowObject){
		// 상품후기 평점 변경
		return cellvalue == null ? "" : cellvalue/2;
	}
}

var valid = {
	numberWithCommas : function(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	},phonenumber : function(value) {
		return value.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	}
}

/*
	title : Error, Info, Confirm, 그 외 커스텀 타이틀
	icon : error, info, question, warning
	fn : 비동기로 하위 로직은 fn안에서 처리
	ex) messager.alert("에러가 발생하였습니다.", "Error", "error", function(){ //doSomething(); });
	ex) messager.confirm("수정하시겠습니까?", function(r){ if(r){ //doSomething(); } });
*/
var messager = {
	alert : function(msg, title, icon, fn){
		$.messager.alert({
			title : title == null ? "" : title,
			msg : msg,
			icon : icon,
			inline : false,
			border : 'thin',
			cls : 'c2',
			draggable : true,
			shadow : false,
			fn : fn
		});
	},confirm : function(msg, fn, title){
		$.messager.confirm({
			title: title == null ? "Confirm" : title,
			msg : msg,
			inline : false,
			border : 'thin',
			cls : 'c2',
			draggable : true,
			shadow : false,
			fn : fn
		});
	},confirm : function(msg, fn, title,callback){
		$.messager.confirm({
			title: title == null ? "Confirm" : title,
			msg : msg,
			inline : false,
			border : 'thin',
			cls : 'c2',
			draggable : true,
			shadow : false,
			fn : fn
		});

		if(callback){
			callback();
		}
	}
}

var initHeight;
var accordion = {
	setInitHeight : function(h){
		initHeight = h;
	},
	onUnselect : function(){
		var contentsId =  $(this).parents().find("#contents");
		var reHeight = $(window).innerHeight() - ( $(window).innerHeight() - contentsId.height() - $(this).height() );

		if(!$(this).data().accordion.options.gridResizeYn){
			$(this).parents().find("#contents .ui-jqgrid-btable").jqGrid('setGridHeight', reHeight);
		}
	},
	onSelect : function(){
		if(!$(this).data().accordion.options.gridResizeYn){
			$(this).parents().find("#contents .ui-jqgrid-btable").jqGrid('setGridHeight', initHeight);
		}
	}
}

var grid = {

	create : function(targetId, options){
		var sortName = options.colModels[0].name;
		
		options.paging = (options.paging == null) ? true : options.paging;
		
		var paging = false; 
		var editing = false;
		var pager = "";
		var rowList = [50,100,200];
		var rowNum;
		var footerrow = false;
		var userDataOnFooter = false;

		paging = setDefaultIfNull(options.paging, false);
		editing = setDefaultIfNull(options.editing, false);
		footerrow = setDefaultIfNull(options.footerrow, false);
		userDataOnFooter = setDefaultIfNull(options.userDataOnFooter, false);


		if(paging){
			pager = "#"+targetId+"Page";
			if(options.rowNum != undefined && options.rowNum != null){
				if(typeof(options.rowNum) == "object"){
					rowList = rowList.concat(options.rowNum);
				}
				if(typeof(options.rowNum) == "number"){
					rowList.push(options.rowNum);
				}
				if(typeof(options.rowNum) == "string" && !isNaN(options.rowNum)){
					rowList.push(parseInt(options.rowNum));
				}
				rowList.sort(function(a,b){return a-b;});
			}
			rowNum = rowList[0];
		}

		options.searchParam = $.extend({rows : rowNum},options.searchParam);

		$("#"+targetId).jqGrid({
			url : options.url
			, loadonce : options.loadonce || false
			, postData : options.searchParam
			, datatype : setDefaultIfNull(options.datatype, "json")
			, sortable: true
			, mtype : "POST"
			, autowidth : false
			, width : '100%'
			, height : setDefaultIfNull(options.height, 200)
			, colNames : options.colNames
			, colModel : options.colModels
			, cellEdit : options.cellEdit || false
			, cellsubmit : setDefaultIfNull(options.cellsubmit, 'clientArray')
			, cellurl : options.cellurl
			, editurl : options.editurl
			, afterEditCell : options.afterEditCell
			, afterSaveCell : options.afterSaveCell
			, beforeEditCell : options.beforeEditCell
			, beforeSaveCell : options.beforeSaveCell
			, rownumbers : options.rownumbers
			, rowNum : setDefaultIfNull(rowNum, -1)
			, rowList : setDefaultIfNull(options.rowList, rowList)
			, pager : pager
			, viewrecords : true
			, multiselect : setDefaultIfNull(options.multiselect, false)
			, sortname : setDefaultIfNull(options.sortname, sortName)
			, sortorder : setDefaultIfNull(options.sortorder, "desc")
			, jsonReader : {
				page: "page"
				, total: "total"
				, root: "data"
				, records: "records"
				, repeatitems: false,
			}
			, cmTemplate: {sortable:false}
			, loadError : function(xhr, status, error){
				if(xhr.status === 450) {
					location.replace("/login/noSessionView.do");
				} else {
					if(xhr.status !== 0) {
						messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
					}
				}
			}
			, footerrow : footerrow
			, userDataOnFooter : userDataOnFooter
			, beforeSelectRow : options.beforeSelectRow
			, onSelectRow : options.onSelectRow
			, onCellSelect : options.onCellSelect == null ? undefined : options.onCellSelect
			, onSelectAll : options.onSelectAll == null ? undefined : options.onSelectAll
			, ondblClickRow : options.ondblClickRow == null ? undefined : options.ondblClickRow
			, loadComplete : function(data){
				if(options.loadComplete != null){
					options.loadComplete(data);
				}

				if(options.accessYn && options.accessYn == "Y" && parseInt(data.cnctHistNo) != 0){
					va.qLog(data);
				}
			}
			, gridComplete : options.gridComplete == null ? undefined : options.gridComplete
			, caption : options.caption == null ? undefined : options.caption
			, grouping: options.grouping == null ? undefined : options.grouping
            , groupingView: {
                groupField: options.groupField == null ? undefined : options.groupField
                , groupText: options.groupText == null ? undefined : ['<b>' + options.groupText + ' : {0}</b>']
                , groupOrder : options.groupOrder == null ? undefined : options.groupOrder
                , groupColumnShow : options.groupColumnShow == null ? undefined : options.groupColumnShow
                , groupCollapse: options.groupCollapse == null ? undefined : options.groupCollapse
                , groupSummary: options.groupSummary == null ? undefined : options.groupSummary
                , showSummaryOnHide: options.showSummaryOnHide == null ? undefined : options.showSummaryOnHide
                , groupDataSorted: options.showSummaryOnHide == null ? undefined : options.showSummaryOnHide
            }
		});

		$("#"+ targetId).setGridWidth($("#gbox_"+ targetId).parent().width() - 2, false);

		if(editing){
			$("#"+targetId).jqGrid('navGrid', pager, { search:false, del:true, add:true, edit:true, refresh:false });
		}

		this.setInitHeight(options.height || 200);

	}
	, reload : function(targetId, options){
		if (options.sortname == undefined) {
			$("#"+targetId).jqGrid('setGridParam',{
				postData: options.searchParam
				, datatype : options.datatype || "json"
			})
			.trigger("reloadGrid",[{page:1}]);
		} else {
			$("#"+targetId).jqGrid('setGridParam',{
				postData: options.searchParam
				, datatype : options.datatype || "json"
				, sortname : setDefaultIfNull(options.sortname, "sysRegDtm")
				, sortorder : setDefaultIfNull(options.sortorder, "desc")
			})
			.trigger("reloadGrid",[{page:1}]);
		}
	}
	, resize : function(){
		var grid = $('.ui-jqgrid-btable:visible');
		grid.each(function(index) {
			var gridId = $(this).attr('id');
			$('#' + gridId).setGridWidth($('#gbox_' + gridId).parent().width() - 2, false);
		});
	}
	, jsonData : function(id) {
		var ids = $("#"+id).getDataIDs();

		var jsonArray = [];

		for (var i = 0; i < ids.length; i++) {
			jsonArray.push($("#"+id).getRowData(ids[i]));
		}

		return jsonArray;
	}
	, setInitHeight : function(h){
		accordion.setInitHeight(h);
	}
};

// Sub Grid 생성
var subGrid = {

	create : function (targetId, options ) {
		var sortName = options.colModels[0].name;

		if(options.paging == null){
			options.paging = true;
		}

		if(options.editing == null){
			options.editing = false;
		}

		var paging = false;
		var editing = false;
		var pager = "";
		var rowList;
		var rowNum;
		var footerrow = false;
		var userDataOnFooter = false;

		if(options.paging){
			paging = true;
		}

		if(options.editing){
			editing = true;
		}

		if(options.footerrow) {
			footerrow = true;
		}

		if(options.userDataOnFooter) {
			userDataOnFooter = true;
		}

		if(paging){
			pager = "#"+targetId+"Page";
			rowList = [50,100,200];
			rowNum = 50;
		}
		$("#"+targetId).jqGrid({
			url : options.url
			, postData : options.searchParam
			, datatype : options.datatype || "json"
			, mtype : "POST"
			, autowidth : false
			, width : '100%'
			, height : options.height || 200
			, colNames : options.colNames
			, colModel : options.colModels
			, cellEdit : options.cellEdit || false
			, cellsubmit : options.cellsubmit || 'clientArray'
			, cellurl : options.cellurl == null ? undefined : options.cellurl
			, rowNum : rowNum || -1
			, rowList : rowList
			, pager : pager
			, viewrecords : true
			, multiselect : options.multiselect || false
			, sortname : options.sortname || sortName
			, sortorder : options.sortorder || "desc"
			, afterEditCell : options.afterEditCell
			, afterSaveCell : options.afterSaveCell
			, beforeEditCell : options.beforeEditCell
			, beforeSaveCell : options.beforeSaveCell
			, jsonReader : {
				page: "page"
				, total: "total"
				, root: "data"
				, records: "records"
				, repeatitems: false,
			}
			, loadError : function(xhr, status, error){
				if(xhr.status === 450) {
					location.replace("/login/noSessionView.do");
				} else {
					if(xhr.status !== 0) {
						messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
					}
				}
			}
			, onSelectRow : options.onSelectRow == null ? undefined : options.onSelectRow
			, onCellSelect : options.onCellSelect == null ? undefined : options.onCellSelect
			// Sub Grid 설정
			, subGrid: true // set the subGrid property to true to show expand buttons for each row
			, subGridRowExpanded: options.subGridRowExpanded // javascript function that will take care of showing the child grid
			, isHasSubGrid : options.isHasSubGrid
			/*
			, subGridOptions : {
				// configure the icons from theme rolloer
				plusicon: "ui-icon-triangle-1-e",
				minusicon: "ui-icon-triangle-1-s",
				openicon: "ui-icon-arrowreturn-1-e"
			}
			*/
			, footerrow : footerrow
			, userDataOnFooter : userDataOnFooter
			, gridComplete : options.gridComplete == null ? undefined : options.gridComplete
			, caption : options.caption == null ? undefined : options.caption
		});

		$("#"+ targetId).setGridWidth($("#gbox_"+ targetId).parent().width() - 2, false);

		if(editing){
			$("#"+targetId).jqGrid('navGrid', pager, { search:false, del:true, add:true, edit:true, refresh:false });
		}

	}
	, reload : function(targetId, options){
		$("#"+targetId).jqGrid('setGridParam',{
			postData: options.searchParam
			, datatype : options.datatype || "json"
		}).trigger("reloadGrid",[{page:1}]);
	}
	, resize : function(){
		var grid = $('.ui-jqgrid-btable:visible');
		grid.each(function(index) {
			var gridId = $(this).attr('id');
			$('#' + gridId).setGridWidth($('#gbox_' + gridId).parent().width() - 2, false);
		});
	}
};

var validation = {
	timestamp : function(val){
		if(val !== "" && val != null){
			return new Date(val).format("yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	,birth : function(val){
		if(val !== "" && val != null){
			return val.replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,"$1년 $2월 $3일");
		}else{
			return "";
		}
	}
	,tel: function(tel){
		if(tel !== "" && tel != null && tel !== 'null'){
			if(tel.length === 8){
				return tel.replace(/([0-9]{4})([0-9]{4})/,"$1-$2");
			}else{
				return tel.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			}
		}else{
			return "";
		}
	}
	, fax: function(fax){
		if(fax !== "" && fax != null && fax !== 'null'){
			if(fax.length === 8){
				return fax.replace(/([0-9]{4})([0-9]{4})/,"$1-$2");
			}else{
				return fax.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
			}
		}else{
			return "";
		}
	}
	, mobile: function(no){
		if(no !== "" && no != null && no !== 'null'){
			return no.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
		}else{
			return "";
		}
	}
	, post: function(no) {
		if(no !== "" && no != null && no !== 'null'){
			return no.replace(/([0-9]{3})([0-9]{3})/,"$1-$2");
		}else{
			return "";
		}
	}
	, bizNo: function(no){
		if(no !== "" && no != null && no !== 'null'){
			return no.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/,"$1-$2-$3");
		}else{
			return "";
		}
	}
	, cprNo: function(no){
		if(no !== "" && no != null && no !== 'null'){
			return no.replace(/([0-9]{6})([0-9]{7})/,"$1-$2");
		}else{
			return "";
		}
	}
	, isValidDate : function(str) {
		// Checks for the following valid date formats:
		// Also separates date into month, day, and year variables
		var datePat = /^(\d{2}|\d{4})(\/|-)(\d{1,2})\2(\d{1,2})$/;

		var matchArray = str.match(datePat); // is the format ok?
		if (matchArray == null) {
			return false;
		}
		var year = matchArray[1];
		var month = matchArray[3]; // parse date into variables
		var day = matchArray[4];

		if (month < 1 || month > 12) { // check month range
			return false;
		}
		if (day < 1 || day > 31) {
			return false;
		}
		if ((month===4 || month===6 || month===9 || month===11) && day===31) {
			return false
		}
		if (month === 2) { // check for february 29th
			var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));

			if (day > 29 || (day === 29 && !isleap)) {
				return false;
			}
		}
		return true; // date is valid
	}
	, isNull : function(str) {
		if(str !== "" && str != null && str !== 'null'){
			return false;
		} else {
			return true;
		}
	}
	, num : function(n){
		  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
		  n += '';                          // 숫자를 문자열로 변환

		  while (reg.test(n))
		    n = n.replace(reg, '$1' + ',' + '$2');

		  return n;
	}

	, isValidCodeName : function(str){
		// '/'는 47, ','는 44 {:123, }:125,(:40,):41, space:32
		for (var i = 0; i < str.length; i++)
	    {
	        var ch = str.charCodeAt(i);
//	        if((ch >= 0  && ch < 32) || ( ch == 47 )  ||   (ch >= 127 && ch <= 255)){
//	            return true;
//	        }
	        if((ch >= 33 && ch <= 43) ||  (ch >= 91 && ch <= 96) || ( ch >= 123 && ch<= 126)){
	            return false;
	        }
	    }

	    return true;
	}
	
	, email : function(str) {
		var reg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((([a-zA-Z]+\.)+[a-zA-Z]{3})|(([a-zA-Z]+\.)+[a-zA-Z]{2}\.[a-zA-Z]{2}))$/;
		
		if(reg.test(str)) {
			return true;
		} else {
			return false;
		}
	}
};

var validate = {
	set: function(formId) {
		$("#"+formId).validationEngine();
	},
	hide: function(formId) {
		$("#"+formId).validationEngine("hide");
	},
	check: function(formId) {
		return $("#"+formId).validationEngine("validate");
	}
};


$.datepicker._gotoToday = function(id) {
    var target = $(id);
    var inst = this._getInst(target[0]);
    if (this._get(inst, 'gotoCurrent') && inst.currentDay) {
            inst.selectedDay = inst.currentDay;
            inst.drawMonth = inst.selectedMonth = inst.currentMonth;
            inst.drawYear = inst.selectedYear = inst.currentYear;
    }
    else {
            var date = new Date();
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            // the below two lines are new
            this._setDateDatepicker(target, date);
            this._selectDate(id, this._getDateDatepicker(target));
    }
    this._notifyChange(inst);
    this._adjustDate(target);
}
var common = {
	datepicker : function(){
		$(".datepicker").datepicker({
			  dateFormat : 'yy-mm-dd'
			, prevText : '이전달'
			, nextText : '다음달'
			, monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			, monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			, dayNamesMin : ['일','월','화','수','목','금','토']
			, showMonthAfterYear : true
			, inline : true
			, changeMonth : true
			, changeYear : true
			, showButtonPanel : true // 캘린더 하단에 버튼 패널을 표시한다.
			, currentText : '오늘 날짜' // 오늘 날짜로 이동하는 버튼 패널
			, closeText : '닫기'
		});

		$(".datepicker").mask("9999-99-99");

		$(".datepicker").blur(function(){
			if(!validation.isNull($(this).val()) && !validation.isValidDate($(this).val())){
				$(this).val("");
				$(this).focus();
				messager.alert("올바르지 않은 날짜입니다.", "Info", "info");
			}
			if(!validation.isNull($(this).val()) && validation.isValidDate($(this).val())){
				var datePat = /^(\d{2}|\d{4})(\/|-)(\d{1,2})\2(\d{1,2})$/;
				var str = $(this).val();
				var matchArray = str.match(datePat); // is the format ok?
				if (matchArray == null) {
					return false;
				}
				var year = matchArray[1];
				var month = matchArray[3]; // parse date into variables
				var day = matchArray[4];
				if (month < 10) {
					month = '0' + month * 1;
				}
				if (day < 10) {
					day = '0' + day * 1;
				}
				$(this).val(year + '-' + month + '-' + day);
			}
		});

		$(".datepickerBtn").click(function(){
			$(this).prev().focus();
		});
	}
	, numeric : function(){
		$(".numeric").css("ime-mode", "disabled");//한글입력 X
		$(".numeric").mask("#0", {reverse: true, maxlength: false});
	}
	, decimal : function(){
		$(".decimal").css("ime-mode", "disabled");//한글입력 X
		 $(".decimal").autoNumeric("init",{
			aSep: ','
			, aDec: '.'
			, vMax : '9999999999999.9'
			, vMin : '-9999999999999.9'
		});
	}
	, decimalNoPoint : function(){
		$(".decimalNoPoint").css("ime-mode", "disabled");//한글입력 X
		 $(".decimalNoPoint").autoNumeric("init",{
			aSep: ','
			, aDec: '.'
			, vMax : '9999999999999'
			, vMin : '-9999999999999'
		});
	}
	, phoneNumber : function() {
		var phoneMask = function (val) {
			var mask = "000-000-000000";
			var value = val.replace(/\D/g, '');

			if(value.length > 2) {
				if(value.substring(0,2) === "02"){
					mask = "00-000-00000"
					if(value.length === 10) {
						mask = "00-0000-0000"
					}
				} else if(value.substring(0,2) === "01"){
					if(value.length === 11) {
						mask = "000-0000-0000"
					}
				} else {
					if(value.length === 11) {
						mask = "000-0000-00000"
					} else if(value.length === 12) {
						mask = "0000-0000-0000"
					}else if(value.length === 8){
						mask = "0000-0000-0000"
					}
				}
			}
			return mask;
		}
		var option = {
			onKeyPress: function(val, e, field, options) {
				field.mask(phoneMask.apply({}, arguments), options);
			}
			, onComplete: function(val, e, field, options) {
				var mask = "000-000-000000";
				var value = val.replace(/\D/g, '');
				if(value.length > 2) {
					if(value.substring(0,2) === "02"){
						mask = "00-000-00000"
						if(value.length === 10) {
							mask = "00-0000-0000"
						}
					} else if(value.substring(0,2) === "01"){
						if(value.length === 11) {
							mask = "000-0000-0000"
						}
					} else {
						if(value.length === 11) {
							mask = "000-0000-00000"
						} else if(value.length === 12) {
							mask = "0000-0000-0000"
						}else if(value.length === 8){
							mask = "0000-0000-0000"
						}
					}
				}
				field.mask(mask, options);
			}
		}

		$('.phoneNumber').mask(phoneMask, option);
	}
	, comma : function() {
		$('.comma').mask("#,##0", {reverse: true, maxlength: false});
	}, numberOnly : function() {
		$(".numberOnly").mask("#0", {reverse: true, maxlength: false});
	}
	, rateOnly : function() {
		$(".rateOnly").css("ime-mode", "disabled");//한글입력 X
		$(".rateOnly").autoNumeric("init",{
			aSep: ','
			, aDec: '.'
			, vMax : '99.99'
			, vMin : '0.00'
		});
	}
	, rateOnly2 : function() {
		$(".rateOnly2").css("ime-mode", "disabled");//한글입력 X
		$(".rateOnly2").autoNumeric("init",{
			aSep: ','
			, aDec: '.'
			, vMax : '100'
			, vMin : '0.00'
		});
	}
	, bigRateOnly : function() {
		$(".rateOnly").css("ime-mode", "disabled");//한글입력 X
		$(".rateOnly").autoNumeric("init",{
			aSep: ','
			, aDec: '.'
			, vMax : '9999.99'
			, vMin : '0.00'
		});
	}
	, readOnly : function() {
		// IE에서 readonly 속성 input 백스페이스 키 입력 시 브라우저 back 처리됨을 막음
		//한번 적용된 이벤트 삭제되지 않는 문제로 변경
		$(document).on("keydown", ".readonly", function(event) {
			if (event.keyCode === 8) {
				return false;
			}else{
				return true;
			}
		});
	}
	, noHash : function() {
		$(document).on("input", ".noHash", function(event) {
			$(this).val($(this).val().replace(/#/g, ''));
		});
	}
	, all : function() {
		common.datepicker();
		common.numeric();
		common.phoneNumber();
		common.comma();
		common.decimal();
		common.decimalNoPoint();
		common.numberOnly();
		common.rateOnly();
		common.rateOnly2();
		common.readOnly();
		common.noHash();
	}
}

var ajax = {
	call : function(options){

		var wait = true;

		if(options.wait != null){
			wait = false;
		}

		if(wait){
			waiting.start();
		}

		jQuery.ajaxSettings.traditional = true;

		options.contentType = setDefaultIfNull(options.contentType, "application/x-www-form-urlencoded;charset=UTF-8");
		options.type = setDefaultIfNull(options.type, "POST");
		options.dataType = setDefaultIfNull(options.dataType, "json");
		options.async = (options.async == null || options.async) ? true : false;
		options.crossDomain = (options.crossDomain == null) ? false : options.crossDomain
		var noAlert = (options.noAlert == null) ? false : options.noAlert

		$.ajax({
			url : options.url
			, type : options.type
			, dataType : options.dataType
			, contentType : options.contentType
			, cache : false
			, data : options.data
			, async: options.async
			, crossDomain : options.crossDomain
		})
		.done(function(data, textStatus, jqXHR){
			if(options.dataType === "text" || options.dataType === "html") {
				try {
					var obj = eval("("+ data +")");

					if(obj.exCode != null && obj.exCode !== ""){
						messager.alert(obj.exMsg, "Info", "info");
//						waiting.stop();
					} else {
						options.callBack(data);
						common.all();
					}
				} catch (e) {
					options.callBack(data);
					common.all();
				}
			} else {
				if(data.exCode != null && data.exCode !== ""){
					messager.alert(data.exMsg, "Info", "info");
//					waiting.stop();
				} else {
					options.callBack(data);
					common.all();
				}
			}
		})
		.fail(function( xhr, status, error ){
			if(xhr.status === 450) {
				location.replace("/login/noSessionView.do");
			} else {
				if (! noAlert) {
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
				}
			}
		})
		.always(function(){
			if(wait){
				waiting.stop();
			}
		})
		.then(function(data, textStatus, jqXHR ) {			
		});
	},
	load : function(targetId, url, params){
		waiting.start();

		if(params == null){
			params = {};
		}
		$("#"+targetId).load(url, params, function(response, status, xhr){
			waiting.stop();

			if(status === "error"){
				if(xhr.status === 450) {
					location.replace("/login/noSessionView.do");
				} else {
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
				}
			}

		});
	}
};

var objClass = {
	add : function (obj, className ) {
		var hasClass = $(obj).hasClass(className);

		if(!hasClass ) {
			$(obj).addClass(className);
		}
	}
	, remove : function (obj, className ) {
		var hasClass = $(obj).hasClass(className);

		if(hasClass ) {
			$(obj).removeClass(className);
		}
	}
	, removePrefix : function (obj, prefix) {
		obj.each( function ( i, it ) {
	        var classes = it.className.split(" ").map(function (item) {
	            return item.indexOf(prefix) === 0 ? "" : item;
	        });
	        it.className = classes.join(" ");
	    });
	}
}

function popupClose() {
	self.close();
}


function resetForm(id) {
	$("#" + id).trigger("reset");
	$("#" + id).find("input[type=hidden]").val('');
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

function createTargetFormSubmit(result) {
	$("#" + result.id + "Form").remove();
	var html = [];
	if(result.target != null) {
		html.push("<form name=\""+result.id+"Form\" id=\""+result.id+"Form\" action=\""+result.url+"\" target=\"" + result.target + "\" method=\"post\">");
	} else {
		html.push("<form name=\""+result.id+"Form\" id=\""+result.id+"Form\" action=\""+result.url+"\" method=\"post\">");
	}

	if(result.data != null) {
		if(result.data.constructor === Object){
			for(var name1 in result.data){
				html.push("<input type=\"hidden\" name=\""+name1+"\" value=\"" + result.data[name1] + "\">");
			}
		} else if(result.data.constructor === Array ){
			for(var i in result.data){
				for(var name2 in result.data[i]){
					html.push("<input type=\"hidden\" name=\""+name2+"\" value=\"" + result.data[i][name2] + "\">");
				}
			}
		}
	}
	html.push("</form>");
	$("body").append(html.join(''));
	$("#" + result.id + "Form").submit();
}

//공통팝업 호출 구분
function openWindowPop(config){
	var url = setDefaultIfNull(config.url, '');
	var target = setDefaultIfNull(config.target, 'popup');
	var left = (screen.width) ? (screen.width - config.width) / 2 : 0;
	var top = (screen.height) ? (screen.height - config.height) / 2 : 0;
	var settings = [];
	settings.push('height=' + config.height);	//세로
	settings.push('width=' + config.width);		//가로
	settings.push('top=' + top);				//y좌표
	settings.push('left=' + left);				//x좌표

	if(config.scrollbars){
		settings.push('scrollbars='+config.scrollbars);	//스크롤바
	}
	if(config.resizable){
		settings.push('resizable='+config.resizable);	//창크기 조절 가능여부
	}
	if(config.toolbar){
		settings.push('toolbar='+config.toolbar);		//뒤로, 앞으로, 검색, 즐겨찾기 등의 버튼이 나오는줄
	}
	if(config.location){
		settings.push('location='+config.location);		//주소창
	}
	if(config.status){
		settings.push('status='+config.status);			//창 상태 유무
	}
	if(config.menubar){
		settings.push('menubar='+config.menubar);		//파일,편집,보기,등의 버튼이 있는줄
	}
	if(config.fullscreen){
		settings.push('fullscreen='+config.fullscreen);		//전체화면 유무 지정
	}
	if(config.data) {
		window.open('', target, settings.join(','));
		$("#" + target + "Form").remove();
		var html = [];
		html.push("<form name=\""+target+"Form\" id=\""+target+"Form\" action=\""+url+"\" target=\""+target+"\" method=\"post\">");
		var data = config.data;
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
		$("#" + target + "Form").submit();
	} else {
		window.open(url, target, settings.join(','));
	}
}

function goUrl(title, url) {
	addTab(title, url, true);
}


$(document).ready(function(){
	common.all();
});

$(document).submit(function(e){
	if(validation.isNull(e.target.target) && (!validation.isNull(e.target.action)
			&& e.target.action.indexOf("/common/fileDownloadResult.do") === -1
			&& e.target.action.indexOf("/common/fileUrlDownloadResult.do") === -1
			&& e.target.action.indexOf("/common/fileNcpDownloadResult.do") === -1
			&& e.target.action.indexOf("Download.do") === -1)) {
		waiting.start();
	}
});


$(document).on("blur", '.comma', function(e) {
	var value = parseInt(removeComma($(this).val()));

	if(value != null && !isNaN(value)) {
		$(this).val(addComma(value));
	} else {
		$(this).val("");
	}
});

$(document).on("focus", "input[type=text]", function(e) {
	$(this).select();
});

$(document).on("keydown", "input", function(e) {
	if(!$(this).hasClass("ui-pg-input")) {
		if(e.keyCode===13) {
			return false;
		}else{
			return true;
		}
	}else{
		return true;
	}

});

$(window).resize(function() {
	grid.resize();
});

function addComma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function removeComma(str) {
	str = String(str);
	return str.replace(/[^0-9\.]+/g, '');
}

function Round (n, pos) {
	var digits = Math.pow(10, pos);
	var sign = 1;
	if (n < 0) {
		sign = -1;
	} // 음수이면 양수처리후 반올림 한 후 다시 음수처리
	n = n * sign;
	var num = Math.round(n * digits) / digits;
	num = num * sign;
	return Number(num.toFixed(pos));
}
//지정자리 버림 (값, 자릿수)
function Floor (n, pos) {
	var digits = Math.pow(10, pos);
	var num = Math.floor(n * digits) / digits;
	return Number(num.toFixed(pos));
}
//지정자리 올림 (값, 자릿수)
function Ceiling (n, pos) {
	var digits = Math.pow(10, pos);
	var num = Math.ceil(n * digits) / digits;
	return Number(num.toFixed(pos));
}


/*
기간 조회
*/
function setSearchDate(term, startObj, endObj ) {
	var startDate;
	var dateNew = new Date();
	var endDate;
	let endDt = $("#" + endObj ).val().replaceAll('-', '') + '000000';
	if ($("#" + endObj ).val() == '') {
		endDt = getCurrentTime();
	}
	if(term === "10") {
		startDate = shiftDate(endDt, 0, 0, 0, "-");
	} else if(term === "20") {
		startDate = shiftDate(endDt, 0, 0, -6, "-");
	} else if(term === "30") {
		startDate = shiftDate(endDt, 0, 0, -14, "-");
	} else if(term === "40") {
		startDate = shiftDate(endDt, 0, -1, 0, "-");
	} else if(term === "50") {
		startDate = shiftDate(endDt, 0, -3, 0, "-");
	} else if(term === "60") {
		startDate = shiftDate(endDt, 0, 0, -2, "-");
	}

	if(term === "thisMonth") {
		var last_day = daysPerMonth(dateNew.getFullYear(), dateNew.getMonth()+1);
		endDate = shiftDate(getCurrentTime(), 0, 0, last_day-dateNew.getDate(), "-");
	} else if(term === ""){
		endDate = "";
	} else {
		endDate = toFormatString(endDt, "-");
	}

	$("#" + startObj ).val(startDate);
	$("#" + endObj ).val(endDate);
}

//3개월 기간조회시에만 호출하는 메소드
function setSearchDateThreeMonth(startObj,endObj) {
	let endDt = $("#" + endObj ).val().replaceAll('-', '') + '000000';
	if ($("#" + endObj ).val() == '') {
		endDt = getCurrentTime();
	}
	var endDate = toFormatString(endDt, "-");
	
	
	//시작 년,월,일
	var strtYear = endDt.substring(0,4)
	var strtMonth = endDt.substring(4,6) -3
	var strtDay = endDt.substring(6,8)
	
	//윤년 계산	
	if((strtYear % 4 == 0 && strtYear % 100 !=0) || strtYear % 400 == 0){ //윤년일때
		if(strtMonth == '9' && strtDay == '31' || strtMonth == '4' && strtDay == '31' || strtMonth == '2' && strtDay == '30'){
			strtDay = strtDay -1
		} else if(strtMonth == '2' && strtDay == '31'){
			strtDay = strtDay -2
		}
	}else{ //평년일때
		if(strtMonth == '9' && strtDay == '31' || strtMonth == '4' && strtDay == '31' || strtMonth == '2' && strtDay == '29'){
			strtDay = strtDay -1
		} else if(strtMonth == '2' && strtDay == '30'){
			strtDay = strtDay -2
		} else if(strtMonth == '2' && strtDay == '31'){
			strtDay = strtDay -3
		}
	} 
	
	
	
	var startDate = new Date(strtYear, strtMonth -1 , strtDay); //치환 전 시작날짜
	

	var year = startDate.getFullYear();
	var month = ('0' + (startDate.getMonth() + 1)).slice(-2);
	var day = ('0' + startDate.getDate()).slice(-2);

	//최종날짜
	var resultStartDate; //치환 후 시작날짜
	resultStartDate = year + '-' + month + '-' + day;
	
	
	$("#" + startObj ).val(resultStartDate);
	$("#" + endObj ).val(endDate);
}



function shift3MonthByEndDt(startObj, endObj ) {
	let term = "50";
	var startDate;
	var dateNew = new Date();
	var endDate;
	let endDt = '';
	let startDt = '';
	if ($("#" + startObj ).val() == undefined) {
		startDt = [startObj.slice(0, 4), startObj.slice(4,6), startObj.slice(6,8)].join('-');
	} else {
		startDt = $("#" + startObj ).val();
		
	}
	if ($("#" + endObj ).val() == undefined) {
		endDt = endObj + '000000';
	} else {
		endDt = $("#" + endObj ).val().replaceAll('-', '') + '000000';
		
	}	
	if ($("#" + endObj ).val() == '' || endObj == '') {
		endDt = getCurrentTime();
	}
	if(term === "50") {
		startDate = shiftDate(endDt, 0, -3, 0, "-");
	}
	endDate = toFormatString(endDt, "-");
	return new Date(startDt).getTime() - new Date(startDate).getTime() < 0 ? false : true;
	
}

/**
 * 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴

 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 00:00 으로부터 100일 전 Time
 */
function shiftDate (time, y, m, d, dele ) { //moveTime(time,y,m,d)
	var date = toDateObject(time);
	if (m == -1 || m == -3) {
		if (m == -3) {
			date = new Date(time.substr(0,4), time.substr(4,2) - 3, time.substr(6,2));
		}
		let dDate = date.getDate();
		if (daysPerMonth(date.getFullYear(), date.getMonth()) <= dDate) {
			dDate = daysPerMonth(date.getFullYear(), date.getMonth());
		}
		let dMonth = date.getMonth();
		let dYear = date.getFullYear();
		if (("" + dMonth).length == 1) { dMonth = "0" + dMonth; }
		if (("" + dDate).length == 1) { dDate = "0" + dDate; }
		if (dMonth == '00') {
			dMonth = '12';
			dYear = dYear - 1;
		}
		return dYear + '-' + dMonth + '-' + dDate;
	}
	date.setFullYear(date.getFullYear() + y);	//y년을 더함
	date.setMonth(date.getMonth() + m);			//m월을 더함
	date.setDate(date.getDate() + d);			//d일을 더함
	return toDateString(date, dele);
}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toDateObject (time ) { //parseTime(time)
	var year  = time.substr(0,4);
	var month = time.substr(4,2) - 1; // 1월=0,12월=11
	var day   = time.substr(6,2);
	return new Date(year,month,day);
}

/**
 * 현재 시각을 Time 형식으로 리턴

 */
function getCurrentTime () {
	return toTimeString(new Date(), 'N' );
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString (date, secondYn ) { //formatTime(date)
	var year  = date.getFullYear();
	var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day   = date.getDate();
	var hour  = date.getHours();
	var min   = date.getMinutes();
	var second = date.getSeconds();

	if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length == 1) { day   = "0" + day;   }
	if (("" + hour).length == 1) { hour  = "0" + hour;  }
	if (("" + min).length == 1) { min   = "0" + min;   }
	if (("" + second).length == 1) { second   = "0" + second;   }

	if ( secondYn === 'Y' ) {
		return ("" + year + month + day + hour + min + second);
	} else {
		return ("" + year + month + day + hour + min);
	}
}

/*
윤달 포함 달별 일수 Return
*/
function daysPerMonth ()
{
	var DOMonth  = ["31","28","31","30","31","30","31","31","30","31","30","31"];
	var IDOMonth = ["31","29","31","30","31","30","31","31","30","31","30","31"];

	if(arguments[1] === 0) arguments[1] = 12;

	if ( (arguments[0]%4) == 0 ) {
		if ( (arguments[0]%100) == 0 && (arguments[0]%400) != 0 )
			return DOMonth[arguments[1]-1];
		return IDOMonth[arguments[1]-1];
	} else {
		return DOMonth[arguments[1]-1];
	}
}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toFormatString (time, dele ) { //parseTime(time)
	var year  = time.substr(0,4);
	var month = time.substr(4,2); // 1월=0,12월=11
	var day   = time.substr(6,2);

	return ("" + year + dele + month + dele + day)
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toDateString(date, dele) { //formatTime(date)
	var year  = date.getFullYear();
	var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day   = date.getDate();

	if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length == 1) { day   = "0" + day;   }

	return ("" + year + dele + month + dele + day)
}

function getDateStr (objId ) {
	var date = ''
	if(typeof $("#"+objId+"Dt").val() != 'undefined') {
		date = $("#"+objId+"Dt").val();
	}

	if(typeof $("#"+objId+"Hr option:selected").val() != 'undefined') {
		date += " " + $("#"+objId+"Hr option:selected").val();
	}

	if(typeof $("#"+objId+"Mn option:selected").val() != 'undefined') {
		date += ":" + $("#"+objId+"Mn option:selected").val();
	}

	if(typeof $("#"+objId+"Sec").val() != 'undefined') {
		date += ":" + $("#"+objId+"Sec").val();
	}

	return date;
}

/**
 * 두 날짜 사이의 개월수(윤년 포함)
 * @param start(yyyymmdd)
 * @param end(yyyymmdd)
 * isLeapYear(year)
 * getDifDays(start, end)
 * @returns
 */
function getDiffMonths(start, end) {
	var startYear = start.substring(0, 4);
	var endYear = end.substring(0, 4);
	var startMonth = start.substring(4, 6) - 1;
	var endMonth = end.substring(4, 6) - 1;
	var startDay = start.substring(6, 8);

	// 연도 차이가 나는 경우
	if (eval(startYear) > eval(endYear)) {

		// 종료일 월이 시작일 월보다 수치로 빠른 경우
		if (eval(startMonth) > eval(endMonth)) {
			var newEnd = startYear + "1231";
			var newStart1 = endYear + "0101";

			return (eval(getDiffMonths(start, newEnd)) + eval(getDiffMonths(newStart1, end))).toFixed(2);
		// 종료일 월이 시작일 월보다 수치로 같거나 늦은 경우
		} else {
			var formMonth = eval(startMonth) + 1;
			if (eval(formMonth) < 10) formMonth = "0" + formMonth;

			var newStart2 = endYear + "" + formMonth + "" + startDay;
			var addMonths = (eval(endYear) - eval(startYear)) * 12;

			return (eval(addMonths) + eval(getDiffMonths(newStart2, end))).toFixed(2);
		}
	} else {
	// 월별 일수차 (30일 기준 차이 일수)
		var difDaysOnMonth = [1, -2, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1];
		var difDaysTotal = getDifDays(start, end);

		for (var i = startMonth; i < endMonth; i++) {
			if (i == 1 && isLeapYear(startYear)) {
				difDaysTotal -= (difDaysOnMonth[i] + 1);
			} else {
				difDaysTotal -= difDaysOnMonth[i];
			}
		}

		return (difDaysTotal / 30).toFixed(2);
	}
}

function isLeapYear(year) {
	// parameter가 숫자가 아니면 false
	if (isNaN(year)) {
		return false;
	} else {
		var nYear = eval(year);
	}

	// 4로 나누어지고 100으로 나누어지지 않으며 400으로는 나눠지면 true(윤년)
	if (nYear % 4 == 0 && nYear % 100 != 0 || nYear % 400 == 0) {
		return true;
	} else {
		return false;
	}
}

function getDifDays(start, end) {
	var dateStart = new Date(start.substring(0, 4), start.substring(4, 6) - 1, start.substring(6, 8));
	var dateEnd = new Date(end.substring(0, 4), end.substring(4, 6) - 1, end.substring(6, 8));
	var difDays = (dateEnd.getTime() - dateStart.getTime()) / (24 * 60 * 60 * 1000);

	return Math.ceil(difDays);
}

function compareDateForDefault(date1, date2, defaultStart, defaultEnd, type) {
	var startDate = $('#' + date1).val();
	var endDate = $('#' + date2).val();
    var startArray = startDate.split('-');
    var endArray = endDate.split('-');
    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2]);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2]);
    var defaultStart = defaultStart != undefined ? defaultStart : $('#' + date2).val();
    var defaultEnd = defaultEnd != undefined ? defaultEnd : $('#' + date1).val();

    if(type === "start"){
	    if(start_date.getTime() > end_date.getTime()) {
    		messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
    			$('#' + date1).val(defaultStart);
    		});
	    }
    }else{
    	 if(end_date.getTime() < start_date.getTime()) {
	    	messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
	    		$('#' + date2).val(defaultEnd);
	    	});
	    }
    }

}

function compareDate(date1, date2) {
	var startDate = $('#' + date1).val();
	var endDate = $('#' + date2).val();
    var startArray = startDate.split('-');
    var endArray = endDate.split('-');
    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2]);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2]);
    
    if(start_date.getTime() > end_date.getTime()) {
    	messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
	        $('#' + date1).val($('#' + date2).val());
        });
    }

}

function compareDate2(date1, date2) {
	var startDate = $('#' + date1).val();
	var endDate = $('#' + date2).val();
    var startArray = startDate.split('-');
    var endArray = endDate.split('-');
    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2]);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2]);

    if(end_date.getTime() < start_date.getTime()) {
    	messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
    		$('#' + date2).val($('#' + date1).val());
    	});
    }
}


function compareDateTime(startDate, endDate, startHr, startMn, endHr, endMn) {
	startDate = $('#' + startDate).val();
	endDate = $('#' + endDate).val();
	startHr = $('#' + startHr).val();
	startMn = $('#' + startMn).val();
	endHr = $('#' + endHr).val();
	endMn = $('#' + endMn).val();

    var startArray = startDate.split('-');
    var endArray = endDate.split('-');

    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2], startHr, startMn);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2], endHr, endMn);

    if(start_date.getTime() > end_date.getTime()) {
        messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info");
        return false;
    }

    return true;
}

function byteCheck(msgbox, smsBytes) {

	var conts = document.getElementById(msgbox);
	var bytes = document.getElementById(smsBytes);

	var cnt = 0;
	var exceed = 0;
	var ch = '';

	for (var j=0; j<conts.value.length; j++) {
		ch = conts.value.charAt(j);
		if (escape(ch).length > 4) {
			cnt += 2;
		} else {
			cnt += 1;
		}
	}

	bytes.innerHTML = cnt;

	if (cnt > 80) {
		exceed = cnt - 80;
		messager.alert('메시지 내용은 80바이트를 넘을수 없습니다.<br><br>작성하신 메세지 내용은 '+ exceed +'byte가 초과되었습니다.<br><br>초과된 부분은 자동으로 삭제됩니다.', "Info", "", function(){
			var tcnt = 0;
			var xcnt = 0;
			var tmp = conts.value;
			for (var i=0; i<tmp.length; i++) {
				ch = tmp.charAt(i);
				if (escape(ch).length > 4) {
					tcnt += 2;
				} else {
					tcnt += 1;
				}

				if (tcnt > 80) {
					tmp = tmp.substring(0,i);
					break;
				} else {
					xcnt = tcnt;
				}
			}
			conts.value = tmp;
			bytes.innerHTML = xcnt;

			return;
		});
	}
}

//월의 마지막 날짜 가져오기
function getLastDay(year, month) {
	var date = new Date(year, month, 0);
	return date.getDate();
}

//지난달 날짜 가져오기("Y"면, 지난달의 1일, "" 이면 지난달의 마지막 날짜)
function f_today(flag){
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth(); // 0부터 시작하므로 1더함 더함
	if (("" + month).length == 1) { month = "0" + month; }
	if(month ===0){
		month= "12";
		year = year-1;
	}
	if(flag ==="Y"){
		return "" + year + "-" + month + "-" +"01";
	} else {
		return "" + year + month+ getLastDay(year,month);
	}
}

var tag = {
		/*
		 * 상품 이미지
		 */
		goodsImage : function(imgDomain, goodsId, imgPath , seq, gb, width, height, cls){
			if(gb == null){
				gb = "";
			}

			if(cls == null){
				cls = "";
			}

			if(imgPath == null){
				imgPath = "";
			}

			var ext  = imgPath.substr(imgPath.lastIndexOf(".") , imgPath.length);

			//var	src = imgDomain + "/goods/" + goodsId + "/" + goodsId + "_" + seq + gb + "_" + width + "x" + height + ext;
			var	src = imgDomain + imgPath?imgPath:("/goods/" + goodsId + "/" + goodsId + "_" + seq + ext);
			var imageStr = "";
			var onError = "/images/noimage.png";

			imageStr = "<img src=\""+src+"\" class=\""+cls+"\" onerror='this.src=\""+onError+"\"'  />";

			return imageStr;
		}
	};

// ex) onkeyup="korNumOnly($(this));"
function korNumOnly(arg){
	if ($('#' + $(arg).attr("id")).val() != null) {
		$('#' + $(arg).attr("id")).val($('#' + $(arg).attr("id")).val().replace(/([^ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9])/g, ''));
	}
}

function engNumOnly(arg){
	if ($('#' + $(arg).attr("id")).val() != null) {
		$('#' + $(arg).attr("id")).val($('#' + $(arg).attr("id")).val().replace(/([^a-zA-Z0-9])/g, ''));
	}
}

// 에디터 내용 필수 체크 - ex) if( !editorRequired( "content", "bottomRight:-250,250", "내용은 필수 입력입니다."  ) ){ return false };
// subId 사용 시 원하는 위치에 subId 추가하여 사용.
function editorRequired( id, showArrow, msg ){
	var customId = id + "custom"
	if( $( "#" + id ).val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() === "" ) {	// 공백일 경우
		$( "#" + customId ).remove();
		$( "#" + id ).parent().prepend('<span id="'+customId+'"></span>');
		$( "#" + customId ).validationEngine('showPrompt', ( msg == null ? '* 내용을 입력해주세요.' : msg ) , 'error', ( showArrow == null ? true : showArrow ) );

		return false;
	}else{
		$( "#" + customId ).validationEngine('hide');
		$( "#" + customId ).remove();
		return true;
	}
}

function setDefaultIfNull(target, def){
	return target || def;
}

function logger(gb){
	if (gb === "prd"){
		window['console']['log'] = function() {};
		window['console']['debug'] = function() {};
	}
}

var logger2 = function() {
    var oldConsoleLog = null;
    var oldConsoleDebug = null;
    var pub = {};
    pub.enableLogger = function enableLogger() {
        if (oldConsoleLog == null)
            return;
        window['console']['log'] = oldConsoleLog;
    };
    pub.disableLogger = function disableLogger() {
        oldConsoleLog = console.log;
        window['console']['log'] = function() {};
    };
    pub.enableDebugger = function enableDebugger() {
        if (oldConsoleDebug == null)
            return;
        window['console']['debug'] = oldConsoleDebug;
    };
    pub.disableDebugger = function disableDebugger() {
    	oldConsoleDebug = console.debug;
        window['console']['debug'] = function() {};
    };
    return pub;
}();

/**
 * @function Name : pswdValid
 * @function Desc : 비밀번호 유효성검사
 * @작성일 : 2020.02.28
 * @작성자 : 김진홍
 * @변경이력 : 이름 : 일자 : 근거자료 : 변경내용
 *       --------------------------------------------------------------------------------
 *       김진홍 : 2020. 02. 28 : : 신규(삼성 password 생성규칙 적용)
 * 예) 2개 문자 종류 조합 시 최소 10자리 이상
 *     3개 이상 문자 조합 시 최소 8자리 이상
 *     동일 또는 연속적인 숫자나 문자(4자리 이상), 생일, 전화번호 사용 제한
 *     단순 패스워드 기준은 8자 미만, 영 숫자 미혼용 등
 */
var pswdValid = {
	pswdRegex1 : /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{8,50}$/	//3개 이상 문자 조합 시 최소 8자리 이상
	, numRegex : /[0-9]/
	, enRegex : /[a-zA-Z]/
	, specialRegex : /[!@#$%^~*+=-]/
	, number : "0123456789"
	, lowerCase : "abcdefghijklmnopqrstuvwxyz"
	, upperCase : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	, checkPswd : function(pswd){
		//3개 이상 문자 조합 시 최소 8자리 이상
		//2개 문자 종류 조합 시 최소 10자리 이상
		if(!this.checkPswdRegex1(pswd) && !this.checkPswdRegex2(pswd)){
			return false;
		}
		return true;
	}
	, checkPswdRegex1 : function(pswd){
		//3개 이상 문자 조합 시 최소 8자리 이상
		if(!this.checkSpace(pswd)){
			return false;
		}
		
		if(!this.pswdRegex1.test(pswd)){
			return false;
		}
		return true;
	}
	, checkPswdRegex2 : function(pswd){
		//2개 문자 종류 조합 시 최소 10자리 이상
		if(!this.checkSpace(pswd)){
			return false;
		}
		
		var matchCnt = 0;
		if(pswd.length < 10 || pswd.length > 50){
			return false;
		}

		if(this.numRegex.test(pswd)){
			matchCnt++;
		}

		if(this.enRegex.test(pswd)){
			matchCnt++;
		}

		if(this.specialRegex.test(pswd)){
			matchCnt++;
		}

		if(matchCnt < 2){
			return false;
		}

		return true;
	}
	, checkSimplePswd : function(pswd){
		//단순 패스워드 기준은 8자 미만, 영 숫자 미혼용 등
		//8자 미만
		if(pswd.length >= 8){
			return false;
		}
		//숫자 X, 문자 X
		if(!this.numRegex.test(pswd) && !this.enRegex.test(pswd)){
			return false;
		}

		//숫자 O, 문자 O
		if(this.numRegex.test(pswd) && this.enRegex.test(pswd)){
			return false;
		}

		return true;
	}
	/**
	 * 비밀번호 3자리 연속, 반복된 문자, 숫자 체크
	 * @param pswd
	 */
	, checkPswdMatch : function(pswd){
		//연속 문자 체크
		for(var i=0; i<this.number.length-3; i++){
			if(pswd.indexOf(this.number.substring(i,i+3)) > -1 || pswd.indexOf(this.reverse(this.number).substring(i,i+3)) >-1){
				return false;
			}
		}
		for(var j=0; j<this.lowerCase.length-3; j++){
			if(pswd.indexOf(this.lowerCase.substring(j,j+3)) >-1 || pswd.indexOf(this.reverse(this.lowerCase).substring(j,j+3)) >-1){
				return false;
			}
		}
		for(var k=0; k<this.upperCase.length-3; k++){
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
	, checkSpace : function(str) {
		//공백 체크
		if(str.search(/\s/) !== -1) {
			return false;
		} else {
			return true;
		}
	}
	, reverse : function(str){
		return str.split("").reverse().join("");
	}
};

/* <frame:gridSelect -> codeData : "key1:value1;key2:value2;key3:value3;"
* key : key1
* return : value1
* */
function getCodeValue(codeData, key){

	if(codeData == null || key == null){
		return "";
	}

	var data = codeData.split(";");
	for(var i in data){
		var codeArr = data[i].split(":");
		if(codeArr.length === 2){
			if(codeArr[0] == key){
				return codeArr[1];
			}
		}
	}

	return "";
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
			return messager.alert("주소를 확인후 다시 시도 바랍니다.", "Info", "info");
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

// apet 사용 정규식
var regExp = {
	login_id : /^[a-z0-9A-Z\d]{6,15}$/
	, name : /^([a-zA-Z0-9]{3,50})|([가-힣]{2,25})$/
	, tel : /^0[2|31|32|33|41|42|43|44|51|52|53|54|55|61|62|63]{1,2}\d{7,8}$/
	, mobile : /^01([0|1|6|7|8|9])(\d{7,8})$/
	, email : /^[^\sㄱ-ㅎㅏ-ㅣ가-힣]*@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
	, url : /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/
	, url_website : /^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/
	, onlyNum : /^[0-9\ ]+$/
	, bizNo : /^\d{3}-?\d{2}-?\d{5}$/
	, acct : /^[0-9-]+$/  // 계좌번호
	, birth : /^(19\d{2}|20\d{2})(0\d|1[0-2])(0\d|[1-2]\d|3[0-1])$/
	, numRegex : /[0-9]/
	, enRegex : /[a-zA-Z]/
	, specialRegex : /[!@#$%^~*+=-]/
	, number : "0123456789"
	, lowerCase : "abcdefghijklmnopqrstuvwxyz"
	, upperCase : "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
};

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
				messager.alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.", "Info", "info");
			}
			regex_plus = new RegExp( "\\+" + sqlArray[i] + "\\+","gi") ;
			if (regex_plus.test(obj.value)) {
				obj =obj.replace(regex_plus, "");
				messager.alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.", "Info", "info");
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
			confmKey : _JUSO_CONFMKEY, <!-- 신청시 발급받은 승인키 -->
			resultType : 4, <!-- 도로명주소 검색결과 화면 출력유형 1 : 도로명, 2 : 도로명+지번+상세보기(관련지번, 관할주민센터), 3 : 도로명+상세보기(상세건물명), 4 : 도로명+지번+상세보기(관련지번, 관할주민센터, 상세건물명) -->
			currentPage : 1, <!-- 현재 페이지 번호 -->
			countPerPage : 100, <!-- 페이지당 출력할 결과 Row 수 -->
			resultType : "json", <!-- 검색결과형식 설정(xml, json) -->
			keyword : $("#"+targetId).val()
		}
		, async:false
		, crossDomain:true
		, callBack : function(jsonStr) {
			var errCode = jsonStr.results.common.errorCode;
			var errDesc = jsonStr.results.common.errorMessage;
			
			if(errCode != "0"){
				messager.alert(errDesc, "Info", "info");
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

/* 
 * 영상 업로드 result
code								Int	200 성공 , 나머지 코드는 message 컬럼 확인
message								String	서버 메세지 message
result								Array	결과값
result.contents.[].no				Int	VOD 고유 번호
result.contents.[].video_id			String	Video 아이디
result.contents.[].path				String	저장경로
result.contents.[].encoding_state	String	인코딩 상태 (SUCCESS|PROGRESSING|FAILED)
result.contents.[].videos	Array	인코딩 결과물
result.contents.[].thumb_url		String	자동생성된 썸네일 (PNG)
result.contents.[].thumb_video_url	String	자동생성된 비디오 썸네일 (MP4) 1~10초
result_cnt	Int	호출된 데이터 수
 * */
function vodUpload(obj, callBack){
	var fileVariable =$(obj).val();
	var ext = $(obj).val().split('.').pop().toLowerCase();
	if (fileVariable != "" && fileVariable != null) {
		if (extChk(obj, 'video')) {
			var fd = new FormData();
			var targetName = $(obj).attr('name');
			fd.append(targetName, obj.files[0]);
			fd.append('iv_key', sgrGenerate());
			fd.append('upload_field_name', targetName);
			fd.append('channel_id', _VOD_CHNL_ID_TV);
			fd.append('playlist_id',_VOD_GROUP_DEFAULT);
			
			waiting.start();
			$.ajax({
				type: 'POST',
				url: _VOD_UPLOAD_URL,
				data: fd,
				processData: false,
				contentType: false,
				dataType: 'json',
				success: function(data, status) {
					waiting.stop();
					if(data.code==200) {
						callBack(data.result, obj);
					} else {
						messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
					}
				},
				error: function(request,status,error) {
					waiting.stop();
					messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.", "Error", "error");
				}
			});
		}
	}
}

// VOD 채널 리스트
function vodChnlList(authKey, callBack) {
	var options = {
			url: _VOD_CHNL_LIST_URL
			, type : "POST"
			, dataType: 'json'
			, data : {
				iv_key : authKey
			}
			, callBack: function(data, status) {
				if(data.code==200) {
					callBack(data);
				} else {
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
				}
			}
		}
	ajax.call(options)
}

// VOD 그룹 리스트
function vodGroupList(option, callBack) {
	var options = {
			url: _VOD_GROUP_LIST_URL + option.channel_id
			, type : "POST"
			, dataType: 'json'
			, data : {
				iv_key : option.authKey
			}
			, callBack: function(data, status) {
				if(data.code==200) {
					callBack(data);
				} else {
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
				}
			}
		}
	ajax.call(options)
}

//VOD 리스트
function vodList(option, callBack) {
	var options = {
			url: _VOD_LIST_URL + option.channel_id
			, type : "POST"
			, dataType: 'json'
			, data : {
				iv_key : option.authKey
				, playlist_id : option.playlist_id
				, row_count : option.row_count
				, order_col : option.order_col
				, order_type : option.order_type
			}
			, callBack: function(data, status) {
				if(data.code==200) {
					callBack(data);
				} else {
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
				}
			}
		}
	ajax.call(options)
}

//VOD move
function vodMove(option, callBack) {
	var options = {
		url: _VOD_GROUP_MOVE_API_URL
		, type : "post"
		, dataType : "json"
		, data : {
			iv_key : option.authKey
			, channel_id : option.channel_id
			, playlist_id : option.playlist_id
			, video_id : option.video_id
		}
		, callBack : function(data, status) {
			callBack(data);
		}
	}

	ajax.call(options)
}

//VOD Info
function vodInfo(option, callBack) {
	$.ajax({
		type: 'POST',
		url: _VOD_INFO_URL + option.video_id,
		async: false,
		dataType: 'json',
		data : {
			iv_key : option.authKey
		},
		success: function(data) {
			if(data.code==200) {
				callBack(data.result);
			}else{
				messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
			}
		},
		error: function(request,status,error) {
			messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.", "Error", "error");
		}
	});
}

//VOD Group Add
function vodGroupAdd(option, callBack) {
	$.ajax({
		type: 'POST',
		url: _VOD_GROUP_ADD_URL,
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
				messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+data.code+"]["+data.message+"]", "Error", "error");
			}
		},
		error: function(request,status,error) {
			messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.", "Error", "error");
		}
	});
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
		messager.alert('[ ' + extArr.join(' / ') + ' ] 파일만 업로드 가능합니다.', 'Info', 'Info');
		$(obj).val(''); 
		return false;
	} else {
		return true;
	}
};

function sgrGenerate() {
	let result;
	$.ajax({
		type: 'POST',
		url: "/common/getSgrAk.do",
		async: false,
		success: function(data) {
			result = data;
		},
		error: function(request,status,error) {
			messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.", "Error", "error");
		}
	});
	return result;
}


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

$(function(){
	// Number 타입 숫자만 입력 가능 하도록 이벤트 설정 
	$('.inputTypeNum').on('keyup keypress blur change',function(event){
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	    let name = $(this).attr('name');
	    if (event.type == 'blur') {
	    	if ($(this).attr('name').indexOf('From') > -1) {
	    		name = name.split('From')[0];
	    		if ($(this).val() != '' && $('input[name=' + name + 'To]').val() != '') {
	    			if ($(this).val() * 1 > $('input[name=' + name + 'To]').val() * 1) {
	    				messager.alert("시작 값이 종료 값보다 작거나 같아야 합니다.", "Info", "info", function(){
	    					let fromVal = $('input[name=' + name + 'To]').val() * 1 - 1 < 0 ? 0 : $('input[name=' + name + 'To]').val() * 1 - 1;
	    					$('input[name=' + name + 'From]').val(fromVal);
	    		        });
	    			}
	    		}
	    	}
	    	if ($(this).attr('name').indexOf('To') > -1) {
	    		name = name.split('To')[0];
	    		if ($(this).val() != '' && $('input[name=' + name + 'From]').val() != '') {
	    			if ($(this).val() * 1 < $('input[name=' + name + 'From]').val() * 1) {
	    				messager.alert("종료 값이 시작 값보다 크거나 같아야 합니다.", "Info", "info", function(){
	    					$('input[name=' + name + 'To]').val($('input[name=' + name + 'From]').val() * 1 + 1);
	    		        });
	    			}
	    		}
	    	}
	    	
	    }
	});
});

function xssCheck(str, level) {
	if(str){
	    if (level == undefined || level == 0) {
	        str = str.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g,"");
	    } else if (level != undefined && level == 1) {
	        str = str.replace(/\</g, "&lt;");
	        str = str.replace(/\>/g, "&gt;");
	    }
	}
    return str;
}

//오늘보다 과거 일자 허용할지 안할지
function setCommonDatePickerEvent(strtSelector,endSelector,isPast){
	if(isPast == undefined){
		isPast = false;
	}
	$(strtSelector).data("origin",$(strtSelector).val());
	$(endSelector).data("origin",$(endSelector).val());

	var $datepicker = $(strtSelector + "," + endSelector);

	$datepicker.bind("change",function(){
		var strtDate = $(strtSelector).val();
		var endDate = $(endSelector).val();

		var limitDays = 3;
		var diff = getDiffMonths(strtDate.replace(/-/g,''),endDate.replace(/-/g,''));
		
		/*
		var diffToday = new Date(strtDate).getTime() - new Date(new Date().format("yyyy-MM-dd")).getTime();
		if(isPast && diffToday<0){
			if($(".window-mask").length == 1){
				messager.alert("오늘날짜보다 작은 날짜 안 됨 -> 문구 확인 필요 ","Info","Info",function(){
					$(strtSelector).val($(strtSelector).data("origin"));
					$(endSelector).val($(endSelector).data("origin"));
				});
			}
		}
		*/
		
		if(diff>limitDays){
			messager.alert("기간 선택범위를 3개월 이내로 선택해주세요.","Info","info",function(){
				$(strtSelector).val($(strtSelector).data("origin"));
				$(endSelector).val($(endSelector).data("origin"));
			});
		}else if(diff<0){
			messager.alert("종료날짜보다 시작날짜가 작아야합니다.","Info","info",function(){
				$(strtSelector).val($(strtSelector).data("origin"));
				$(endSelector).val($(endSelector).data("origin"));
			});
		}else{
			//날짜 변경 시 , 선택 된 날짜 아닌 다른 날짜로 변경 시 퀵버튼 - '기간 선택'으로
			if($(strtSelector).data("origin") != "" && $(endSelector).data("origin") != ""){
				if(strtDate != $(strtSelector).data("origin") || endDate != $(endSelector).data("origin")){
					$("#checkOptDate").children("option:selected").prop("selected",false);
					$("#checkOptDate").children("option").eq(0).prop("selected",true);
				}
			}

			$(strtSelector).data("origin",strtDate);
			$(endSelector).data("origin",endDate);
		}
	});
}
//검색버튼 click이후에 alert창 띄우기 
function compareDateAlert(strtSelector,endSelector,term){
	
	var startDate = $('#' + strtSelector).val();
	var endDate = $('#' + endSelector).val();
    var startArray = startDate.split('-');
    var endArray = endDate.split('-');
    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2]);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2]);
    var term = $("#checkOptDate").children("option:selected").val();
    
    //시작 날짜가 종료날짜보다 클때 
    if(start_date.getTime() > end_date.getTime()) {
    	messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
	        $('#' + strtSelector).val($('#' + endSelector).val());
        });
    }
    
    //시작날짜, 종료날짜 둘다 값이 없을때 , 시작날짜 종료날짜 둘다 값이 있을때
    if(startDate == "" && endDate != ""){
    	messager.alert("시작날짜를 선택해주세요.", "Info", "info");
    } else if(startDate != "" && endDate == ""){
    	messager.alert("종료날짜를 선택해주세요.", "Info", "info");
    }

	//3개월 이상으로 기간 설정 했을때 
	var searchStDate = $('#' + strtSelector).val().replace(/-/gi, ""); 
	var searchEnDate = $('#' + endSelector).val().replace(/-/gi, "");
	var diffMonths = getDiffMonths(searchStDate, searchEnDate);

/*
 * 
 * [[조건]]
	옵션이 3개월이고
	시작일 종료일 차가 3이 넘고
	5월 31일 등 (특정한 날짜 ...) 로 끝나지 않을때
	"기간 선택범위를 3개월이내로 선택해주세요."
 */	
	if((eval(diffMonths) > 3 && term == '') || (term == '50' && eval(diffMonths) > 3.0 && (searchEnDate.endsWith('0531') == false && searchEnDate.endsWith('0530') == false  && searchEnDate.endsWith('0529') == false  && searchEnDate.endsWith('1231') == false && searchEnDate.endsWith('0731') == false ))){
		messager.alert("기간 선택범위를 3개월이내로 선택해주세요.","info","info");
	}
return true
}

//검색버튼 click이후에 alert창 띄우기 
function compareDateAlertOptions(strtSelector,endSelector,term){
    var returnFlag = false;
    var startDate = $('#' + strtSelector).val();
    var endDate = $('#' + endSelector).val();
    var startArray = startDate.split('-');
    var endArray = endDate.split('-');
    var start_date = new Date(startArray[0], startArray[1] - 1, startArray[2]);
    var end_date = new Date(endArray[0], endArray[1] - 1, endArray[2]);
    var term = $('#'+term).children("option:selected").val();
   
    //시작 날짜가 종료날짜보다 클때 
    if(start_date.getTime() > end_date.getTime()) {
        messager.alert("종료날짜보다 시작날짜가 작아야합니다.", "Info", "info", function(){
            $('#' + strtSelector).val($('#' + endSelector).val());
        	returnFlag = true;
        });
    }
    
    //시작날짜, 종료날짜 둘다 값이 없을때 , 시작날짜 종료날짜 둘다 값이 있을때
    if(startDate == "" && endDate != ""){
    	messager.alert("시작날짜를 선택해주세요.", "Info", "info");
    	returnFlag = true;
    } else if(startDate != "" && endDate == ""){
        messager.alert("종료날짜를 선택해주세요.", "Info", "info");
    	returnFlag = true;
    }

 

    //3개월 이상으로 기간 설정 했을때 
    var searchStDate = $('#' + strtSelector).val().replace(/-/gi, ""); 
    var searchEnDate = $('#' + endSelector).val().replace(/-/gi, "");
    var diffMonths = getDiffMonths(searchStDate, searchEnDate);

/*
 * 
 * [[조건]]
    옵션이 3개월이고
    시작일 종료일 차가 3이 넘고
    5월 31일 등 (특정한 날짜 ...) 로 끝나지 않을때
    "기간 선택범위를 3개월이내로 선택해주세요."
 */    
    if((eval(diffMonths) > 3 && term == '') || (term == '50' && eval(diffMonths) > 3.0 && (searchEnDate.endsWith('0531') == false && searchEnDate.endsWith('0530') == false  && searchEnDate.endsWith('0529') == false  && searchEnDate.endsWith('1231') == false && searchEnDate.endsWith('0731') == false ))){
        messager.alert("기간 선택범위를 3개월이내로 선택해주세요.","info","info");
    	returnFlag = true;
    }
    return returnFlag;
}
//08-13 재조회(grid.reload) 추가
function gridReload(strtSelector,endSelector,gridName,term,options){
	
	var startDate = $('#' + strtSelector).val();
	var endDate = $('#' + endSelector).val();	
	
	var dispStrtDtm = $('#' + strtSelector).val().replace(/-/gi, "");
	var dispEndDtm = $('#' + endSelector).val().replace(/-/gi, "");
	var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
	
	var term = $("#checkOptDate").children("option:selected").val();
	
	if((startDate != "" && endDate != "") || (startDate == "" && endDate == "")){ //시작일 종료일 둘다없거나 있을때는 검색 되어야함.
		if((term =='50' && dispEndDtm.endsWith('0531')) || (term =='50' && dispEndDtm.endsWith('0530')) || (term =='50' && dispEndDtm.endsWith('0529')) ||(term =='50' && dispEndDtm.endsWith('1231')) || (term =='50' && dispEndDtm.endsWith('0731')) || diffMonths <= 3){ //3개월일때 말일이 다음과 같이 끝날때는 3개월이 초과되더라도 검색이 되어야한다.
		grid.reload(gridName, options);
		}
	}
}
function gridReloadVariableTerm(strtSelector,endSelector,gridName,term,options){
    var returnFlag = false;
	var startDate = $('#' + strtSelector).val();
	var endDate = $('#' + endSelector).val();	
	
	var dispStrtDtm = $('#' + strtSelector).val().replace(/-/gi, "");
	var dispEndDtm = $('#' + endSelector).val().replace(/-/gi, "");
	var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
	
	var term = $('#'+term).children("option:selected").val();
	
	if((startDate != "" && endDate != "") || (startDate == "" && endDate == "")){ //시작일 종료일 둘다없거나 있을때는 검색 되어야함.
		if((term =='50' && dispEndDtm.endsWith('0531')) || (term =='50' && dispEndDtm.endsWith('0530')) || (term =='50' && dispEndDtm.endsWith('0529')) ||(term =='50' && dispEndDtm.endsWith('1231')) || (term =='50' && dispEndDtm.endsWith('0731')) || diffMonths <= 3){ //3개월일때 말일이 다음과 같이 끝날때는 3개월이 초과되더라도 검색이 되어야한다.
			grid.reload(gridName, options);
			returnFlag = true;
		}
	}
	return returnFlag;
}
// 08-06 데이트피커 기본 
function newSetCommonDatePickerEvent(strtSelector,endSelector){
	$(strtSelector).data("origin",$(strtSelector).val());
	$(endSelector).data("origin",$(endSelector).val());

	var $datepicker = $(strtSelector + "," + endSelector);

	
	$datepicker.on("change",function(){
		var strtDate = $(strtSelector).val();
		var endDate = $(endSelector).val();

		//날짜 변경 시 , 선택 된 날짜 아닌 다른 날짜로 변경 시 퀵버튼 - '기간 선택'으로
		if($(strtSelector).data("origin") != "" && $(endSelector).data("origin") != "" ||(strtDate != $(strtSelector).data("origin") || endDate != $(endSelector).data("origin"))){
				$("#checkOptDate").children("option:selected").prop("selected",false);
				$("#checkOptDate").children("option").eq(0).prop("selected",true);
		}
		$(strtSelector).data("origin",strtDate);
		$(endSelector).data("origin",endDate);		
	});
}
// 08-17 셀렉트 박스가 여러개인 경우 구분
function newSetCommonDatePickerEventOptions(strtSelector,endSelector,option){
	$(strtSelector).data("origin",$(strtSelector).val());
	$(endSelector).data("origin",$(endSelector).val());
	
	var $datepicker = $(strtSelector + "," + endSelector);
	
	
	$datepicker.on("change",function(){
		var strtDate = $(strtSelector).val();
		var endDate = $(endSelector).val();
		
		//날짜 변경 시 , 선택 된 날짜 아닌 다른 날짜로 변경 시 퀵버튼 - '기간 선택'으로
		if($(strtSelector).data("origin") != "" && $(endSelector).data("origin") != "" ||(strtDate != $(strtSelector).data("origin") || endDate != $(endSelector).data("origin"))){
			$(option).children("option:selected").prop("selected",false);
			$(option).children("option").eq(0).prop("selected",true);
		}
		$(strtSelector).data("origin",strtDate);
		$(endSelector).data("origin",endDate);		
	})
}


function dateCheck(strtSelector, endSelector){
		var limitDays = 3;
		var diff = getDiffMonths(strtSelector.replace(/-/g,''),endSelector.replace(/-/g,''));

		if(diff>limitDays){
			messager.alert("기간 선택범위를 3개월로 선택해 주세요","Info","info",function(){
				return true;
			});
			return true;
		}else if(diff<0){
			messager.alert("종료일이 시작일보다 크게 선택해 주세요.","Info","info",function(){
				return true;
			});
			return true;
		}else{
			return false;
		}
}

function fileAllDownload(targetId, seq){
	var form = document.getElementById(targetId);
	form.setAttribute("action","/common/fileDownloadAll.do");
	form.setAttribute("target","_self");
	form.setAttribute("method","POST");

	//일괄 파일 다운로드 식별값이 필요할때(ex : DB 시퀀스 )
	if(seq != null){
		var input = document.createElement("input");
		input.setAttribute("type","hidden");
		input.setAttribute("name","seq");
		input.setAttribute("value",seq);
		form.append(input);
	}

	form.submit();
}