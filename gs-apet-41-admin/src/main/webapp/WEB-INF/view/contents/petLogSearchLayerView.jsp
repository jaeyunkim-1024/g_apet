<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		layerPetLogList.searchDateChange();
	});
	
	$(document).on("change", "#orderingGb_", function(e) {
		var ordering = $("#orderingGb_ option:selected").val();
		$("#orderingGb").val(ordering);	
		layerPetLogList.searchPetLogList();
	});
	
	function getImage(imgPath) {
		return "<img src='${frame:optImagePath('"+imgPath+"', adminConstants.IMG_OPT_QRY_410)}' alt='' />";
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
					, height : 630
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
	
	function petLogUpdateProc(location) {
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
							layerPetLogList.searchPetLogList();
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
</script>
<input type = "hidden" id = "selectedPetLogNo" />
<form id="petLogSearchForm" name="petLogSearchForm" method="post">
	<input type="hidden" name="mbrNo" id="mbrNo" value="${petLogSO.mbrNo }" />
	<input type="hidden" name="dispCallYn" id="dispCallYn" value="${petLogSO.dispCallYn }" />
	<input type="hidden" name="customSort" />			
	<table class="table_type1">
		<caption>정보 검색</caption>
		<colgroup>
			<col style="width:15%;">							
			<col style="width:30%;">
			<col style="width:15%;">
			<col style="width:40%;">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.reg_dt" /><strong class="red">*</strong></th>								
				<!-- 기간 -->
				<td>
					<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" readonly = "true"/>
					<select id="checkOptDate" name="checkOptDate" onchange="layerPetLogList.searchDateChange();" style="margin-top: 5px;">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
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
					<frame:radio name="contsStatCd" grpCd="${adminConstants.CONTS_STAT }" defaultName="전체" selectKey="${petLogSO.contsStatCd}"/>
				</td>
			</tr>
			<tr>
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
						<frame:select grpCd="${adminConstants.PETLOG_CHNL }" defaultName="전체" selectKey="${petLogSO.petLogChnlCd}"/>
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
				<td><input type="text" class = "w200" name="tag" id="tag" title="태그" value="" /></td>
				
				<th scope="row"></th>								
				<td>				
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.petlog.url" /></th>
				<!-- URL -->
				<td>
					<input type="text" class = "w200" name="srtPath" id="srtPath" title="<spring:message code="column.url" />" value="" />
				</td>
				<th scope="row"><spring:message code="column.content" /></th>
				<!-- 내용 -->
				<td>
					<input type="text" class = "w300" name="dscrt" id="dscrt" title="내용" value="" />
				</td>							
			</tr>
			<tr>
				<!-- 공유 건수 -->
				<th scope="row"><spring:message code="column.petlog.share_cnt" /></th>
				<td>
					<input type="text" class="inputTypeNum w100" name="shareCntStrt"> ~ <input type="text" class="inputTypeNum w100" name="shareCntEnd"> 
				</td>
				<!-- 좋아요 건수 -->
				<th scope="row"><spring:message code="column.petlog.good_cnt" /></th> 
				<td>
					<input type="text" class="inputTypeNum w100" name="goodCntStrt"> ~ <input type="text" class="inputTypeNum w100" name="goodCntEnd">
				</td>							
			</tr>						
		</tbody>
	</table>
	<input type = "hidden" id = "orderingGb" name = "orderingGb" value=""/>
	
	<div class="btn_area_center">
		<button type="button" onclick="layerPetLogList.searchPetLogList();" class="btn btn-ok">조회</button>
		<button type="button" onclick="layerPetLogList.searchReset();" class="btn btn-cancel">초기화</button>
	</div>
</form>

<div class="mModule">
	<div class = "mButton">
		<div id="resultArea" class = "rightInner">
			<select id="orderingGb_" name="orderingGb_">							
				<frame:select grpCd="${adminConstants.PETLOG_ORDERING_TP }" selectKey="${adminConstants.PETLOG_ORDERING_TP_10 }" />
			</select>						
		</div>
	</div>
	<table id="layerPetLogList"></table>
	<div id="layerPetLogListPage"></div>
</div>
