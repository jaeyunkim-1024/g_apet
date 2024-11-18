<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			//	$("#checkOptDate option[value=${adminConstants.SELECT_PERIOD_40}]").prop("selected", true);
				searchDateChange();
				//날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#aplStrtDtm", "#aplEndDtm"); 
				createCouponGrid();
				
				//엔터 키 이벤트
				$(document).on("keydown","input[name=cpNm]",function(e){
					if (e.keyCode == 13) {
						reloadCouponGrid();
					}
				});
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

			// 쿠폰 목록
			function createCouponGrid(){
				var options = {
					url : "<spring:url value='/promotion/couponListGrid.do' />"
					, height : 400
					, searchParam : $("#couponSearchForm").serializeJson()
					, multiselect : true
					, colModels : [
						{name:"cpNo", label:'<b><u><tt><spring:message code="column.cp_no" /></tt></u></b>', key:true, width:"80", align:"center", formatter:'integer', classes:'pointer fontbold'}
						, {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"400", align:"center", cellattr:function(){
							return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';
						}}
						, {name:"cpPvdMthCd", label:'<spring:message code="column.cp_isu_mth_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_PVD_MTH}" />"}}
						, {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}
						, {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
						, {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
						, {name:"cpAplCd", label:'<spring:message code="column.dc_gb_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
						, {name:"aplVal", label:'<spring:message code="column.apl_val" />', width:"70", align:"center", formatter:'integer'}
						, {name:"minBuyAmt", label:'<spring:message code="column.min_buy_amt" />', width:"90", align:"center", formatter:'integer'}
						, {name:"maxDcAmt", label:'<spring:message code="column.max_dc_amt" />', width:"90", align:"center", formatter:'integer'}
						//, {name:"cpRstrYn", label:'<spring:message code="column.cp_rstr_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_RSTR_YN}" />"}}						
						, {name:"aplStrtDtm", label:'<spring:message code="column.apl_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"aplEndDtm", label:'<spring:message code="column.apl_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center", sortable :false}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onCellSelect : function (id, cellidx, cellvalue) {
						if(cellidx != 0) {
							var rowdata = $("#couponList").getRowData(id);
							couponView(rowdata.cpNo);
						}
					}
				};
				grid.create("couponList", options);
			}

			function reloadCouponGrid(){
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("aplStrtDtm", "aplEndDtm", "term");
				
				var options = {
					searchParam : $("#couponSearchForm").serializeJson()
				};
			
				gridReload('aplStrtDtm','aplEndDtm','couponList','term', options);
				
			}

			function couponView(cpNo) {
				addTab('쿠폰 상세', '/promotion/couponView.do?cpNo=' + cpNo);
			}
			
            function couponInsertView() {
                addTab('쿠폰 등록', '/promotion/couponInsertView.do?');
            }
            
            function searchDateChange() {
    			var term = $("#checkOptDate").children("option:selected").val();
    			if(term == "") {
    				$("#aplStrtDtm").val("");
    				$("#aplEndDtm").val("");
    			}else if(term == "50"){
    				//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("aplStrtDtm", "aplEndDtm");
    			}else{
    				setSearchDate(term, "aplStrtDtm", "aplEndDtm");
    			}
    		}
            
         	// 초기화 버튼클릭
    		function searchReset () {
    			resetForm ("couponSearchForm");
    	//		$("#checkOptDate option[value=${adminConstants.SELECT_PERIOD_40}]").prop("selected", true);
				searchDateChange();    			
    			reloadCouponGrid();
    		}
         	
         	// 쿠폰 복사
         	function copyCoupon(){
         		var rowids = $("#couponList").jqGrid('getGridParam', 'selarrrow');
         		
        		if (rowids == null || rowids === ''){
        			messager.alert("복사할 대상을 선택하세요.", "Info", "info");
        			return;
        		}
        		
        		if (rowids.length != 1){
        			messager.alert("복사할 대상을 1개만 선택해 주세요.", "Info", "info");
        			return;
        		}
        		
        		var options = {
                	url : "<spring:url value='/promotion/copyCoupon.do' />"
                    , data : {
                    	cpNo : rowids[0]
                    }
                    , callBack : function(result){
                    	messager.alert("쿠폰번호 <b>"+result.couponBase.cpNo +"</b> 복사완료", "Info", "info", function(){
	                    	grid.reload("couponList", options);
                    	});
                    }
                };

                ajax.call(options);	
         	}
         
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding: 10px">
				<form name="couponSearchForm" id="couponSearchForm">
					<table class="table_type1">
						<colgroup>
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
						</colgroup>
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">
									<spring:message code="column.coupon_view.date" />
								</th>
								<!-- 쿠폰 기간 -->
								<td colspan="3">
									<frame:datepicker startDate="aplStrtDtm" endDate="aplEndDtm" startValue="${frame:toDate('yyyy-MM-dd')}" endValue="${frame:toDate('yyyy-MM-dd')}" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간 선택"/>
									</select>
								</td>
								<th scope="row">
									<spring:message code="column.st_id" />
								</th>
								<!-- 사이트 ID -->
								<td>
									<select id="stIdCombo" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<spring:message code="column.cp_kind_cd" />
								</th>
								<!-- 쿠폰 종류 -->
								<td>
									<select name="cpKindCd" id="cpKindCd" title="<spring:message code="column.cp_kind_cd" />">
										<frame:select grpCd="${adminConstants.CP_KIND}" defaultName="전체" />
									</select>
								</td>
								<th scope="row">
									<spring:message code="column.cp_tg_cd" />
								</th>
								<!-- 쿠폰 대상 -->
								<td>
									<select name="cpTgCd" id="cpTgCd" title="<spring:message code="column.cp_tg_cd" />">
										<frame:select grpCd="${adminConstants.CP_TG}" useYn="Y" defaultName="전체"/>
									</select>
								</td>
								<th scope="row">
									<spring:message code="column.cp_stat_cd" />
								</th>
								<!-- 쿠폰 상태 -->
								<%-- selectKey="${adminConstants.CP_STAT_10 }" --%>
								<td>
									<select name="cpStatCd" id="cpStatCd" title="<spring:message code="column.cp_stat_cd" />">
										<frame:select grpCd="${adminConstants.CP_STAT}"  defaultName="전체"/>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<spring:message code="column.cp_nm" />
								</th>
								<!-- 쿠폰 명 -->
								<td>
									<input type="text" name="cpNm" id="cpNm" title="<spring:message code="column.cp_nm" />">
								</td>
								<th scope="row">
									<spring:message code="column.dc_gb_cd" />
								</th>
								<!-- 할인 구분 -->
								<td>
									<select name="cpAplCd" id="cpAplCd" title="<spring:message code="column.cp_apl_cd" />">
										<frame:select grpCd="${adminConstants.CP_APL}"  defaultName="전체"/>
									</select>
								</td>
								<th scope="row">
									<spring:message code="column.cp_isu_mth_cd" />
								</th>
								<!--  쿠폰발급 방식-->
								<td>
									<select name="cpPvdMthCd" id="cpPvdMthCd" title="<spring:message code="column.cp_pvd_mth_cd" />">
										<frame:select grpCd="${adminConstants.CP_PVD_MTH}"  defaultName="전체"/>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadCouponGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="couponInsertView();" class="btn btn-add">쿠폰 등록</button>
			<button type="button" onclick="copyCoupon();" class="btn btn-add">쿠폰 복사</button>
			
			<table id="couponList"></table>
			<div id="couponListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>