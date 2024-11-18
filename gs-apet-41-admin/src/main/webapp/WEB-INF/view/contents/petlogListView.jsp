<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			th.ui-th-column div { white-space:normal !important; height:auto !important; }
		</style>
		<script type="text/javascript">		
		var isGridExists = false;
		var customSort = "N";
		$(document).ready(function() {
			newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
			searchDateChange();
			createPetLogGrid();         
			

            $(document).on("keydown","#petlogListForm input",function(){
      			if ( window.event.keyCode == 13 ) {
      				searchPetlogList();
    		  	}
            });			
		});
				
		// 펫로그 Grid
		function createPetLogGrid () {			
			//var _lebel = "<span style='display:inline-block;line-height: 14px;vertical-align: middle'><spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)</span>";			
			var _lebel = "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)";
			var gridOptions = {
				  url : "<spring:url value='/petLogMgmt/listPetLog.do' />"	
 				, height : 400 	
 				, sortname : 'sysRegDtm'
				, searchParam : $("#petlogListForm").serializeJson()
				, colModels : [
					  {name:"rowIndex", 	label:'<spring:message code="column.no" />', 			width:"60", 	align:"center", sortable:false} /* 번호 */	  
				    , {name:"petLogChnlCd",label:"<spring:message code='column.petlog.chnl' />",  	width:"120", align:"center", sortable:false
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.PETLOG_CHNL}' showValue='false' />"}} /* 등록유형 */  
					, {name:"petlogContsGb",label:"<spring:message code='column.petlog.conts_gb' />",  	width:"120", align:"center", sortable:false
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.PETLOG_CONTS_GB}' showValue='false' />"}} /* 컨텐츠구분 */
					, {name:"vdThumPath", 	label:'<spring:message code="column.thum" />',	width:"150", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.vdThumPath != "" && rowObject.vdThumPath != null) {		
							var imgPath = rowObject.vdThumPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.vdThumPath :  '${frame:optImagePath("' + rowObject.vdThumPath + '","400")}';							
							return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'" />';[]	
														
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
						}
						} /* 썸네일 */
					}	
					, {name:"dscrt", 		label:'<spring:message code="column.content" />', 		width:"600", 	align:"left",	sortable:false, classes:'pointer fontbold'}/* 내용 */
					, {name:"goodsRcomYn", 	label:"<spring:message code='column.goods_map' />", 	width:"80", 	align:"center", sortable:false} /* 상품추천 */
					, {name:"pstNm", 		label:"<spring:message code='column.location' />", 		width:"80", 	align:"center", sortable:false} /* 위치 */
					, {name:"nickNm", 		label:"<spring:message code='column.nickname' />", 		width:"200", 	align:"center", sortable:false} /* 닉네임 */
					, {name:"shareCnt",		label:"<spring:message code='column.vod.share_cnt' />",	width:"80", 	align:"center", sortable:false} /* 공유수 */
					, {name:"goodCnt",		label:"<spring:message code='column.good_cnt' />", 		width:"80", 	align:"center", sortable:false} /* 좋아요 */
					, {name:"hits", 		label:"<spring:message code='column.hits' />", 			width:"80", 	align:"center", sortable:false} /* 조회수 */
					, {name:"claimCnt", 	label:"<spring:message code='column.claim_cnt' />", 	width:"80", 	align:"center", sortable:false} /* 신고수 */
					, {name:"snctYn", 		label:"<spring:message code='column.snct_yn' />", 		hidden:true, 	align:"center", sortable:false} /* 제재여부 */
					, {name:"petLogNo", 	label:'<spring:message code="column.no" />', 			hidden:true,	width:"60", 	align:"center", sortable:false}/* 번호 */					  
					, {name:"contsStatCd", 	label:"<spring:message code='column.contsStat' />",  	width:"100", 	align:"center", sortable:false
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.CONTS_STAT}' showValue='false' />"}} /* 전시여부 */
					, {name:"regModDtm",	label:_lebel,  align:"center", sortable:false} /* 등록수정일 */
	                ]

				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 5) {						
						var rowData = $("#petlogList").getRowData(id);						
						var petLogNo = rowData.petLogNo;
						var contsStatCd = rowData.contsStatCd;
						var snctYn = rowData.snctYn;
						var petLogChnlCd = rowData.petLogChnlCd;						
						$("#selectedPetLogNo").val(petLogNo);						
						viewPetLogDetail(petLogNo, contsStatCd, snctYn, petLogChnlCd);
					} 
				}
				/* , gridComplete : function (){					
					$(".grid-multiline-column").css("line-height", "1em");
					var totalCnt = $("#petlogList").getGridParam("records");
					var curPage = $('#petlogList').getGridParam('page');
					var totPage = Math.ceil(totalCnt/$('#petlogList').getGridParam('rowNum'));
					if(totalCnt > 0){
						$("#pageArea").html("총 "+totalCnt+"건 ("+curPage+"/"+totPage+" 페이지)");						
					}else{
						$("#pageArea").html("");
					}
				} */
				
			}
			grid.create("petlogList", gridOptions);
			isGridExists = true;
		}

		// 검색 조회
		function searchPetlogList () {
			
			compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');
			var sysRegDtmStartVal = $("#sysRegDtmStart").val();
			var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
    		var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
			var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
			var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			var term = $("#checkOptDate").children("option:selected").val();						
			
			if (! isGridExists) {
				createPetLogGrid();
			}
			var ordering = $("#orderingGb_ option:selected").val();
			$("#orderingGb").val(ordering);			
			if(validate.check("petlogListForm")) {
				var options = {
					searchParam : $("#petlogListForm").serializeJson()
				};
				var sortCol = "sysRegDtm";
				if(ordering == "20"){
					sortCol = "hits";
				}if(ordering == "30"){
					sortCol = "goodCnt";
				}
				
				options.sortname = sortCol;
				if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
					if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문				
						grid.reload("petlogList", options);
					}
				}
			}

			
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("petlogListForm");	
			if("${petLogSO.mbrNo}" != null && "${petLogSO.mbrNo}" != "") $("#mbrNo").val("${petLogSO.mbrNo}");
			searchDateChange();
		}


		// 전시상태 일괄 변경
		function batchUpdatePetLogStat () {
			if($("#contsStatUpdateGb option:selected").val() == "" || $("#contsStatUpdateGb option:selected").val() == null){
				messager.alert("<spring:message code='column.common.petlog.update.gb' />", "Info", "info");
				$("#contsStatUpdateGb").focus();
				return;
			}
			var grid = $("#petlogList");
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.petlog.update.no_select' />", "Info", "info");
				return;
			}
			
			var contsStatUpdateGb = $("#contsStatUpdateGb").children("option:selected").val();
			petLogUpdateProc ("batch");
			
		}
		function petLogUpdateProc (location) {
			var addMsg="";
			if(location == "batch") addMsg="선택 ";
			messager.confirm(addMsg+"<spring:message code='column.common.petlog.confirm.batch_update' />",function(r){
				if(r){
					var contsStatUpdateGb = $("#contsStatUpdateGb").children("option:selected").val();
					var petLogNos = new Array();
					var snctYn = "";
					if(location == "batch"){//일괄 업데이트
						var grid = $("#petlogList");
						var selectedIDs = grid.getGridParam ("selarrrow");
						
						for (var i = 0; i < selectedIDs.length; i++) {
							var petLogNo = grid.getCell(selectedIDs[i], 'petLogNo');
							petLogNos.push (petLogNo );		
						}
					}else{//팝업창에서 저장
						petLogNos.push ($("#selectedPetLogNo").val() );						
						contsStatUpdateGb = $(":input:radio[name=detailContsStatCd]:checked").val();		
						/* snctYn = $(":input:checkbox[name=snct_yn]:checked").val();
						if(snctYn == null || snctYn == ""){
							snctYn = "N";
						} */
					}
					
					var sendData = {
						petLogNos : petLogNos
						, contsStatUpdateGb:contsStatUpdateGb	
						/* , snctYn : snctYn */
					};
							
					var options = {
						url : "<spring:url value='/petLogMgmt/updatePetLog.do' />"
						, data : sendData
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
								searchPetlogList ();
								$("#contsStatUpdateGb").val("");
								if(location != "batch"){
									layer.close('petLogDetail');									
								}
							});
						}
					};
					ajax.call(options);
				}
			});
		}

		function viewPetLogDetail(petLogNo, contsStatCd, snctYn, petLogChnlCd) {

			var titles = "펫로그 상세";
			var options = {
				url : "<spring:url value='/petLogMgmt/popupPetLogDetail.do' />"
				, data : {  petLogNo : petLogNo
						  ,	contsStatCd : contsStatCd
						  , snctYn : snctYn
						  , petLogChnlCd : petLogChnlCd
						 }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "petLogDetail"
						, width : 1050
						, height : 700
						, top : 200
						, title : titles
						, body : data
						, button : "<button type=\"button\" onclick=\"petLogUpdateProc('detail');\" class=\"btn btn-ok\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

		// 등록일 변경
		function searchDateChange() {			
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			} else if(term == "50") {
				setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
		

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<input type = "hidden" id = "selectedPetLogNo" />
				<form id="petlogListForm" name="petlogListForm" method="post">
					<input type = "hidden" name = "mbrNo" id = "mbrNo" value="${petLogSO.mbrNo }" />		
					<input type = "hidden" name = "customSort" />
					<input type = "hidden" name = "petLogMgmtCallYn" value="Y" />			
					<table class="table_type1">
						<caption>정보 검색</caption>
						<colgroup>
							<col style="width:10%;">							
							<col style="width:40%;">
							<col style="width:10%;">
							<col style="width:40%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.reg_dt" /><strong class="red">*</strong></th>								
								<!-- 기간 -->
								<td>
									<frame:datepicker startDate="sysRegDtmStart" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }"  readonly = "true"/>&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.reply.rptp_type" /></th>	
								<!-- 신고사유 -->							
								<td>							
									<frame:radio name="rptpRsnCd" grpCd="${adminConstants.RPTP_RSN }" defaultName="전체"  />
								</td>								
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.sys_regr_nm" /></th>	
								<!-- 등록자 -->							
								<td>
									<select id="regGb" name="regGb" onchange="">
										<option value="nickNm" data-usrdfn1="" title="닉네임" selected="selected">닉네임</option>
										<option value="loginId" data-usrdfn1="" title="loginId">아이디</option>
										<option value="mbrNo" data-usrdfn1="" title="mbrNo">User-no</option>										
									</select>
									<input type="text" name="loginId" id="loginId" title="등록자" value="" />
								</td>
								
								<th scope="row"><spring:message code="column.disp_yn" /></th>
								<!-- 전시여부 -->								
								<td>									
									<frame:radio name="contsStatCd" grpCd="${adminConstants.CONTS_STAT }" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<%-- <th scope="row"><spring:message code="column.tag" /></th>
								<!-- 태그 -->								
								<td><input type="text"  class = "w300" name="tag" id="tag" title="태그" value="" /></td> --%>
								<th><spring:message code="column.reply.rptp_cnt"/></th>
								<td>
									<!-- 신고 접수 건수 -->
									<select id="rptpCnt" name="rptpCnt" onchange="">
										<option value="" data-usrdfn1="" selected="selected">전체</option>
										<option value="5" data-usrdfn1="" title="5">5</option>
										<option value="4" data-usrdfn1="" title="4">4</option>
										<option value="3" data-usrdfn1="" title="3">3</option>
										<option value="2" data-usrdfn1="" title="2">2</option>
										<option value="1" data-usrdfn1="" title="1">1</option>
									</select>
								</td>
								
								<th scope="row"><spring:message code="column.goods_map_yn" /></th>
								<!-- 상품추천여부 -->								
								<td>									
									<frame:radio name="goodsMapYn" grpCd="${adminConstants.GOODS_RECOM_YN }"  defaultName="전체" />
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.petlog.chnl" /></th>
								<!-- 등록유형 -->								
								<td>
									<select id="petLogChnlCd" name="petLogChnlCd" >							
										<frame:select grpCd="${adminConstants.PETLOG_CHNL }" defaultName="전체"  />
									</select>
								</td>
								
								<th scope="row"><spring:message code="column.petlog.conts_gb" /></th>
								<!-- 컨텐츠 구분 -->
								<td>									
									<frame:radio name="petlogContsGb" grpCd="${adminConstants.PETLOG_CONTS_GB }" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.tag" /></th>
								<!-- 태그 -->								
								<td><input type="text"  class = "w400" name="tag" id="tag" title="태그" value="" /></td>
								
								<th scope="row"></th>								
								<td>				
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.petlog.url" /></th>
								<!-- URL -->
								<td>
									<input type="text" class = "w400" name="srtPath" id="srtPath" title="<spring:message code="column.url" />" value="" />
								</td>
								<th scope="row"><spring:message code="column.content" /></th>
								<!-- 내용 -->
								<td>
									<input type="text" class = "w400" name="dscrt" id="dscrt" title="내용" value="" />
								</td>								
							</tr>	
							<tr>
								<!-- 공유 건수 -->
								<th scope="row"><spring:message code="column.petlog.share_cnt" /></th>
								<td>
									<input type="text" class="inputTypeNum" name="shareCntStrt"> ~ <input type="text" class="inputTypeNum" name="shareCntEnd"> 
								</td>
								<!-- 좋아요 건수 -->
								<th scope="row"><spring:message code="column.petlog.good_cnt" /></th> 
								<td>
									<input type="text" class="inputTypeNum" name="goodCntStrt"> ~ <input type="text" class="inputTypeNum" name="goodCntEnd">
								</td>							
							</tr>
												
						</tbody>
					</table>
					<input type = "hidden" id = "orderingGb" name = "orderingGb" />
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchPetlogList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		
		<div class="mModule">
			<div class = "mButton">
				<div class = "leftInner">
					<div id = "pageArea" style = "margin-top:15px;"></div>
				</div>
				<div id="resultArea" class = "rightInner">
					<select id="contsStatUpdateGb" name="contsStatUpdateGb" >							
						<frame:select grpCd="${adminConstants.CONTS_STAT }" defaultName="전체" usrDfn1Val="Y" />
					</select>
					<button type="button" onclick="batchUpdatePetLogStat();" class="btn btn-add">일괄 변경</button>
					<select id="orderingGb_" name="orderingGb_" onchange="searchPetlogList();">							
						<frame:select grpCd="${adminConstants.PETLOG_ORDERING_TP }" selectKey="${adminConstants.PETLOG_ORDERING_TP_10 }" />
					</select>						
				</div>
			</div>
			
			<table id="petlogList"></table>
			<div id="petlogListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>