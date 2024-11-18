<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.constants.CommonConstants" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			select:disabled {
				display: none;
			}
		</style>
		<script type="text/javascript">
			$(document).ready(function() {
				searchDate();
				createGoodsCommentGrid ();
				newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
				
				//엔터키 
				$(document).on("keydown","#goodsCommnetListForm input" ,function(){
    			if ( window.event.keyCode == 13 ) {
    				searchGoodsCommentList();
  		  		}
            });

				$("#goodsCommentBestListTitle").hide();

				$("#bestSelValue").hide();
				$("#btnGoodsCommentBestUpdate").hide();
				$("#bestOrderByDesc").show();
				$("#bestOrderBy").val("");
				
			});

			// 사이트 검색
			function searchSt () {
				var options = {
					multiselect : false
					, callBack : searchStCallback
				}
				layerStList.create (options );
			}
			function searchStCallback (stList ) {
				if(stList.length > 0 ) {
					$("#stId").val (stList[0].stId );
					$("#stNm").val (stList[0].stNm );
				}
			}

			// 상품 후기 Grid
			function createGoodsCommentGrid () {
				var gridOptions = {
					url : "<spring:url value='/goods/goodsCommentGrid.do' />"
					, height : 400
					, searchParam : $("#goodsCommnetListForm").serializeJson()
					, colModels : [
						{name:"rowNum", hidden:true, label:'<b><u><tt><spring:message code="column.no.en" /></tt></u></b>', width:"60", align:"center", formatter:'integer', classes:'pointer fontbold'}
						,  {name:"goodsEstmNo", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_no' /></tt></u></b>", width:"80", key: true, sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
						, {name:"rowNum", label:'<b><u><tt><spring:message code="column.no.en" /></tt></u></b>', width:"60", align:"center", formatter:'integer', sortable:true, classes:'pointer fontbold'}
						, {name:"imgRegYn", hidden:true, label:"<spring:message code='column.img_reg_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } } /* 이미지 여부 */
						, {name:"goodsEstmTp", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_tp' /></tt></u></b>", width:"80", key: false, sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
						, {name:"goodsEstmTpNm", label:"<spring:message code='column.goods_estm_tp_nm' />", width:"100", align:"center", sortable:false} /* 후기 유형 */
						, {name:"estmScore", label:"<spring:message code='column.goods_estm_score' />", width:"100", align:"center", sortable:false, formatter:gridFormat.numEstmCoreFormat} /* 평점 */
						, {name:'goodsId', label:'<spring:message code="column.goods_id" />', width:'120', align:'center', sortable:false}		// 상품 ID
						, _GRID_COLUMNS.goodsNm		// 상품명
						, {name:"content", label:"<b><u><tt><spring:message code='column.content' /></tt></u></b>", width:"500", align:"left", sortable:false, classes:'pointer fontbold', formatter:fnJqGridMaxHeight } /* 내용 */
						, {name:"estmId", label:"<spring:message code='column.login_id' />", width:"120", align:"center", sortable:false } /* 로그인 ID */
						, {name:"estmActnLke", label:"<spring:message code='column.estm_actn_lke' />", width:"80", align:"center", sortable:false } /* 도움(좋아요개수) */
						, {name:"estmActnRpt", label:"<spring:message code='column.estm_actn_rpt' />", width:"80", align:"center", sortable:false } /* 신고(신고개수) */
						, {name:"dispYn", label:"<spring:message code='column.goods.disp_yn' />", width:"120", align:"center", sortable:false, formatter:strDispNmFormat } /* 전시 */
						, {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dt" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:true}
					]
					, multiselect : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) {
							console.log("ids : " + ids);
							console.log("cellidx : " + cellidx);
							
							if(cellidx == 10){
								var rowData = $("#goodsCommentList").getRowData(ids);
								fnGoodsCommentNormalPopup(rowData.goodsEstmNo, rowData.imgRegYn, rowData.goodsEstmTp);
							}
						}
					}
				}
				grid.create("goodsCommentList", gridOptions);
			}

			// 상품 후기 Grid
			function createGoodsCommentBestGrid (searchParam) {
				var gridOptions = {
					url : "<spring:url value='/goods/goodsCommentGrid.do' />"
					, height : 200
					, searchParam : searchParam
					, colModels : [
						{name:"goodsEstmNo", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_no' /></tt></u></b>", width:"80", key: true, sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
						, {name:"goodsEstmTp", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_tp' /></tt></u></b>", width:"80", key: false, sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
						, {name:"imgRegYn", hidden:true, label:"<spring:message code='column.img_reg_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } } /* 이미지 여부 */
						, {name:"rowNum", label:'<b><u><tt><spring:message code="column.no.en" /></tt></u></b>', width:"60", align:"center", formatter:'integer', classes:'pointer fontbold'}
						, {name:"goodsEstmTpNm", label:"<spring:message code='column.goods_estm_tp' />", width:"100", align:"center", sortable:false} /* 후기 유형 */
						, {name:"estmScore", label:"<spring:message code='column.goods_estm_score' />", width:"100", align:"center", sortable:false, formatter:gridFormat.numEstmCoreFormat} /* 평점 */
						, {name:'goodsId', label:'<spring:message code="column.goods_id" />', width:'120', align:'center', sortable:false}		// 상품 ID
						, _GRID_COLUMNS.goodsNm		// 상품명
						, {name:"content", label:"<b><u><tt><spring:message code='column.content' /></tt></u></b>", width:"500", align:"left", sortable:false, classes:'pointer fontbold', formatter:fnJqGridMaxHeight } /* 내용 */
						, {name:"estmId", label:"<spring:message code='column.login_id' />", width:"120", align:"center", sortable:false } /* 로그인 ID */
						, {name:"estmActnLke", label:"<spring:message code='column.estm_actn_lke' />", width:"120", align:"center", sortable:false } /* 도움(좋아요개수) */
						, {name:"dispYn", label:"<spring:message code='column.goods.disp_yn' />", width:"120", align:"center", sortable:false, formatter:strDispNmFormat } /* 전시 */
						, {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dt" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					]
					, multiselect : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) {
							console.log("ids : " + ids);
							var rowData = $("#goodsCommentBestList").getRowData(ids);
							fnGoodsCommentNormalPopup(rowData.goodsEstmNo, rowData.imgRegYn, rowData.goodsEstmTp);
						}
					}
				}
				grid.create("goodsCommentBestList", gridOptions);
			}

			// 전시
			function strDispNmFormat( cellvalue, options, rowObject ){

				var dispNm = "<spring:message code='column.show_not' />";
				if(cellvalue == "Y"){
					dispNm = "<spring:message code='column.show' />";
				}
				return dispNm;
			}


			function viewGoodsCommentDetail (goodsEstmNo ) {
				var url = '/goods/goodsCommentDetailView.do?goodsEstmNo=' + goodsEstmNo;
				addTab("<spring:message code='column.goods.comment.detail' />", url);
			}

			// 높이 설정
			function fnJqGridMaxHeight (v ) {
				return '<div style="max-height: 70px">' + v + '</div>';
			}

			function searchGoodsCommentList () {
				compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');
				var sysRegDtmStartVal = $("#sysRegDtmStart").val();
				var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
				
	    		var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
				var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				var term = $("#checkOptDate").children("option:selected").val();						
				
				
				var searchParam = $("#goodsCommnetListForm").serializeJson();
				var options = {
					searchParam : searchParam
				};
				var searchParamBest = new Object();
				searchParamBest.goodsId = searchParam.goodsId;
				searchParamBest.bestYn = searchParam.bestYn;
				var optionsBest = {
					searchParam : searchParamBest
				};

				console.log("searchParam.bestYn : " + searchParam.bestYn);
				//$("#goodsCommentList").jqGrid("hideCol", ["cb"]);
				if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
					if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
						if(searchParam.bestYn == "Y"){
							//$("#goodsCommentList").jqGrid("showCol", ["cb"]);
		
							$("#goodsCommentBestList").jqGrid("clearGridData");
							options.searchParam.bestYn = "";
							$("#goodsCommentList").jqGrid("clearGridData");
							if(searchParam.goodsId != ""){
								grid.reload("goodsCommentList", options);
								grid.reload("goodsCommentBestList", optionsBest);
							}
						}else{
							$("#goodsCommentList").jqGrid("clearGridData");
							$("#goodsCommentBestList").jqGrid("clearGridData");
							grid.reload("goodsCommentList", options);
							grid.reload("goodsCommentBestList", optionsBest);
						}
					}
				}
			}

			// 초기화 버튼 클릭
			function searchResetGoodsComment () {
				resetForm ("goodsCommnetListForm" );
				searchDate();
				
				var cur_tab = $('#gsCommentInfoGroup').find('.active').attr('data-target');
				if(cur_tab == "gsCommentInfoBestTab"){
					$("#bestOrderBy").val("S");	
					$("#bestYn").val("Y");	
				}
				
				<c:if test="${adminSession.usrGrpCd ne '10'}">
					$("#goodsCommnetListForm #compNo").val('${adminSession.compNo}');
					$("#goodsCommnetListForm #showAllLowCompany").val("N");
				</c:if>

			}

			// 업체 검색
			function searchCompany () {
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
					, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create (options );
			}
			function searchCompanyCallback (compList ) {
				if(compList.length > 0 ) {
					$("#goodsCommnetListForm #compNo").val (compList[0].compNo );
					$("#goodsCommnetListForm #compNm").val (compList[0].compNm );
				}
			}

			// 하위 업체 검색
			function searchLowCompany () {
				var options = {
					multiselect : false
					, callBack : searchLowCompanyCallback
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
					, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create (options );
			}
			// 업체 검색 콜백
			function searchLowCompanyCallback(compList) {
				if(compList.length > 0) {
					$("#goodsCommnetListForm #lowCompNo").val (compList[0].compNo);
					$("#goodsCommnetListForm #lowCompNm").val (compList[0].compNm);
				}
			}

			function searchDate() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "" ) {
					$("#sysRegDtmStart").val("" );
					$("#sysRegDtmEnd").val("" );
				} else if(term == "50") {
					setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
				} else {
					setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd" );
				}
				
			}

			function batchUpdateCommentView () {
				var grid = $("#goodsCommentList");

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
					return;
				}

				var options = {
					url : "<spring:url value='/goods/goodsCommentBatchUpdateLayerView.do' />"
					, data : { }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "goodsCommentUpdate"
							, width : 500
							, height : 200
							, top : 200
							, title : "상품 후기 일괄 수정"
							, body : data
							, button : "<button type=\"button\" onclick=\"commentUpdateProc();\" class=\"btn btn-ok\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function commentUpdateProc () {
				messager.confirm("<spring:message code='column.common.confirm.batch_update' />",function(r){
					if(r){
						var goodsEstmNos = new Array();
						var grid = $("#goodsCommentList");
						var selectedIDs = grid.getGridParam ("selarrrow");
						for (var i = 0; i < selectedIDs.length; i++) {
							goodsEstmNos.push (selectedIDs[i] );
						}

						var sendData = {
							goodsEstmNos : goodsEstmNos
							, sysDelYn : $("#goodsCommentBatchUpdateForm :radio[name=sysDelYn]:checked").val()
						};

						var options = {
							url : "<spring:url value='/goods/goodsCommentBatchUpdate.do' />"
							, data : sendData
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									searchGoodsCommentList ();
									layer.close ("goodsCommentUpdate" );
								});
							}
						};
						ajax.call(options);
					}
				});

			}

			$(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
				if ($(this).is(":checked") == true) {
					$("#showAllLowCompany").val("Y");
				} else {
					$("#showAllLowCompany").val("N");
				}
			});

			function changeCsTab(index) {
				var cur_tab = $('#gsCommentInfoGroup').find('.active').attr('data-target');
				var chg_li = $('#gsCommentInfoGroup').find('li:nth-child(' + (index+1) + ')');
				var chg_tab = chg_li.attr('data-target');

				$("#goodsEstmTp"+index).removeAttr("disabled").attr("name", "goodsEstmTp");
				$("#goodsEstmTp"+(index?0:1)).attr("disabled", "disabled").attr("name", "");

				$('#' + cur_tab).hide();
				$('#' + chg_tab).show();
				//$("#goodsCommentList").jqGrid("hideCol", ["cb"]);
				$('#gsCommentInfoGroup li').removeClass('active');
				$(chg_li).addClass('active');
				// gsCommentInfoBestTab
				$("#goodsCommentBestListTitle").hide();
				//$("#goodsCommentListTitle").hide();
				$("#bestSelValue").hide();
				$("#btnGoodsCommentBestUpdate").hide();
				$("#bestOrderByDesc").show();
				$("#bestOrderBy").val("");
				$("#bestYn").val("");
				$("#tabFlag").val("");
				
				console.log("chg_tab : " + chg_tab);
				var searchParam = $("#goodsCommnetListForm").serializeJson();
				var options = {
					searchParam : searchParam
				};

				// 리스트 초기화
				$("#goodsCommentList").jqGrid("clearGridData");
				$("#goodsCommentBestList").jqGrid("clearGridData");
				// 리스트 호출
				if(searchParam.goodsId != ""){
					grid.reload("goodsCommentList", options);
				}

				// BEST 리스트 호출
				if(chg_tab == "gsCommentInfoBestTab"){
					
					$("#goodsCommentSearchRow1").hide();
					$("#goodsCommentSearchRow2").hide();
					
					$("#bestYn").val("Y");
					$("#tabFlag").val("BEST");
					options.searchParam.bestYn = "Y";
					//$("#goodsCommentList").jqGrid("showCol", ["cb"]);	// 동적으로 grid 숨김
					$("#goodsCommentBestListTitle").show();
					//$("#goodsCommentListTitle").show();
					$("#bestSelValue").show();
					$("#btnGoodsCommentBestUpdate").show();
					$("#bestOrderByDesc").hide();
					$("#bestOrderBy").val("S");

					var searchParamBest = new Object();
					searchParamBest.goodsId = searchParam.goodsId;
					searchParamBest.bestYn = searchParam.bestYn;
					var optionsBest = {
						searchParam : searchParamBest
					};

					$("#goodsCommentBestList").jqGrid("clearGridData");
					console.log("searchParamBest.goodsId is null : " + validation.isNull(searchParamBest.goodsId));
					if(validation.isNull(searchParamBest.goodsId)) {
						searchParamBest.goodsId = ".";
						optionsBest.searchParam.goodsId = ".";
						createGoodsCommentBestGrid(searchParamBest); //최초 실행
					}else{
						createGoodsCommentBestGrid(searchParamBest); //최초 실행
						grid.reload("goodsCommentBestList", optionsBest);
					}
				}else{
					
					$("#tabFlag").val("");
					$("#goodsCommentSearchRow1").show();
					$("#goodsCommentSearchRow2").show();
				}
			}

			function fnGoodsCommentBestOrderBy(){
				var value = $("#bestOrderBy").val();
				console.log("value : " + value);
				$("#searchOrderBy").val(value);
				$("#goodsCommentList").jqGrid("clearGridData");

				var goodsId = $("#goodsId").val();
				if(goodsId == ""){
					return;
				}
				
				var searchParam = $("#goodsCommnetListForm").serializeJson();
				var options = {
					searchParam : searchParam
				};

				console.log("searchParam.bestYn : " + searchParam.bestYn);
				//$("#goodsCommentList").jqGrid("hideCol", ["cb"]);
				if(searchParam.bestYn == "Y"){
					//$("#goodsCommentList").jqGrid("showCol", ["cb"]);

					options.searchParam.bestYn = "";
					$("#goodsCommentList").jqGrid("clearGridData");
					if(searchParam.goodsId != ""){
						grid.reload("goodsCommentList", options);
					}
				}else{
					$("#goodsCommentList").jqGrid("clearGridData");
					grid.reload("goodsCommentList", options);
				}
			}

			function fnGoodsCommentNormalPopup(goodsEstmNo, imgRegYn, goodsEstmTp) {
				var paramGoodsEstmNo = goodsEstmNo;
				var goodsBestYn = $("#bestYn").val();

				var buttonText = "<spring:message code='column.save' />";
				var detailPopTitle = "<spring:message code='column.goods.comment.detail' />";
				if(imgRegYn != "Y" && goodsEstmTp == "NOR") {
					detailPopTitle = "<spring:message code='column.simple' /> " + detailPopTitle;
				}
				// url 설정.
				var optionUrl = "/goods/goodsCommentNormalPopup.do";
				if(goodsEstmTp == "PLG"){
					detailPopTitle = "<spring:message code='column.pet_log' /> " + detailPopTitle;
					optionUrl = "/goods/goodsCommentPetLogPopup.do";
				}
				var options = {
					url : optionUrl
					, data : {goodsEstmNo : paramGoodsEstmNo, goodsEstmTp : goodsEstmTp, goodsBestYn : goodsBestYn}
					, dataType : "html"
					, callBack : function (result) {
						var config = {
							id : "goodsCommentDetailView"
							, width : 760
							, height : 1000
							, top : 200
							, scroll:'N'
							, title : detailPopTitle
							, button : "<button type=\"button\" onclick=\"updateGoodsComment();\" class=\"btn btn-ok\">" + buttonText + "</button>"
							, body : result
						};
						layer.create(config);
					}
				};
				ajax.call(options);
			}

			// 상품 조회
			function fnGoodsBaseSearch() {
				var sysRegDtmStart = $("#sysRegDtmStart").val();
				var sysRegDtmEnd = $("#sysRegDtmEnd").val();
				window.setTimeout(function(){
					$("#sysRegDtmStart").val(sysRegDtmStart);
					$("#sysRegDtmEnd").val(sysRegDtmEnd);
				}, 300)
				console.log("sysRegDtmStart : " + sysRegDtmStart + ", sysRegDtmEnd : " + sysRegDtmEnd);
				var options = {
					multiselect : false
					, compNo : $("#goodsCommnetListForm #compNo").val()
					, compNm : $("#goodsCommnetListForm #compNm").val()
					, stId : $("#goodsCommnetListForm #stId").val()
					, stNm : $("#goodsCommnetListForm #stNm").val()
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							for(var i in result) {
								$("#goodsCommnetListForm #goodsId").val(result[i].goodsId);
								break;
							}
						}
					}
				}

				layerGoodsList.create(options);
			}

			// 상품후기 best 저장
			function updateGoodsBestComment (type, data) {
				var alertMessage = "<spring:message code='column.common.confirm.best_update' />";
				if(type == "delete"){
					alertMessage = "<spring:message code='column.common.confirm.best_delete' />";
				}
				if(data.goodsEstmNos.length == 0) return ;

				messager.confirm(alertMessage,function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/goodsCommentDetailBestUpdate.do' />"
							, data : data
							, callBack : function(data ) {

								/* var searchParam = $("#goodsCommnetListForm").serializeJson();
								var options = {
									searchParam : searchParam
								};
								$("#goodsCommentList").jqGrid("clearGridData");
								$("#goodsCommentBestList").jqGrid("clearGridData");

								grid.reload("goodsCommentBestList", options);
								options.searchParam.bestYn = "";
								grid.reload("goodsCommentList", options); */
								searchGoodsCommentList();
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info");
							}
						};
						ajax.call(options);
					}
				});
			}

			// multiSelect
			function fnGoodsCommentBestUpdate(jqgridType){
				var bestYn  = "Y";
				var bestType = "update";
				
				var bestIDs = $("#goodsCommentBestList").jqGrid("getDataIDs");
				var selectedIDs = $("#"+jqgridType).getGridParam("selarrrow");
				// var currentIDs = $("#goodsCommentBestList").getGridParam("selarrrow");
				
				if(selectedIDs.length == 0){
					messager.alert( "<spring:message code='column.goods.comment.not_checked' />" ,"Info","info");
					return;
				}
				
				if(jqgridType == "goodsCommentBestList"){
					bestYn = "N";
					bestType = "delete";
				}else{
					bestYn = $("#bestSelValue").val();
					if(bestYn == ""){
						messager.alert( "<spring:message code='column.goods.comment.not_selected' />" ,"Info","info");
						return;
					}
				}
				console.log("jqgridType : " + jqgridType);
				var estmPlgCnt = 0, estmNorCnt = 0;
				if(bestType == "update"){
					estmNorCnt = fnGoodsCommentBestEstmTp(bestIDs, selectedIDs, "NOR");
					estmPlgCnt = fnGoodsCommentBestEstmTp(bestIDs, selectedIDs, "PLG");

					console.log("유형별 개수 > estmPlgCnt : " + estmPlgCnt + ", estmNorCnt : " + estmNorCnt);
					if(estmNorCnt > 5){
						messager.alert( "<spring:message code='column.goods.comment.not_best_default5' />" ,"Info","info");
						return;
					}
					if(estmPlgCnt > 5){
						messager.alert( "<spring:message code='column.goods.comment.not_petlog_default5' />" ,"Info","info");
						return;
					}
					if((estmPlgCnt + estmNorCnt) > 10){
						messager.alert( "<spring:message code='column.goods.comment.not_all_default' />" ,"Info","info");
						return;
					}
				}
				var data = new Array();
				var obj = new Object();
				for (var i in selectedIDs) {
					var rowdata = $('#'+jqgridType).jqGrid('getRowData', selectedIDs[i]);
					data.push(rowdata.goodsEstmNo);
				}
				obj.goodsEstmNos = data;
				obj.bestYn = bestYn;
				updateGoodsBestComment(bestType, obj);
			}

			// Normal, petlog
			function fnGoodsCommentBestEstmTp(bestIDs, selectedIDs, estmTp){
				var estmCnt = 0;
				// 기존 best 개수
				for (var i in bestIDs) {
					var rowdata = $('#goodsCommentBestList').jqGrid('getRowData', bestIDs[i]);
					if(estmTp == rowdata.goodsEstmTp){
						estmCnt++;
					}else{
						// NULL, undefined 값은 일반으로 적용.
						if(estmTp == "NOR" && rowdata.goodsEstmTp != "PLG"){
							estmCnt++;
						}
					}
				}
				// 신규 best 개수
				for (var i in selectedIDs) {
					var rowdata = $('#goodsCommentList').jqGrid('getRowData', selectedIDs[i]);
					if(estmTp == rowdata.goodsEstmTp){
						estmCnt++;
					}else{
						// NULL, undefined 값은 일반으로 적용.
						if(estmTp == "NOR" && rowdata.goodsEstmTp != "PLG"){
							estmCnt++;
						}
					}
				}

				return estmCnt;
			}
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<style>
			html, body {
				height: auto !important;
				overflow: scroll !important;
			}
		</style>


		<div id="gsCommentInfoGroup" class="cs_tabs mt10" style="width: 100%;">
			<ul>
