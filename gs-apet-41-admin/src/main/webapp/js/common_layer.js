var layerCompanyList = {
	option : {
		 callBack : undefined
		, multiSelect : false
	}
	,create : function (option) {
		$.extend(this.option, option);

		var options = {
			 url : _COMPANY_SEARCH_LAYER_URL
			,dataType : "html"
			,data : {
				compStatCd : option.compStatCd == null ? undefined : option.compStatCd	
				, readOnlyCompStatCd : option.readOnlyCompStatCd == null ? undefined : option.readOnlyCompStatCd
				, selectKeyOnlyCompStatCd : option.selectKeyOnlyCompStatCd == null ? undefined : option.selectKeyOnlyCompStatCd
				, excludeCompStatCd : option.excludeCompStatCd == null ? undefined : option.excludeCompStatCd
						
				, compTpCd : option.compTpCd == null ? undefined : option.compTpCd
				, readOnlyCompTpCd : option.readOnlyCompTpCd == null ? undefined : option.readOnlyCompTpCd
				, selectKeyOnlyCompTpCd : option.selectKeyOnlyCompTpCd == null ? undefined : option.selectKeyOnlyCompTpCd
				, excludeCompTpCd : option.excludeCompTpCd == null ? undefined : option.excludeCompTpCd
						
				, stId : option.stId == null ? undefined : option.stId
				, stIds : option.stIds == null ? undefined : option.stIds
			}
			,callBack : function(result) {
				var config = {
					 id : "layerCompanyView"
					,top : 100
					,width : 1200
					,height : 620
					,title : "업체 조회"
					,body : result
					,button : "<button type=\"button\" class=\"btn btn-ok\" onclick=\"layerCompanyList.confirm();\">확인</button>"
				}

				layer.create(config);
				layerCompanyList.grid();
			}
		}
		ajax.call(options);
	}
	,confirm : function() {
		var jsonArray = [];
		var grid = $("#layerCompanyList" );
		var rowids = null;
		if(layerCompanyList.option.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		layerCompanyList.option.callBack(jsonArray );
		layer.close("layerCompanyView");
	}
	,grid : function() {
		var baseColModels = {
			compBaseCols_1 : [
				 _GRID_COLUMNS.compNo_b
				,_GRID_COLUMNS.compNm
				, {name:"cisRegYn", label:_COMPANY_SEARCH_GRID_LABEL.cisRegYn, width:"100", align:"center", formatter:"select", editoptions:{value:_CIS_REG_YN}, sortable:false, hidden:true  } /* cis 등록여부 */
				, {name:"stIds", label:_COMPANY_SEARCH_GRID_LABEL.stIds, width:"100", align:"center", sortable:false, hidden:true } /* 사이트 아이디 */
				, {name:"stNms", label:_COMPANY_SEARCH_GRID_LABEL.stNms, width:"200", align:"center", sortable:false, hidden:true } /* 사이트 명 */
			],

			compBaseCols_2 : [
				  {name:"compStatCd", label:_COMPANY_SEARCH_GRID_LABEL.compStatCd, width:"90", align:"center", formatter:"select", editoptions:{value:_COMP_STAT_CD}, sortable:false}
				, {name:"compGbCd", label:_COMPANY_SEARCH_GRID_LABEL.compGbCd, width:"90", align:"center", formatter:"select", editoptions:{value:_COMP_GB_CD}, sortable:false}
				, {name:"compTpCd", label:_COMPANY_SEARCH_GRID_LABEL.compTpCd, width:"90", align:"center", formatter:"select", editoptions:{value:_COMP_TP_CD}, sortable:false}
			],

			compBaseCols_3 : [
				{name:"bizNo", label:_COMPANY_SEARCH_GRID_LABEL.bizNo, width:"120", align:"center", sortable:false}
				, {name:"ceoNm", label:_COMPANY_SEARCH_GRID_LABEL.ceoNm, width:"100", align:"center", sortable:false}
				, _GRID_COLUMNS.fax
				, _GRID_COLUMNS.tel
			],

			compBrandCols : [
				{name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"100", align:"center", sortable:false}
				, {name:"bndNmEn", label:_GOODS_SEARCH_GRID_LABEL.bndNmEn, width:"100", align:"center", sortable:false}
			],

			commonCols : [
				  _GRID_COLUMNS.sysRegrNm
				, _GRID_COLUMNS.sysRegDtm
				, _GRID_COLUMNS.sysUpdrNm
				, _GRID_COLUMNS.sysUpdDtm
			]
		};

		var gridColModels = baseColModels.compBaseCols_1;
//		gridColModels = gridColModels.concat(baseColModels.compBrandCols);
		gridColModels = gridColModels.concat(baseColModels.compBaseCols_2);
		gridColModels = gridColModels.concat(baseColModels.compBaseCols_3);
		gridColModels = gridColModels.concat(baseColModels.commonCols);

		var options = {
			url : _POPUP_COMPANY_GRID_URL
			, height : 200
			, searchParam : $("#layerCompanySearchForm").serializeJson()
			, colModels :gridColModels
			, multiselect : layerCompanyList.option.multiselect
		};
		grid.create("layerCompanyList", options);
	}
	,reload : function() {
		var options = {
			searchParam : $("#layerCompanySearchForm").serializeJson()
		};
		grid.reload("layerCompanyList", options);
	}
	,searchReset : function(defaultVal) {
		resetForm("layerCompanySearchForm");
		layerCompanyList.reload();
		/*$("#layerCompanySearchForm #showLowerCompany").val(defaultVal);
		$("#layerCompanySearchForm #showOnlyMainCompany").val('Y');*/
	}
}


//----------------------------------------------------------------------------------------------------------
//업체관리쪽에 업체검색 에서 쓰는 업체검색팝업
//----------------------------------------------------------------------------------------------------------
var companyMgtCompanyLayerOptions = {
		callBack : undefined
		, multiselect : false
	};
var companyMgtLayerCompanyList = {

	create : function (option) {
		$.extend(companyMgtCompanyLayerOptions, option);
		var options = {
			url : _COMPANY_SEARCH_LAYER_URL
			, dataType : "html"
			, data : {
				showLowerCompany : option.showLowerCompany == null ? undefined : option.showLowerCompany
			}
			, callBack : function(result) {
				var config = {
					id : "layerCompanyView"
					, top : 100
					, width : 1200
					, height : 800
					, title : "업체 조회"
					, body : result
					, button : "<button type=\"button\" onclick=\"companyMgtLayerCompanyList.confirm();\" class=\"btn btn-ok\">확인</button>"
				}
				layer.create(config);
				companyMgtLayerCompanyList.grid();
			}
		}
		ajax.call(options);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerCompanyList" );
		var rowids = null;
		if(companyMgtCompanyLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		companyMgtCompanyLayerOptions.callBack (jsonArray );
		layer.close("layerCompanyView");
	}
	, grid : function() {
		var options = {
			url : _POPUP_COMPANY_GRID_URL
			, height : 400
			, searchParam : $("#layerCompanySearchForm").serializeJson()
			, colModels : [
				{name:"compNo", label:_COMPANY_SEARCH_GRID_LABEL.compNo, width:"100", align:"center", formatter:'integer', classes:'pointer fontbold', sortable:false}
				, {name:"compNm", label:_COMPANY_SEARCH_GRID_LABEL.compNm, width:"150", align:"center", sortable:false}
				, {name:"bizNo", label:_COMPANY_SEARCH_GRID_LABEL.bizNo, width:"150", align:"center", sortable:false}
				, {name:"compStatCd", label:_COMPANY_SEARCH_GRID_LABEL.compStatCd, width:"100", align:"center", formatter:"select", editoptions:{value:_COMP_STAT_CD}, sortable:false}
				, {name:"ceoNm", label:_COMPANY_SEARCH_GRID_LABEL.ceoNm, width:"100", align:"center", sortable:false}
				, {name:"compGbCd", label:_COMPANY_SEARCH_GRID_LABEL.compGbCd, width:"100", align:"center", formatter:"select", editoptions:{value:_COMP_GB_CD}, sortable:false}
				, {name:"compTpCd", label:_COMPANY_SEARCH_GRID_LABEL.compTpCd, width:"100", align:"center", formatter:"select", editoptions:{value:_COMP_TP_CD}, sortable:false}
				, {name:"fax", label:_COMPANY_SEARCH_GRID_LABEL.fax, width:"150", align:"center", sortable:false}
				, {name:"tel", label:_COMPANY_SEARCH_GRID_LABEL.tel, width:"150", align:"center", sortable:false}
				, {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"120", align:"center", sortable:false}
				, {name:"bndNmEn", label:_GOODS_SEARCH_GRID_LABEL.bndNmEn, width:"120", align:"center", sortable:false}
				, {name:"sysRegrNm", label:_COMPANY_SEARCH_GRID_LABEL.sysRegrNm, width:"150", align:"center", sortable:false}
				, {name:"sysRegDtm", label:_COMPANY_SEARCH_GRID_LABEL.sysRegDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
				, {name:"sysUpdrNm", label:_COMPANY_SEARCH_GRID_LABEL.sysUpdrNm, width:"150", align:"center", sortable:false}
				, {name:"sysUpdDtm", label:_COMPANY_SEARCH_GRID_LABEL.sysUpdDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
			]
			, multiselect : companyMgtCompanyLayerOptions.multiselect
		};
		grid.create("layerCompanyList", options);
	}
	, reload : function () {
		var $form = $('#layerCompanySearchForm');
		$("<input></input>").attr({type:"hidden", id:"adminYn", name:"adminYn", value:"Y"}).appendTo($form);
		$("<input></input>").attr({type:"hidden", id:"searchCompanyGb",name:"searchCompanyGb", value:"UP"}).appendTo($form);

		var options = {
			searchParam : $("#layerCompanySearchForm").serializeJson()
		};
		grid.reload("layerCompanyList", options);
	}
	, searchReset : function () {
		resetForm("layerCompanySearchForm");
	}
}

//---------------------------------------------------------------------------------------------------------
var stLayerOptions = {
	callBack : undefined
	, multiselect : false
};
var layerStList = {
	create : function (data) {
		$.extend(stLayerOptions, data);
		var options = {
			url : _ST_SEARCH_LAYER_URL
			, dataType : "html"
			, callBack : function(result) {
				var config = {
					id : "layerStView"
					, top : 100
					, width : 1000
					, height : 750
					, title : "사이트 조회"
					, body : result
					, button : "<button type=\"button\" onclick=\"layerStList.confirm();\" class=\"btn btn-ok\">확인</button>"
				}
				layer.create(config);
				layerStList.grid();
			}
		}
		ajax.call(options );
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerStList" );
		var rowids = null;
		if(stLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		stLayerOptions.callBack (jsonArray );
		layer.close("layerStView");
	}
	, grid : function() {
		var options = {
			url : _ST_GRID_URL
			, height : 400
			, searchParam : $("#layerStSearchForm").serializeJson()
			, colModels : [
				{name:"stId", label:_ST_SEARCH_GRID_LABEL.stId, width:"100", align:"center", formatter:'integer', classes:'pointer fontbold'}
				, _GRID_COLUMNS.stNm
				, {name:"stUrl", label:_ST_SEARCH_GRID_LABEL.stUrl, width:"250", align:"center"}
				, {name:"stSht", label:_ST_SEARCH_GRID_LABEL.stSht, width:"150", align:"center"}
				, _GRID_COLUMNS.useYn
				, _GRID_COLUMNS.compNm
				, {name:"compStatCd", label:_ST_SEARCH_GRID_LABEL.compStatCd, width:"90", align:"center", formatter:"select", editoptions:{value:_COMP_STAT_CD } }
				, _GRID_COLUMNS.sysRegrNm
				, _GRID_COLUMNS.sysRegDtm
				, _GRID_COLUMNS.sysUpdrNm
				, _GRID_COLUMNS.sysUpdDtm
			]
			, multiselect : stLayerOptions.multiselect
		};
		grid.create("layerStList", options);
	}
	, reload : function () {
		var options = {
			searchParam : $("#layerStSearchForm").serializeJson()
		};
		grid.reload("layerStList", options);
	}
	, searchReset : function () {
		resetForm("layerStSearchForm");
		$("#layerStSearchForm #useYn").val('Y');
	}
}


//회원 목록 팝업 - 최신결제일자 순 210107 이지희
var memberLayerOptions = {
	callBack : undefined
	, multiselect : false
	, param : {}
};

var rowArr = [];
var layerMemberList = {
	create : function (data) {
		$.extend(memberLayerOptions, data);
		var options = {
			url : _MEMBER_SEARCH_LAYER_URL
			, dataType : "html"
			, data : memberLayerOptions.param
			, callBack : function(result) {
				var config = {
					id : "layerMemberView"
					, top : 100
					, width : 800
					, height : 600
					, title : "회원 목록 조회"
					, body : result
					, button : "<button type=\"button\" onclick=\"layerMemberList.confirm();\" class=\"btn btn-ok\">확인</button>"
				}
				layer.create(config);
				
				/*//처음에는 결제 날짜 안걸리고 다 나오게 하려고 추가 
				var gridParam = $("#layerMemberSearchForm").serializeJson();
	            delete gridParam.searchDtmStart;
	            delete gridParam.searchDtmEnd;
	            */
				layerMemberList.grid();
				
			}
		}
		ajax.call(options );
	}
	, confirm : function () {
		
		var jsonArray = [];
		var grid = $("#layerMemberList" );
		var rowids = null;
		if(memberLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			rowArr = [];
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
				rowArr.push(rowids[i]);
//				rowArr.push(grid.jqGrid("getCell" , rowids[i] , "mbrNo"));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
			rowArr.push(rowids)
		}
		$("#layerMemberList").jqGrid("resetSelection");
		
		
		if(jsonArray.length == 0 ){
			messager.alert("수신대상자를 선택해 주세요.", "Info", "info" );
    		return;
		}
		
		resetForm("layerMemberSearchForm");
		
		memberLayerOptions.callBack (jsonArray );
		layer.close("layerMemberView");
	}
	, grid : function(gridParam) {
		
		if(gridParam == null) gridParam =  $("#layerMemberSearchForm").serializeJson();
		
		var colModelsObj =  [
			{name:"mbrNo", label:_MEMBER_SEARCH_GRID_LABEL.mbrNo, width:"90", align:"center", sortable:false , key:true}
			, {name:"mbrGbCd", label:_MEMBER_SEARCH_GRID_LABEL.mbrGbCd, width:"80", align:"center", sortable:false, formatter:"select" ,editoptions:{value:_MBR_GB_CD} }  
			, {name:"mbrNm", label:_MEMBER_SEARCH_GRID_LABEL.mbrNm, width:"130", align:"left", sortable:false, formatter : function(rowId, val, rawObject, cm){
				return rawObject.mbrNm + "("+ rawObject.loginId + ")" ;
			}}
			, {name:"nickNm", label:_MEMBER_SEARCH_GRID_LABEL.nickNm, width:"160", align:"center", sortable:false}
			, {name:"mobile", label:_MEMBER_SEARCH_GRID_LABEL.mobile, width:"130", align:"center", sortable:false}
			, {name:"payCpltDtm", label:_MEMBER_SEARCH_GRID_LABEL.mbrPayDtm, width:"160", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
		];
		
		//반려동물 등록된 회원만 조회인 경우 210114
		if(gridParam.petRegYn == 'Y'){
			colModelsObj =  [
				{name:"mbrNo", label:_MEMBER_SEARCH_GRID_LABEL.mbrNo, width:"90", align:"center", sortable:false}
				, {name:"mbrGbCd", label:_MEMBER_SEARCH_GRID_LABEL.mbrGbCd, width:"80", align:"center", sortable:false, formatter:"select" ,editoptions:{value:_MBR_GB_CD} }  
				, {name:"mbrNm", label:_MEMBER_SEARCH_GRID_LABEL.mbrNm, width:"130", align:"left", sortable:false, formatter : function(rowId, val, rawObject, cm){
					return rawObject.mbrNm + "("+ rawObject.loginId + ")" ;
				}}
				, {name:"nickNm", label:_MEMBER_SEARCH_GRID_LABEL.nickNm, width:"160", align:"center", sortable:false}
				, {name:"mobile", label:_MEMBER_SEARCH_GRID_LABEL.mobile, width:"130", align:"center", sortable:false}
				, {name:"joinDtm", label:_MEMBER_SEARCH_GRID_LABEL.joinDtm, width:"160", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
			]
		}
		
		var options = {
			url : _MEMBER_GRID_POPUP_URL
			, height : 300
			, datatype : 'local'
			, searchParam : gridParam
			, colModels : colModelsObj
			, multiselect : memberLayerOptions.multiselect
			, cellEdit : true
			/*, ondblClickRow : function(){
				if(memberLayerOptions.multiselect ) {
					layerMemberList.confirm();
				}
			}*/
			, gridComplete : function() {
				$("#noData").remove();
				var grid = $("#layerMemberList").jqGrid('getRowData');
				if(grid.length <= 0) {
					var str = "";
					str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
					str += "	<td role='gridcell' colspan='7' style='text-align:center;'>조회결과가 없습니다.</td>";
					str += "</tr>"
						
					$("#layerMemberList .ui-jqgrid-btable").append(str);
				}
				
				if(rowArr){
					for(var i = 0 ; i < rowArr.length ; i++){
						$("#layerMemberList").jqGrid("setSelection" , rowArr[i]);
					}
				}
				
//				$("#layerMemberList").resetSelection();
			}
		};
		grid.create("layerMemberList", options);
		
	}
	, searchMemberList : function () {
		
		if($("#searchDtmStart").val() != null && $("#searchDtmEnd").val()!=null){
			var starr = $("#searchDtmStart").val().split("-");
			var endarr = $("#searchDtmEnd").val().split("-");
			var stdate = new Date(starr[0], starr[1], starr[2] );
			var enddate = new Date(endarr[0], endarr[1], endarr[2] );
			var diff = enddate - stdate;
			var diffDays = parseInt(diff/(24*60*60*1000));
			if(diffDays > 90){
				messager.alert("기간 선택범위를 3개월로 선택해 주세요", "Info", "info" );
				return;
			}else if(diffDays<0){
				messager.alert("종료일이 시작일 보다 빠릅니다. 시작일을 확인해주세요.", "Info", "info" );
				return;
				
			}
			
			
		}
		var options = {
			searchParam : $("#layerMemberSearchForm").serializeJson()
		};
		grid.reload("layerMemberList", options);
	}
	, searchReset : function () {
		var formData = $("#layerMemberSearchForm").serializeJson();
		var petRegYn = "";
		if(formData.petRegYn == 'Y'){
			petRegYn = 'Y';
		}
		
		
		resetForm("layerMemberSearchForm");
		$("#layerMemberList").jqGrid("resetSelection");

		var param = $("#layerMemberSearchForm").serializeJson();
		param.searchDtmStart = "";
		param.searchDtmEnd = "";
		param.petRegYn = petRegYn;
		if(petRegYn == 'Y') {
			$("#petRegYn").val("Y");
		}

		grid.reload("layerMemberList", {searchParam : param} );
	}
}


var userLayerOptions = {
		  callBack : undefined
		, multiselect : false
		, param : {}
	};
var layerUserList = {
	create : function (data) {
		$.extend(userLayerOptions, data);
		var options = {
			url : _USER_SEARCH_LAYER_URL
			, dataType : "html"
			, data : userLayerOptions.param
			, callBack : function(result) {
				var config = {
					id : "layerUserView"
					, top : 100
					, width : 1000
					, height : 720
					, title : "사용자 목록 조회"
					, body : result
					, button : "<button type=\"button\" onclick=\"layerUserList.confirm();\" class=\"btn btn-ok\">확인</button>"
				}
				layer.create(config);
				layerUserList.grid();
			}
		}
		ajax.call(options );
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerUserList" );
		var rowids = null;
		if(userLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		userLayerOptions.callBack (jsonArray );
		layer.close("layerUserView");
	}
	, grid : function() {
		var options = {
			url : _USER_GRID_URL
			, height : 300
			, searchParam : $("#layerUserSearchForm").serializeJson()
			, colModels : [
				  {name:"usrNo", label:_USER_SEARCH_GRID_LABEL.usrNo, width:"90", align:"center", classes:'pointer fontbold', sortable:false}
				, {name:"usrNm", label:_USER_SEARCH_GRID_LABEL.usrNm, width:"80", align:"center", sortable:false}
				, {name:"authNm", label:_USER_SEARCH_GRID_LABEL.authNm, width:"130", align:"center", sortable:false}
				, {name:"usrStatCd", label:_USER_SEARCH_GRID_LABEL.usrStatCd, width:"80", align:"center", formatter:"select", editoptions:{value:_USR_STAT}, sortable:false}
				, {name:"usrGbCd", label:_USER_SEARCH_GRID_LABEL.usrGbCd, width:"100", align:"center", formatter:"select", editoptions:{value:_USR_GB}, sortable:false}
				, _GRID_COLUMNS.compNm
				, {name:"loginId", label:_USER_SEARCH_GRID_LABEL.usrId, width:"100", align:"center", sortable:false}
				, _GRID_COLUMNS.tel
				, _GRID_COLUMNS.mobile
				//, _GRID_COLUMNS.fax
				, _GRID_COLUMNS.email
			]
			, multiselect : userLayerOptions.multiselect
		};
		grid.create("layerUserList", options);
	}
	, searchUserList : function () {
		var options = {
			searchParam : $("#layerUserSearchForm").serializeJson()
		};
		grid.reload("layerUserList", options);
	}
	, searchReset : function () {
		resetForm("layerUserSearchForm");
	}
};


var layerUserInfo = {
	create : function() {
		var options = {
			url : _USER_INFO_LAYER_URL
			, dataType : "html"
			, callBack : function(result) {
				var config = {
					id : "layerUserInfoView"
					, top : 100
					, width : 800
					, height : 350
					, title : "사용자 정보 수정"
					, body : result
					, button : "<button type=\"button\" onclick=\"layerUserInfo.update();\" class=\"btn btn-ok\">수정</button>"
				}
				layer.create(config);
			}
		}
		ajax.call(options );
	}
	, update : function () {
		if(validate.check("userInfoLayerForm")) {
			//if(this.valid()){
				messager.confirm( _CONFIRM_UPDATE, function(r){
	                if (r){
	                	var options = {
	    					url : _USER_INFO_UPDATE_URL
	    					, data : $("#userInfoLayerForm").serializeJson()
	    					, callBack : function(result){
	    						messager.alert("사용자 정보 수정이 완료되었습니다.", "info", "info");
	    						//layer.close("layerUserInfoView");
	    					}
	    				};
	    				ajax.call(options);
	                }
	            });
			//}
		}
	}
	, valid : function(){
		var pswd = $("#layerUserInfoView").find('#userUpdatePswd');
		var pswdCfm = $("#layerUserInfoView").find('#userUpdatePswdCfm');
		
		if(pswd.val() !== '' || pswdCfm.val() !== ''){
			pswd.validationEngine("hide");
			pswdCfm.validationEngine("hide");
			if(pswd.val() ===''){
				pswd.validationEngine('showPrompt', "* 필수입력입니다.", 'error', true);
				return false;
			}
			
			if(!pswdValid.checkPswd(pswd.val())){
				pswd.validationEngine('showPrompt', "2개 문자 종류 조합 시 최소 10자리 이상<br/> 3개 이상 문자 조합 시 최소 8자리 이상 입력해 주세요.", 'error', true);
				return false;
			}
			
			if(!pswdValid.checkPswdMatch(pswd.val())){
				pswd.validationEngine('showPrompt', "4자리 연속, 반복된 문자, 숫자는 입력할 수 없습니다.", 'error', true);
				return false;
			}
			
			var mobile = $("#layerUserInfoView").find('[name=mobile]');
			if(!pswdValid.checkIncludeStr(pswd.val(), mobile.val().replace(/-/g, ''))){
				pswd.validationEngine('showPrompt', "휴대폰번호는 비밀번호에 포함할 수 없습니다.", 'error', true);
				return false;
			}
			
			var tel = $("#layerUserInfoView").find('[name=tel]');
			if(!pswdValid.checkIncludeStr(pswd.val(), tel.val().replace(/-/g, ''))){
				pswd.validationEngine('showPrompt', "전화번호는 비밀번호에 포함할 수 없습니다.", 'error', true);
				return false;
			}
			
			if(pswd.val() !== pswdCfm.val()){
				pswdCfm.validationEngine('showPrompt', "동일한 비밀번호를 입력해 주세요.", 'error', true);
				return false;
			}
			
		}
		return true;
	}
	,updatePwd : function(){
		layer.close("layerUserInfoView");
		location.href="/login/pswdChangeView.do";
		return true;
	}
}

//--------------------------------------------------------------------------------//
//Brand 검색 Layer
var brandLayerOptions = {
	compNo : null
	, bndGbCd : null
	, callBack : undefined
	, multiselect : false
};
var layerBrandList = {
	create : function (option ) {
		brandLayerOptions = $.extend( {}, brandLayerOptions, option );
		var options = {
			url : _BRAND_SEARCH_LAYER_URL
			, data : {
				compNo : brandLayerOptions.compNo
				, compNm : brandLayerOptions.compNm
				, useYn : brandLayerOptions.useYn
			}
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data) {
		var config = {
			id : "brandSearch"
			, width : 1200
			, height : 620
			, title : "브랜드 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerBrandList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerBrandList.initBrandGrid();
	}
	, initBrandGrid : function () {
		var gridOptions = {
			url : _BRAND_GRID_URL
			, height : 200
			, searchParam : $("#brandListForm").serializeJson()
			, colModels : [
				 {name:"bndNo", label:_BRAND_SEARCH_GRID_LABEL.bndNo , width:"100", key: true, align:"center", classes:'pointer fontbold', sortable:false} /* 브랜드 번호 */
				, _GRID_COLUMNS.bndNmKo
				//, {name:"bndNmEn", label:_BRAND_SEARCH_GRID_LABEL.bndNmEn , width:"150", align:"center", sortable:false} /* 브랜드 영문 */
				, {name:"useYn", label:_BRAND_SEARCH_GRID_LABEL.useYn , width:"90", align:"center", formatter:"select", editoptions:{value:_USE_YN }, sortable:false } /* 사용여부 */
				//, {name:"sortSeq", label:_BRAND_SEARCH_GRID_LABEL.sortSeq , width:"100", align:"center", sortable:false } /* 정렬순서 */
				//, {name:"compNm", label:_BRAND_SEARCH_GRID_LABEL.compNm , width:"200", align:"center", sortable:false } /* 업체명 */
				, {name:"stIds", label:_GOODS_SEARCH_GRID_LABEL.stIds, width:"100", align:"center", sortable:false, hidden:true } /* 사이트 아이디 */
				, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center", sortable:false, hidden:false } /* 사이트 명 */
				, _GRID_COLUMNS.sysRegrNm
				, _GRID_COLUMNS.sysRegDtm
			]
			, multiselect : brandLayerOptions.multiselect
		}
		grid.create("layerBrandList", gridOptions);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerBrandList" );
		var rowids = null;
		if(brandLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		brandLayerOptions.callBack (jsonArray );
		layer.close("brandSearch");
	}
	, searchBrandList : function () {
		var options = {
			searchParam : $("#brandListForm").serializeJson()
		};
		grid.reload("layerBrandList", options);
	}
	, searchReset : function () {
		resetForm ("brandListForm" );
	}
	, searchCompany : function () {
		var options = {
			multiselect : false
			, callBack : this.searchCompanyCallback
		}
		layerCompanyList.create (options );
	}
	, searchCompanyCallback : function (compList ) {
		if(compList.length > 0 ) {
			$("#brandListForm #compNo").val (compList[0].compNo );
			$("#brandListForm #compNm").val (compList[0].compNm );
		}
	}
}

//--------------------------------------------------------------------------------//
//goods 검색 Layer
var goodsLayerOptions = {
	compNo : null
	, callBack : undefined
	, multiselect : false
	, compStatCd : undefined
	, readOnlyCompStatCd : undefined
};
var layerGoodsList = {
	create : function (option) {
		goodsLayerOptions = $.extend( {}, goodsLayerOptions, option );
		/**
		 * 20201231 검색 조건 추가
		 * stIds : 검색 사이트 ID 목록
		 * frbPsbYn : 사은품 가능여부 Y:가능,N:불가능
		 * goodsStatCd : 상품 상태
		 * goodsCstrtTpCds : 상품 구성 유형
		 * goodsIds : 상품 ID
		 * goodsNms : 상품 명
		 * compNo : 업체번호
		 * brndNo : 브랜드번호
		 * tags : 태그
		 * dispClsfNo : 전시 카테고리
		 * showYn : 상품 노출 여부
		 * attrYn : 상품 속성 표출 여부
		 * ...
		 */
		var options = {
			url : _GOODS_SEARCH_LAYER_URL
			, data : {
				stId : option.stId == null ? undefined : option.stId,
				stIds : option.stIds == null ? undefined : option.stIds,
				stNm : option.stNm == null ? undefined : option.stNm,
				disableAttrGoodsTpCd : option.disableAttrGoodsTpCd,
				frbPsbYn: option.frbPsbYn == null ? undefined : option.frbPsbYn,
				goodsStatCd : option.goodsStatCd == null ? undefined : option.goodsStatCd,
				goodsCstrtTpCd : option.goodsCstrtTpCd == null ? undefined : option.goodsCstrtTpCd,
				goodsCstrtTpCds : option.goodsCstrtTpCds == null ? undefined : option.goodsCstrtTpCds,
				goodsIds : option.goodsIds == null ? undefined : option.goodsIds,
				goodsNms : option.goodsNms == null ? undefined : option.goodsNms,
				bndNo : option.bndNo == null ? undefined : option.bndNo,
				bndNmKo : option.bndNmKo == null ? undefined : option.bndNmKo,
				compNo : option.compNo == null ? undefined : option.compNo,
				compNm : option.compNm == null ? undefined : option.compNm,
				compStatCd :  option.compStatCd == null ? undefined : option.compStatCd,
				readOnlyCompStatCd : option.readOnlyCompStatCd == null ? undefined : option.readOnlyCompStatCd,
				forceStSearchReadOnly : option.forceStSearchReadOnly == null ? undefined : option.forceStSearchReadOnly,
				eptGoodsId :  option.eptGoodsId == null ? undefined : option.eptGoodsId,	// 상품상세 연관상품 추가 팝업 자기자신 제외용 goodsId by pkt on 20200115
				showYn : option.showYn == null ? undefined : option.showYn,
				tags : option.tags == null ? undefined : option.tags,
				attrYn : option.attrYn == null ? undefined : option.attrYn, //상품 속성 표출 여부
				dispClsfNo : option.dispClsfNo == null ? undefined : option.dispClsfNo //카테고리
			}
			, dataType : "html"
			, callBack : layerGoodsList.callBackCreate
		}
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : 'goodsSearch'
			, width : 1300
			, height : 800
			, top : 50
			, init : 'goodsSearchViewInit'
			, title : '상품 조회'
			, body : data
			, button : '<button type="button" onclick="layerGoodsList.confirm();" class="btn btn-ok">확인</button>'
		};
		$('#'+config.id).dialog({content: ""});
		layer.create(config);
		layerGoodsList.initGoodsGrid(data);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerGoodsList" );
		var rowids = null;
		if(goodsLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}

		if(jsonArray == null || jsonArray.length == 0){
			messager.alert("선택된 대상이 없습니다.","Info","Info");
		}else{
			goodsLayerOptions.callBack(jsonArray);
			layer.close("goodsSearch");
		}
	}
	, initGoodsGrid : function (data) {
		var gridOptions = {
			url : _GOODS_GRID_URL
			, height : 200
			, searchParam : $("#layerGoodsListForm").serializeJson()
			, colModels : [
				  _GRID_COLUMNS.goodsId_b
				, {name:"compGoodsId", label:_GOODS_SEARCH_GRID_LABEL.compGoodsId, width:"100", align:"center"} /* 업체 상품 번호 */
				, {name:"imgPath", label:_GOODS_SEARCH_GRID_LABEL.imgPaths, hidden:true}
				, {name:"imgPath1", label:_GOODS_SEARCH_GRID_LABEL.imgPaths, width:"220", align:"center", formatter: function(cellvalue, options, rowObject) {
						if(rowObject.imgPath !== "" && rowObject.imgPath != null ) {
							//return tag.goodsImage(_IMG_URL, rowObject.goodsId, rowObject.imgPath , rowObject.imgSeq, "", _IMAGE_GOODS_SIZE_70_0, _IMAGE_GOODS_SIZE_70_1, "w100 h100");
							return getImage(rowObject.imgPath);
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="" />';
						}
					}
				 }
				, {name:"imgSeq", label:_GOODS_SEARCH_GRID_LABEL.imgSeq, width:"70", align:"center", sortable:false, hidden:true } /* 이미지 순번 */
				, _GRID_COLUMNS.bndNmKo
				, _GRID_COLUMNS.goodsNm
				//, {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
				, _GRID_COLUMNS.goodsStatCd
				, {name:"goodsCstrtTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsCstrtTpCd, width:"100", align:"center", sortable:false, editoptions:{value:_GOODS_CSTRT_TP_CD  }} /* 상품 구성 유형 */
				, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
				//, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
				, {name:'compTpCd', label:_COMPANY_SEARCH_GRID_LABEL.compTpCd, width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:_COMP_TP_CD } }
				, {name:'goodsAmtTpCd', label:_GOODS_SEARCH_GRID_LABEL.goodsAmtTpCd, width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:_GOODS_AMT_TP_CD } } /* 상품 금액 유형 */
				, {name:"priceSaleStrtDtm", label:'현재가 시작일자', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"priceSaleEndDtm", label:'현재가 종료일자', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"orgSaleAmt", label:_GOODS_SEARCH_GRID_LABEL.orgSaleAmt, width:"90", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
				, {name:"splAmt", label:_GOODS_SEARCH_GRID_LABEL.splAmt, width:"90", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
				, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"90", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
				, /* 판매 시작일시 */ {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, /* 판매 종료일시 */ {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, /* 업체명 */ _GRID_COLUMNS.compNm
				, {name:"compNo", label:_GOODS_SEARCH_GRID_LABEL.stIds, width:"100", align:"center", sortable:false, hidden:true } /* 업체 번호 */
				, /* 제조사 */ {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"100", align:"center", sortable:false } /* 제조사 */
				, /* 등록자 */ _GRID_COLUMNS.sysRegrNm
				, /* 등록일시 */ _GRID_COLUMNS.sysRegDtm
				, /* 수정자 */ _GRID_COLUMNS.sysUpdrNm
				, /* 수정일시 */ _GRID_COLUMNS.sysUpdDtm
				, /* 비고 */ {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } 
				, /* 아이콘 */ {name:"icons", label:"아이콘", width:"200", align:"center", sortable:false }//,formatter: function(cellvalue, options, rowObject) { return getIcons(rowObject.icons);}}
				, {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN }, hidden:true } /* 노출여부 */
				, {name:"stIds", label:_GOODS_SEARCH_GRID_LABEL.stIds, width:"100", align:"center", sortable:false, hidden:true } /* 사이트 아이디 */
				, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center", sortable:false, hidden:true } /* 사이트 명 */
				, {name:"attr1No", label:'', sortable:false, hidden:true }      /* 속성1 */
				, {name:"attr1Nm", label:'', sortable:false, hidden:true }      /* 속성1 */
				, {name:"attr1Val", label:'', sortable:false, hidden:true }     /* 속성1 */
				, {name:"attr1ValNo", label:'', sortable:false, hidden:true }   /* 속성1 */
				, {name:"attr2No", label:'', sortable:false, hidden:true }      /* 속성2 */
				, {name:"attr2Nm", label:'', sortable:false, hidden:true }      /* 속성2 */
				, {name:"attr2Val", label:'', sortable:false, hidden:true }     /* 속성2 */
				, {name:"attr2ValNo", label:'', sortable:false, hidden:true }   /* 속성2 */
				, {name:"attr3No", label:'', sortable:false, hidden:true }      /* 속성3 */
				, {name:"attr3Nm", label:'', sortable:false, hidden:true }      /* 속성3 */
				, {name:"attr3Val", label:'', sortable:false, hidden:true }     /* 속성3 */
				, {name:"attr3ValNo", label:'', sortable:false, hidden:true }   /* 속성3 */
				, {name:"attr4No", label:'', sortable:false, hidden:true }      /* 속성4 */
				, {name:"attr4Nm", label:'', sortable:false, hidden:true }      /* 속성4 */
				, {name:"attr4Val", label:'', sortable:false, hidden:true }     /* 속성4 */
				, {name:"attr4ValNo", label:'', sortable:false, hidden:true }   /* 속성4 */
				, {name:"attr5No", label:'', sortable:false, hidden:true }      /* 속성5 */
				, {name:"attr5Nm", label:'', sortable:false, hidden:true }      /* 속성5 */
				, {name:"attr5Val", label:'', sortable:false, hidden:true }     /* 속성5 */
				, {name:"attr5ValNo", label:'', sortable:false, hidden:true }   /* 속성5 */
				, {name:"attrCnt", label:'', sortable:false, hidden:true }   	/* 속성 갯수 */
				]
			, multiselect : goodsLayerOptions.multiselect
			, goodsTpCd : data.goodsTpCd
		}
		grid.create("layerGoodsList", gridOptions);
	}
	, searchGoodsList : function () {
		var options = {
			searchParam : $("#layerGoodsListForm").serializeJson()
		};
		grid.reload("layerGoodsList", options);
	}
	, searchReset : function () {
		resetForm ("layerGoodsListForm" );
	}
	, searchCompany : function () {
		var options = {
			multiselect : false
			, callBack : this.searchCompanyCallback
			, stId : goodsLayerOptions.stId == null ? undefined : goodsLayerOptions.stId
			, stIds : goodsLayerOptions.stIds == null ? undefined : goodsLayerOptions.stIds
			, compStatCd : goodsLayerOptions.compStatCd == null ? undefined : goodsLayerOptions.compStatCd
			, readOnlyCompStatCd : goodsLayerOptions.readOnlyCompStatCd == null ? undefined : goodsLayerOptions.readOnlyCompStatCd
		}
		layerCompanyList.create (options );
	}
	, searchCompanyCallback : function (compList ) {
		if(compList.length > 0 ) {
			$("#layerGoodsListForm #compNo").val (compList[0].compNo );
			$("#layerGoodsListForm #compNm").val (compList[0].compNm );
		}
	}
	, selectBrandSeries : function (gubun ) {
		var options = null;
		if(gubun === "brand") {
			options = {
				multiselect : false
				, bndGbCd : '20'
				, callBack : this.searchBrandCallback
			}
		} else {
			options = {
				multiselect : false
				, bndGbCd : '10'
				, callBack : this.searchSeriesCallback
			}
		}
		layerBrandList.create (options );
	}
	, searchBrandCallback : function (brandList ) {
		if(brandList != null && brandList.length > 0 ) {
			$("#bndNo").val (brandList[0].bndNo );
			$("#bndNm").val (brandList[0].bndNmKo );
		}
	}
	, searchSeriesCallback : function (brandList ) {
		if(brandList != null && brandList.length > 0 ) {
			$("#seriesNo").val (brandList[0].bndNo );
			$("#seriesNm").val (brandList[0].bndNmKo );
		}
	}
	, searchDateChange : function () {
		var term = $("#layerGoodsListForm #checkOptDate").children("option:selected").val();
		if(term === "") {
			$("#layerGoodsListForm #sysRegDtmStart").val("");
			$("#layerGoodsListForm #sysRegDtmEnd").val("");
		} else {
			setSearchDate(term, "layerGoodsListForm #sysRegDtmStart", "layerGoodsListForm #sysRegDtmEnd");
		}
	}
}

//--------------------------------------------------------------------------------//
//item 검색 Layer
var itemLayerOptions = {
	compNo : null
	, callBack : undefined
	, multiselect : false
};
var layerItemList = {
	create : function (option ) {
		itemLayerOptions = $.extend( {}, itemLayerOptions, option );
		var options = {
			url : _ITEM_SEARCH_LAYER_URL
			, data : itemLayerOptions
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "itemSearch"
			, width : 1000
			, height : 900
			, title : "단품 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerItemList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerItemList.initItemGrid();
	}
	, initItemGrid : function () {
		var gridOptions = {
			url : _ITEM_GRID_URL
			, datatype : 'local'
			, height : 200
			, searchParam : $("#itemListForm").serializeJson()
			, colModels : [
				{name:"goodsId", label:_ITEM_SEARCH_GRID_LABEL.goodsId, width:"100", align:"center"} /* 상품 번호 */
				, {name:"goodsNm", label:_ITEM_SEARCH_GRID_LABEL.goodsNm, width:"300", align:"center", sortable:false } /* 상품명 */
				, {name:"itemNo", label:_ITEM_SEARCH_GRID_LABEL.itemNo, width:"100", key: true, align:"center"} /* 단품 번호 */
				, {name:"itemNm", label:_ITEM_SEARCH_GRID_LABEL.itemNm, width:"300", align:"center", sortable:false } /* 단품명 */
				, {name:"itemStatCd", label:_ITEM_SEARCH_GRID_LABEL.itemStatCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_ITEM_STAT_CD } } /* 단품 상태 */
				, {name:"saleAmt", label:_ITEM_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
				, {name:"addSaleAmt", label:_ITEM_SEARCH_GRID_LABEL.addSaleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 추가 금액 */
				, {name:"webStkQty", label:_ITEM_SEARCH_GRID_LABEL.webStkQty, width:"100", align:"center"} /* 재고수량 */
				, {name:"bomCd", label:_ITEM_SEARCH_GRID_LABEL.bomCd, width:"100", align:"center", sortable:false } /* BOM */
				, {name:"cstrtGoodsId", label:_ITEM_SEARCH_GRID_LABEL.cstrtGoodsId, width:"100", align:"center", hidden:true } /* 구성 상품 번호 */
				, {name:"goodsStatCd", label:_ITEM_SEARCH_GRID_LABEL.goodsStatCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
				, {name:"goodsTpCd", label:_ITEM_SEARCH_GRID_LABEL.goodsTpCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
				, {name:"mdlNm", label:_ITEM_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
				, {name:"compNm", label:_ITEM_SEARCH_GRID_LABEL.compNm, width:"200", align:"center", sortable:false } /* 업체명 */
				, {name:"bndNmKo", label:_ITEM_SEARCH_GRID_LABEL.bndNmKo, width:"200", align:"center", sortable:false } /* 브랜드명 */
				, {name:"saleStrtDtm", label:_ITEM_SEARCH_GRID_LABEL.saleStrtDtm, width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"saleEndDtm", label:_ITEM_SEARCH_GRID_LABEL.saleEndDtm, width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				]
			, multiselect : itemLayerOptions.multiselect
		};
		grid.create("layerItemList", gridOptions);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerItemList" );
		var rowids = null;
		if(itemLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		itemLayerOptions.callBack (jsonArray );
		layer.close("itemSearch");
	}
	, searchItemList : function () {
		var options = {
			searchParam : $("#itemListForm").serializeJson()
		};
		grid.reload("layerItemList", options);
	}
	, searchReset : function () {
		resetForm ("itemListForm" );
	}
	, searchCompany : function () {
		var options = {
			multiselect : false
			, callBack : this.searchCompanyCallback
		}
		layerCompanyList.create (options );
	}
	, searchCompanyCallback : function (compList ) {
		if(compList.length > 0 ) {
			$("#itemListForm #compNo").val (compList[0].compNo );
			$("#itemListForm #compNm").val (compList[0].compNm );
		}
	}
	, selectBrandSeries : function (gubun ) {
		var options = null;
		if(gubun === "brand") {
			options = {
				multiselect : false
				, callBack : this.searchBrandCallback
			}
		}
		layerBrandList.create (options );
	}
	, searchBrandCallback : function (brandList ) {
		if(brandList != null && brandList.length > 0 ) {
			$("#bndNo").val (brandList[0].bndNo );
			$("#bndNm").val (brandList[0].bndNmKo );
		}
	}
}

//--------------------------------------------------------------------------------//
//coupon 검색 Layer
var couponLayerOptions = {
	compNo : null
	, callBack : undefined
	, multiselect : false
};
var layerCouponList = {
	create : function (option ) {
		couponLayerOptions = $.extend( {}, couponLayerOptions, option );
		var options = {
			url : _COUPON_SEARCH_LAYER_URL
			, data : {
				compNo : couponLayerOptions.compNo,
				cpPvdMthCd : option.cpPvdMthCd == null ? undefined : option.cpPvdMthCd,
				isReadonlyCpPvdMthCd : option.isReadonlyCpPvdMthCd == null ? false : option.isReadonlyCpPvdMthCd,
				isReadonlyStId : option.isReadonlyStId == null ? false : option.isReadonlyStId,
				stId : option.stId == null ? undefined : option.stId,
			}
			, dataType : "html"
			, callBack : layerCouponList.callBackCreate
		}
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "couponSearch"
			, width : 1100
			, height : 700
			, title : "쿠폰 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerCouponList.confirm();\" class=\"btn btn-ok\">확인</button>"
		}
		layer.create(config);
		layerCouponList.initCouponGrid(data);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerCouponList" );
		var rowids = null;
		if(couponLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		couponLayerOptions.callBack (jsonArray );
		layer.close("couponSearch");
	}
	, initCouponGrid : function (data) {
		var gridOptions = {
			url : _COUPON_GRID_URL
			, height : 200
			, searchParam : $("#couponListForm").serializeJson()
			, colModels : [{name:"cpNo", label:_COUPON_SEARCH_GRID_LABEL.cpNo, width:"100", key: true, align:"center"} /* 쿠폰 번호 */
				, {name:"cpNm", label:_COUPON_SEARCH_GRID_LABEL.cpNm, width:"300", align:"center", sortable:false } /* 쿠폰 명 */
				, {name:"stNms", label:_COUPON_SEARCH_GRID_LABEL.stNms, width:"200", align:"center", sortable:false } /* 사이트 명 */
				, {name:"cpTgCd", label:_COUPON_SEARCH_GRID_LABEL.cpTgCd, width:"200", align:"center", sortable:false, formatter:"select", editoptions:{value:_CP_TG } } /* 사이트 명 */
				, {name:"cpKindCd", label:_COUPON_SEARCH_GRID_LABEL.cpKindCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_CP_KIND_CD } }
				, {name:"cpStatCd", label:_COUPON_SEARCH_GRID_LABEL.cpStatCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_CP_STAT_CD } }
				, {name:"cpAplCd", label:_COUPON_SEARCH_GRID_LABEL.cpAplCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_CP_APL_CD } }
				, {name:"aplVal", label:_COUPON_SEARCH_GRID_LABEL.aplVal, width:"300", align:"center", sortable:false }
				, {name:"minBuyAmt", label:_COUPON_SEARCH_GRID_LABEL.minBuyAmt, width:"300", align:"center", sortable:false }
				, {name:"maxDcAmt", label:_COUPON_SEARCH_GRID_LABEL.maxDcAmt, width:"300", align:"center", sortable:false }
				, {name:"aplStrtDtm", label:_COUPON_SEARCH_GRID_LABEL.aplStrtDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"aplEndDtm", label:_COUPON_SEARCH_GRID_LABEL.aplEndDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"dupleUseYn", label:_COUPON_SEARCH_GRID_LABEL.dupleUseYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_DUPLE_USE_YN } }
				, _GRID_COLUMNS.sysRegrNm
				, _GRID_COLUMNS.sysRegDtm
			]
			, multiselect : couponLayerOptions.multiselect
			, couponTpCd : data.couponTpCd
		}
		grid.create("layerCouponList", gridOptions);
	}
	, searchCouponList : function () {
		var options = {
			searchParam : $("#couponListForm").serializeJson()
		};
		grid.reload("layerCouponList", options);
	}
	, searchReset : function () {
		resetForm ("couponListForm" );
	}
	, searchSt : function () {
		var options = {
			multiselect : false
			, callBack : searchStCallback
		}
		layerStList.create (options );
	}
	, searchStCallback : function (stList ) {
		if(stList.length > 0 ) {
			$("#stId").val (stList[0].stId );
			$("#stNm").val (stList[0].stNm );
		}
	}
}

//--------------------------------------------------------------------------------//
//company카테고리 검색 Layer
var companyCategoryLayerOptions = {
	compNo : null

};
var layerCompanyCategoryList = {
	create : function (option ) {
		companyCategoryLayerOptions = $.extend( {}, option );
		var options = {
			url : _COMPANY_CATEGORY_LAYER_URL
			, data : {
				compNo : companyCategoryLayerOptions.compNo
			}
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "companyCategory"
			, width : 1000
			, height : 700
			, title : "업체 카테고리 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerCompanyCategoryList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerCompanyCategoryList.initCompanyCategoryGrid();
	}
	, initCompanyCategoryGrid : function () {

		var gridOptions = {
			url : _COMPANY_CATEGORY_GRID_URL
			, height : 200
			, searchParam : $("#companyCategoryListForm").serializeJson()
			, colModels : [
				    {name:"stNm", label:_COMPANY_CATEGORY_GRID_LABEL.stNm, width:"200", align:"center", sortable:false } /* 사이트 명 */
				  , {name:"dispClsfNo", label:_COMPANY_CATEGORY_GRID_LABEL.dispClsfNo, width:"100", align:"center", key: true, sortable:false } /* 전시분류 번호 */
				  , {name:"dispClsfNm", label:_COMPANY_CATEGORY_GRID_LABEL.dispClsfNm, width:"150", align:"center", sortable:false } /* 전시분류 명 */
				  , {name:"ctgPath", label:_COMPANY_CATEGORY_GRID_LABEL.ctgPath, width:"300", align:"center", sortable:false } /* 대분류 */
				  , {name:"goodsId", label:_COMPANY_CATEGORY_GRID_LABEL.goodsId, width:"100", align:"center", hidden:true, sortable:false } /* 전시분류 번호 */
				  , {name:"stId", label:_COMPANY_CATEGORY_GRID_LABEL.stId, width:"100", align:"center", hidden:true} /* 사이트 ID */
				]

			, multiselect : true
		}
		grid.create("layerCompanyCategoryList", gridOptions);
	}
	, confirm : function () {

		var jsonArray = [];
		var grid = $("#layerCompanyCategoryList" );
		var rowids = null;
		//if(companyLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		/*} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}*/
		companyCategoryLayerOptions.callBack (jsonArray );
		layer.close("companyCategory");
	}

}

//--------------------------------------------------------------------------------//
//전시목록 검색 Layer
var layerCategoryList = {
	option : {
		callBack : undefined
		, multiselect : false
		, plugins : [ "themes" ]
		, arrDispClsfCd : undefined
		, stId : undefined
		, compNo : undefined
		, dispClsfCd : undefined
		, filterGb : undefined
		, upDispYn : undefined
	}
	, create : function (option ) {
		var stIdVal= option.stId;
		var dispClsfCdVal = option.dispclsfCd;
		var compNoVal = option.compNo;
		var filterGbVal = option.filterGb;
		var upDispYn = option.upDispYn;
		var exhibitionYn = option.exhibitionYn;
		this.option = $.extend( {}, this.option, option );
		var options = {
			url : _CATEGORY_SEARCH_LAYER_URL
			, data : { "stId" : stIdVal , "dispClsfCd" : dispClsfCdVal, "compNo" : compNoVal, "filterGb": filterGbVal, "upDispYn": upDispYn, "exhibitionYn": exhibitionYn}
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "categorySearch"
			, width : 500
			, height : 700
			, title : "전시목록 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerCategoryList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerCategoryList.initDisplayTree();
	}
	, initDisplayTree : function () {
		var arrDispClsfCd = this.option.arrDispClsfCd;
		var stId = this.option.stId; // 사이트아이디
		var dispClsfCd = this.option.dispClsfCd; // 전시카테고리분류
		var compNo = this.option.compNo; // 업체번호
		var filterGb = this.option.filterGb; // 필터링 조건. 상품상세의 경우 G
		var upDispYn = this.option.upDispYn; // 상위 전시여부
		var exhibitionYn = this.option.exhibitionYn;
		$("#layerCategoryList").jstree({
			core : {
				multiple : this.option.multiselect
				, data : {
					type : "POST"
					, url : function(node) {
	//					return "/display/displayListTree.do";
						return "/display/displayListTreeFilter.do";
					}
					, data : function (node) {
						var data = null;
						if(arrDispClsfCd != null && arrDispClsfCd.length > 0) {
							data = {
								arrDispClsfCd : arrDispClsfCd,
								stId : stId,
								dispClsfCd :dispClsfCd,
								compNo : compNo,
								filterGb : filterGb,
								upDispYn : upDispYn
							};
						} else {
							data = {
								stId : stId,
								dispClsfCd :dispClsfCd,
								compNo : compNo,
								filterGb : filterGb,
								upDispYn : upDispYn,
								exhibitionYn : exhibitionYn
							};
						}
						return data;
					}
				}
			}
			, plugins : this.option.plugins
		})
		.bind("ready.jstree", function (event, data) {
				$("#layerCategoryList").jstree("open_node", $("#layerCategoryList > ul > li"));
      });
	}
	, confirm : function () {
		var arrId = $("#layerCategoryList").jstree().get_selected();
		var result = [];
		for(var i in arrId) {
			var data = $("#layerCategoryList").jstree().get_node(arrId[i]);

			if(this.option.plugins.indexOf("checkbox") > -1) {
				
				if(data.children == null || data.children.length === 0){
					
					result.push({
						  dispNo : data.id
						, dispNm : data.text
						, dispClsfCd : data.original.dispClsfCd
						, dispPath : data.original.dispPath
						, dispLvl : data.original.dispLvl
						, upDispNo : data.original.parent
						, stId : data.original.stId
						, stNm : data.original.stNm
					});
				}
				
			} else {
				result.push({
					  dispNo : data.id
					, dispNm : data.text
					, dispClsfCd : data.original.dispClsfCd
					, dispPath : data.original.dispPath
					, dispLvl : data.original.dispLvl
					, upDispNo : data.original.parent
					, stId : data.original.stId
					, stNm : data.original.stNm
				});
			}
		}

		this.option.callBack(result);

		layer.close("categorySearch");
	}
}

//배너 이미지/동영상/태그 Layer
var petTvMainLayerOptions = {
		callBack : undefined
		, dispClsfNo : null
		, dispCornTpCd : null
};
var layerPetTvMainLayer = {
		create : function(option) {
			petTvMainLayerOptions = $.extend({}, petTvMainLayerOptions, option);
			var options = {
					url : _DISPLAY_BNR_VOD_TAG_URL
					, data : {
						dispCornTpCd : option.dispCornTpCd == null ? undefined : option.dispCornTpCd
						, dispClsfNo : option.dispClsfNo == null ? undefined : option.dispClsfNo
						, dispClsfCornNo : option.dispClsfCornNo == null ? undefined : option.dispClsfCornNo
						, dispCnrItemNo : option.dispCnrItemNo == null ? undefined : option.dispCnrItemNo
						, itemLength : option.itemLength == null ? undefined : option.itemLength
					}
						, dataType : "html"
						, callBack : layerPetTvMainLayer.callBackCreate
			};
			ajax.call(options);
		}
		, callBackCreate : function(data) {
			var config = {
					id : "bnrVodTagViewPop"
					, height : 600
					, width : 800
					, title : "전시 코너 아이템"
					, body : data
					, button : "<button type=\"button\" onclick=\"layerPetTvMainLayer.confirm();\" class=\"btn btn-ok\">저장</button>" 
			}
			layer.create(config);
		}
		, confirm : function() {
			var dispStrtDtm = $("#displayCornerItemPopForm #dispStrtdt").val().replace(/-/gi, "");
			var dispEndDtm = $("#displayCornerItemPopForm #dispEnddt").val().replace(/-/gi, "");
			var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			
			if(parseInt(dispStrtDtm) > parseInt(dispEndDtm)){
				messager.alert("시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info");
				return;
			}
			
			if(validate.check("displayCornerItemPopForm")) {
				if($("#displayCornerItemPopForm #dispCornTpCd").val() == "72") {
					if($("#displayCornerItemPopForm #pcImg").css("display") == "none") {
						var valCheck = $("#pcBannerBtn");
						
						valCheck.validationEngine('showPrompt', "* 이미지를 추가해 주세요.", 'error', true);
						return;
					}
					
					if($("#displayCornerItemPopForm #tagList span").length <= 0) {
						
						var tagDiv = $("#displayCornerItemPopForm #tagList");
						
						tagDiv.validationEngine('showPrompt', "* 태그를 추가해 주세요.", 'error', true);
						return;
					}
				} 
				
				if($("#displayCornerItemPopForm #dispCornTpCd").val() == "71" ||
					$("#displayCornerItemPopForm #dispCornTpCd").val() == "133") {
					
					var gridLength = $("#displayCornerItemPopForm #itemLength").val()*1;
					if($("#displayCornerItemPopForm #vdId").val() == null || $("#displayCornerItemPopForm #vdId").val() == "") {
						var vdIdDiv = $("#displayCornerItemPopForm #vdId");
						
						vdIdDiv.validationEngine('showPrompt', "* 영상을 추가해 주세요.", 'error', true);
						return;
					}
					
					if($("#displayCornerItemPopForm #dispCornTpCd").val() == "133" && (gridLength >= 50)) {
						messager.alert("영상 50개까지 등록 가능합니다.","Info","info");
						return;
					}
					
				}
				
				if($("#displayCornerItemPopForm #dispCornTpCd").val() == "75") {
					if($("#displayCornerItemPopForm #bnrNo").val() == null || $("#displayCornerItemPopForm #bnrNo").val() == "") {
						
						var bnrNoDiv = $("#displayCornerItemPopForm #bnrNo");
						
						bnrNoDiv.validationEngine('showPrompt', "* 배너를 추가해 주세요.", 'error', true);
						return;
					}
				}
				
				if(petTvMainLayerOptions.dispCornTpCd == "130" || petTvMainLayerOptions.dispCornTpCd == "131") {
					var gridLength = $("#displayCornerItemPopForm #itemLength").val()*1
					var thisLength = $("#displayCornerItemPopForm #tagList span").length;
					var tagMaxCheck = gridLength + thisLength;
					
					if(tagMaxCheck <= 4) {
						if($("#displayCornerItemPopForm #tagList span").length <= 0) {
							
							var tagDiv = $("#displayCornerItemPopForm #tagList");
							
							tagDiv.validationEngine('showPrompt', "* 태그를 추가해 주세요.", 'error', true);
							return;
						}
						
						if(tagMaxCheck < 2) {
							messager.alert("Tag는 최소 2개 이상 등록해주세요.","Info","info");
							return;
						}
					}else {
						messager.alert("Tag는 최대 4개까지 등록 가능합니다.","Info","info");
						return;
					}
				}
				
				messager.confirm(_BNR_VOD_TAG_UPDATE, function(r) {
					if(r) {
						var formData = {
								bnrNo : $("#displayCornerItemPopForm #bnrNo").val()
								, vdId : $("#displayCornerItemPopForm #vdId").val()
								, dispClsfNo : $("#displayCornerItemPopForm #dispClsfNo").val()
								, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
								, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
								, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
								, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
								, bnrText : $("#displayCornerItemPopForm #bnrText").val()
								, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
								, bnrVodGb : $("#displayCornerItemPopForm #bnrVodGb").val()
								, dispStrtdt :$("#displayCornerItemPopForm #dispStrtdt").val()
								, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
						}
						
						if($("#displayCornerItemPopForm #dispCornTpCd").val() == "72" || petTvMainLayerOptions.dispCornTpCd == "130" || petTvMainLayerOptions.dispCornTpCd == "131") {
							var tagListLength = $("#tagList span").length;
							var tagList = $("#tagList span");
							
							var tagNo = new Array();
							
							if(tagListLength > 0) {
								for(var i = 0; i < tagListLength; i++) {
									tagNo[i] = tagList.eq(i).attr('id');
								}
							}
							
							$.extend(formData, {
								tagNo : tagNo
							});
						}
						petTvMainLayerOptions.callBack(formData);
						layer.close("bnrVodTagViewPop");
					}
				})
			}
		}
}

//펫로그 배너 등록/수정 Layer
var petLogContentLayerOptions = {
		callBack : undefined
};
var layerPetLogContent = {
		create : function(data) {
			petLogContentLayerOptions = $.extend({}, petLogContentLayerOptions, data);
			var options = {
					url : _PET_TV_CONTENT_LAYER_URL
					, data : data
					, dataType : "html"
					, callBack : layerPetLogContent.callBackCreate
			};
			ajax.call(options);
		}
		, callBackCreate : function(data) {
			var config = {
					id : "petLogContentViewPop"
					, height : 400
					, width : 1100
					, title : "어바웃TV 콘텐츠 등록/수정"
					, body : data
					, button : "<button type=\"button\" onclick=\"layerPetLogContent.confirm();\" class=\"btn btn-ok\">저장</button>"
			}
			layer.create(config);
		}
		, confirm : function() {
			if(validate.check("contentSearchForm")) {
				$("#contentSearchForm #dispStrtDtm").val(getDateStr ("dispStrt"));
				$("#contentSearchForm #dispEndDtm").val(getDateStr ("dispEnd"));
				
				var dispStrtDt = $("#contentSearchForm #dispStrtDtm").val();
				var dispEndDt = $("#contentSearchForm #dispEndDtm").val();
				
				var formData = {
						dispBnrNo : $("#contentSearchForm #dispBnrNo").val()
						, contentId : $("#contentSearchForm #contentId").val()
						, vdId : $("#contentSearchForm #vdId").val()
						, cntsTtl : $("#contentSearchForm #contentTtl").val()
						, dispStrtDt : dispStrtDt
						, dispEndDt : dispEndDt
				}
				petLogContentLayerOptions.callBack(formData);
				layer.close("petLogContentViewPop");
			}
		}
}

//배너 조회 검색 Layer
var bannerLayerOptions = {
		callBack : undefined
		, multiselect : false
};
var layerBannerList = {
		create : function(option) {
			bannerLayerOptions = $.extend({}, bannerLayerOptions, option);
			var options = {
				url : _BANNER_SEARCH_LAYER_URL
				, data : {
					stId : option.stId == null ? undefined : option.stId
				}
				, dataType : "html"
				, callBack : layerBannerList.callBackCreate
			}
			ajax.call(options);
		}
		, callBackCreate : function(data) {
			var config = {
					id : "bannerSearch"
					, height : 700
					, width : 1100
					, title : "배너 조회"
					, body : data
					, button : "<button type=\"button\" onclick=\"layerBannerList.confirm();\" class=\"btn btn-ok\">확인</button>"
			}
			layer.create(config);
			layerBannerList.initBannerGrid(data);
		}
		, updateUseYn : function(data, rowids) {
				messager.confirm( _BANNER_USE_YN_UPDATE, function(r){
					if(r) {
						var options = {
								url : _BANNER_USE_YN_UPDATE_URL
								, data : {
									bnrNo : data.bnrNo
									, useYn : 'Y'
								}
								, callBack : function(result) {
									$("#layerBannerList").jqGrid('setCell', rowids, 'useYn', 'Y');
								}
						};
						ajax.call(options);
					}
				});
		}
		, confirm : function() {
			var jsonArray = [];
			var grid = $("#layerBannerList");
			var rowids = null;
			if(bannerLayerOptions.multiselect ) {
				rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids == null || rowids == '') {
					messager.alert("추가할 목록을 선택해 주세요.", "info", "info");
					return;
				}
				for (var i = rowids.length - 1; i >= 0; i--) {
					jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
				}
				bannerLayerOptions.callBack(jsonArray);
				layer.close("bannerSearch");
				
			} else {
				rowids = grid.jqGrid('getGridParam', 'selrow');
				if(rowids == null || rowids == '') {
					messager.alert("추가할 목록을 선택해 주세요.", "info", "info");
					return;
				}
				var rowData = grid.jqGrid('getRowData', rowids);
				
				if(rowData.useYn == 'N') {
					layerBannerList.updateUseYn(rowData, rowids);
				} else {
					jsonArray.push(grid.jqGrid('getRowData', rowids));
					bannerLayerOptions.callBack(jsonArray);
					layer.close("bannerSearch");
				}
			}
		}
		, initBannerGrid : function(data) {
			var gridOptions = {
					url : _BANNER_GRID_URL
					, height : 350
					, searchParam : $("#bannerSearchForm").serializeJson()
					, colModels : [
						{name : "bnrNo",label : _BANNER_GRID_LABEL.bnrNo, width : "80", key : true, align : "center", hidden : true}
						, {name : "stId", label : _BANNER_GRID_LABEL.stId, width : "80", align : "center", hidden : true}
						//, {name : "bnrId",label : _BANNER_GRID_LABEL.bnrId, width : "100", align : "center"}
						, {name : "bnrTpCd",label : _BANNER_GRID_LABEL.bnrTpCd ,width : "100", align : "center", formatter:"select", editoptions : {value:_BANNER_TP}}
						, {name : "bnrMobileImgPath",label : _BANNER_GRID_LABEL.bnrMobileImgPath, width : "180", align : "center", formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "" && rowObject.bnrMobileImgPath != undefined) {
									return getImage(rowObject.bnrMobileImgPath, rowObject.bnrTtl)
								} else {
									return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
								}
							}
						}
						, {name : "bnrMoImgPath",label : _BANNER_GRID_LABEL.bnrMobileImgPath, width : "180", hidden : true, align : "center", formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "" && rowObject.bnrMobileImgPath != undefined) {
									return rowObject.bnrMobileImgPath;
								} else {
									return '';
								}
							}
						}
						, {name : "bnrImgPath",label : _BANNER_GRID_LABEL.bnrImgPath, width : "180", align : "center", hidden : true, formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "" && rowObject.bnrImgPath != undefined) {
									   return getImage(rowObject.bnrImgPath, rowObject.bnrTtl)
								} else {
									return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
								}
							}
						}
						, {name : "bnrPcImgPath",label : _BANNER_GRID_LABEL.bnrImgPath, width : "180", align : "center", hidden : true, formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "" && rowObject.bnrImgPath != undefined) {
									   return rowObject.bnrImgPath;
								} else {
									return '';
								}
							}
						}
						, {name : "bnrTtl",label : _BANNER_GRID_LABEL.bnrTtl,width : "450", align : "center", classes:'pointer fontbold'}
						, {name : "bnrLinkUrl",label : _BANNER_GRID_LABEL.bnrLinkUrl, width : "100", align : "center", hidden : true}
						, {name : "bnrMobileLinkUrl",label : _BANNER_GRID_LABEL.bnrMobileLinkUrl, width : "100", align : "center", hidden : true}
						, {name : "useYn", label : _BANNER_GRID_LABEL.useYn, width : "100", align : "center", formatter:"select", editoptions:{value:_USE_YN}}
						, {name : "sysRegrNm", label : _BANNER_GRID_LABEL.sysRegrNm, width : "100", align : "center"}
						, {name : "sysRegDtm", label : _BANNER_GRID_LABEL.sysRegDtm, width : "100", align : "center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT}
						, {name : "sysUpdrNm", label : _BANNER_GRID_LABEL.sysUpdrNm, width : "100", align : "center", hidden : true}
						, {name : "sysUpdDtm", label : _BANNER_GRID_LABEL.sysUpdDtm, width : "100", align : "center", hidden : true, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT}
					]
					, multiselect : bannerLayerOptions.multiselect
			}
			grid.create("layerBannerList", gridOptions);
		}
		, searchBannerList : function() {
			var options = {
				searchParam : $("#bannerSearchForm").serializeJson()
			};
			grid.reload("layerBannerList", options);
		}
		, searchReset : function() {
			resetForm("bannerSearchForm");
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#regStrtDtm").val("");
				$("#regEndDtm").val("");
			} else {
				setSearchDate(term, "regStrtDtm", "regEndDtm");
			}
		}
}

//시리즈 조회 검색 Layer
var seriesLayerOptions = {
		callBack : undefined
		, multiselect : false
};
var layerSeriesList = {
		create : function(option) {
			seriesLayerOptions = $.extend({}, seriesLayerOptions, option);
			var options = {
				url : _SERIES_SEARCH_LAYER_URL
				, data : {
					dispCornTpCd : option.dispCornTpCd == null ? undefined : option.dispCornTpCd
					, itemLength : option.itemLength == null ? undefined : option.itemLength
				}
				, dataType : "html"
				, callBack : layerSeriesList.callBackCreate
			}
			ajax.call(options);
		}
		, callBackCreate : function(data) {
			var config = {
					id : "seriesSearch"
					, height : 650
					, width : 1100
					, title : "시리즈 조회"
					, body : data
					, button : "<button type=\"button\" onclick=\"layerSeriesList.confirm();\" class=\"btn btn-ok\">확인</button>"
			}
			layer.create(config);
			layerSeriesList.initSeriesGrid(data);
		}
		, confirm : function() {
			var jsonArray = [];
			var grid = $("#layerSeriesList");
			var rowids = null;
			if(seriesLayerOptions.multiselect ) {
				rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids == null || rowids == '') {
					messager.alert("추가할 목록을 선택해 주세요.", "info", "info");
					return;
				}
				
				if(seriesLayerOptions.dispCornTpCd == "132") {
					var gridLength = seriesLayerOptions.itemLength*1
					var tagMaxCheck = gridLength + rowids.length
					if(tagMaxCheck > 50) {
						messager.alert("시리즈 50개까지 등록 가능합니다.", "info", "info");
						return;
					}
				}
				
				for (var i = rowids.length - 1; i >= 0; i--) {
					jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
				}
				seriesLayerOptions.callBack(jsonArray);
				layer.close("seriesSearch");
				
			} else {
				rowids = grid.jqGrid('getGridParam', 'selrow');
				if(rowids == null || rowids == '') {
					messager.alert("추가할 목록을 선택해 주세요.", "info", "info");
					return;
				}
				var rowData = grid.jqGrid('getRowData', rowids);
				
				jsonArray.push(grid.jqGrid('getRowData', rowids));
				bannerLayerOptions.callBack(jsonArray);
				layer.close("seriesSearch");
			}
		}
		, initSeriesGrid : function(data) {
			var gridOptions = {
				  url : _SERIES_GRID_URL
 				, height : 400 				
				, searchParam : $("#seriesListForm").serializeJson()
				, colModels : [
					{name:"srisNo", 			label:_SERIES_GRID_LABEL.srisNo, hidden:true,	width:"60", 	align:"center", sortable:false}/* 번호 */
					, {name:"rowIndex", 		label:_SERIES_GRID_LABEL.rowIndex, width:"80", align:"center", sortable:false}
					, {name:"srisId", 			label:_SERIES_GRID_LABEL.srisId, width:"200", 	align:"center", sortable:false, classes:'pointer fontbold'}/* 시리즈ID */					
					, {name:"srisNm", 			label:_SERIES_GRID_LABEL.srisNm, width:"500", 	align:"left", sortable:false, classes:'pointer fontbold'} /* 시리즈명 */
					, {name:"sesnCnt",			label:_SERIES_GRID_LABEL.sesnCnt, width:"100", 	align:"center", sortable:false} /* 시즌수 */
					, {name:"tpCd", 			label:_SERIES_GRID_LABEL.tpCd,  align:"left", 	sortable:false, width:"180"
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:_SERIES_APET_TP}}  /* 타입 */ 
					, {name:"dispYn", 			label:_SERIES_GRID_LABEL.dispYn, align:"center", sortable:false, width:"180"
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:_SERIES_DISP_STAT}}  /* 전시 */
					, {name:"regModDtm",		label:_SERIES_GRID_LABEL.regModDtm,  align:"center", width:"200", sortable:false} /* 등록수정일 */
					, {name:"flNo", 			label:'', hidden:true,	width:"60", 	align:"center", sortable:false}/* file번호 */
	                ]
				, onCellSelect : function(id, cellidx, cellvalue) {
					if(cellidx == 4) {
						var rowData = $("#layerSeriesList").getRowData(id);
						var srisNo = rowData.srisNo;						
						addTab('시리즈 상세', '/series/seriesDetailView.do?srisNo='+srisNo);
					}
				}
				, multiselect : true
				, gridComplete : function (){
					jQuery("#layerSeriesList").jqGrid( 'setGridWidth', $(".mModule").width() );
				}
			}
			grid.create("layerSeriesList", gridOptions);
		}
		, searchSeriesList : function() {
			if($("#seriesSearchForm #sysRegDtmStart").val() > $("#seriesSearchForm #sysRegDtmEnd").val()){
				messager.alert("등록일 검색기간 시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info");
				return;
			}
			
			if(validate.check("seriesSearchForm")) {
				var options = {
					searchParam : $("#seriesSearchForm").serializeJson()
				};
				grid.reload("layerSeriesList", options);
			}
		}
		, searchReset : function() {
			resetForm("seriesSearchForm");
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#seriesSearchForm #sysRegDtmStart").val("");
				$("#seriesSearchForm #sysRegDtmEnd").val("");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
}

//상품평 검색 Layer
var goodsCommentLayerOptions = {
	compNo : null
	, callBack : undefined
	, multiselect : false
};
var layerGoodsCommentList = {
	create : function (option ) {
		goodsCommentLayerOptions = $.extend( {}, goodsCommentLayerOptions, option );
		var options = {
			url : _GOODS_COMMENT_SEARCH_LAYER_URL
			, data : {
				compNo : goodsCommentLayerOptions.compNo
			}
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "goodsCommentSearch"
			, width : 1200
			, height : 800
			, title : "상품평 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerGoodsCommentList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerGoodsCommentList.initGoodsCommentGrid();
	}
	, initGoodsCommentGrid : function () {
		var gridOptions = {
			url : _GOODS_COMMENT_GRID_URL
			, height : 300
			, searchParam : $("#displayGoodsCommentListForm").serializeJson()
			, colModels : [
				{name:"goodsEstmNo", label:_GOODS_COMMENT_GRID_LABEL.goodsEstmNo, width:"100", key: true, align:"center"} /* 상품 평가 번호 */
				, {name:"estmId", label:_GOODS_COMMENT_GRID_LABEL.estmId, width:"100", align:"center", sortable:false } /* 로그인 ID */
				, {name:"mbrNm", label:_GOODS_COMMENT_GRID_LABEL.mbrNm, width:"100", align:"center", sortable:false } /* 회원명 */
				, {name:"ttl", label:_GOODS_COMMENT_GRID_LABEL.ttl, width:"300", align:"center", sortable:false } /* 제목 */
				, {name:"imgRegYn", label:_GOODS_COMMENT_GRID_LABEL.imgRegYn, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_IMAGE_YN } } /* 이미지 여부 */
				, {name:"sysDelYn", label:_GOODS_COMMENT_GRID_LABEL.sysDelYn, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_DEL_YN } } /* 삭제여부 */
				, {name:"goodsId", label:_GOODS_COMMENT_GRID_LABEL.goodsId, width:"100", align:"center", sortable:false } /* 상품 ID */
				, {name:"goodsNm", label:_GOODS_COMMENT_GRID_LABEL.goodsNm, width:"200", align:"center", sortable:false } /* 상품명 */
				, {name:"sysRegDtm", label:_GOODS_COMMENT_GRID_LABEL.sysRegDtm, width:"200", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT } ]
			, multiselect : goodsCommentLayerOptions.multiselect
		}
		grid.create("layerGoodsCommentList", gridOptions);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerGoodsCommentList" );
		var rowids = null;
		if(goodsCommentLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		goodsCommentLayerOptions.callBack (jsonArray );
		layer.close("goodsCommentSearch");
	}
	, searchGoodsCommentList : function () {
		var options = {
			searchParam : $("#displayGoodsCommentListForm").serializeJson()
		};
		grid.reload("layerGoodsCommentList", options);
	}
	, searchReset : function () {
		resetForm ("displayGoodsCommentListForm" );
	}
	, searchCompany : function () {
		var options = {
			multiselect : false
			, callBack : this.searchCompanyCallback
		}
		layerCompanyList.create (options );
	}
	, searchCompanyCallback : function (compList ) {
		if(compList.length > 0 ) {
			$("#displayGoodsCommentListForm #compNo").val (compList[0].compNo );
			$("#displayGoodsCommentListForm #compNm").val (compList[0].compNm );
		}
	}
}

//--------------------------------------------------------------------------------//
//History Layer
var historyLayerOptions = {
	histGb : null
	, goodsId : null
	, bomCd : null
}
var layerHistoryList = {
	create : function (option ) {
		historyLayerOptions = $.extend( {}, historyLayerOptions, option );
		var options = {
			url : _HISTORY_VIEW_LAYER_URL
			, data : historyLayerOptions
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "historyView"
			, width : 800
			, height : 650
			, title : "이력 조회"
			, body : data
		};
		layer.create(config );
		layerHistoryList.initHistoryGrid();
	}
	, initHistoryGrid : function () {
		var histGb = $("#historyListForm #histGb").val();
		var gridUrl = '';
		var colModels;
		if(histGb === 'GOODS_DETAIL' ) {
			gridUrl = _GOODS_HISTORY_GRID_URL;
			colModels = [
				  _GRID_COLUMNS.sysRegDtm
				, _GRID_COLUMNS.sysRegrNm
				, {name:"histNo", label:_HISTORY_VIEW_GRID_LABEL.histNo , width:"110", align:"center"}
				, _GRID_COLUMNS.goodsId
				, _GRID_COLUMNS.goodsNm
				, {name:"bndNo", label:_HISTORY_VIEW_GRID_LABEL.bndNo , width:"100", align:"center"}
				, _GRID_COLUMNS.goodsStatCd
				, {name:"ntfId", label:_HISTORY_VIEW_GRID_LABEL.ntfId , width:"80", align:"center"}
				, {name:"mdlNm", label:_HISTORY_VIEW_GRID_LABEL.mdlNm , width:"120", align:"center"}
				, _GRID_COLUMNS.compNo
				, {name:"kwd", label:_HISTORY_VIEW_GRID_LABEL.kwd , width:"150", align:"center"}
				, {name:"ctrOrg", label:_HISTORY_VIEW_GRID_LABEL.ctrOrg , width:"150", align:"center"}
				, {name:"minOrdQty", label:_HISTORY_VIEW_GRID_LABEL.minOrdQty , width:"100", align:"center"}
				, {name:"maxOrdQty", label:_HISTORY_VIEW_GRID_LABEL.maxOrdQty , width:"100", align:"center"}
				, {name:"dlvrMtdCd", label:_HISTORY_VIEW_GRID_LABEL.dlvrMtdCd , width:"100", align:"center", formatter:"select", editoptions:{value:_COMP_DLVR_MTD_CD } }
				, {name:"dlvrcPlcNo", label:_HISTORY_VIEW_GRID_LABEL.dlvrcPlcNo , width:"100", align:"center"}
				, {name:"compPlcNo", label:_HISTORY_VIEW_GRID_LABEL.compPlcNo , width:"100", align:"center"}
				, {name:"prWds", label:_HISTORY_VIEW_GRID_LABEL.prWds , width:"150", align:"center"}
				, {name:"freeDlvrYn", label:_HISTORY_VIEW_GRID_LABEL.freeDlvrYn, width:"100", align:"center", formatter:"select", editoptions:{value:_COMM_YN } }
				, {name:"importer", label:_HISTORY_VIEW_GRID_LABEL.importer , width:"100", align:"center"}
				, {name:"mmft", label:_HISTORY_VIEW_GRID_LABEL.mmft , width:"100", align:"center"}
				, {name:"taxGbCd", label:_HISTORY_VIEW_GRID_LABEL.taxGbCd, width:"100", align:"center", formatter:"select", editoptions:{value:_TAX_GB_CD } }
				, {name:"stkMngYn", label:_HISTORY_VIEW_GRID_LABEL.stkMngYn, width:"100", align:"center", formatter:"select", editoptions:{value:_COMM_YN } }
				, {name:"mdUsrNo", label:_HISTORY_VIEW_GRID_LABEL.mdUsrNo , width:"100", align:"center"}
				, {name:"pplrtRank", label:_HISTORY_VIEW_GRID_LABEL.pplrtRank , width:"100", align:"center"}
				, {name:"pplrtSetCd", label:_HISTORY_VIEW_GRID_LABEL.pplrtSetCd, width:"100", align:"center", formatter:"select", editoptions:{value:_PPLRT_SET_CD } }
				, {name:"saleStrtDtm", label:_HISTORY_VIEW_GRID_LABEL.saleStrtDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"saleEndDtm", label:_HISTORY_VIEW_GRID_LABEL.saleEndDtm, width:"150", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, _GRID_COLUMNS.showYn
				, {name:"compGoodsId", label:_HISTORY_VIEW_GRID_LABEL.compGoodsId , width:"150", align:"center"}
				, {name:"webMobileGbCd", label:_HISTORY_VIEW_GRID_LABEL.webMobileGbCd, width:"100", align:"center", formatter:"select", editoptions:{value:_WEB_MOBILE_GB_CD } }
				, {name:"rtnPsbYn", label:_HISTORY_VIEW_GRID_LABEL.rtnPsbYn, width:"100", align:"center", formatter:"select", editoptions:{value:_COMM_YN } }
				, {name:"rtnMsg", label:_HISTORY_VIEW_GRID_LABEL.rtnMsg , width:"150", align:"center"}
				, {name:"prWdsShowYn", label:_HISTORY_VIEW_GRID_LABEL.prWdsShowYn, width:"110", align:"center", formatter:"select", editoptions:{value:_SHOW_YN } }
				, {name:"itemMngYn", label:_HISTORY_VIEW_GRID_LABEL.itemMngYn, width:"100", align:"center", formatter:"select", editoptions:{value:_COMM_YN } }
				, {name:"goodsTpCd", label:_HISTORY_VIEW_GRID_LABEL.goodsTpCd, width:"100", align:"center", formatter:"select", editoptions:{value:_GOODS_TP_CD } }
				, {name:"bigo", label:_HISTORY_VIEW_GRID_LABEL.bigo , width:"150", align:"center"}
				//, {name:"vdLinkUrl", label:_HISTORY_VIEW_GRID_LABEL.vdLinkUrl , width:"150", align:"center"}
				//, {name:"hits", label:_HISTORY_VIEW_GRID_LABEL.hits , width:"150", align:"center"}
			];
		}/* else if (histGb === 'BOM_DETAIL' ) {
			gridUrl = _BOM_HISTORY_GRID_URL;
		} */else if (histGb === 'ITEM_DETAIL' ) {
			gridUrl = _ITEM_HISTORY_GRID_URL;
			colModels = [
				{name:"columnId", label:_HISTORY_VIEW_GRID_LABEL.columnId , width:"100", align:"center", hidden:true}
				, {name:"sysUpdDtm", label:_HISTORY_VIEW_GRID_LABEL.sysUpdDtm , width:"150", align:"center", formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				, {name:"columnNm", label:_HISTORY_VIEW_GRID_LABEL.columnNm , width:"120", align:"center", sortable:false }
				, {name:"value1", label:_HISTORY_VIEW_GRID_LABEL.value1 , width:"170", align:"center", sortable:false }
				, {name:"value2", label:_HISTORY_VIEW_GRID_LABEL.value2 , width:"170", align:"center", sortable:false }
				, {name:"sysUpdrNm", label:_HISTORY_VIEW_GRID_LABEL.sysUpdrNm , width:"90", align:"center"}
			];
		}
		var gridOptions = {
			url : gridUrl
			, height : 300
			, searchParam : $("#historyListForm").serializeJson()
			, paging : false
			, colModels : colModels
		}
		grid.create("historyList", gridOptions);
	}
	, searchHistoryList : function () {
		var options = {
			searchParam : $("#historyListForm").serializeJson()
		};
		grid.reload("historyList", options);
	}
	, searchReset : function (histGb, goodsId) {
		resetForm ("historyListForm" );
		$("#historyListForm #histGb").val(histGb);
		$("#historyListForm #goodsId").val(goodsId);
		layerHistoryList.searchDateChange();
	}
	, searchDateChange : function () {
		var term = $("#historyListForm #checkOptDate").children("option:selected").val();
		if(term === "") {
			$("#historyListForm #sysRegDtmStart").val("");
			$("#historyListForm #sysRegDtmEnd").val("");
		} else {
			setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
		}
	}

};

//--------------------------------------------------------------------------------//
//Brand 콘텐츠 검색 Layer
var brandCntsLayerOptions = {
	callBack : undefined
	, multiselect : false
};
var layerBrandCntsList = {
	create : function (option ) {
		brandCntsLayerOptions = $.extend( {}, brandCntsLayerOptions, option );
		var options = {
			url : _BRAND_CNTS_SEARCH_LAYER_URL
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "brandCntsSearch"
			, width : 1000
			, height : 650
			, title : "브랜드 콘텐츠 조회"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerBrandCntsList.confirm();\" class=\"btn btn-ok\">확인</button>"
		};
		layer.create(config);
		layerBrandCntsList.initBrandCntsGrid();
	}
	, initBrandCntsGrid : function () {
		var gridOptions = {
			url : _BRAND_CNTS_GRID_URL
			, height : 200
			, searchParam : $("#brandCntsListForm").serializeJson()
			, colModels : [
			               {name:"bndCntsNo", label:_BRAND_CNTS_SEARCH_GRID_LABEL.bndCntsNo, width:"100", key: true, align:"center"} /* 브랜드 콘텐츠 번호 */
			               , {name:"bndNo", label:_BRAND_CNTS_SEARCH_GRID_LABEL.bndNo, width:"100", align:"center"} /* 브랜드 번호 */
			               , {name:"bndNmKo", label:_BRAND_CNTS_SEARCH_GRID_LABEL.bndNmKo, width:"200", align:"center", sortable:false } /* 브랜드 국문 */
			               , {name:"bndNmEn", label:_BRAND_CNTS_SEARCH_GRID_LABEL.bndNmEn, width:"200", align:"center", sortable:false } /* 브랜드 영문 */
			               // 콘텐츠 구분 코드
			               , {name:"cntsGbCd", label:_BRAND_CNTS_SEARCH_GRID_LABEL.cntsGbCd, width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:_CNTS_GB } }
			               // 타이틀
			               , {name:"cntsTtl", label:_BRAND_CNTS_SEARCH_GRID_LABEL.cntsTtl, width:"200", align:"center"}
			               // 콘텐츠 이미지 경로
			               , {name:"cntsImgPath", label:_BRAND_CNTS_SEARCH_GRID_LABEL.cntsImgPath, width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
				            	   if(rowObject.cntsImgPath !== "") {
				            		   return '<img src="'+imgUrl + rowObject.cntsImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.cntsImgPath + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
			               // 콘텐츠 모바일 이미지 경로
			               , {name:"cntsMoImgPath", label:_BRAND_CNTS_SEARCH_GRID_LABEL.cntsMoImgPath, width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
			            	   		if(rowObject.cntsMoImgPath !== "") {
			            		   		return '<img src="'+imgUrl + rowObject.cntsMoImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.cntsMoImgPath + '" />';
			            	   		} else {
			            	   			return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 썸네일 이미지 경로
							, {name:"tnImgPath", label:_BRAND_CNTS_SEARCH_GRID_LABEL.tnImgPath, width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.tnImgPath !== "") {
										return '<img src="'+imgUrl + rowObject.tnImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.tnImgPath + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 썸네일 모바일 이미지 경로
							, {name:"tnMoImgPath", label:_BRAND_CNTS_SEARCH_GRID_LABEL.tnMoImgPath, width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.tnMoImgPath !== "") {
										return '<img src="'+imgUrl + rowObject.tnMoImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.tnMoImgPath + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
			]
			, multiselect : brandCntsLayerOptions.multiselect
		}
		grid.create("layerBrandCntsList", gridOptions);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerBrandCntsList" );
		var rowids = null;
		if(brandCntsLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		brandCntsLayerOptions.callBack (jsonArray );
		layer.close("brandCntsSearch");
	}
	, searchBrandCntsList : function () {
		var options = {
			searchParam : $("#brandCntsListForm").serializeJson()
		};
		grid.reload("layerBrandCntsList", options);
	}
	, searchReset : function () {
		resetForm ("brandCntsListForm" );
	}
};

//--------------------------------------------------------------------------------//
//제외상품 일괄업로드 Layer
var goodsExListExcelUploadLayerOptions = {
	callBack : undefined
	, multiselect : false
};
var layerGoodsExListExcelUpload = {
	create : function (option ) {
		goodsExListExcelUploadLayerOptions = $.extend( {}, goodsExListExcelUploadLayerOptions, option );
		var options = {
			url : _GOODS_EX_LIST_EXCEL_UPLOAD_LAYER_URL
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : "goodsExListExcelUpload"
			, width : 800
			, height : 800
			, title : "제외상품 일괄업로드"
			, body : data
			, button : "<button type=\"button\" onclick=\"layerGoodsExListExcelUpload.confirm();\" class=\"btn btn-ok\">확인</button>"
		}
		layer.create(config);
	}
	, confirm : function () {
		var jsonArray = [];
		var message = [];
		var grid = $("#resultList" );
		var rowids = null;
		var check = true;
		rowids = grid.jqGrid('getGridParam', 'selarrrow');
		if (rowids == null || rowids.length == 0 || rowids === ''){
			messager.alert("선택된 대상이 없습니다.", "Info", "info");
			return;
		}
		for (var i = rowids.length - 1; i >= 0; i--) {
			if(jsonArray.length > 0 ){
				for (var j = jsonArray.length - 1; j >= 0; j--) {
					if (jsonArray[j].goodsId  ===  grid.jqGrid('getRowData', rowids[i]).goodsId ){
						message.push( grid.jqGrid('getRowData', rowids[i]).goodsId + " 중복된 상품입니다.");
						check = false ;
					}
				}
			}
			if (grid.jqGrid('getRowData', rowids[i]).resultYN  === '성공'){
				jsonArray.push( grid.jqGrid('getRowData', rowids[i])      );
			}else if(grid.jqGrid('getRowData', rowids[i]).resultYN  === '실패') {
				check = false ;
				message.push( grid.jqGrid('getRowData', rowids[i]).goodsId + " 조회가 안된 상품입니다.");
			}
		}
		if (!check){
			if(message.length > 0) {
				messager.alert(message.join("<br>"), "Info", "info");
			}
		}else{
			fnGoodsExListExcelUploadPopCallBack(jsonArray);
			layer.close("goodsExListExcelUpload");
		}

	}
};





var layerMessageList = {
	create : function (mode, userNo) {
		var options = {
       		url : '/common/userMessageListViewPop.do'
       		, data : {mode : mode}
       		, dataType : "html"
       		, callBack : function (data ) {
       			var config = {
       				id : "userMessageListView"
       				, width : 900
       				, height : 700
       				, top : 200
       				, title : "메세지함 목록"
       				, body : data
       				, button : "<button type=\"button\" onclick=\"userMessage(0, " + userNo + ");\" class=\"btn btn-ok\">메세지 쓰기</button>"
       			}
       			layer.create(config);
       		}
       	}
       	ajax.call(options );
	}
	,close : function() {
		layer.close("userMessageListView");
	}
};


//--------------------------------------------------------------------------------//
//Tag그룹 Tree 조회 Layer
var layerTagGroupList = {
	option : {
		callBack : undefined
		, multiselect : true
		, plugins : [ "themes" ]
	}
	,create : function (option ) {
		var stIdVal= option.stId;
		this.option = $.extend( {}, this.option, option );
		var options = {
			url : "/tag/tagGroupLayerView.do"
			, data : {  }
			, dataType : "html"
			, callBack : this.callBackCreate
		};
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
				id : "tagGroupSearch"
				, width : 350
				, height : 500
				, title : "Tag Group 선택"
				, body : data
				, button : "<button type=\"button\" onclick=\"layerTagGroupList.confirm();\" id=\"tagGroupSelectBtn\" class=\"btn btn-ok\" disabled=\"disabled\">확인</button>"
			};
		
		layer.create(config);
		layerTagGroupList.initDisplayTree();
	}
	, initDisplayTree : function () {
		
		$("#layerTagGroupList").jstree({
			core : {
				multiple : this.option.multiselect
				, data : {
					type : "POST"
					, url : function(node) {
						return "/tag/tagGroupTree.do";
					}
					/*, data : function (node) {
						var data = null;
						return data;
					}*/
				}
			}
			, plugins : this.option.plugins
		})
		.bind("ready.jstree", function (event, data) {
			$("#layerTagGroupList").jstree("open_node", $("#layerTagGroupList > ul > li"));
		})
		.on("select_node.jstree Event", function(e, data){
			if (data.selected.length > 0) {
				$("#tagGroupSelectBtn").prop("disabled", false);
			}
		})
		.on("deselect_node.jstree Event", function(e, data){
			let selectArr = $("#layerTagGroupList").jstree().get_selected();
			if (selectArr.length == 0) {
				$("#tagGroupSelectBtn").prop("disabled", true);
			}
		});
	}
	, confirm : function () {
		var arrId = $("#layerTagGroupList").jstree().get_selected();
		var result = [];
		for(var i in arrId) {
			var data = $("#layerTagGroupList").jstree().get_node(arrId[i]);

			if(this.option.plugins.indexOf("checkbox") > -1) {
				if(data.children == null || data.children.length === 0){
					result.push({
						tagGrpNo : data.id
						//, grpNm : data.text
						, upGrpNo : data.original.parent
						, grpNm : data.original.pathText
					});
				}
			} else {
				result.push({
					  tagGrpNo : data.id
					//, grpNm : data.text
					, upGrpNo : data.original.parent
					, grpNm : data.original.pathText
				});
			}
		}

		this.option.callBack(result);

		layer.close("tagGroupSearch");
	}	

};

//--------------------------------------------------------------------------------//
//Tag 검색 팝업 Layer
var tagBaseLayerOptions = {
		callBack : undefined
		, multiselect : false
	};

var layerTagBaseList = {
		create : function (option) {
			tagBaseLayerOptions = $.extend( {}, tagBaseLayerOptions, option );
			var options = {
				url : _TAG_BASE_SEARCH_LAYER_URL
				, data : {
					
				}
				, dataType : "html"
				, callBack : this.callBackCreate
			};
			ajax.call(options );
		}
		, callBackCreate : function (data) {
			var config = {
				id : "tagBaseSearch"
				, width : 1000
				, height : 750
				, top : 50
				, title : "Tag 선택"
				, body : data
				, button : "<button type=\"button\" id=\"btn_tagBaseOk\" onclick=\"layerTagBaseList.confirm();\" class=\"btn btn-ok\" disabled=\"\">확인</button>"
				, status : false
			};
			layer.create(config);
			layerTagBaseList.initTagBaseGrid();
			layerTagBaseList.createDisplayCategory(1,"0");
		}
		, initTagBaseGrid : function () {
			var gridOptions = {
				url : _TAG_BASE_GRID_URL
				, height : 300
				, searchParam : $("#tagBaseSearchForm").serializeJson()
				, sortname : 'tagNm'
				, sortorder : 'DESC'
				, colModels : [
//					{name:"tagNo", label:_TAG_BASE_SEARCH_GRID_LABEL.tagNo , width:"110", hidden:true, key: true} 	
//					, {name:"tagNm", label:_TAG_BASE_SEARCH_GRID_LABEL.tagNm , width:"180", align:"center"}
//					, {name:"grpNm", label:_TAG_BASE_SEARCH_GRID_LABEL.grpNm , width:"180", align:"left"}
//					, {name:"rltTagCnt", label:_TAG_BASE_SEARCH_GRID_LABEL.rltTagCnt , width:"180", align:"center"}
//					, {name:"rltCntsCnt", label:_TAG_BASE_SEARCH_GRID_LABEL.rltCntsCnt , width:"180", align:"center"}
//					, {name:"rltGoodsCnt", label:_TAG_BASE_SEARCH_GRID_LABEL.rltGoodsCnt , width:"180", align:"center"}
//					, {name:"statCd", label:_TAG_BASE_SEARCH_GRID_LABEL.statCd ,width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:_TAG_STAT } }
//					, _GRID_COLUMNS.sysRegrNm
//					, _GRID_COLUMNS.sysRegDtm
					{name:"tagNo",  label:"Tag ID", width:"200", align:"center",  hidden:false, key:true}
					, {name:"rowIndex", label:"No", width:"200", align:"center", sortable:false, hidden:true}
					, {name:"tagNm", label:"Tag 명", width:"400", align:"center", sortable:false, classes:'pointer fontbold'}
//					, {name:"statCd", label:"상태",width:"150", align:"center", sortable:false, hidden:true}
					, {name:"sysRegDtm", label:"등록일", width:'200', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
				]
				, multiselect : tagBaseLayerOptions.multiselect	
				, onSelectAll: function(aRowids, status) {
					if( status ){
						$("#btn_tagBaseOk").prop("disabled", false);
						
						$.each(aRowids, function(index, rowid){
							var rowData = $('#layerTagBaseList').getRowData(rowid);
							if($('#add_'+rowid).length == 0){
								var tagHtml = '';
								tagHtml += '<span class="rcorners1 selectedTag" id="add_'+rowid+'" data-tag="'+rowid+'" data-tag-nm="'+rowData['tagNm']+'">'+rowData['tagNm']+'</span>' 
								tagHtml += '<img id="add_'+rowid+'Delete" onclick="layerTagBaseList.deleteTag(\'add_'+rowid+'\',\''+rowData['tagNm']+'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg">'
								$('#addGoodsTags').append(tagHtml);
							}
						})
					
						/*var check = true;
						var uniqueTagNames = new Array();
						var selTags = new Array();
						for(var i = 0; i < id.length; i++) {
							var rowData = $("#layerTagBaseList").getRowData(id[i]);	
							if($.inArray(rowData.tagNm, uniqueTagNames) === -1){ 
								// tagNm 만 비교.							
								uniqueTagNames.push(rowData.tagNm);
								var selData = {
										tagNo : rowData.tagNo
										,tagNm : rowData.tagNm
								}		
								selTags.push(selData);
							}
						}
							
						for(var j = 0; j < selTags.length; j++) {	
							check = true;
							$(".selectedTag").each(function(i, v){								
								var tagName = $("#"+v.id).attr('tag-nm');								
								if (tagName == selTags[j].tagNm) {
									check = false;
									//$('#layerTagBaseList').jqGrid('setSelection', rowData.tagNo).prop('checkbox', chk);
									return false;
								}else{
									check = true;
								}
							});							
							
							if(!check){
								//messager.alert("이미 동일한 태그가 선택되어 있습니다.");
							}							
							else{					
								//$('#layerTagBaseList').jqGrid('setSelection', id).prop('checkbox', false);
								var html = '<span class="rcorners1 selectedTag" tag-nm="' + selTags[j].tagNm +'" id="sel_' + selTags[j].tagNo + '">' + selTags[j].tagNm + '</span>' 
								+ '<img id="sel_' + selTags[j].tagNo + 'Delete" onclick="layerTagBaseList.deleteTag(\'sel_' + selTags[j].tagNo + "\',\'"+ selTags[j].tagNm +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
			
								$("#tags").append (html);		
							}
						}*/
					}else{
						$("#btn_tagBaseOk").prop("disabled", true);

						$.each(aRowids, function(index, rowid){
							if($('#add_'+rowid).length > 0){
								var tagHtml = '';
								$('#add_'+rowid).remove();
								$('#add_'+rowid+'Delete').remove();
							}
						})
					}
				}				
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#layerTagBaseList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='5' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#layerTagBaseList.ui-jqgrid-btable").append(str);
					}else{
						if($('#addGoodsTags span[id^=add_]').length > 0){
							var addTagList = $('#addGoodsTags span[id^=add_]');
							for(var i = 0; i < addTagList.length; i++){
								var tagId = $(addTagList[i]).data('tag');
								$('#'+ tagId).trigger('click');
							}
							
						}
					}
				}
				, onSelectRow : function(rowid, status, e) {
					var s = $("#layerTagBaseList").jqGrid('getGridParam', 'selarrrow');
					if(s.length > 0){
						$("#btn_tagBaseOk").prop("disabled", false);
					}else{
						$("#btn_tagBaseOk").prop("disabled", true);
					}
					
					if(status){
						var rowData = $('#layerTagBaseList').getRowData(rowid);
						if($('#add_'+rowid).length == 0){
							var tagHtml = '';
							tagHtml += '<span class="rcorners1 selectedTag" id="add_'+rowid+'" data-tag="'+rowid+'" data-tag-nm="'+rowData['tagNm']+'">'+rowData['tagNm']+'</span>' ;
							tagHtml += '<img id="add_'+rowid+'Delete" onclick="layerTagBaseList.deleteTag(\'add_'+rowid+'\',\''+rowData['tagNm']+'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg">';
							$('#addGoodsTags').append(tagHtml);
						}
					}else{
						if($('#add_'+rowid).length > 0){
							$('#add_'+rowid).remove();
							$('#add_'+rowid+'Delete').remove();
						}
					}
				}
			};
			grid.create("layerTagBaseList", gridOptions);
		}
		, confirm : function () {
			var jsonArray = [];
			var tagList = $('#addGoodsTags span[id^=add_]');
			
			if(tagList.length > 0){
				for(var i = 0; i < tagList.length; i++){
					var data = {
						tagNo : $(tagList[i]).data('tag')
						, tagNm : $(tagList[i]).data('tagNm')
					}
					jsonArray.push(data);
				}
				
				tagBaseLayerOptions.callBack (jsonArray);
				layer.close("tagBaseSearch");
				if($("div[class~=tagListformError]").hasClass("formError")) {
					$("div[class~=tagListformError]").css("display", "none");
				}
			}else{
				messager.alert('추가할 Tag 정보가 없습니다.', "Info", "info");
			}
		}
		, searchList : function () {
			if(validate.check("tagBaseSearchForm")) {
				var options = {
					searchParam : $("#tagBaseSearchForm").serializeJson()
				};
				grid.reload("layerTagBaseList", options);
			}
		}
		, searchReset : function () {
			resetForm ("tagBaseSearchForm" );
			layerTagBaseList.searchList();
			layerTagBaseList.createDisplayCategory(1,"0");
		}
		, createDisplayCategory : function (dispLvl, upGrpNo) {
			
			var selectCategory = "<option value='' selected='selected'>선택</option>";
			if (dispLvl == 0) {
				jQuery("#searchTagGroup" + (dispLvl+1)).html("");
				jQuery("#searchTagGroup" + (dispLvl+1)).append(selectCategory);
				jQuery("#searchTagGroup" + (dispLvl+2)).hide();
				jQuery("#searchTagGroup" + (dispLvl+3)).hide();
				jQuery("#tagBaseSearchForm #tagGrpNo").val("");
			} else {
				jQuery("#searchTagGroup" + (dispLvl)).html("");
				jQuery("#searchTagGroup" + (dispLvl)).hide();
				jQuery("#searchTagGroup" + (dispLvl+1)).hide();
				jQuery("#searchTagGroup" + (dispLvl+2)).hide();

				if (dispLvl == 1) {
					jQuery("#searchTagGroup" + (dispLvl)).show();
				}

				if (upGrpNo != "") {
					var options = {
						url : "/tag/listDisplayTagGroup.do"
						, data : {
							upGrpNo : upGrpNo
							, stat : "Y"
						}
						, callBack : function(result) {
							if (result.length > 0) {
			 					jQuery(result).each(function(i){
			 						selectCategory += "<option value='" + result[i].tagGrpNo + "'>" + result[i].grpNm + "</option>";
								});
								jQuery("#searchTagGroup" + (dispLvl)).show();
							}
							jQuery("#searchTagGroup" + (dispLvl)).append(selectCategory);
						}
					};
					ajax.call(options);
				}
			}
		}
		, searchTagGroup1Change : function() {
			var displayCategory = $("#searchTagGroup1").val();
			jQuery("#tagBaseSearchForm #tagGrpNo").val(displayCategory);
			searchTagGroup1 = displayCategory;
			layerTagBaseList.createDisplayCategory(2, displayCategory);
		}		
		, searchTagGroup2Change : function() {
			var displayCategory = $("#searchTagGroup2").val();

			if (displayCategory == "") {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(searchTagGroup1);
			} else {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(displayCategory);
				searchTagGroup2 = displayCategory;
			}

			layerTagBaseList.createDisplayCategory(3, displayCategory);
		}		
		, searchTagGroup3Change : function() {
			var displayCategory = $("#searchTagGroup3").val();

			if (displayCategory == "") {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(searchTagGroup2);
			} else {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(displayCategory);
				searchTagGroup3 = displayCategory;
			}

			layerTagBaseList.createDisplayCategory(4, displayCategory);
		}
		, searchTagGroup4Change : function() {
			var displayCategory = $("#searchTagGroup4").val();

			if (displayCategory == "") {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(searchTagGroup3);
			} else {
				jQuery("#tagBaseSearchForm #tagGrpNo").val(displayCategory);
			}
		}, deleteTag : function(tagNo, tagNm) {
			if (tagNm == undefined) {
				let firId = $("span[id^='grp_']")[0].id;
				$("#"+ tagNo).remove();
				if (firId == tagNo) {
					$("#"+ tagNo + "Delete").next("br").remove();
				}
			}
			$("#"+ tagNo).remove();
			$("#"+ tagNo + "Delete").remove();
			$("#"+ tagNo + "Br").remove();
			
			if(tagNo.indexOf('add_') != -1){
				console.log(tagNo.split('_')[1]);
				$('#'+tagNo.split('_')[1]).trigger('click');
			}
			
		}
	};

//--------------------------------------------------------------------------------//
//Tag 상세 팝업 Layer
var tagBaseDetailLayerOptions = {
		tagNo : null
	};

var layerTagBaseDetail = {
		create : function (option ) {
			$.extend(tagBaseDetailLayerOptions, option);
			var options = {
				url : _TAG_BASE_DETAIL_LAYER_URL
				, data : {
					tagNo : option.tagNo == null ? undefined : option.tagNo
				}
				, dataType : "html"
				, callBack : this.callBackCreate
			};
			ajax.call(options );
		}
		, callBackCreate : function (data) {
			var config = {
				id : "tagBaseDetail"
				, width : 900
				, height : 650
				, top : 50
				, title : "Tag 상세"
				, body : data
			};	
			layer.create(config);
		}
	};

//--------------------------------------------------------------------------------//
//Tag 관련 상품 팝업 Layer
var tagGoodsLayerOptions = {
		callBack : undefined
		, tagNo : null
		, tagNm : null
	};

var layerTagGoodsList = {
		create : function (option ) {
			$.extend(tagGoodsLayerOptions, option);
			var options = {
				url : _TAG_GOODS_LAYER_URL
				, data : {
					tagNo : option.tagNo == null ? undefined : option.tagNo
					,tagNm : option.tagNm == null ? undefined : option.tagNm		
				}
				, dataType : "html"
				, callBack : this.callBackCreate
			};
			ajax.call(options );
		}
		, callBackCreate : function (data) {
			var config = {
				id : "tagGoodsList"
				, width : 830
				, height : 650
				, top : 50
				, title : "Tag 관련 상품"
				, body : data
			};
			layer.create(config);
			layerTagGoodsList.initTagGoodsListGrid();
		}
		, initTagGoodsListGrid : function () {
			var gridOptions = {
				url : _TAG_GOODS_LIST_GRID_URL
				, height : 300
				, searchParam : $("#tagGoodsListForm").serializeJson()
				, sortname : 'sysRegDtm'
				, sortorder : 'DESC'
				, colModels : [
					{name:"rltGb", label:_TAG_RLT_LIST_GRID_LABEL.rltGb , width:"100", align:"center", sortable:false} 	
					, {name:"rltTp", label:_TAG_RLT_LIST_GRID_LABEL.rltTp , width:"80", align:"center", sortable:false} 	
					//, {name:"rltId", label:"ID" , width:"110", align:"center", classes:'pointer fontbold'} 	
					, {name:"rltNm", label:_TAG_RLT_LIST_GRID_LABEL.rltNm , width:"280", align:"center", sortable:false, classes:'pointer fontbold'} 		
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
					, {name:"rltId", key: true, hidden:true}
				]
				,rownumbers: true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 3) {
						let goodsId = $('#layerTagGoodsList').jqGrid ('getCell', id, 'rltId');
						addTab('상품 상세 - ' + goodsId, "/goods/goodsDetailView.do?goodsId=" + goodsId);
					}
				}
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#layerTagGoodsList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='6' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#layerTagGoodsList.ui-jqgrid-btable").append(str);
					}
				}
			}
			grid.create("layerTagGoodsList", gridOptions);
		}
	};

//--------------------------------------------------------------------------------//
//Tag 관련 영상 팝업 Layer
var tagContentsLayerOptions = {
		callBack : undefined
		, tagNo : null
		, tagNm : null
	};

var layerTagContentsList = {
		create : function (option ) {
			$.extend(tagContentsLayerOptions, option);
			var options = {
				url : _TAG_CONTENTS_LAYER_URL
				, data : {
					tagNo : option.tagNo == null ? undefined : option.tagNo
					,tagNm : option.tagNm == null ? undefined : option.tagNm		
				}
				, dataType : "html"
				, callBack : this.callBackCreate
			};
			ajax.call(options );
		}
		, callBackCreate : function (data) {
			var config = {
				id : "tagContentsList"
				, width : 830
				, height : 650
				, top : 50
				, title : "Tag 관련 영상"
				, body : data
			};
			layer.create(config);
			layerTagContentsList.initTagContentsListGrid();
		}
		, initTagContentsListGrid : function () {
			var gridOptions = {
				url : _TAG_CONTENTS_LIST_GRID_URL
				, height : 300
				, searchParam : $("#tagContentsListForm").serializeJson()
				, sortname : 'sysRegDtm'
				, sortorder : 'DESC'				
				, colModels : [
					{name:"rltGb", label:_TAG_RLT_LIST_GRID_LABEL.rltGb , width:"100", align:"center", sortable:false} 	
					, {name:"rltTp", label:_TAG_RLT_LIST_GRID_LABEL.rltTp , width:"80", align:"center", sortable:false} 	
					//, {name:"rltId", label:"ID" , width:"110", align:"center", classes:'pointer fontbold'} 	
					, {name:"rltNm", label:_TAG_RLT_LIST_GRID_LABEL.rltNm , width:"280", align:"center", sortable:false, classes:'pointer fontbold'}	
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
					, {name:"rltId", key: true, hidden:true}
					, {name:"rltGbCd", hidden:true}
					, {name:"contsStatCd", hidden:true}
					, {name:"petLogChnlCd", hidden:true}
					, {name:"vdGbCd", hidden:true}
				]
				,rownumbers: true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 3) {
						let rltGbCd = $('#layerTagContentsList').jqGrid ('getCell', id, 'rltGbCd');
						if(rltGbCd == "P"){
							var options = {
								url : "/petLogMgmt/popupPetLogDetail.do"
								, data : {
									petLogNo : $('#layerTagContentsList').jqGrid ('getCell', id, 'rltId')
									, contsStatCd : $('#layerTagContentsList').jqGrid ('getCell', id, 'contsStatCd')
									, snctYn : 'N'
									, petLogChnlCd : $('#layerTagContentsList').jqGrid ('getCell', id, 'petLogChnlCd')
									, tagCallYn : "Y"
								 }
								, dataType : "html"
								, callBack : function (data ) {
									var config = {
										id : "petLogDetail"
										, width : 1050
										, height : 630
										, top : 200
										, title : "펫로그 상세"
										, body : data
									}
									layer.create(config);
								}
							}
							ajax.call(options);
						}else if(rltGbCd == "T"){
							let vdId = $('#layerTagContentsList').jqGrid ('getCell', id, 'rltId');
							let vdGbCd = $('#layerTagContentsList').jqGrid ('getCell', id, 'vdGbCd');
							if(vdGbCd == "10"){
								addTab('교육용 컨텐츠 상세', '/contents/eduContsDetailView.do?vdId=' + vdId);
							}else{
								addTab('영상 상세', '/contents/vodDetailView.do?vdId=' + vdId);
							}
						}else if(rltGbCd == "S"){
							let srisNo = $('#layerTagContentsList').jqGrid ('getCell', id, 'rltId');
							addTab('시리즈 상세', '/series/seriesDetailView.do?srisNo='+srisNo);
						}
					}
				}
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#layerTagContentsList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='6' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#layerTagContentsList.ui-jqgrid-btable").append(str);
					}
				}
			}
			grid.create("layerTagContentsList", gridOptions);
		}
	};
//--------------------------------------------------------------------------------//

// 펫TV 영상 조회 Layer
var vodLayerOptions = {
	callBack : undefined
	, multiselect : false
};
var layerVodList = {
	create : function (option) {
		vodLayerOptions = $.extend( {}, vodLayerOptions, option );

		var options = {
			url : _VOD_SEARCH_LAYER_URL
			, dataType : "html"
			, data : {
				srisYn : option.srisYn == null ? undefined : option.srisYn
			}
			, callBack : layerVodList.callBackCreate
		}
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : 'vodSearch'
			, width : 1000
			, height : 600
			, top : 50
			, init : 'vodSearchViewInit'
			, title : '영상 조회'
			, body : data
			, button : '<button type="button" onclick="layerVodList.confirm();" class="btn btn-ok">선택</button>'
		}
		layer.create(config);
		layerVodList.initVodGrid(data);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerVodList" );
		var rowids = null;
		if(vodLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if (rowids.length == 0) {
				messager.alert("추가할 목록을 선택해 주세요.", "Info", "info");
				return;
			}
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			if (rowids == null) {
				messager.alert("추가할 목록을 선택해 주세요.", "Info", "info");
				return;
			}
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		
		var updateDispChk = false;
		var vdIds = new Array();
		for(var i=0; i<jsonArray.length; i++) {
			if (jsonArray[i].dispYn == "N") {
				updateDispChk = true;
				vdIds.push(jsonArray[i].vdId);
			}
		}
		
		if (updateDispChk) {
			messager.confirm("숨김 처리된 영상입니다.<br>상태를 '전시'로 변경할까요?", function(r){
				if (r) {
					var sendData = {
						  vdIds : vdIds
						, dispYn : "Y"
					};
					
					var options = {
						url : _VOD_UPDATE_DISP_URL
						, data : sendData
						, callBack : function(result) {
							layerVodList.searchVodList();
						}
					}
					ajax.call(options);
				}
			});
		} else {
			vodLayerOptions.callBack(jsonArray);
			layer.close("vodSearch");
		}
	}
	, initVodGrid : function (data) {
		var gridOptions = {
			url : _VOD_GRID_URL
			, height : 400
			, searchParam : $("#vodSearchForm").serializeJson()
			, sortname : 'sysRegDtm'
			, sortorder : 'DESC'
			, multiselect : vodLayerOptions.multiselect
			, colModels : [
				  /* 영상 Id */
				  {name:"vdId", label:_VOD_SEARCH_GRID_LABEL.vdId, width:"150", align:"center", sortable:false}
				  /* 썸네일 이미지 */
				, {name:"thumPath", label:_VOD_SEARCH_GRID_LABEL.thumPath, width:"120", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.thumPath != "" && rowObject.thumPath != null) {
							//return '<img src="<frame:imgUrl />' + rowObject.thumPath + '" style="width:100px; height:100px;" alt="' + rowObject.thumPath + '" />';[]
							var imgPath = rowObject.thumPath;
							return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
						}
					}
				}
				  /* 썸네일 이미지 경로 값 */
				, {name:"thumPathValue", label:_VOD_SEARCH_GRID_LABEL.thumPath, width:"120", align:"center", sortable:false, hidden:true, formatter: function(cellvalue, options, rowObject) {
						var str = "";
						if(rowObject.thumPath != "") {
							str = rowObject.thumPath;
						}
						return str;
					}
				}
				  /* 제목  */
				, {name:"ttl", label:_VOD_SEARCH_GRID_LABEL.ttl, width:"300", align:"left", classes:'pointer', sortable:false}
				  /* 시리즈 */
				, {name:"srisNm", label:_VOD_SEARCH_GRID_LABEL.srisNm, width:"171", align:"left", sortable:false}
				  /* 시리즈 번호 */
				, {name:"srisNo", label:_VOD_SEARCH_GRID_LABEL.srisNm, width:"171", align:"left", sortable:false, hidden:true}
				  /* 시즌 */
				, {name:"sesnNm", label:_VOD_SEARCH_GRID_LABEL.sesnNm, width:"100", align:"center", sortable:false}
				  /* 공유수 */
				, {name:"shareCnt", label:_VOD_SEARCH_GRID_LABEL.shareCnt, width:"110", align:"center", sortable:false}
				  /* 조회수 */
				, {name:"hits", label:_VOD_SEARCH_GRID_LABEL.hits, width:"110", align:"center", sortable:false}
				  /* 좋아요 */
				, {name:"likeCnt", label:_VOD_SEARCH_GRID_LABEL.likeCnt, width:"110", align:"center", sortable:false}
				  /* 댓글수 */
				, {name:"replyCnt", label:_VOD_SEARCH_GRID_LABEL.replyCnt, width:"110", align:"center", sortable:false}
				  /* 전시 */
				, {name:"dispYn", label:_VOD_SEARCH_GRID_LABEL.dispYn, width:"60", align:"center", sortable:false, formatter:"select", editoptions:{value:_VOD_DISP_STAT } }
				  /* 등록일(수정일) */
				, {name:"sysRegDtm", label:_VOD_SEARCH_GRID_LABEL.sysRegDtm, width:"145", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
					return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss") + '\r\n<p style="font-size:11px;">(' + new Date(rawObject.sysUpdDtm).format("yyyy-MM-dd HH:mm:ss")+ ')</p>';
					}
				}
			]
		};
		grid.create("layerVodList", gridOptions);
	}
	, searchVodList : function () {
		var options = {
			searchParam : $("#vodSearchForm").serializeJson()
		};
		grid.reload("layerVodList", options);
	}
	, searchReset : function () {
		resetForm ("vodSearchForm");
		layerVodList.searchDateChange();
		$("#vodSortOrder").val("sysRegDtm");
	}
	, searchDateChange : function () {
		var term = $("#vodSearchForm #checkOptDate").children("option:selected").val();
		if(term === "") {
			$("#vodSearchForm #sysRegDtmStart").val("");
			$("#vodSearchForm #sysRegDtmEnd").val("");
		} else {
			setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
		}
	}
	, reloadVodGrid : function (obj) {
		var options = {
			searchParam : $("#vodSearchForm").serializeJson()
		};
		if (obj != '') {
			options.sortname = obj.value;
		}
		grid.reload("layerVodList", options);
	}
};

// ====================================================================================
// 행정안전부 우편번호 검색 Layer
// https://www.juso.go.kr/addrlink/devAddrLinkRequestGuide.do?menu=roadApi 참조
// zonecode : 우편번호
// roadAddress : 도로명 주소
// roadAddressEnglish : 영문 도로명 주소
// jibunAddress : 지번 주소
// addrDetail : 고객입력 상세주소
// ====================================================================================
var layerMoisPost = {
	option : {
		 callBack : undefined
	}
	,create : function (funcCallBack) {
		$('#moisPostPopup').remove();
		layerMoisPost.option.callBack = funcCallBack;
		var options = {
			 url : _JUSO_LAYER_URL
			,data : {}
			,dataType : "html"
			,callBack : function(result) {
				var config = {
					 id : "moisPostPopup"
					,width : 700
					,height : 550
					,title : "우편번호"
					,body : result
					,button : ""
				}
	
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	,setData : function(rsltData) {
		layerMoisPost.option.callBack(rsltData);
	}
	,close : function() {
		layer.close("moisPostPopup");
	}
};

//펫로그 조회 Layer
var petLogLayerOptions = {
	callBack : undefined
	, multiselect : false
};
var layerPetLogList = {
	create : function (option) {
		petLogLayerOptions = $.extend( {}, petLogLayerOptions, option );
		var options = {
			url : _PET_LOG_SEARCH_LAYER_URL
			, data : {
				petLogChnlCd : option.petLogChnlCd == null ? undefined : option.petLogChnlCd
				, contsStatCd : option.contsStatCd == null ? undefined : option.contsStatCd
				, dispCallYn : option.dispCallYn
			}
			, dataType : "html"
			, callBack : layerPetLogList.callBackCreate
		}
		ajax.call(options );
	}
	, callBackCreate : function (data ) {
		var config = {
			id : 'petLogSearch'
			, width : 1000
			, height : 600
			, top : 50
			, init : 'petLogSearchViewInit'
			, title : '펫로그 조회'
			, body : data
			, button : '<button type="button" onclick="layerPetLogList.confirm();" class="btn btn-ok">확인</button>'
		}
		layer.create(config);
		layerPetLogList.initPetLogGrid(data);
	}
	, confirm : function () {
		var jsonArray = [];
		var grid = $("#layerPetLogList" );
		var rowids = null;
		if(petLogLayerOptions.multiselect ) {
			rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				jsonArray.push(grid.jqGrid('getRowData', rowids[i]));
			}
		} else {
			rowids = grid.jqGrid('getGridParam','selrow');
			jsonArray.push(grid.jqGrid('getRowData', rowids));
		}
		
		if( jsonArray.length > 0 ){
			petLogLayerOptions.callBack(jsonArray);
			layer.close("petLogSearch");
		}else{
			messager.alert("선택된 대상이 없습니다.", "Info", "info");
		}
	}
	, initPetLogGrid : function (data) {
		var gridOptions = {
			url : _PET_LOG_GRID_URL
			, height : 300
			, searchParam : $("#petLogSearchForm").serializeJson()
			, multiselect : petLogLayerOptions.multiselect
			, colModels : [
				  {name:"rowIndex", 	label:_PET_LOG_GRID_LABEL.rowIndex, 	width:"60", 	align:"center", sortable:false} /* 번호 */	  
				, {name:"petLogChnlCd", 	label:_PET_LOG_GRID_LABEL.petLogChnlCd, 	width:"120", align:"center", sortable:false
					, editable:true, edittype:'select', formatter:'select', editoptions:{value:_PETLOG_CHNL }} /* 등록유형 */  
				, {name:"petlogContsGb", 	label:_PET_LOG_GRID_LABEL.petlogContsGb, 	width:"120", align:"center", sortable:false
					, editable:true, edittype:'select', formatter:'select', editoptions:{value:PETLOG_CONTS_GB }} /* 컨텐츠구분 */
				, {name:"vdThumPath", 	label:_PET_LOG_GRID_LABEL.vdThumPath, 	width:"150", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.vdThumPath != "" && rowObject.vdThumPath != null) {		
							if(rowObject.vdThumPath.indexOf('cdn.ntruss.com') > -1) {
								return '<img src='+rowObject.vdThumPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'" />'
							}else {
								return getImage(rowObject.vdThumPath)
							}
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="" />';
						}
					} /* 썸네일 */
				}	
				, {name:"dscrt", 		label:_PET_LOG_GRID_LABEL.dscrt, 		width:"400", 	align:"left",	sortable:false, classes:'pointer fontbold'}/* 내용 */
				, {name:"goodsRcomYn", 	label:_PET_LOG_GRID_LABEL.goodsRcomYn, 	width:"80", 	align:"center", sortable:false} /* 상품추천 */
				, {name:"pstNm", 	label:_PET_LOG_GRID_LABEL.pstNm, 	width:"80", 	align:"center", sortable:false} /* 위치 */
				, {name:"nickNm", 	label:_PET_LOG_GRID_LABEL.nickNm, 	width:"200", 	align:"center", sortable:false} /* 상품추천 */
				, {name:"shareCnt", 	label:_PET_LOG_GRID_LABEL.shareCnt, 	width:"80", 	align:"center", sortable:false} /* 상품추천 */
				, {name:"goodCnt",		label:_PET_LOG_GRID_LABEL.goodCnt, 		width:"80", 	align:"center", sortable:false} /* 좋아요 */
				, {name:"hits", 		label:_PET_LOG_GRID_LABEL.hits, 		width:"80", 	align:"center", sortable:false} /* 조회수 */
				, {name:"claimCnt", 	label:_PET_LOG_GRID_LABEL.claimCnt, 	width:"80", 	align:"center", sortable:false} /* 신고수 */
				, {name:"snctYn", 		label:_PET_LOG_GRID_LABEL.snctYn, 		hidden:true, 	align:"center", sortable:false} /* 제재여부 */
				, {name:"petLogNo", 	label:_PET_LOG_GRID_LABEL.petLogNo, 	hidden:true,	width:"60", align:"center", sortable:false}/* 번호 */	
				, {name:"mbrNo",  	hidden:true,	width:"60", align:"center", sortable:false}/* 번호 */
				, {name:"contsStatCd", 	label:_PET_LOG_GRID_LABEL.contsStatCd,  width:"100", 	align:"center", sortable:false
					, editable:true, edittype:'select', formatter:'select', editoptions : {value:_CONTS_STAT_CD }} /* 전시여부 */
				, {name:"regModDtm",	label:_PET_LOG_GRID_LABEL.regModDtm,  	align:"center", sortable:false} /* 등록수정일 */
              ]
			, onCellSelect : function (id, cellidx, cellvalue) {
				if(cellidx == 5) {						
					var rowData = $("#layerPetLogList").getRowData(id);						
					var petLogNo = rowData.petLogNo;
					var contsStatCd = rowData.contsStatCd;
					var snctYn = rowData.snctYn;
					var petLogChnlCd = rowData.petLogChnlCd;						
					$("#selectedPetLogNo").val(petLogNo);						
					viewPetLogDetail(petLogNo, contsStatCd, snctYn, petLogChnlCd);
				} 
			}
		};
		grid.create("layerPetLogList", gridOptions);
	}
	, searchPetLogList : function () {
		if($("#petLogSearchForm #sysRegDtmStart").val() > $("#petLogSearchForm #sysRegDtmEnd").val()){				
			messager.alert("등록일 검색기간 시작일은 <br/>종료일과 같거나 이전이어야 합니다.", "Info", "info");				
			return;
		}
		if(validate.check("petlogListForm")) {
			var options = {
				searchParam : $("#petLogSearchForm").serializeJson()
			};
			grid.reload("layerPetLogList", options);
		}
	}
	, searchReset : function () {
		resetForm ("petLogSearchForm");
		layerPetLogList.searchDateChange();
		layerPetLogList.reloadPetLogGrid();
	}
	, searchDateChange : function () {
		var term = $("#petLogSearchForm #checkOptDate").children("option:selected").val();
		if(term === "") {
			$("#petLogSearchForm #sysRegDtmStart").val("");
			$("#petLogSearchForm #sysRegDtmEnd").val("");
		} else {
			setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
		}
	}
	, reloadPetLogGrid : function (obj) {
		var options = {
			searchParam : $("#petLogSearchForm").serializeJson()
		};
		grid.reload("layerPetLogList", options);
	}
};

//이벤트 당첨자 등록/수정 팝업
var layerEventWinner = {
	option : {}
	/**
	 * 이벤트 당첨자 팝업 생성 메소드
	 * @name  layerEventWinner.create(sendData)
	 * @param {String} sendData : 선택값을 입력할 input id
	 *
	 */
	, create : function(option){
		$.extend(this.option, option);
		var options = {
			url : _EVENT_WINNER_LAYER_URL
			, data : option.data
			, dataType : "html"
			, callBack : function (data){
				var config = {
					id : "eventWinnerPop"
					, width : 1000
					, height : 700
					, top : 200
					, title : option.title
					, body : data
					, button : option.button
				}
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	,confirm : function() {

		var formId = $("#WinnerForm").attr("id");
		if(validate.check(formId)){
			messager.confirm(_MESSAGE_UPLOAD_EVENT_WIN_INFO, function(r){
				if(r){
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					var formData = $("#WinnerForm").serializeJson();
					var notOpenYn = "N";
					if($("input[name=notOpenYn]")[0].checked){
						notOpenYn = "Y";
					}

					var data = {
						fileName : $("#fileName").val()
						, filePath : $("#filePath").val()
						, notOpenYn : notOpenYn
					}
					$.extend(data, formData);

					var options = {
						url : _EVENT_WINNER_UPLOAD_CSV_URL
						, data : data
						, callBack : function(data) {
							layer.close("eventWinnerPop");
							//$("#winnerLi a").trigger('click');
							grid.reload("eventWinnerList", { eventNo : $("input[name=eventNo]").val() } );
						}
					}
					ajax.call(options);
				}
			});
		}
	}
	, fnDeleteWinInfo : function(eventNo){
		messager.confirm(_MESSAGE_DELETE_EVENT_WIN_INFO, function(r){
			if(r){
				var data = {
					eventNo : eventNo
				}
				var options = {
					url : _DELECT_EVENT_WIN_INFO_URL
					, data : data
					, callBack : function(data){

						layer.close("eventWinnerPop");
					}
				}
				ajax.call(options);
			}
		});
	}
}