<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				console.log('${itemList}');
				setCisAPIRequestData();
			});
			
			//CIS API 호출 테스트 데이타 SET
			function setCisAPIRequestData(){
				var data;
				//주문등록
				data = '{"ordrNm":"데모테스터(EK)3","ordrTelNo":"01012345678","ordrCelNo":"01056781234","ordrEmail":"admin@valfac.com","recvNm":"데모테스터(EK)","recvTelNo":"","recvCelNo":"01012345678","recvZipcode":"06000","recvAddr":"서울 강남구 강남대로 708","recvAddrDtl":"1","dcAmt":0,"cpnAmt":0,"dlvAmt":0,"gateNo":null,"ordrDd":"20210209","ordrTm":"180735","rmkTxt":"","itemList":[{"skuCd":"GI000054423","skuNm":"[작업중] 상품 rework 테스트1","optTxt":"","unitNm":"EA","price":380000,"ea":1,"cstrtGbCd":"10","ownrCd":"AP","wareCd":"AW01","drelTpCd":"SO1","dlvtTpCd":"20","arrvCd":"aboutPet","dlvGrpCd":null,"dawnMallId":null,"dlvReqDd":"20210217","shopOrdrNo":"C202102090001223","shopSortNo":"1_1","exchgYn":"N","orgShopOrdrNo":"","orgShopSortNo":"","rmkTxt":"","dlvrcNo":2013,"compGbCd":"10","compNo":"330"},{"skuCd":"G000054169","skuNm":"갤럭시 버즈","optTxt":"","unitNm":"EA","price":159500,"ea":3,"cstrtGbCd":"10","ownrCd":"AP","wareCd":"AW01","drelTpCd":"SO1","dlvtTpCd":"20","arrvCd":"aboutPet","dlvGrpCd":null,"dawnMallId":null,"dlvReqDd":"20210217","shopOrdrNo":"C202102090001223","shopSortNo":"2_1","exchgYn":"N","orgShopOrdrNo":"","orgShopSortNo":"","rmkTxt":"","dlvrcNo":2013,"compGbCd":"10","compNo":"330"}]}';
				$("#orderI").val(data);
				
				//주문조회
				data = '{"shopOrdrNo":"C202102090001224","srcStaDd":"20210201","srcEndDd":"20210207","allYn":"Y"}';
				$("#orderS").val(data);
				
				//주문취소
				data = '{"shopOrdrNo":"2020101511112317530","ea":1,"shopSortNo":"17236"}';
				$("#orderC").val(data);
				
				//반품등록
				data = '{"rtnTpCd":"R1","rqstNm":"홍길동","rtnDueDd":"20210120","rqstTelNo":"010-1234-5678","rqstZipcode":"06141","rqstAddrDtl":"지하 1층","rqstAddr":"서울특별시 강남구 논현로 508 GS강남타워","rqstCelNo":"010-1234-5678","rmkTxt":"고객변심","itemList":[{"shopOrdrNo":"2021011508123217530","shopSortNo":"17231","ea":1,"dlvCmpyCd":"CJ","rmkTxt":""},{"shopOrdrNo":"2021011508123217530","shopSortNo":"17232","ea":1,"dlvCmpyCd":"CJ","rmkTxt":""}]}';
				$("#returnI").val(data);
				
				//반품조회
				data = '{"rtnsNo":null,"shopOrdrNo":null,"clltOrdrNo":null,"srcStaDd":"20201208","srcEndDd":"20201214","allYn":"Y"}';
				$("#returnS").val(data);

				//반품취소
				data = '{"rtnsNo":"202010190017530","itemNo":1,"statCd":"D"}';
				$("#returnC").val(data);
				
				//슬롯조회
				data = '{"dlvtTpCd":"20","ymd":"20210202","mallId":null,"dlvGrpCd":null,"zipcode":"01000"}';
				$("#slotS").val(data);
				
				//권역조회
				data = '{"dlvtTpCd":"20","zipcode":"01000"}';
				$("#rngeS").val(data);
				
				//주문수정
				data = '{"recvZipcode":"06000","recvNm":"고길동","shopOrdrNo":"C202102090001224","recvAddrDtl":"123-1","recvCelNo":"01012345678","recvTelNo":"01012345678","gateNo":"4378","recvAddr":"서울특별시 강남구 논현로 508 (역삼동, GS강남타워) 123","itemList":[{"shopOrdrNo":"C202103040000073","shopSortNo":"1_1","dlvtTpCd":"10","dlvGrpCd":"20","dlvReqDd":"20210209"}]}';
				$("#orderU").val(data);
				
				//반품수정
				data = '{"rqstTelNo":"01012345678","rqstZipcode":"06000","rqstAddrDtl":"369","rqstAddr":"서울특별시 강남구 논현로 508 (역삼동, GS강남타워) 123","rtnsNo":"202101150017533","rqstCelNo":"01023569856","rqstNm":"김몰라"}';
				$("#returnU").val(data);
				
				//반품수정
				data = '{"shopOrdrNo":"C202104020001302","shopSortNo":"1_1"}';
				$("#dlvrS").val(data);
			}
			
			//CIS API 호출
			function callCisAPI(gubun){
				var url, data, contentType="";
				$("#res"+gubun).val('호출중...');
				
				if(gubun == 'ORDER-I'){
					url = "<spring:url value='/samplecisapi/shopOrderInsert.do' />";
					data = jQuery.parseJSON($("#orderI").val());
					data = JSON.stringify(data);
					contentType = "application/json";
					
				}else if(gubun == 'ORDER-S'){
					url = "<spring:url value='/samplecisapi/shopOrderInquiry.do' />";
					data = jQuery.parseJSON($("#orderS").val());

				}else if(gubun == 'ORDER-C'){
					url = "<spring:url value='/samplecisapi/shopOrderCancel.do' />";
					data = jQuery.parseJSON($("#orderC").val());
					
				}else if(gubun == 'RETURN-I'){
					url = "<spring:url value='/samplecisapi/shopReturnInsert.do' />";
					data = jQuery.parseJSON($("#returnI").val());
					data = JSON.stringify(data);
					contentType = "application/json";
					
				}else if(gubun == 'RETURN-S'){
					url = "<spring:url value='/samplecisapi/shopReturnInquiry.do' />";
					data = jQuery.parseJSON($("#returnS").val());

				}else if(gubun == 'RETURN-C'){
					url = "<spring:url value='/samplecisapi/shopReturnCancel.do' />";
					data = jQuery.parseJSON($("#returnC").val());
					
				}else if(gubun == 'SLOT-S'){
					url = "<spring:url value='/samplecisapi/shopSlotInquiry.do' />";
					data = jQuery.parseJSON($("#slotS").val());
					
				}else if(gubun == 'RNGE-S'){
					url = "<spring:url value='/samplecisapi/shopRngeInquiry.do' />";
					data = jQuery.parseJSON($("#rngeS").val());
					
				}else if(gubun == 'ORDER-U'){
					url = "<spring:url value='/samplecisapi/shopOrderUpdate.do' />";
					data = jQuery.parseJSON($("#orderU").val());
					data = JSON.stringify(data);
					contentType = "application/json";
					
				}else if(gubun == 'RETURN-U'){
					url = "<spring:url value='/samplecisapi/shopReturnUpdate.do' />";
					data = jQuery.parseJSON($("#returnU").val());
					data = JSON.stringify(data);
					contentType = "application/json";
					
				}else if(gubun == 'DLVR-S'){
					url = "<spring:url value='/samplecisapi/shopDlvrSearch.do' />";
					data = jQuery.parseJSON($("#dlvrS").val());
					data = JSON.stringify(data);
					contentType = "application/json";
					
				}
				
				var options = {
						  url : url
						, wait : true
						, type : 'POST'
						, contentType : contentType
						, data : data
						, callBack : function(result){
							$("#res"+gubun).val(JSON.stringify(result));
						}
						, error : function (xhr, status, error) {
							$("#res"+gubun).val('통신오류발생');
							console.info(error);
						}
				};
				ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="CIS API Client 적용 가이드" style="padding:10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> MDM 거래처 조회를 예시로 하였습니다.</li>
							<li style="margin-bottom: 5px;"><b>·</b> local 환경에서는 Bastion 에 10.20.23.10:8081 port forwarding 합니다.</li>
							<li style="margin-bottom: 5px;">1. CommonConstants에 API ID(CommonConstants.CIS_API_ID_ + "API ID")를 추가합니다.</li>
							<li style="margin-bottom: 5px;">&emsp;ex) /** MDM 거래처 조회 */</li>
							<li style="margin-bottom: 5px;">&emsp;&emsp;&emsp;public static final String CIS_API_ID_<b style="color: red;">IF_S_SELECT_PRNT_LIST</b> = "<b style="color: red;">IF_S_SELECT_PRNT_LIST</b>";</li>
							<li style="margin-bottom: 5px;">2. 환경별(LOCAL/DEV/STG/PRD) business.xml에 경로(entry key="cis.api.request.url.'API ID')를 모두 추가합니다.</li>
							<li style="margin-bottom: 5px;">&emsp;ex) /** MDM 거래처 조회 */</li>
							<li style="margin-bottom: 5px;">&emsp;&emsp;&emsp;&lt;entry key="cis.api.request.url.<b style="color: red;">IF_S_SELECT_PRNT_LIST</b>"&gt;/cis/selectPrntList.do&lt;/entry&gt;</li>
							<li style="margin-bottom: 5px;">3. CisApiSpec에 enum 을 추가합니다.</li>
							<li style="margin-bottom: 5px;">4. ApiRequest를 확장한 Request Object를 생성합니다.(SampleRequest.java 참고)</li>
							<li style="margin-bottom: 5px;">5. ApiClient 호출(/gs-apet-41-admin/src/main/java/admin/web/view/common/controller/CommonController.java sampleCisApiClientGuideView 메소드 참고)</li>
							<br/>
							* request 또는 response 시 암복호화는 CisCryptoUtil bean 주입 후 사용합니다.
							<br/>
							@Autowired private CisCryptoUtil cisCryptoUtil;
							<br/>
							* cisCryptoUtil.encrypt("test");// 암호화
							<br/>
							* cisCryptoUtil.decrypt("A8KFXIBbiVN8ytabIgUt4A=="); // 복호화
							<br/>
							<br/>
							<br/>
							json으로 반환하므로 각 업무에 맞춰 response data 가공 후 사용합니다.
							<br/>
							<br/>
							ApiResponse ar = null;
							<br/>
							// Map
							<br/>
							Map<String, String> queryString = new HashMap<String, String>();
							<br/>		
							queryString.put("allYn", "Y");
							<br/>
							ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_PRNT_LIST, queryString);
							<br/>
							<br/>
							// Object
							<br/>
							SampleRequest sampleRequest = new SampleRequest();
							<br/>
							sampleRequest.setAllYn("Y");
							<br/>
							<br/>
							ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_PRNT_LIST, sampleRequest);
							<br/>
							ObjectNode on = (ObjectNode) ar.getResponseJson();
							<br/>
							ObjectMapper objectMapper = new ObjectMapper();
							<br/> 
							<br/>
							<br/>
							List<SampleVO> itemList = new ArrayList<SampleVO>();
							<br/>
							try {
							<br/>
								itemList = objectMapper.readValue(on.get("itemList"), new TypeReference<ArrayList<SampleVO>>(){});
								<br/>
							} catch (JsonParseException | JsonMappingException e) {
							<br/>
								throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
								<br/>
							} catch (IOException e) {
							<br/>
								log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
								<br/>
							}
							<br/>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="CIS API 호출 테스트" style="padding:10px">
				<div class="box">
				- <span style="margin-right:10px">CIS SHOP 주문등록 API :</span> <textarea id="orderI" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('ORDER-I')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resORDER-I" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 주문조회 API :</span> <textarea id="orderS" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('ORDER-S')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resORDER-S" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 주문취소 API :</span> <textarea id="orderC" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('ORDER-C')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resORDER-C" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 반품등록 API :</span> <textarea id="returnI" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('RETURN-I')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resRETURN-I" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 반품조회 API :</span> <textarea id="returnS" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('RETURN-S')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resRETURN-S" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 반품취소 API :</span> <textarea id="returnC" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('RETURN-C')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resRETURN-C" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 슬롯조회 API :</span> <textarea id="slotS"   style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('SLOT-S')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resSLOT-S" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 권역조회 API :</span> <textarea id="rngeS"   style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('RNGE-S')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resRNGE-S" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 주문수정 API :</span> <textarea id="orderU"  style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('ORDER-U')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resORDER-U" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 반품수정 API :</span> <textarea id="returnU" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('RETURN-U')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resRETURN-U" style="width:35%;margin-bottom:1px"></textarea><br/>
				- <span style="margin-right:10px">CIS SHOP 차수생성 API :</span> <textarea id="dlvrS" style="width:35%;margin-bottom:1px;margin-right:10px"></textarea> <button type="button" onclick="javascript:callCisAPI('DLVR-S')" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button> <textarea id="resDLVR-S" style="width:35%;margin-bottom:1px"></textarea><br/>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>