<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<script type="text/javascript">
		//파일 다운로드
		function fileDownload(filePath, fileName){
			var data = {
				  filePath : filePath
				, fileName : fileName
			}
			createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
		}
	</script>
	<form id="shop_enter_form">
	<table class="table_type1">
		<caption>입점문의상세</caption>
		<colgroup>
			<col style="width:170px" />
			<col />
			<col style="width:170px" />
			<col />
		</colgroup>
		<tbody>
		<c:forEach items="${contectDetail}" var="contectDetail">
			<tr>
				<th><strong>회사명</strong></th>
				<td colspan="3">
					${contectDetail.compNm }
				</td>
			</tr>
			<tr>
				<th><strong>대표자명</strong></th>
				<td colspan="3">
					${contectDetail.ceoNm }
				</td>
			</tr>
			<tr>
				<th><strong>사업자 등록번호</strong></th>
				<td colspan="3">
					${contectDetail.bizNo }
				</td>
			</tr>
			<tr>
				<th><strong>회사주소</strong></th>
				<td colspan="3">
					<div class="zip_code">
						<strong class="label_tit">우편번호</strong> 
						${contectDetail.postNoNew }
					</div>
					<br>
					<div class="address_box">
						<strong class="label_tit">주소</strong>
						${contectDetail.roadAddr }&nbsp; ${contectDetail.roadDtlAddr }
					</div>
				</td>
			</tr>
			<tr>
				<th><strong>담당자명 /직급</strong></th>
				<td>
					${contectDetail.picNm }
				</td>
				<th><strong>부서</strong></th>
				<td>
					${contectDetail.picDpm }
				</td>
			</tr>
			<tr>
				<th><strong>E-mail</strong></th>
				<td>
					${contectDetail.picEmail }
				</td>
				<th><strong>담당자 핸드폰</strong></th>
				<td>
					${contectDetail.picMobile }
				</td>
			</tr>
			<tr>
				<th><strong>URL (website)</strong></th>
				
				<td colspan="3">
					${contectDetail.webSt }
				</td>
			</tr>
			<tr>
				<th><strong>URL (SNS)</strong></th>
				<td colspan="3">
					${contectDetail.sns }
				</td>
			</tr>
			<tr>
				<th><strong>브랜드명</strong></th>
				<td colspan="3">
					${contectDetail.bndNm }
				</td>
			</tr>
			<tr>
				<th><strong>회사(브랜드) 소개</strong></th>
				<td colspan="3">
					${contectDetail.compItrdc }
				</td>
			</tr>
			<tr>
				<th><strong>대표상품 소개</strong><br /></th>
				<td colspan="3">
					${contectDetail.goodsItrdc }
				</td>
			</tr>
			<tr>
				<th><strong>상품 평균 가격대</strong></th>
				<td colspan="3">
					${contectDetail.goodsPrcRng }
				</td>
			</tr>
			<tr>
				<th><strong>주요 고객층 (판매 타겟)</strong></th>
				<td colspan="3">
					${contectDetail.stpCust }
				</td>
			</tr>
			<tr>
				<th><strong>상품 유형</strong></th>
				<td colspan="3">
					<frame:codeName grpCd="${adminConstants.SE_GOODS_TP }" dtlCd="${contectDetail.seGoodsTpCd }"/>
				</td>
			</tr>
			<tr>
				<th><strong>판매 유형</strong></th>
				<td colspan="3">
					<frame:codeName grpCd="${adminConstants.SE_SALE_TP }" dtlCd="${contectDetail.seSaleTpCd }"/>
				</td>
			</tr>
			<tr>
				<th><strong>물류 유형</strong></th>
				<td colspan="3">
					<frame:codeName grpCd="${adminConstants.SE_DSTB_TP }" dtlCd="${contectDetail.seDstbTpCd }"/>
				</td>
			</tr>
			<tr>
				<th><strong>입점희망 카테고리</strong></th>
				<td colspan="3">
					${contectDetail.ctgNm } ${contectDetail.seHopeCtgNm }
				</td>
			</tr>
			<tr>
				<th><strong>첨부파일</strong></th>
				<td colspan="3">
					<div>
					<c:if test="${fn:length(contectDetail.phyPathList) > 0}">
						<c:forEach var="item" items="${contectDetail.phyPathList}">
							<div>
								<a href="#" onclick="fileDownload('${item.phyPath}', '${item.orgFlNm}');" style="text-align:left !important;">${item.orgFlNm}</a>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty contectDetail.phyPathList}">
							첨부 파일이 없습니다.
						</c:if>
					</div>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</form>

