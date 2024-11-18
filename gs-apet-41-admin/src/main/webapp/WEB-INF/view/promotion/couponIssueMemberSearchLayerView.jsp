<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function(){
		
        $("#searchWord").bind('keydown', function(e) {
            if(event.keyCode == 13) {
                $('#searchBtn').click();
                return false;
            }
        });
        fnMembrerListGrid();
	});
	
	function fnMembrerListGrid(gridParam) {
		
		$("#layerMemberSearchForm input[name='petRegYn']").val("Y");
		$("#layerMemberSearchForm input[name='sidx']").val("MBR_NO");
		$("#layerMemberSearchForm input[name='sord']").val("DESC");
		
		if(gridParam == null) gridParam =  $("#layerMemberSearchForm").serializeJson();
		
		var colModelsObj =  [
			{name:"mbrNo", label:_MEMBER_SEARCH_GRID_LABEL.mbrNo, width:"70", align:"center", sortable:false , key:true}
			, {name:"loginId", label:_MEMBER_SEARCH_GRID_LABEL.loginId, width:"150", align:"center", sortable:false}
			, {name:"mbrNm", label:_MEMBER_SEARCH_GRID_LABEL.mbrNm, width:"80", align:"left", sortable:false}
			, {name:"mobile", label:_MEMBER_SEARCH_GRID_LABEL.mobile, width:"110", align:"center", sortable:false}
			, {name:"email", label:_MEMBER_SEARCH_GRID_LABEL.email, width:"150", align:"center", sortable:false}
			, {name:"mbrGbCd", label:_MEMBER_SEARCH_GRID_LABEL.mbrGbCd, width:"80", align:"center", sortable:false, formatter:"select" ,editoptions:{value:_MBR_GB_CD} }  
			, {name:"mbrGrdCd", label:_MEMBER_SEARCH_GRID_LABEL.mbrGrdCd, width:"80", align:"center", sortable:false, formatter:"select" ,editoptions:{value:_MBR_GRD_CD} }
		];
		
		var options = {
			url : _MEMBER_GRID_POPUP_URL
			, height : 300
			, datatype : 'local'
			, searchParam : gridParam
			, colModels : colModelsObj
			, multiselect : true
			
		};
		grid.create("layerMemberList", options);
		
	}
	
	function searchMemberList() {
		
		$("#layerMemberSearchForm input[name='petRegYn']").val("Y");
		$("#layerMemberSearchForm input[name='sidx']").val("MBR_NO");
		$("#layerMemberSearchForm input[name='sord']").val("DESC");
		
		var options = {
			searchParam : $("#layerMemberSearchForm").serializeJson()
		};
		grid.reload("layerMemberList", options);
	}
	
	function searchReset(){
		resetForm ("layerMemberSearchForm" );
	}
	
	function saveCouponIssueList(){
		var gridMember = $("#layerMemberList");

		var rowids = gridMember.jqGrid('getGridParam', 'selarrrow');
		if(rowids.length <= 0 ) {
			messager.alert("<spring:message code='admin.web.view.msg.common.noSelect' />", "Info", "info");
			return;
		}
		
		// 사용자 정보 확인
		var isuTgCd = "<c:out value='${coupon.isuTgCd}'/>";	//발급대상회원
		var isuTgCdNm = "<frame:codeName grpCd='${adminConstants.ISU_TG }' dtlCd='${coupon.isuTgCd }' />";
		var couponGrdCd = "<c:out value='${coupon.mbrGrdCd}'/>";	//발급대상등급

		for (var i = 0; i < rowids.length; i++) {
			var rowData = gridMember.jqGrid('getRowData', rowids[i]);

			// 발급대상회원 구분 체크
			if(isuTgCd != "00" && isuTgCd == rowData.mbrGbCd){
				messager.alert(isuTgCdNm+" 발급 가능 쿠폰 입니다.", "Info", "info");
				return;
			}
			
			// 발급회원등급 체크
			if((couponGrdCd != null && couponGrdCd != '') && couponGrdCd.indexOf(rowData.mbrGrdCd)  < 0){
				messager.alert("발급 가능 회원등급이 아닙니다.", "Info", "info");
				return;
			}
			
		}
				
		messager.confirm("쿠폰을 발급하시겠습니까?",function(r){
			if(r){

				var cpNo = Number("<c:out value='${coupon.cpNo }'/>");
				var options = {
					url : "<spring:url value='/promotion/couponIssueMemberList.do' />"
					, data : {cpNo : cpNo, mbrNos : rowids}
					, callBack : function(data ) {
						grid.reload("couponIssueList", options);
						
						
						var resultMsg = "쿠폰 발급이 완료되었습니다.";
						
						if(data.totCnt == 1 && data.failCnt > 0){
							resultMsg = "쿠폰 발급 실패하였습니다."+"<br/>(사유 : 이전 발급)";
						}else if(data.totCnt > 1 && data.sussCnt > 0){
							resultMsg = resultMsg+"<br/>(성공 : "+data.sussCnt+"명 / 실패 : "+data.failCnt+"명)";
						}else if(data.totCnt > 1 && data.sussCnt == 0){
							resultMsg = "쿠폰 발급 실패하였습니다."+"<br/>(성공 : "+data.sussCnt+"명 / 실패 : "+data.failCnt+"명)";
						}
						
						messager.alert( resultMsg , "Info", "info", function(){
							layer.close('layerCouponIssueSearchView');
						});
					}
				};
				ajax.call(options);
			}
		});
	}
	
