<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	//이미지 대표 라디오박스 비활성화
	$('input:radio[name=dlgtYn]').attr('disabled', true);

	$(function(){
		checkImgDlgtYn();
	});

	/**
	 * 이미지 업로드 콜백
	 * @param file
	 * @param objId
	 */
	function resultImage (file, objId ) {
		$("#" + objId).val(file.filePath);
		$("#" + objId + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath);

		checkImgDlgtYn();
	}

	/**
	 * 이미지 삭제
	 * @param objId
	 * @param imgSeq
	 */
	function deleteImage (objId, imgSeq ) {
		$("#" + objId + imgSeq).val('');
		$("#" + objId + imgSeq + "View").attr('src', '/images/noimage.png');

		if(objId == "imgPath"){
			$("#regYn" + imgSeq).val('N');
		}

		checkImgDlgtYn();
	}

	/**
	 * 이미지 대표 여부 체크 후 비활성화 처리
	 */
	function checkImgDlgtYn() {
		var lengthImg = 0;
		var imgIdx = [];

		//등록된 이미지가 있는지 체크
		$.each($("input[name=imgPath]"), function(i, v){
			//등록되어 있는 이미지
			var regYn = $(this).siblings('input[name=regYn]').val();
			//추가 등록한 이미지
			var imgPath = $(this)[0].value;

			if(regYn == 'Y' || $(this)[0].value != '') {
				lengthImg++;
				imgIdx.push(i);
				$('input:radio[name=dlgtYn]:eq('+i+')').attr('disabled', false);
			} else {
				$('input:radio[name=dlgtYn]:eq('+i+')').prop('checked', false);
				$('input:radio[name=dlgtYn]:eq('+i+')').attr('disabled', true);
			}
		});

		//대표이미지 체크
		if(lengthImg < 1) {
			$('input:radio[name=dlgtYn]').prop('checked', false);
		} else if(lengthImg == 1) {
			//등록된 이미지 = 1개 그게 바로 대표이미지닷
			var imageIdx = imgIdx[0];
			$('input:radio[name=dlgtYn]:eq('+imageIdx+')').prop('checked', true);
		} else {
			//등록된 이미지 > 1 , 대표 체크는 안되어 있다면 어떻게 할까?
			//TODO 첫번째 이미지에 대표 체크 <- 확인후 필요없다면 삭제
			var imageIdx = imgIdx[0];
			if($('input:radio[name=dlgtYn]:checked').length < 1) {
				$('input:radio[name=dlgtYn]:eq('+ imageIdx +')').prop('checked', true);
			}
		}
	}

</script>

