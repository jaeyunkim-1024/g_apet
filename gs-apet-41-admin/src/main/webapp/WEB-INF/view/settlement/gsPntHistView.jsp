<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			searchDateChange();
			createGsPntHistGrid();
			newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
			
			// 총금액 계산
			gsPnt.setTotlaInfo();
			
			// input 엔터 이벤트
            $(document).on("keydown","#usrGbIpt, #orderGbIpt, input[name='pnt']",function(e){
                if ( e.keyCode == 13 ) {
                	reloadEduContsGrid('');
                }
            });
		});

		// GS&포인트 내역 그리드
		function createGsPntHistGrid(){
			var options = {
				url : "<spring:url value='/settlement/getGsPntHistList.do' />"
				, height : 400
				, searchParam : $("#gsPntHistSearchForm").serializeJson()
				, colModels : [
					{name:"rowIndex", label:'NO', width:"60", align:"center", sortable:false}
					/* 원거래 번호 */
					, {name:"ordNo", label:'원거래번호', width:"90", align:"center", sortable:false}
					/* 거래 번호 */
					, {name:"dealNo", label:'거래번호', width:"90", align:"center", sortable:false}
					/* 거래 구분 */
					, {name:"dealGbCd", label:'거래구분', width:"80", align:"center", sortable:false , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DEAL_GB }' showValue='false' />"}}
					/* 적립 사용 구분 */
					, {name:"saveUseGbCd", label:'적립사용 구분', width:"70", align:"center", sortable:false , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SAVE_USE_GB }' showValue='false' />"}}
					/* 회원 번호 */
					, {name:"mbrNo", label:'user-no', width:"80", align:"center", sortable:false}
					/* 포인트 회원번호 */
					, {name:"gspntNo", label:'포인트 회원번호', width:"120", align:"center", sortable:false} 
					/* 거래일시 */
					, {name:"dealDtm", label:'거래일시', width:"150", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
						return new Date(rawObject.dealDtm).format("yyyy-MM-dd HH:mm:ss");
						}
					}
					/* 총 결제 금액 */
					, {name:"payAmt", label:'총 결제 금액', width:"100", align:"right", formatter:"integer", sortable:false} 
					/* 포인트 거래일시 */
					, {name:"sysRegDtm", label:'포인트 거래일시', width:"150", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
						return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss");
						}
					}
					/* 포인트 사용 */
					, {name:"pntUse", label:'포인트 사용', width:"100", align:"right", formatter:"integer", sortable:false} 
					/* 포인트 적립 */
					, {name:"pntSave", label:'포인트 적립', width:"100", align:"right", formatter:"integer", sortable:false} 
					/* 포인트 취소 */
					, {name:"pntCncl", label:'포인트 취소', width:"100", align:"right", formatter:"integer", sortable:false} 
				]
			};
			grid.create("gsPntHistList", options);
			$("#gsPntHistList").jqGrid('setGroupHeaders', {
    			useColSpanStyle: true,
    			groupHeaders : [
    				{"startColumnName":"pntUse", "numberOfColumns":3, "titleText":'포인트 내역' }
    			]
    		});
		}
		
		/* 날짜 변경 적용 */
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
		
		/* 검색 */
		function reloadEduContsGrid(){
			compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');		
	    	
			rIndex = 0;
			// 주문정보
			var orderGb = $("#orderGb").val();
			var orderGbInfo = $("#orderGbIpt").val();
			if(orderGb == ""){
				$("input[name=ordNo]").val(orderGbInfo);
				$("input[name=dealNo]").val(orderGbInfo);
			}else if(orderGb == "10"){
				$("input[name=ordNo]").val(orderGbInfo);
			}else if(orderGb == "20"){
				$("input[name=dealNo]").val(orderGbInfo);
			}
			// 주문자 정보
			var usrGb = $("#usrGb").val();
			var usrGbInfo = $("#usrGbIpt").val();
			if(usrGb == ""){
				$("input[name=mbrNo]").val(usrGbInfo);
				$("input[name=gspntNo]").val(usrGbInfo);
			}else if(usrGb == "10"){
				$("input[name=mbrNo]").val(usrGbInfo);
			}else if(usrGb == "20"){
				$("input[name=gspntNo]").val(usrGbInfo);
			}
			
			// 옵션 설정
			let options = {
				searchParam : $("#gsPntHistSearchForm").serializeJson()
			};
			gridReload('sysRegDtmStart','sysRegDtmEnd','gsPntHistList','term', options);
			// 총금액 계산
			gsPnt.setTotlaInfo();
		}
		
		/* 초기화 버튼클릭 */
		function searchReset () {
			resetForm ("gsPntHistSearchForm");
			searchDateChange();
		}
		
		/* 엑셀 다운로드 */
		function gsPntHistExcelDownload() {
			var searchParam = $("#gsPntHistSearchForm").serializeJson();
			var headerName = new Array();
			var fieldName = new Array();
			headerName.push("NO");
			headerName.push("원거래 번호");
			headerName.push("거래 번호");
			headerName.push("거래 구분");
			headerName.push("적립 사용 구분");
			headerName.push("usr-no");
			headerName.push("포인트 회원번호");
			headerName.push("거래일시");
			headerName.push("총 결제 금액");
			headerName.push("포인트 거래일시");
			headerName.push("포인트 사용");
			headerName.push("포인트 적립");
			headerName.push("포인트 취소");
			fieldName.push("excelNo");
			fieldName.push("ordNo");
			fieldName.push("dealNo");
			fieldName.push("dealGbCd");
			fieldName.push("saveUseGbCd");
			fieldName.push("mbrNo");
			fieldName.push("gspntNo");
			fieldName.push("dealDtm");
			fieldName.push("payAmt");
			fieldName.push("sysRegDtm");
			fieldName.push("pntUse");
			fieldName.push("pntSave");
			fieldName.push("pntCncl");
			
			$.extend(searchParam, {
				headerName : headerName
				, fieldName : fieldName
			});
			createFormSubmit("gsPntHistExcelDownload", "/settlement/gsPntHistExcelDownload.do", searchParam);
		}
		var gsPnt = {
			chgOrderGb : function() {
				$(".orderGbIpt").val("");
			},
			chgUsrGb : function() {
				$(".usrGbIpt").val("");
			},
			setTotlaInfo : function() {
				var options = {
					url : "/settlement/getGsPntHistTotal.do"
					, data : $("#gsPntHistSearchForm").serializeJson()
					, callBack : function(data) {
						if( data.totlal != null && data.totlal.totalPntUse != null){
							$("#totalPntUse").html(valid.numberWithCommas(data.totlal.totalPntUse));
						}else{
							$("#totalPntUse").html("0");
						}
						if( data.totlal != null && data.totlal.totalPntSave != null){
							$("#totalPntSave").html(valid.numberWithCommas(data.totlal.totalPntSave));
						}else{
							$("#totalPntSave").html("0");
						}
						if( data.totlal != null && data.totlal.totalPntCncl != null){
							$("#totalPntCncl").html(valid.numberWithCommas(data.totlal.totalPntCncl));
						}else{
							$("#totalPntCncl").html("0");
						}
					}
				};
				ajax.call(options );
			}
		}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="조회 조건" style="padding:10px">
				<form name="gsPntHistSearchForm" id="gsPntHistSearchForm" method="post">
					<table class="table_type1">
						<colgroup>
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
						</colgroup>
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<!-- 기간(등록일) -->
								<th scope="row">포인트 거래일자</th>
								<td >
									<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd"	startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" /> 
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate"	onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"	defaultName="기간선택" />
									</select>
								</td>
								<!-- 주문정보 -->
								<th scope="row">주문정보</th>
								<td >
									<select id="orderGb" onchange="gsPnt.chgOrderGb();">
										<option value="">전체</option>
										<option value="10">원거래번호</option>
										<option value="20">거래번호</option>
									</select>
									<input class="orderGbIpt" type="text" id="orderGbIpt" ><!-- w250  -->
									<input class="orderGbIpt" type="hidden" name="ordNo" title="원거래번호"/>
									<input class="orderGbIpt" type="hidden" name="dealNo" title="거래번호"/>
								</td>
							</tr>
							<tr>
								<!-- 거래구분 -->
								<th scope="row">거래구분</th>
								<td>
									<select id=dealGbCd name="dealGbCd">
										<frame:select grpCd="${adminConstants.DEAL_GB }" useYn="Y" defaultName="전체"/>
									</select>
								</td>
								<!-- 적립/사용 구분 -->
								<th scope="row">적립/사용 구분</th>
								<td>
									<select id=saveUseGbCd name="saveUseGbCd">
										<frame:select grpCd="${adminConstants.SAVE_USE_GB }" useYn="Y" defaultName="전체"/>
									</select>
								</td>
							</tr>		
							<tr>
								<!-- 주문자 -->
								<th scope="row">주문자</th>
								<td >
									<select id="usrGb" onchange="gsPnt.chgUsrGb();">>
										<option value="">전체</option>
										<option value="10">user-no</option>
										<option value="20">포인트 회원번호</option>
									</select>
									<input class="usrGbIpt" type="text" id="usrGbIpt" >
									<input class="usrGbIpt" type="hidden" name="mbrNo" title="회원번호"/>
									<input class="usrGbIpt" type="hidden" name="gspntNo" title="포인트 회원 번호"/>
								</td>
								<!-- 포인트 금액 -->
								<th scope="row">포인트 금액</th>
								<td>
									<input  class="numberOnly" type="text" name="pnt" title="포인트 금액"/>
								</td>
							</tr>									
								
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadEduContsGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea" style="text-align: right;">
					<span>(총 사용금액 : <span id="totalPntUse" class="comma">0</span>원, 적립금액 : <span id="totalPntSave" class="comma">0</span>원, 취소금액 : <span id="totalPntCncl" class="comma">0</span>원) </span>
					<button type="button" onclick="gsPntHistExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
			
			<table id="gsPntHistList"></table>
			<div id="gsPntHistListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>