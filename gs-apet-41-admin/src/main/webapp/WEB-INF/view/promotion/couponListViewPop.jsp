<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#checkOptDate option[value=${adminConstants.SELECT_PERIOD_40}]").prop("selected", true);
				searchDateChange();
				setCommonDatePickerEvent('#aplStrtDtm','#aplEndDtm');
				createCouponGrid();
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
			
			function resetSearchForm() {
				resetForm('couponSearchForm');
				$("#stId").val (${member.stId});
				$("#checkOptDate option[value=${adminConstants.SELECT_PERIOD_20}]").prop("selected", true);
				searchDateChange();    			
    			reloadCouponGrid();
			}

			function searchDateChange(){
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#aplStrtDtm").val($("#aplStrtDtm").data("origin"));
					$("#aplEndDtm").val($("#aplEndDtm").data("origin"));
				} else {
					setSearchDate(term, "aplStrtDtm", "aplEndDtm");
				}
			}

			// 그룹 코드 리스트
			function createCouponGrid(){
				var options = {
					url : "<spring:url value='/promotion/couponListGrid.do' />"
					, height : 300
					, searchParam : $("#couponSearchForm").serializeJson()
					, colModels : [
						{name:"cpNo", label:'<spring:message code="column.cp_no" />', width:"80", align:"center", formatter:'integer'}
						, {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"200", align:"center"}
						, {name:"cpPvdMthCd", label:'<spring:message code="column.cp_isu_mth_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_PVD_MTH}" />"}}
						, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center"}
						, {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}
						, {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
						, {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
						, {name:"cpAplCd", label:'<spring:message code="column.dc_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
						, {name:"aplVal", label:'<spring:message code="column.dc_amt" />', width:"80", align:"center", formatter:'integer'}
						, {name:"minBuyAmt", label:'<spring:message code="column.min_buy_amt" />', width:"80", align:"center", formatter:'integer'}
						, {name:"maxDcAmt", label:'<spring:message code="column.max_dc_amt" />', width:"80", align:"center", formatter:'integer'}
						, {name:"aplStrtDtm", label:'<spring:message code="column.apl_strt_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"aplEndDtm", label:'<spring:message code="column.apl_end_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"cpRstrYn", label:'<spring:message code="column.cp_rstr_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_RSTR_YN}" />"}}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
				};
				grid.create("couponList", options);
			}

			function reloadCouponGrid(){
				
				var options = {
					searchParam : $("#couponSearchForm").serializeJson()
				};

				grid.reload("couponList", options);
				
			}

			function couponView(cpNo) {
				createTargetFormSubmit({
					  id : "couponView"
					, url : "<spring:url value='/promotion/couponView.do' />"
					, target : '_blank'
					, data : {
						cpNo : cpNo
					}
				});
			}
			
			function memberIssueCoupon() {
                var grid = $("#couponList" );
                var rowids = grid.jqGrid('getGridParam','selrow');
                
                var message = '<spring:message code="column.prmt.coupon.member.warning" />';
                if (rowids == null) {
                	//messager.alert(message,"Info","info");
                	messager.alert("발급하실 쿠폰을 선택하세요","Info","info");
                	return;
                };
                var rowdata = grid.getRowData(rowids);


                var aplStrtDtm = new Date(rowdata.aplStrtDtm);
				var aplStrtYear = aplStrtDtm.getFullYear(); // 년도
				var aplStrtMonth = ("0" + (aplStrtDtm.getMonth() +1 )).slice(-2) ;  // 월
				var aplStrtDate = ("0" + (aplStrtDtm.getDate())).slice(-2);  // 날짜
				var aplStrtDate = aplStrtYear + aplStrtMonth + aplStrtDate;
				
				var today = new Date();
				var year = today.getFullYear(); // 년도
				var month = ("0" + (today.getMonth() +1 )).slice(-2) ;  // 월
				var date = ("0" + (today.getDate())).slice(-2);  // 날짜
				var currentDate = year + month + date;
				
				if(parseInt(aplStrtDate) > parseInt(currentDate)){
					message = '<spring:message code="column.prmt.coupon.member.isu_stb" />';
				}else{
					message = '<spring:message code="column.prmt.coupon.member.issue" />';
				}
				
				messager.confirm(message,function(r){
					if(r){
						var options = {
	                            url : "<spring:url value='/promotioin/memberCouponIssue.do' />"
	                            , data : {
	                            	cpNo : rowdata.cpNo,
	                            	mbrNo : ${member.mbrNo}
	                            }
	                            , callBack : function(result){
	                                var mbrCpNo = result.mbrCpNo;
	                                var msg = "";
	                            	
	                                if(parseInt(mbrCpNo) > 0) {
		                                var msg = "발급";
		                            }else{
		                                var msg = "대기";
		                            }
	                            	messager.alert("쿠폰 발급이 완료되었습니다.", "Info", "info",function(){
										reloadCsMemberCouponPossibleListGrid();
										layer.close('couponListView');
									});
	                            }
	                    };
	        
	                    ajax.call(options);					
					}
				});
			}    
		</script>
			<form name="couponSearchForm" id="couponSearchForm">
			<table class="table_type1">
				<caption>정보 검색</caption>
				<colgroup>
					<col width="15%"/>
					<col width="45%"/>
					<col width="15%"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.cp_kind_cd" /></th>
						<td>
							<select name="cpKindCd" id="cpKindCd" title="<spring:message code="column.cp_kind_cd" />">
								<frame:select grpCd="${adminConstants.CP_KIND}" defaultName="전체"/>
							</select>
						</td>
						<th scope="row"><spring:message code="column.cp_stat_cd" /></th>
						<td>
							<select name="cpStatCd" id="cpStatCd" title="<spring:message code="column.cp_stat_cd" />">
								<frame:select grpCd="${adminConstants.CP_STAT}" defaultName="전체"/>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.cp_nm" /></th>
						<td>
							<input type="text" name="cpNm" id="cpNm" title="<spring:message code="column.cp_nm" />" >
						</td>
						<th scope="row"><spring:message code="column.dc_gb_cd" /></th>
						<td>
							<select name="cpAplCd" id="cpAplCd" title="<spring:message code="column.dc_gb_cd" />">
								<frame:select grpCd="${adminConstants.CP_APL}" defaultName="전체"/>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.cp_prd" /></th>
						<td>
							<frame:datepicker startDate="aplStrtDtm" endDate="aplEndDtm" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd')}" />

							<select id="checkOptDate" class="ml10" name="checkOptDate" onchange="searchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
							</select>
						</td>
						<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
						<td>
							<frame:stId funcNm="searchSt()" defaultStId="${member.stId }" defaultStNm="${member.stNm }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.cp_isu_mth_cd" /><!--  쿠폰발급 방식--></th>
						<td>
								<c:choose>
									<c:when test="${not empty coupon.cpPvdMthCd}">
										<select class="wth100 readonly" readonly="" name="cpPvdMthCd" id="cpPvdMthCd" title="<spring:message code="column.cp_pvd_mth_cd"/>" disabled >
											<frame:select grpCd="${adminConstants.CP_PVD_MTH}" defaultName="전체" selectKey="${coupon.cpPvdMthCd}"/>
										</select>
									</c:when>
									<c:otherwise>
										<select class="wth100" name="cpPvdMthCd" id="cpPvdMthCd" title="<spring:message code="column.cp_pvd_mth_cd" />">
											<frame:select grpCd="${adminConstants.CP_PVD_MTH}" defaultName="전체"/>
										</select>
									</c:otherwise>
								</c:choose>

						</td>
						<th scope="row"><spring:message code="column.cp_tg_cd" /><!--  쿠폰대상--></th>
						<td>
								<c:choose>
									<c:when test="${not empty coupon.cpTgCd}">
										<select class="wth100 readonly" readonly="" name="cpTgCd" id="cpTgCd" title="<spring:message code="column.cp_tg_cd"/>" disabled >
											<frame:select grpCd="${adminConstants.CP_TG}"  selectKey="${coupon.cpTgCd}"/>
										</select>
									</c:when>
									<c:otherwise>
										<select class="wth100" name="cpTgCd" id="cpTgCd" title="<spring:message code="column.cp_pvd_mth_cd" />">
											<frame:select grpCd="${adminConstants.CP_TG}" defaultName="전체"/>
										</select>
									</c:otherwise>
								</c:choose>

						</td>						
					</tr>
				</tbody>
			</table>
			</form>

		<div class="btn_area_center">
			<button type="button" onclick="reloadCouponGrid();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetSearchForm();" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="couponList"></table>
			<div id="couponListPage"></div>
		</div>

