<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>


		<table class="table_type1">
			<caption>코드</caption>
			<tbody>
			<tr>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<td>Code</td>
							<td>사이트 아이디</td>
						</tr>
						<c:forEach items="${stStdInfoVOList}"  var="stStdInfo">
						<tr>
							<td>${stStdInfo.stId }</td>
							<td>${stStdInfo.stNm }</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				
				</td>
				<td style="vertical-align:top;">
						<table class="table_type3">
							<caption>코드</caption>
							<colgroup>
								<col style="width:45%;">
								<col style="width:auto;">
							</colgroup>
							<tbody>
							<tr>
								<td>Code</td>
								<td>과세구분</td>
							</tr>
							<c:forEach items="${taxGbList}" var="taxGb">
							<tr>
								<td>${taxGb.dtlCd }</td>
								<td>${taxGb.dtlNm }</td>
							</tr>
							</c:forEach>
							</tbody>
						</table>
					
					</td>
					<td style="vertical-align:top;">
						<table class="table_type3">
							<caption>코드</caption>
							<colgroup>
								<col style="width:45%;">
								<col style="width:auto;">
							</colgroup>
							<tbody>
							<tr>
								<td>Code</td>
								<td>재고 관리 여부</td>
							</tr>
							<tr>
								<td>Y</td>
								<td>관리 함</td>
							</tr>
							<tr>
								<td>N</td>
								<td>관리 안함</td>
							</tr>
							<tr>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</td>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<td>Code</td>
							<td>단품 관리 여부</td>
						</tr>
						<tr>
							<td>Y</td>
							<td>관리함</td>
						</tr>
						<tr>
							<td>N</td>
							<td>관리안함</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
							<tr>
							<td>Code</td>
							<td>속성1번호</td>
						</tr>
						<c:forEach items="${attributeList}" var="attribute">
							<tr>
								<td>${attribute.attrNo }</td>
								<td>${attribute.attrNm }</td>
							</tr>
						</c:forEach>
					</tbody></table>
				
				</td>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<td>Code</td>
							<td>노출 여부</td>
						</tr>
						<tr>
							<td>Y</td>
							<td>노출 함</td>
						</tr>
						<tr>
							<td>N</td>
							<td>노출 안함</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
					</tbody></table>
				
				</td>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<td>Code</td>
							<td>웹 모바일 구분</td>
						</tr>
						<c:forEach items="${webMobileGbList }" var="webMobileGb">
						<tr>
							<td>${webMobileGb.dtlCd }</td>
							<td>${webMobileGb.dtlNm}</td>
						</tr>
						</c:forEach>
					</tbody></table>
				</td>
				<td style="vertical-align:top;">
					<table class="table_type3">
						<caption>코드</caption>
						<colgroup>
							<col style="width:45%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<td>Code</td>
							<td>반품 가능 여부</td>
						</tr>
						<tr>
							<td>Y</td>
							<td>반품 가능</td>
						</tr>
						<tr>
							<td>N</td>
							<td>반품 불가능</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						</tbody>
					</table>
				</td>
			</tr>
			</tbody>
		</table>
	<br/>
	<p class="description">
	- 단품 관리 여부가 'Y' 인 경우 속성1번호 및 속성1값이 필수로 들어가야 함.</p>
	<p class="description">- 재고 관리 여부가 'Y' 인 경우 기본 재고 항목에 재고가 필수로 들어가야 함.</p>
	<br/>
	
		<table class="table_type1">
			<caption>상세 설명</caption>
			<colgroup>
				<col style="width:15%;">
				<col style="width:15%;">
				<col style="width:auto;">
			</colgroup>
			<tbody>
			<tr>
				<td>항목</td>
				<td>필수 여부</td>
				<td>설명</td>
			</tr>
			<tr>
				<td>사이트 아이디</td>
				<td>필수</td>
				<td>- 입점시 판매 계약이 진행된 사이트 ID 입력</td>
			</tr>
			<tr>
				<td>업체 상품 코드</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>필수</td>
				<td>- 상품명</td>
			</tr>
			<tr>
				<td>업체번호</td>
				<td>필수</td>
				<td>- 입점시 판매 계약이 진행된 업체의 번호 입력( 확인 위치 : Admin의 업체관리&gt;계약 업체 목록 )</td>
			</tr>
			<tr>
				<td>모델명</td>
				<td></td>
				<td>- 상품의 모델명이 존재시 입력</td>
			</tr>
			<tr>
				<td>브랜드 번호</td>
				<td>필수</td>
				<td>- 입점시 팜매 계약이 진행된 업체에 배정된 브랜드 번호 중 입력( 확인 위치 : Admin의 업체관리&gt;계약 업체 목록&gt;업체 상세&gt;브랜드 )</td>
			</tr>
			<tr>
				<td>원산지</td>
				<td>필수</td>
				<td>- 상품의 원산지 직접 입력</td>
			</tr>
			<tr>
				<td>제조사</td>
				<td>필수</td>
				<td>- 상품의 제조사 직접 입력</td>
			</tr>
			<tr>
				<td>과세 구분</td>
				<td>필수</td>
				<td>- 과세구분 Code 입력 ( 10:과세 , 20:면세 , 30:영세 )</td>
			</tr>
			<tr>
				<td>노출 여부</td>
				<td>필수</td>
				<td>- 등록되는 상품 노출 여부 입력 ( Y:노출 , N:미 노출 )</td>
			</tr>
			<tr>
				<td>웹 모바일 구분</td>
				<td>필수</td>
				<td>- 등록되는 상품의 판매 위치 설정 ( 00:전체 , 01:PC , 02:Mobile )</td>
			</tr>
			<tr>
				<td>키워드</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>배송비 정책 번호</td>
				<td>필수</td>
				<td>- 입점시 판매 계약이 진행된 업체에서 등록한 배송정책 번호 중 입력( 확인 위치 : Admin의 업체관리&gt;계약 업체 목록&gt;업체 상세&gt;업체 배송정책 )</td>
			</tr>
			<tr>
				<td>반품 가능 여부</td>
				<td>필수</td>
				<td>- 등록되는 상품이 주문시 반품이 가능한지 여부를 체크  ( Y:반품 가능 , N:반품 불가능 )</td>
			</tr>
			<tr>
				<td>판매가</td>
				<td>필수</td>
				<td>- 등록되는 상품의 사이트내 판매 가격</td>
			</tr>
			<tr>
				<td>재고관리 여부</td>
				<td>필수</td>
				<td>- 등록되는 상품의 재고 관리 여부  ( Y:재고 관리 함 , N:재고 관리 안함), Y 선택시 기본 재고를 필수로 입력 해야 함</td>
			</tr>
			<tr>
				<td>기본 재고</td>
				<td></td>
				<td>- 재고 관리 여부 Y 선택 시 상품의 기본 재고 수량을 입력</td>
			</tr>
			<tr>
				<td>단품 관리 여부</td>
				<td>필수</td>
				<td>- 등록되는 상품의 단품 관리 여부 ( Y:단품 관리 함 , N:단품 관리 안함), Y 선택시 속성 및 속성 값을 필수로 입력 해야 함</td>
			</tr>
			<tr>
				<td>상세설명[PC]</td>
				<td>필수</td>
				<td>- PC 상품 상세 설명</td>
			</tr>
			<tr>
				<td>상세설명[MC]</td>
				<td></td>
				<td>- Mobile 상품 상세 설명</td>
			</tr>
			<tr>
				<td>속성1번호</td>
				<td></td>
				<td>- 단품 관리 여부 Y 선택시 필수로 속성 Code를 입력 해야 함 ( 7:색상, 6, 사이즈  등)</td>
			</tr>
			<tr>
				<td>속성1값</td>
				<td></td>
				<td>- 속성1번호 값이 입력되면 필수로 속성 1 값을 , 로 구분하여 입력해야 함 ( EX : 빨강,파랑,노랑 )</td>
			</tr>
			<tr>
				<td>속성2번호</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성2값</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성3번호</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성3값</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성4번호</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성4값</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성5번호</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>속성5값</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>이미지1URL</td>
				<td>필수</td>
				<td>- 상품의 대표 이미지로, 리스트, 상품상세, 주문 등에 노출되는 이미지 ( 600 x 600 이상의 이미지를 등록 해야 함 )</td>
			</tr>
			<tr>
				<td>반전이미지1 URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>이미지2URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>반전이미지2 URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>이미지3URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>반전이미지3 URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>이미지4URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>반전이미지4 URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>이미지5URL</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>반전이미지5 URL</td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
		</table>
	
