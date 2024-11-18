<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			$(":radio[name=stkMngYn]").change(function () {
				changeStkMngYn ();
			});
		});

		// callback : 업체 검색
		function searchCompany(){
			var options = {
				  multiselect : false
				, callBack : function(compList){
					if(compList.length > 0){
						$("#compNo").val (compList[0].compNo);
						$("#compNm").val (compList[0].compNm);
					}
				}
			}
			layerCompanyList.create (options);
		}

		function changeStkMngYn () {
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			if(stkMngYn == "${adminConstants.COMM_YN_N }" ) {
				$("#webStkQty").val(9999 );
			} else {
				$("#webStkQty").val(0 );
			}
		}

		// 이미지 업로드
		function resultImage (file, objId ) {
			$("#" + objId).val(file.filePath);
			$("#" + objId + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath);
		}

		function deleteImage (objId, imgSeq ) {
			$("#" + objId).val('');
			$("#" + objId + "View").attr('src', '/images/noimage.png');
		}

		// 사은품 상품 등록
		function insertGoods () {
			var sendData = null;

			if(validate.check("giftGoodsInsertForm")) {
				var formData = $("#giftGoodsInsertForm").serializeJson();
				var itemList = new Array();
				var goodsImgList = new Array();

				var webStkQty = $("#webStkQty").val();
				itemList.push({
					itemNo : 0
					, itemNm : '기본단품'
					, webStkQty : webStkQty
					, itemStatCd : '${adminConstants.ITEM_STAT_10 }'
					, addSaleAmt : 0
					, showSeq : 1
					, saleYn : '${adminConstants.COMM_YN_Y }'
				});
				
				var stGoodsMapPO = new Array();			
				// 사이트 선택 체크. hjko 2017.01.10
				var chkStCnt = $("input[name='stId']:checked").length;
				if(chkStCnt ==0){
					messager.alert("<spring:message code='column.site_msg' />","Info","info");
					return false;
				}else{
					$("input[name='stId']:checked").each(function(index, ob){
						stGoodsMapPO.push( {stId : $(this).val() , goodsId : $("#goodsId").val() } );
					});
				}

				// 상품 이미지
				$("input[name=imgPath]").each (function (idx ) {
					var goodsImgIdx = $(this).siblings("input[name=imgSeq]").val();
					var imgPath = $("#imgPath" + goodsImgIdx).val();
					var rvsImgPath = $("#rvsImgPath" + goodsImgIdx).val();

					if(imgPath != "" || rvsImgPath != "" ) {
						goodsImgList.push({
							imgPath : imgPath
							, rvsImgPath : rvsImgPath
							, dlgtYn : $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N'
							, imgSeq : goodsImgIdx
						});
					}
				});

				// Form 데이터
				sendData = {
					goodsBasePO : JSON.stringify(formData )
					, itemPO : JSON.stringify(itemList )
					, goodsImgPO : JSON.stringify(goodsImgList )
					, stGoodsMapPO : JSON.stringify(stGoodsMapPO )
				}

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/goods/goodsInsert.do' />"
								, data : sendData
								, callBack : function (data ) {
									messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
										viewGoodsDetail (data.goodsId );
									});									
								}
							};
							ajax.call(options);				
					}
				});
			}
		}

		function viewGoodsDetail (goodsId ) {
			updateTab('/goods/giftGoodsDetailView.do?goodsId=' + goodsId, '사은품 상세');
		}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<form id="giftGoodsInsertForm" name="giftGoodsInsertForm" method="post" >
	<!-- 상품 유형 코드 : 사은품 상품 -->
	<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${adminConstants.GOODS_TP_30 }" />
	<input type="hidden" id="itemMngYn" name="itemMngYn" value="${adminConstants.COMM_YN_N }" />

	<table class="table_type1">
		<caption>사은품 등록</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.gift_goods_no" /><strong class="red">*</strong></th> <!-- 사은품 상품 번호-->
				<td>
					<c:if test="${empty goodsBase}"> <!-- 상품 번호-->
						<b>자동입력</b>
					</c:if>
					<c:if test="${not empty goodsBase}"> <!-- 사은품 상품 번호-->
						<input type="text" class="readonly" readonly="readonly" name="goodsId" id="goodsId" title="<spring:message code="column.gift_goods_no"/>" value="${goodsBase.goodsId}" />
					</c:if>
				</td>
				<th><spring:message code="column.st_id"/><strong class="red">*</strong></th> <!-- 사이트 아이디 -->
				<td>
					<frame:stIdCheckbox selectKey="${goodsBase.stStdList}" compNo="${goodsBase.compNo}"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods_nm" /><strong class="red">*</strong></th>	<!-- 상품 명-->
				<td>
					<input type="text" class="w400 validate[required]" name="goodsNm" id="goodsNm" title="<spring:message code="column.goods_nm" />" value="${goodsBase.goodsNm}" />
				</td>
				<th><spring:message code="column.goods.comp_no" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
				<td>
					<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${goodsBase.compNo}" defaultCompNm="${goodsBase.compNm}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods_stat_cd" /><strong class="red">*</strong></th>	<!-- 상품 상태 코드-->
				<td>
					<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">
						<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${goodsBase.goodsStatCd eq null ? adminConstants.GOODS_STAT_40 : goodsBase.goodsStatCd }" />
					</select>
				</td>
				<th><spring:message code="column.show_yn" /></th>	<!-- 노출여부 -->
				<td>
					<frame:radio name="showYn" grpCd="${adminConstants.SHOW_YN}" selectKey="${goodsBase.showYn}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.stk_mng_yn" /></th>	<!-- 재고 관리 여부 -->
				<td>
					<frame:radio name="stkMngYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.stkMngYn eq null ? adminConstants.COMM_YN_Y : goodsBase.stkMngYn }" />
				</td>
				<th><spring:message code="column.web_stk_qty" /></th>	<!-- 웹재고 수량 -->
				<td>
					<input type="text" class="numeric" name="webStkQty" id="webStkQty" title="<spring:message code="column.web_stk_qty" />" value="${goodsBase.webStkQty eq null ? 0 : goodsBase.webStkQty }" />
				</td>
			</tr>
		</tbody>
	</table>
	<hr />
	
	<div style="margin-left:-10px;margin-right:-10px;">
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsImageInfo.jsp" />
	</div>
	
		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="insertGoods(); return false;" >등록</button>
			<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
		</div>

</form>
	</t:putAttribute>

</t:insertDefinition>