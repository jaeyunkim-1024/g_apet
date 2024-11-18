<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		
		$(document).ready(function(){
			<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_20}">
			changeRplYn();
			</c:if>
 		});
		
		// 머리말/맺음말 유형 변경
		$(document).on("change", "#replType", function(e) {
			// 머리말/맺음말 유형
			<c:forEach var="item" items="${frame:listCode(adminConstants.REPLY_TYPE_TP)}">
			if('${item.dtlCd}' == $("#replType").val()) {
				$("#rplHdContent").val('${item.usrDfn1Val}');
				$("#rplFtContent").val('${item.usrDfn2Val}');
			}
			</c:forEach>
			if('' == $("#replType").val()) {
				$("#rplHdContent").val('');
				$("#rplFtContent").val('');
			}
		});
		
		$(function() {
			<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_20}">
			$("#counsel_cc_process_rpl_yn").click(function(){
				changeRplYn();
			});
			</c:if>
		});
		
		// 처리 내용 등록
		function counselProcessSave() {

			if(validate.check("counselProcessForm") && validateProcessSave()) {
				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/counsel/cc/insertCounselProcess.do' />"
								, data : $("#counselProcessForm").serializeJson()
								, callBack : function(data) {
									messager.alert("<spring:message code='admin.web.view.msg.counsel.list.regist' />","Info","info",function(){
										var url = '/counsel/cc/counselCcView.do?cusNo=' + '${counsel.cusNo}' + '&viewGb=' + '${viewGb}';
										updateTab(url);
									});									
								}
							};

			 				ajax.call(options);				
					}
				});
			}
			
		}
		
		function validateProcessSave(){
			if($("#counsel_cc_process_rpl_yn").prop( "checked")){
				var cusRplCd = $("input[name=cusRplCd]:checked").val();
				if(cusRplCd == "<c:out value="${adminConstants.CUS_RPL_10}" />" && "${counsel.eqrrMobile}" == "") {
					messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.sms' />","Info","info");
					return false;
				}
				if(cusRplCd == "<c:out value="${adminConstants.CUS_RPL_20}" />" && "${counsel.eqrrEmail}" == "") {
					messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.email' />","Info","info");
					return false;
				}
			}
			return true;
		}
		
		<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_20}">
		// 고객회신 체크 이벤트
		function changeRplYn(){
			if($("#counsel_cc_process_rpl_yn").prop( "checked")){
				$(".process_rpl").show();
			}else{
				$(".process_rpl").hide();
				$("#rplHdContent").val('');
				$("#rplContent").val('');
				$("#rplFtContent").val('');
			}
		}
		</c:if>

		// 회원상세
		function fnMemberDetailView() {
            addTab('회원 상세', '/member/memberView.do?mbrNo=' + '${counsel.eqrrMbrNo}' + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
        }
		
		// 주문상세
		function fnOrderDetailView(ordNo) {
			addTab('주문 상세', '/cs/orderDetailView.do?ordNo=' + ordNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
		}
			

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle">
			<h2>상담문의 내용</h2>
		</div>
		<table class="table_type1">
			<caption>상담문의 상세</caption>
			<colgroup>
				<col style="width:170px;">
				<col />
				<col style="width:170px;">
				<col />
				<col style="width:170px;">
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.cus_no" /></th>
					<td>
						${counsel.cusNo}
					</td>
					<th scope="row"><spring:message code="column.cus_tp_cd" />/<spring:message code="column.cus_stat_cd" /></th>
					<td>
						<frame:codeName grpCd="${adminConstants.CUS_TP}" dtlCd="${counsel.cusTpCd}"/>
						/
						<frame:codeName grpCd="${adminConstants.CUS_STAT}" dtlCd="${counsel.cusStatCd}"/>
					</td>
					<th scope="row"><spring:message code="column.cus_chrg_nm" /></th>
					<td>
						${counsel.cusChrgNm}
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.cus_acpt_dtm" /></th>
					<td>
						${counsel.cusAcptDtm} / ${counsel.cusAcptrNm}
					</td>
					<th scope="row"><spring:message code="column.cus_cnc_dtm" /></th>
					<td>
						<c:if test="${!empty counsel.cusCncDtm}">
						${counsel.cusCncDtm} / ${counsel.cusCncrNm}
						</c:if>
					</td>
					<th scope="row"><spring:message code="column.cus_cplt_dtm" /></th>
					<td>
						<c:if test="${!empty counsel.cusCpltDtm}">
						${counsel.cusCpltDtm} / ${counsel.cusCpltrNm}
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.st_nm" /></th>
					<td>
						${counsel.stNm}
					</td>
					<th scope="row"><spring:message code="column.eqrr_id" /></th>
					<td>
						${counsel.loginId}
						<c:if test="${counsel.memberOK}">
						<button class="ml10 btn" onclick="fnMemberDetailView(); return false;">조회</button>
						</c:if>
					</td>
					<th scope="row"><spring:message code="column.eqrr_nm" />/<spring:message code="column.call_gb_cd" /></th>
					<td>
						${counsel.eqrrNm}
						/
						<frame:codeName grpCd="${adminConstants.CALL_GB}" dtlCd="${counsel.callGbCd}" />
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.eqrr_email" /></th>
					<td>
						${counsel.eqrrEmail}
					</td>
					<th scope="row"><spring:message code="column.eqrr_tel" /></th>
					<td>
						<frame:tel data="${counsel.eqrrTel}" />
					</td>
					<th scope="row"><spring:message code="column.eqrr_mobile" /></th>
					<td>
						<frame:mobile data="${counsel.eqrrMobile}" />
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.cus_ctg" /></th>
					<td colspan="5">
						<frame:codeName grpCd="${adminConstants.CUS_CTG1}" dtlCd="${counsel.cusCtg1Cd}"/>
						<c:if test="${!empty counsel.cusCtg2Cd}">
						&gt;
						<frame:codeName grpCd="${adminConstants.CUS_CTG2}" dtlCd="${counsel.cusCtg2Cd}"/>
						</c:if>
						<c:if test="${!empty counsel.cusCtg3Cd}">
						&gt;
						<frame:codeName grpCd="${adminConstants.CUS_CTG3}" dtlCd="${counsel.cusCtg3Cd}"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.ttl" /></th>
					<td colspan="5">
						${counsel.ttl}
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.content" /></th>
					<td colspan="5" >
						<div style="max-height:200px;overflow:auto;margin-top:5px;margin-bottom:5px;">
						${counsel.content}
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">연관정보</th>
					<td colspan="5">
						<c:forEach items="${counselOrderList}" var="counselOrder" varStatus="idx">
							<c:if test="${idx.first}">
							<p>[<spring:message code="column.ord_no" />] ${counselOrder.ordNo}<button class="ml10 btn" onclick="fnOrderDetailView('${counselOrder.ordNo}'); return false;">조회</button></p>
							</c:if>
							<ul class="orderlist">
								<li class="seq"><b>[<spring:message code="column.ord_dtl_seq" />]</b> ${counselOrder.ordDtlSeq}<li>
								<li class="goods"><b>[<spring:message code="column.goods_nm" />]</b> ${counselOrder.goodsNm}<li>
								<li class="item"><b>[<spring:message code="column.item_nm" />]</b> ${counselOrder.itemNm}<li>
							</ul>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		
		<c:if test="${!empty counselProcessList}">
		<div class="mTitle mt30">
			<h2>콜센터 처리내용</h2>
		</div>

		<table class="table_type1">
			<caption>콜센터 처리내용</caption>
			<colgroup>
				<col style="width:170px;">
				<col />
				<col style="width:170px;">
				<col />
			</colgroup>
			<tbody>
				<c:forEach items="${counselProcessList}" var="counselProcess" varStatus="idx">
				<tr <c:if test="${!idx.first}">style="border-top-style: double;border-top-width: 2px;"</c:if>>
					<th><spring:message code='column.prcs_content' /></th>
					<td colspan="3">
						${counselProcess.prcsContent}
					</td>
				</tr>					
				<c:if test="${!empty counselProcess.rplContent}">
				<tr>
					<th><spring:message code='column.rpl_content' /></th>
					<td colspan="3">
						[해당 내용은 <b><frame:codeName grpCd="${adminConstants.CUS_RPL}" dtlCd="${counselProcess.cusRplCd}"/></b>로 전송되었습니다.]
						<br/><br/>
						<div style="max-height:80px;overflow:auto;">
						${counselProcess.rplHdContent}
						<c:if test="${!empty counselProcess.rplHdContent}">
						<br/><br/>
						</c:if>
						${counselProcess.rplContent}
						<c:if test="${!empty counselProcess.rplFtContent}">
						<br/><br/>
						</c:if>
						${counselProcess.rplFtContent}
						</div>
					</td>
				</tr>
				</c:if>
				<tr>
					<th scope="row"><spring:message code='column.cus_prcsr_no' /></th>
					<td>
						${counselProcess.cusPrcsrNm}
					</td>
					<th scope="row"><spring:message code='column.cus_prcs_dtm' /></th>
					<td>
						<fmt:formatDate value="${counselProcess.cusPrcsDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>						
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>					

		<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_20 and counsel.cusChrgNo eq adminSession.usrNo}">
		<div class="mTitle mt30">
			<h2>콜센터 처리내용 등록</h2>
			<div class="buttonArea">
				<button type="button" onclick="counselProcessSave();" class="btn btn-add">저장</button>
			</div>
		</div>

		<form id="counselProcessForm" name="counselProcessForm" method="post" >
		<input type="hidden" name="cusNo" value="${counsel.cusNo}" />
			<table class="table_type1">
				<caption>콜센터 처리내용 등록</caption>
				<tbody>
					<tr>
						<th>최종완료여부</th>
						<td>
							<label class="fRadio"><input type="radio" name="lastRplYn" class="validate[required]" value="Y" /><span>예</span></label>
							<label class="fRadio"><input type="radio" name="lastRplYn" class="validate[required]" value="N" /><span>아니오</span></label>
							<span class="ml10">
							* 해당 상담이 최종 완료처리 하고자 하는경우 '예'를 선택하시기 바랍니다.
							</span>
						</td>
					</tr>						
					<tr>
						<th><spring:message code='column.prcs_content' /></th>
						<td>
							<textarea rows="3" class="validate[required]" id="prcsContent" name="prcsContent" style="width:98%"></textarea>
						</td>
					</tr>						
					<tr>
						<th scope="row">고객 회신 여부</th>
						<td> 
							<label class="fCheck"><input type="checkbox" id="counsel_cc_process_rpl_yn" value="Y" /><span>예</span></label>
							<span class="ml10">
							* 문의 고객에게 회신 내용이 존재할 경우 문자 또는 이메일을 사용하여 회신 가능
							</span>
						</td>
					</tr>
					<tr class="process_rpl" style="display:none">
						<th scope="row" rowspan="5"><spring:message code='column.rpl_content' /></th>
						<td>
							<select name="replType" id="replType" title="<spring:message code="column.disp_yn"/>" >
								<frame:select grpCd="${adminConstants.REPLY_TYPE_TP}" defaultName="머리말/맺음말 유형"/>
							</select>
						</td>
					</tr>
					<tr class="process_rpl" style="display:none;">
						<td style="border-bottom:none;" >
							<input type="text" class="w500 readonly" name="rplHdContent" id="rplHdContent" title="<spring:message code="column.rpl_hd_content"/>" value="" />
						</td>
					</tr>
					<tr class="process_rpl" style="display:none;">
						<td style="border-bottom:none;" >
							<textarea rows="3" class="w500 validate[required]" id="rplContent" name="rplContent" ></textarea>
						</td>
					</tr>
					<tr class="process_rpl" style="display:none;">
						<td>
							<input type="text" class="w500 readonly mt5" name="rplFtContent" id="rplFtContent" title="<spring:message code="column.rpl_ft_content"/>" value="" />
						</td>						
					</tr>
					<tr class="process_rpl" style="display:none;">
						<td>
							<frame:radio name="cusRplCd" grpCd="${adminConstants.CUS_RPL}" />
						</td>						
					</tr>
				</tbody>
			</table>
		
		</form>
		</c:if>		
	</t:putAttribute>
</t:insertDefinition>