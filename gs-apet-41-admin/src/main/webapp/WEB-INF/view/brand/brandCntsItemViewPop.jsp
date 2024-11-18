<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function() {
			});
			
			// 상품 검색
			function searchGoods () {
				var options = {
					multiselect : false
					, callBack : searchGoodsCallback
				}
				layerGoodsList.create (options );
			}
			function searchGoodsCallback (goodsList ) {
				if(goodsList.length > 0 ) {
					$("#goodsId").val (goodsList[0].goodsId );
					$("#goodsNm").val (goodsList[0].goodsNm );
				}
			}

			// 등록 / 수정
			function insertBrandCntsItem() {
				if(validate.check("brandCntsItemPopForm")) {
					messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
						if(r){
							var options = {
								url : "<spring:url value='/brandCnts/brandCntsItemSave.do' />"
								, data : $("#brandCntsItemPopForm").serializeJson()
								, callBack : function(result){
									reloadBrandCntsItemGrid();
									layer.close('brandCntsItemView');
								}
							};
	
							ajax.call(options);
						}
					});
				}
			}

			// 아이템 이미지(PC) 파일 업로드
			function resultItemImage(result) {
				$("#itemImgPath").val(result.filePath);
			}

			// 아이템 이미지(MOBILE) 파일 업로드
			function resultItemMoImage(result) {
				$("#itemMoImgPath").val(result.filePath);
			}
		</script>
			<form name="brandCntsItemPopForm" id="brandCntsItemPopForm">
				<input type="hidden" name="bndCntsNo" id="bndCntsNo" value="${brandCnts.bndCntsNo}"/>
				<input type="hidden" name="itemNo" id="itemNo" value="${brandCnts.itemNo}"/>

				<table class="table_type1">
					<caption>배너 정보</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.goods_id" /><strong class="red">*</strong></th> <!-- 상품 ID -->
							<td colspan="3">								
								<frame:goodsId funcNm="searchGoods()" defaultGoodsNm="${brandCntsItem[0].goodsNm}" defaultGoodsId="${brandCntsItem[0].goodsId}" requireYn="Y"/>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.pc_img"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 이미지(PC) -->
								<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="itemImgPath" id="itemImgPath" title="<spring:message code="column.display_view.pc_img"/>" value="${brandCntsItem[0].itemImgPath}" />
								<button type="button" onclick="fileUpload.image(resultItemImage);" class="btn">파일찾기</button>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.mobile_img"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 이미지(MOBILE) -->
								<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="itemMoImgPath" id="itemMoImgPath" title="<spring:message code="column.display_view.mobile_img"/>" value="${brandCntsItem[0].itemMoImgPath}" />
								<button type="button" onclick="fileUpload.image(resultItemMoImage);" class="btn">파일찾기</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			