<%--				<li data-target="gsCommentInfoTab" class="active"><a href="#" onclick="javascript:changeCsTab(0);">내용별 문의</a></li>--%>
				<li class="active"><a href="#" onclick="javascript:changeCsTab(0);">내용별 문의</a></li>
				<li data-target="gsCommentInfoBestTab"><a href="#" onclick="javascript:changeCsTab(1);">상품별 Best 설정</a></li>
			</ul>
		</div>
		<form id="goodsCommnetListForm" name="goodsCommnetListForm" method="post" >
			<input type="hidden" id="stId" name="stId" value="" />
			<input type="hidden" id="stNm" name="stNm" value="" />
			<input type="hidden" name="compNo" id="compNo" value=""/>
			<input type="hidden" name="compNm" id="compNm" value=""/>
			<input type="hidden" name="bestYn" id="bestYn" value=""/>
			<input type="hidden" name="searchOrderBy" id="searchOrderBy" value=""/>
			<input type="hidden" name="tabFlag" id="tabFlag" value=""/>

			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>

							<tr>
								<th scope="row"><spring:message code="column.goods_id" /></th> <!-- 상품 번호 -->
								<td>
									<input type="text" id="goodsId" name="goodsId" title="<spring:message code="column.goods_id" />" value=""/>
									<button type="button" onclick="fnGoodsBaseSearch();" class="btn btn-add">검색</button>
								</td>
								<th scope="row"><spring:message code="column.goods.comment.select" /></th> <!-- 후기 유형 -->
								<td>
									<select id="goodsEstmTp0" name="goodsEstmTp">
										<option value="">전체</option>
										<option value="NOR">일반</option>
										<option value="PLG">펫로그</option>
									</select>

									<select id="goodsEstmTp1" name="" disabled="disabled">
										<option value="NOR">일반</option>
										<option value="PLG">펫로그</option>
									</select>

								</td>
							</tr>
	
							<tr>
								<th><spring:message code="column.goods_estm_score"/></th><!-- 평점 -->
								<td>
									<select id="estmScore" name="estmScore">
										<frame:estmScoreSelectTag grpCd="${CommonConstants.GOODS_ESTM_SCR_TP }" defaultName="전체"/>
	
									</select>
								</td>
								<th scope="row"><spring:message code="column.goods.comment.id" /></th> <!-- 회원 ID -->
								<td>
									<input type="text" id="loginId" name="loginId" title="<spring:message code="column.goods.comment.id" />" value="" />
								</td>
							</tr>
	
							<tr>
								<th scope="row"><spring:message code="column.goods.comment.date" /></th> <!-- 등록 일자 -->
								<td>
									<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDate();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.disp_yn.nogap" /></th> <!-- 전시 여부 -->
								<td>
									<select id="dispYn" name="dispYn">
										<option value="">전체</option>
										<option value="Y">전시</option>
										<option value="N">숨김</option>
									</select>
								</td>
							</tr>
							
							<tr id="goodsCommentSearchRow1">
								<th scope="row"><spring:message code="column.lke_cnt" /></th> <!-- 도움 건수 -->
								<td>
									<input type="text" id="startLkeCnt" name="startLkeCnt" title="" value="" /> ~ <input type="text" id="endLkeCnt" name="endLkeCnt" title="" value="" /> 
								</td>
								<th scope="row"></th>
								<td>
								</td>
							</tr>
							
							<tr id="goodsCommentSearchRow2">
								<th scope="row"><spring:message code="column.rptp_cnt" /></th> <!-- 신고 접수 건수 -->
								<td>
									<select id="rptpCnt" name="rptpCnt">
										<option value="">전체</option>
										<option value="5">5</option>
										<option value="4">4</option>
										<option value="3">3</option>
										<option value="2">2</option>
										<option value="1">1</option>
									</select>
								</td>
								<th scope="row"><spring:message code="column.rptp_rsn" /></th> <!-- 신고 사유 -->
								<td>
									<frame:radio name="rptpRsn" grpCd="${adminConstants.RPTP_RSN }" defaultName="전체" />
								</td>
							</tr>
							
						</tbody>
					</table>

					<div class="btn_area_center">
						<button type="button" onclick="searchGoodsCommentList();" class="btn btn-ok">검색</button>
						<button type="button" onclick="searchResetGoodsComment();" class="btn btn-cancel">초기화</button>
					</div>
				</div>

			</div>

			<div id="gsCommentInfoBestTab" class="mModule">
				<div class="mTitle" id="goodsCommentBestListTitle" >
					<h2><spring:message code='admin.web.view.app.goods.comment.best_list' /></h2>
					<div class="buttonArea">
						<button type="button" onclick='fnGoodsCommentBestUpdate("goodsCommentBestList");' class="btn btn-add">해제</button>
					</div>
				</div>
				<table id="goodsCommentBestList" ></table>
<%--				<div id="goodsCommentBestListPage"></div>--%>
			</div>

			<div id="gsCommentInfoTab" class="mModule">
				<div class="mTitle" id="goodsCommentListTitle">
					<h2></h2>
					<div class="buttonArea">
						<select id="bestSelValue" name="bestSelValue" style="width: 100px; vertical-align: center;">
							<option value="">선택</option>
							<option value="Y">설정</option>
							<option value="N">해제</option>
						</select>
						<button type="button" id="btnGoodsCommentBestUpdate" onclick='fnGoodsCommentBestUpdate("goodsCommentList");' class="btn btn-add">일괄변경</button>
						<select id="bestOrderBy" name="bestOrderBy" style="width: 100px; vertical-align: center;" onchange="fnGoodsCommentBestOrderBy();">
							<option id="bestOrderByDesc" value="">최근 등록 순</option>
							<option value="S">평점 순</option>
							<option value="L">도움 순</option>
						</select>
					</div>
				</div>

				<table id="goodsCommentList" ></table>
				<div id="goodsCommentListPage"></div>
			</div>

		</form>
	</t:putAttribute>

</t:insertDefinition>
<style>
.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
</style>