</script>
			
<form id="layerMemberSearchForm" name="layerMemberSearchForm" method="post" >
	<input type="hidden" name="petRegYn" value="Y" />
	<input type="hidden" name="sidx" value="MBR_NO" />
	<input type="hidden" name="sord" value="DESC" />
	<table class="table_type1 popup">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th>회원구분</th>
				<td>
					<input type="hidden" name="mbrStatCd" id="mbrStatCd" value="10"  />
					<!-- 회원 구분 코드-->
					<select name="mbrGbCd" id="mbrGbCd">
						<option value="" selected="selected">전체</option>
						<frame:select grpCd="${adminConstants.MBR_GB_CD}" selectKey="${param.mbrGbCd }"
						 excludeOption="${adminConstants.MBR_GB_CD_40 },${adminConstants.MBR_GB_CD_30 },${adminConstants.MBR_GB_CD_50 }"/>
					</select>
				</td>
				<th>회원등급</th>
				<td>
					<!-- 회원 구분 코드-->
					<select name="mbrGrdCd" id="mbrGrdCd">
						<option value="" selected="selected">전체</option>
						<frame:select grpCd="${adminConstants.MBR_GRD_CD}" selectKey="${param.mbrGrdCd }" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.mobile"/>번호</th>
				<td colspan="3">
					<!-- 휴대폰-->
					<input type="text" class="phoneNumber" name="mobile" id="mobile" placeholder="-없이 입력" title="<spring:message code="column.mobile"/>" value="${param.mobile }" style="width:60%;" />
				</td>
			</tr>
			<tr>
				<th>검색어</th>
				<td colspan="3">
					<select name="searchType" id="searchType" title="<spring:message code="column.faq.search_text" />">
						<option value="">전체</option>
						<option value="loginId">회원ID</option>
						<option value="mbrNo">회원번호</option>
						<option value="memberNm">회원명</option>
						<option value="nickNm">닉네임</option> 
					</select>
 					<input type="text" class="" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요"  value="${param.searchWord}" style="width:40%;" />
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="btn_area_center">
	<button type="button" onclick="searchMemberList();" id="searchBtn" class="btn btn-ok">검색</button>
	<button type="button" onclick="resetForm('layerMemberSearchForm');" class="btn btn-cancel">초기화</button>
</div>

<div class="mModule">
	<table id="layerMemberList" ></table>
	<div id="layerMemberListPage"></div>
</div>