<div title="상품 이미지" data-options="" style="padding:10px">
	<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
	<%-- <c:if test="${goodsImg ne null and fn:length(goodsImg) gt 0 }"> --%>
	<!--                 <div class="mButton"> -->
	<!--                     <div class="leftInner"> -->
	<%--                         <button type="button" onclick="createInvalidate();messager.alert('<spring:message code='column.goods.img.request' />', 'Info', 'info');" class="btn btn-add">이미지 갱신 요청</button> --%>
	<!--                     </div> -->
	<!--                 </div> -->
	<%-- </c:if> --%>
	</c:if>
	<table class="table_type1">
		<caption>GOODS 등록</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.goods_img" /><strong class="red offLineCntrl"><c:if test="${goodsBase.webMobileGbCd eq null || goodsBase.webMobileGbCd ne adminConstants.WEB_MOBILE_GB_30}">*</c:if></strong></th>	<!-- 상품 이미지-->
				<td colspan="3">
					<table>
						<colgroup>
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
						</colgroup>
							<c:forEach begin="1" end="10" var="template" varStatus="i">
								<c:set var="imgSeq" value="${template}" />
								<c:set var="imgPath" value="" />
								<c:set var="dlgtYn" value="" />
								<c:forEach items="${goodsImg }" var="goodsImg" >
									<c:if test="${goodsImg.imgSeq eq template}" >
										<c:set var="dlgtYn" value="${goodsImg.dlgtYn}" />
										<c:set var="imgSeq" value="${goodsImg.imgSeq}" />
										<c:set var="imgPath" value="${goodsImg.imgPath}" />
									</c:if>
								</c:forEach>
								<c:if test="${i.count % 5 eq 1 }"><tr></c:if>
								<td>
									<div class="center" style="padding-bottom: 5px; height: 250px;" >
										<input type="hidden" id="imgPath${imgSeq }" name="imgPath" value="" />
										<input type="hidden" id="regYn${imgSeq }" name="regYn" value="${(!empty imgPath ) ? 'Y' : 'N' }" />
										<input type="hidden" id="imgSeq${imgSeq }" name="imgSeq" value="${imgSeq }" />
										<input type="hidden" id="imgTpCd${imgSeq }" name="imgTpCd" value="${adminConstants.IMG_TP_10 }" />
										<c:choose>
											<c:when test="${imgPath ne null and imgPath ne '' }" >
												<img id="imgPath${imgSeq }View" name="imgPath${imgSeq }View" src="${frame:imagePath( imgPath )}" class="thumb" style="width:90%;height:240px" alt="" />
											</c:when>
											<c:otherwise>
												<img id="imgPath${imgSeq }View" name="imgPath${imgSeq }View" src="/images/noimage.png" class="thumb" style="width:90%;height:240px" alt="" />
											</c:otherwise>
										</c:choose>
									</div>
									<div class="center mb10">
										<button type="button" name="imgAddBtn" id="imgAddBtn_${imgSeq }" class="w90 btn" onclick="fileUpload.goodsImage(resultImage, 'imgPath${imgSeq }');" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
										<button type="button" class="w90 btn" onclick="deleteImage('imgPath', ${imgSeq });" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
									</div>
									<div class="center" style="padding-bottom: 5px" >
										<label class="fRadio"><input type="radio" name="dlgtYn" id="dlgtYn_${imgSeq }" value="Y" <c:if test="${dlgtYn eq 'Y' }"><c:out value=" checked='checked'" escapeXml="false" /></c:if> ><span><spring:message code="column.dlgt_yn" /></span></label>
									</div>
									<c:if test="${not empty goodsBase }">
										<div class="center " style="padding-bottom: 5px" >
											<button type="button" class="w200 btn" onclick="goodsImgReview(${imgSeq } );" ><spring:message code="column.common.review" /></button> <!-- 미리보기 -->
										</div>
									</c:if>
								</td>
								<c:if test="${i.count % 5 eq 0}"></tr></c:if>
							</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods_img.banner" /></th>
				<td colspan="3">
					<table>
						<colgroup>
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
							<col style="width:20%;">
						</colgroup>
							<c:forEach begin="11" end="11" var="template">
								<c:set var="imgSeq" value="${template}" />
								<c:set var="imgPath" value="" />
								<c:set var="dlgtYn" value="" />
								<c:forEach items="${goodsImg }" var="goodsImg" >
									<c:if test="${goodsImg.imgSeq eq template}" >
										<c:set var="dlgtYn" value="${goodsImg.dlgtYn}" />
										<c:set var="imgSeq" value="${goodsImg.imgSeq}" />
										<c:set var="imgPath" value="${goodsImg.imgPath}" />
									</c:if>
								</c:forEach>
								<tr>
									<td>
										<div class="center" style="padding-bottom: 5px; height: 250px;" >
											<input type="hidden" id="imgPath${imgSeq }" name="imgPath" value="" />
											<input type="hidden" id="regYn${imgSeq }" name="regYn" value="${(!empty imgPath ) ? 'Y' : 'N' }" />
											<input type="hidden" id="imgSeq${imgSeq }" name="imgSeq" value="${imgSeq }" />
											<input type="hidden" id="imgTpCd${imgSeq }" name="imgTpCd" value="${adminConstants.IMG_TP_30 }" />
											<c:choose>
												<c:when test="${imgPath ne null and imgPath ne '' }" >
													<img id="imgPath${imgSeq }View" name="imgPath${imgSeq }View" src="${frame:imagePath( imgPath )}" class="thumb" style="width:90%;height:240px" alt="" />
												</c:when>
												<c:otherwise>
													<img id="imgPath${imgSeq }View" name="imgPath${imgSeq }View" src="/images/noimage.png" class="thumb" style="width:90%;height:240px" alt="" />
												</c:otherwise>
											</c:choose>
										</div>
										<div class="center mb10">
											<button type="button" name="imgAddBtn" id="imgAddBtn_${imgSeq }" class="w90 btn" onclick="fileUpload.goodsImage(resultImage, 'imgPath${imgSeq }');" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
											<button type="button" class="w90 btn" onclick="deleteImage('imgPath', ${imgSeq });" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
										</div>
										<div class="center" style="padding-bottom: 5px;display:none;" >
											<label class="fRadio"><input type="radio" name="dlgtYn" id="dlgtYn_${imgSeq }" value="Y" <c:if test="${dlgtYn eq 'Y' }"><c:out value=" checked='checked'" escapeXml="false" /></c:if> ><span><spring:message code="column.dlgt_yn" /></span></label>
										</div>
										<c:if test="${not empty goodsBase }">
											<div class="center " style="padding-bottom: 5px" >
												<button type="button" class="w200 btn" onclick="goodsImgReview(${imgSeq } );" ><spring:message code="column.common.review" /></button> <!-- 미리보기 -->
											</div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<hr />
			