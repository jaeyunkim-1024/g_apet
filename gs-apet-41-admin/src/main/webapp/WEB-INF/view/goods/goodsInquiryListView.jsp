<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			searchDateChange();
			
			newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
			// 상품Q&A 리스트
			createGoodsInquiryGrid();
			
			//상품Q&A 회원ID
		    $(document).on("keydown","#goodsInquiryListForm input",function(){
    			if ( window.event.keyCode == 13 ) {
    				searchGoodsInquiryList();
  		  		}
            });
		});

		// 상품Q&A 리스트
		function createGoodsInquiryGrid() {
			var gridOptions = {
				url : "<spring:url value='/${gb}/goodsInquiryListGrid.do'/>"
				, multiselect : true
				, height : 400
				, searchParam : $("#goodsInquiryListForm").serializeJson()
				, colModels : [
					  {name:"goodsIqrNo", label:"<spring:message code='column.no.en' />", width:"50", key: true, align:"center"}	// 상품 문의 번호
					, {name:"goodsIqrStatCd", label:"<spring:message code='column.display_view.goods_iqr_stat_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_IQR_STAT}' showValue='false'/>"}}	// 답변여부
					, _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.goodsNm				// 상품명
					, {name:"iqrContent", label:"<spring:message code='column.content' />", width:"300", align:"left", sortable:false, classes:'pointer fontbold',
						cellattr:function(){return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';}}	// 상품Q&A 내용
					, {name:"eqrrId", label:"<spring:message code='column.display_view.eqrr_mbr_id' />", width:"100", align:"center", classes:'pointer fontbold'}					// 고객ID
					, {name:"rplContent", label:"<spring:message code='column.display_view.rplr_cont' />", width:"300", align:"center", sortable:false,
						cellattr:function(){return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';}}		// 답변내용
					, {name:"rplrNm", label:"<spring:message code='column.display_view.rplr_nm' />", width:"80", align:"center", sortable:false}			// 답변자
					, {name:'sysRegDtm', label:"<spring:message code='column.sys_reg_dt' />", width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					, {name:'rplDtm', label:"<spring:message code='column.display_view.rpl_dtm' />", width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
				]
				, loadComplete : function(data){
					$("[name=listRecords]").text(data.records);
					$("[name=listPage]").text(data.page);
					$("[name=listTotal]").text(data.total);
					
				}
				, onCellSelect : function(id, cellidx, cellvalue) {
					if(cellidx != 0) {
						var rowdata = $("#goodsInquiryList").getRowData(id);

						// 상세 조회
	 					viewGoodsInquiryDetail(rowdata.goodsIqrNo);
					}
				}
			}

			grid.create("goodsInquiryList", gridOptions);
		}

		// 상세 조회
		function viewGoodsInquiryDetail(goodsIqrNo) {
			var url = '/${gb}/goodsInquiryDetailView.do?goodsIqrNo=' + goodsIqrNo;
			addTab('<spring:message code="admin.web.view.app.goods.qna.tab.detail"/>', url);
		}

		// 검색
		function searchGoodsInquiryList() {
			compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');
			
			var options = {
				searchParam : $("#goodsInquiryListForm").serializeJson()
			};
			
			var sysRegDtmStartVal = $("#sysRegDtmStart").val();
			var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
			
	    	var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
			var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
			var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			var term = $("#checkOptDate").children("option:selected").val();
			
			if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
				if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
			grid.reload("goodsInquiryList", options); 
				}
			}
		}

		// 업체 검색
		function searchCompany() {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create(options);
		}

		// 업체 검색 콜백
		function searchCompanyCallback(compList) {
			if(compList.length > 0) {
				$("#goodsInquiryListForm #compNo").val (compList[0].compNo);
				$("#goodsInquiryListForm #compNm").val (compList[0].compNm);
			}
		}

		// 등록일 변경
		function searchDateChange(term) {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			}else if(term == "50") {
				setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
			}else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}

		// 전시여부 수정
		function batchUpdateInquiryDisp(strDispYn) {
			var url = "";
			var grid = $("#goodsInquiryList");
			var dispArr = new Array();

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
				return;
			} else {
				for(var i = 0; i < rowids.length; i++) {
					var data = $("#goodsInquiryList").getRowData(rowids[i]);

					$.extend(data, {
						strDispYn : strDispYn
					});

					dispArr.push(data);
				}

				sendData = {
	 				goodsInquiryPOList : JSON.stringify(dispArr)
 				};
			}
			messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
				if(r){
					var options = {
							url : "<spring:url value='/${gb}/updateGoodsInquiryDisp.do' />"
							, data : sendData
							, callBack : function(data) {
								messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
									// 검색
									searchGoodsInquiryList();
								});
							}
						};

						ajax.call(options);				
				}
			});
		}

        // 초기화 버튼클릭
        function searchQnAReset() {
           	$("#goodsInquiryListForm").trigger("reset");
       		$("#goodsInquiryListForm").find("input[type=hidden]").val('');
            $("#goodsInquiryListForm").find('input[name=goodsId]').val("");
           searchDateChange();
            <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
            $("#goodsInquiryListForm #compNo").val('${adminSession.compNo}');
            </c:if>
        }

		/* 상품 검색 팝업 추가 */
    	function searchGoods () {
    		var options = {
   				multiselect : false,
   				callBack : searchGoodsCallback
    		}
    		layerGoodsList.create (options);
    	}
    	function searchGoodsCallback(result){
    		if(result[0].goodsId != null){
    			$("#goodsInquiryListForm").find('input[name=goodsId]').val(result[0].goodsId);
    		}
    	}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="goodsInquiryListForm" name="goodsInquiryListForm" method="post" >
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
					<table class="table_type1">
						<caption><spring:message code="admin.web.view.app.goods.search"/></caption>
						<tbody>
							<tr>
								<!-- 등록일자 -->
								<th scope="row"><spring:message code="column.user_list_view.date" /></th>
								<td>
									<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									<spring:message code='admin.web.view.app.goods.search.date' var="searchDatePh"/>
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="${searchDatePh}" />
									</select>
								</td>
								<!-- 고객ID -->
								<th scope="row"><spring:message code="column.display_view.eqrr_mbr_id"/></th>
								<td>
									<input type="text" name="loginId" id="loginId" title="<spring:message code="column.display_view.eqrr_mbr_id"/>" value="" />
								</td>
							</tr>
							<tr>
								<!-- 상품번호 -->
								<th scope="row"><spring:message code="column.goods_id_2nd" /></th>
								<td>
									<!-- <textarea rows="3" cols="30" id="goodsIdArea" name="goodsIdArea" ></textarea> -->
									<input type="text" class="readonly" id="goodsId" name="goodsId" title="<spring:message code='column.goods_id_2nd' />" readonly/>
									<button type="button" class="btn" onclick="searchGoods(); return false;"><spring:message code="admin.web.view.common.search"/></button>
								</td>
								<!-- 답변여부 -->
								<th scope="row"><spring:message code="column.display_view.goods_iqr_stat_cd" /></th>
								<td>
									<spring:message code="admin.web.view.common.button.select.all" var="selectDefaultName"/>
									<select id="goodsIqrStatCd" name="goodsIqrStatCd" >
										<frame:select grpCd="${adminConstants.GOODS_IQR_STAT}" defaultName="${selectDefaultName}" />
									</select>
								</td>
							</tr>
							<tr>
								<!-- 노출여부 -->
								<th scope="row"><spring:message code="column.show_yn" /></th>
								<td>
									<select id="dispYn" name="dispYn" >
										<frame:select grpCd="${adminConstants.SHOW_YN}" defaultName="${selectDefaultName}" />
									</select>
								</td>
								<!-- 답변자 -->
								<th scope="row"><spring:message code="column.rplr_nm" /></th>
								<td>
									<input type="text" id="rplrNm" name="rplrNm" title="<spring:message code="column.rplr_nm" />" value="" />
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_area_center">
						<button type="button" onclick="searchGoodsInquiryList();" class="btn btn-ok"><spring:message code="admin.web.view.common.search"/></button>
						<button type="button" onclick="searchQnAReset();" class="btn btn-cancel"><spring:message code="admin.web.view.common.button.clear"/></button>
					</div>
				</div>
			</div>

			<div class="mModule">
				<p>총 <string name="listRecords">0</string>건 (<span class="red" name="listPage">0</span>/<span name="listTotal">0</span> 페이지)</p>
				<table id="goodsInquiryList"></table>
				<div id="goodsInquiryListPage"></div>
			</div>
		</form>
	</t:putAttribute>
</t:insertDefinition>