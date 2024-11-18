<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			p.error, b.error {
				color:red
			}
            p.warning, b.warning {
                color:#e38d13;
            }
		</style>
		<script type="text/javascript">
		//목록 ID , 검색Form = 목록 ID + 'Form'
		var listId = 'goodsBulkList';

		var columns = new Array();
		columns.push({name :'successYn', label :'<spring:message code="admin.web.view.common.result"/>', width :'60', align :'center', sortable : false });
		columns.push({name :'resultMessage', label :'<spring:message code="admin.web.view.common.message"/>', width :'250', align :'left', sortable : false });
		/* 사이트 ID HIDDEN */ columns.push({name :'stId', label :'<spring:message code="column.st_id" />', hidden : true });
		/* 사이트명 */ columns.push({name :'stNm', label :'<spring:message code="column.st_nm" />', width :'100', align :'center', sortable : false});
		/* 상품명 */ columns.push({name :'goodsNm', label :'<spring:message code="column.goods_nm" />', width :'300', align :'center', sortable : false });
		/* 업체명 */ columns.push({name :'compNm', label :'<spring:message code="column.goods.comp_nm" />', width :'150', align :'center', sortable : false });
		/* 업체번호 HIDDEN */ columns.push({name :'compNo', label :'<spring:message code="column.goods.comp_no" />', hidden : true });
		/* 표준코드 */ columns.push({name :'prdStdCd', label :'<spring:message code="column.goods.strdCd"/>', width :'100', align :'center', sortable : false });
		/* 자체 상품코드 */ columns.push({name :'compGoodsId', label :'<spring:message code="column.goods.comp.goods.id"/>', width :'100', align :'center', sortable : false });
		/* 모델명 */ columns.push({name :'mdlNm', label :'<spring:message code="column.mdl_nm" />', width :'100', align :'center', sortable : false });
		/* 브랜드명 */ columns.push({name :'bndNm', label :'<spring:message code="column.bnd_nm" />', width :'80', align :'center', sortable : false });
		/* 브랜드번호 HIDDEN */ columns.push({name :'bndNo', label :'<spring:message code="column.bnd_nm" />', hidden : true});
		/* 애완동물 종류 DTL_NM FROM CODE_DETAIL WHERE GRP_CD = 'PET_GB' */
		/* 애완동물 종류 */ columns.push({name :'petGbNm', label :'<spring:message code="column.goods.pet.gb"/>', width :'100', align :'center', sortable : false});
		/* 애완동물 종류 HIDDEN */ columns.push({name :'petGbCd', label :'<spring:message code="column.goods.pet.gb"/>', hidden : true});
		/* 원산지 */ columns.push({name :'ctrOrgNm', label :'<spring:message code="column.ctr_org" />', width :'100', align :'center', sortable : false });
		/* 원산지 */ columns.push({name :'ctrOrg', label :'<spring:message code="column.ctr_org" />', width :'100', align :'center', sortable : false, hidden:true });
		/* 제조사 */ columns.push({name :'mmft', label :'<spring:message code="column.mmft" />', width :'100', align :'center', sortable : false });
		/* 수입사 */ columns.push({name :'importer', label :'<spring:message code="column.importer" />', width :'100', align :'center', sortable : false });
		/* 과세구분명 */ columns.push({name :'taxGbNm', label :'<spring:message code="column.tax_gb_cd" />', width :'80', align :'center', sortable : false });
		/* 과세구분코드 HIDDEN */ columns.push({name :'taxGbCd', label :'<spring:message code="column.tax_gb_cd" />', hidden : true});
		/* 노출여부 */ columns.push({name :'showYn', label :'<spring:message code="column.show_yn" />', width :'80', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='true' />"} });
		/* 웹 모바일 WEB_MOBILE_GB_CD */ columns.push({name :'webMobileGbNm', label :'<spring:message code="column.web_mobile_gb_cd" />', width :'100', align :'center', sortable : false });
		/* 웹 모바일 코드 HIDDEN */ columns.push({name :'webMobileGbCd', label :'<spring:message code="column.web_mobile_gb_cd" />', hidden : true });
		/* 배송비 정책 번호 */ columns.push({name :'dlvrcPlcNo', label :'<spring:message code="column.dlvrc_plc_no" />', width :'80', align :'center', sortable : false });
		/* 반품 가능 여부 */ columns.push({name :'rtnPsbYn', label :'<spring:message code="column.rtn_psb_yn" />', width :'80', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 정상가 */ columns.push({name :'orgSaleAmt', label :'<spring:message code="column.goods.org_sale_prc" />', width :'100', align :'center', sortable : false });
		/* 판매가 */ columns.push({name :'saleAmt', label :'<spring:message code="column.sale_prc" />', width :'100', align :'center', sortable : false });
		/* 매입가 */ columns.push({name :'splAmt', label :'<spring:message code="column.spl_prc" />', width :'100', align :'center', sortable : false });
		/* 재고관리여부 */ columns.push({name :'stkMngYn', label :'<spring:message code="column.stk_mng_yn" />', width :'100', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 웹 재고 수량 */ columns.push({name :'webStkQty', label :'<spring:message code="column.web_stk_qty" />', width :'100', align :'center', sortable : false });
		/* 최소주문수량 */ columns.push({name :'minOrdQty', label :'<spring:message code="column.min_ord_qty" />', width :'60', align :'center', sortable : false });
		/* 최대주문수량 */ columns.push({name :'maxOrdQty', label :'<spring:message code="column.max_ord_qty" />', width :'60', align :'center', sortable : false });
		/*매입업체 명*/ columns.push({name:'phsCompNm', title:false, label:'<spring:message code="column.goods.phsCompNo" />', width :'100', align :'center', sortable : false, hidden:true })	
		/* 샵링커 전송 여부 */ columns.push({name :'shoplinkerSndYn', label :'<spring:message code="column.goods.shoplinkerSndYn" />', width :'80', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 성분 정보 연동 여부 */ columns.push({name :'igdtInfoLnkYn', label :'<spring:message code="column.goods.twc.igdtInfoLnkYn" />', width :'70', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 무료 배송 여부 */ columns.push({name :'freeDlvrYn', label :'<spring:message code="column.free_dlvr_yn" />', width :'70', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 재고 수량 노출 여부 */ columns.push({name :'stkQtyShowYn', label :'<spring:message code="column.goods.stkQtyShowYn" />', width :'60', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 품절 상품 노출 여부 */ columns.push({name :'ostkGoodsShowYn', label :'<spring:message code="column.goods.ostkGoodsShowYn" />', width :'60', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 재입고 알림 여부 */ columns.push({name :'ioAlmYn', label :'<spring:message code="column.goods.io_alm_yn"/>', width :'80', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 상세설명 [PC] contentPc */ columns.push({name :'contentPc', label :'<spring:message code="column.goods_content_pc" />', width :'200', align :'left', sortable : false });
		/* 상세설명 [MOBILE] contentMobile */ columns.push({name :'contentMobile', label :'<spring:message code="column.goods_content_mobile" />', width :'200', align :'left', sortable : false });
		/* 속성1 No */ columns.push({name :'attr1No', class:'attrNo', label :'<spring:message code="column.attribute.name" arguments="1"/>', hidden: true });
		/* 속성1 명 */ columns.push({name :'attr1Nm', label :'<spring:message code="column.attribute.name" arguments="1"/>', width :'80', align :'center', sortable : false });
		/* 속성1 값 No */ columns.push({name :'attr1ValNo', class:'attrValNo', label :'<spring:message code="column.attribute.value" arguments="1"/>', hidden: true });
		/* 속성1 값 */ columns.push({name :'attr1Val', label :'<spring:message code="column.attribute.value" arguments="1"/>', width :'80', align :'center', sortable : false });
		/* 속성2 No */ columns.push({name :'attr2No', class:'attrNo', label :'<spring:message code="column.attribute.name" arguments="2"/>', hidden: true });
		/* 속성2 명 */ columns.push({name :'attr2Nm', label :'<spring:message code="column.attribute.name" arguments="2"/>', width :'80', align :'center', sortable : false });
		/* 속성2 값 No*/ columns.push({name :'attr2ValNo', class:'attrValNo', label :'<spring:message code="column.attribute.value" arguments="2"/>', hidden: true });
		/* 속성2 값 */ columns.push({name :'attr2Val', label :'<spring:message code="column.attribute.value" arguments="2"/>', width :'80', align :'center', sortable : false });
		/* 속성3 No */ columns.push({name :'attr3No', class:'attrNo', label :'<spring:message code="column.attribute.name" arguments="3"/>', hidden: true });
		/* 속성3 명 */ columns.push({name :'attr3Nm', label :'<spring:message code="column.attribute.name" arguments="3"/>', width :'80', align :'center', sortable : false });
		/* 속성3 값 No*/ columns.push({name :'attr3ValNo', class:'attrValNo', label :'<spring:message code="column.attribute.value" arguments="3"/>', hidden: true });
		/* 속성3 값 */ columns.push({name :'attr3Val', label :'<spring:message code="column.attribute.value" arguments="3"/>', width :'80', align :'center', sortable : false });
		/* 속성4 No */ columns.push({name :'attr4No', class:'attrNo', label :'<spring:message code="column.attribute.name" arguments="4"/>', hidden: true });
		/* 속성4 명 */ columns.push({name :'attr4Nm', label :'<spring:message code="column.attribute.name" arguments="4"/>', width :'80', align :'center', sortable : false });
		/* 속성4 값 No*/ columns.push({name :'attr4ValNo', class:'attrValNo', label :'<spring:message code="column.attribute.value" arguments="4"/>', hidden: true });
		/* 속성4 값 */ columns.push({name :'attr4Val', label :'<spring:message code="column.attribute.value" arguments="4"/>', width :'80', align :'center', sortable : false });
		/* 속성5 No */ columns.push({name :'attr5No', class:'attrNo', label :'<spring:message code="column.attribute.name" arguments="5"/>', hidden: true });
		/* 속성5 명 */ columns.push({name :'attr5Nm', label :'<spring:message code="column.attribute.name" arguments="5"/>', width :'80', align :'center', sortable : false });
		/* 속성5 값 No*/ columns.push({name :'attr5ValNo', class:'attrValNo', label :'<spring:message code="column.attribute.value" arguments="5"/>', hidden: true });
		/* 속성5 값 */ columns.push({name :'attr5Val', label :'<spring:message code="column.attribute.value" arguments="5"/>', width :'80', align :'center', sortable : false });
		/* 이미지1 URL */ columns.push({name :'img1Url', label :'<spring:message code="column.images.path" arguments="1"/>', width :'200', align :'left', sortable : false });
		/* 이미지2 URL */ columns.push({name :'img2Url', label :'<spring:message code="column.images.path" arguments="2"/>', width :'200', align :'left', sortable : false });
		/* 이미지3 URL */ columns.push({name :'img3Url', label :'<spring:message code="column.images.path" arguments="3"/>', width :'200', align :'left', sortable : false });
		/* 이미지4 URL */ columns.push({name :'img4Url', label :'<spring:message code="column.images.path" arguments="4"/>', width :'200', align :'left', sortable : false });
		/* 이미지5 URL */ columns.push({name :'img5Url', label :'<spring:message code="column.images.path" arguments="5"/>', width :'200', align :'left', sortable : false });
		/* 이미지6 URL */ columns.push({name :'img6Url', label :'<spring:message code="column.images.path" arguments="6"/>', width :'200', align :'left', sortable : false });
		/* 이미지7 URL */ columns.push({name :'img7Url', label :'<spring:message code="column.images.path" arguments="7"/>', width :'200', align :'left', sortable : false });
		/* 이미지8 URL */ columns.push({name :'img8Url', label :'<spring:message code="column.images.path" arguments="8"/>', width :'200', align :'left', sortable : false });
		/* 이미지9 URL */ columns.push({name :'img9Url', label :'<spring:message code="column.images.path" arguments="9"/>', width :'200', align :'left', sortable : false });
		/* 이미지10 URL */ columns.push({name :'img10Url', label :'<spring:message code="column.images.path" arguments="10"/>', width :'200', align :'left', sortable : false });
		/* 배너이미지 URL */ columns.push({name :'bannerImgUrl', label :'<spring:message code="column.bnr_img_path"/>', width :'100', align :'left', sortable : false });	
		/* 상품 필수 정보 1,2,3,4,5*/
								/* columns.push({name:'ntfld', }) */
		/* 필수정보1*/ columns.push({name :'itemVal1', title:false, label :'<spring:message code="column.goods.notifyInfo" arguments="1"/>', hidden: true });
		/* 필수정보2*/ columns.push({name :'itemVal2', title:false, label :'<spring:message code="column.goods.notifyInfo" arguments="2"/>', hidden: true });
		/* 필수정보3*/ columns.push({name :'itemVal3', title:false, label :'<spring:message code="column.goods.notifyInfo" arguments="3"/>', hidden: true });
		/* 필수정보4*/ columns.push({name :'itemVal4', title:false, label :'<spring:message code="column.goods.notifyInfo" arguments="4"/>', hidden: true });
		/* 필수정보5*/ columns.push({name :'itemVal5', title:false, label :'<spring:message code="column.goods.notifyInfo" arguments="5"/>', hidden: true });
		/* 판매기간 설정여부 */ columns.push({name :'saleDtYn', label :'판매기간<br/>설정여부', width :'100', align :'center', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 판매기간 시작일시 yyyy-mm-dd 00:00 */ columns.push({name :'saleStrtDtm', label :'판매기간<br/>시작일시', width :'100', align :'left', sortable : false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }'});
		/* 판매기간 종료일시 yyyy-mm-dd 00:00. 판매기간 설정여부 N 일때 입력된 값에 상관 없이 9999-12-31 23:59:59로 입력 */
		columns.push({name :'saleEndDtm', label :'판매기간<br/>종료일시', width :'100', align :'left', sortable : false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }'});
		/* 태그 */ columns.push({name :'tagsNm', label :'태그', width :'100', align :'left', sortable : false });
		/* 태그 HIDDEN */ columns.push({name :'tags', label :'태그', hidden : true });
		/* 네이버쇼핑 노출여부 */ columns.push({name :'sndYn', label :'<spring:message code="column.goods.naverEpInfo.sndYn"/>', width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 수입 및 제작 여부 */ columns.push({name :'goodsSrcNm', label :'<spring:message code="column.goods.naverEpInfo.goodsSrcCd"/>', width :'100', align :'left', sortable : false });
		/* 수입 및 제작 여부 HIDDEN */ columns.push({name :'goodsSrcCd', label :'<spring:message code="column.goods.naverEpInfo.goodsSrcCd"/>', hidden : true });
		/* 판매 방식 구분 */ columns.push({name :'saleTpNm', label :'<spring:message code="column.goods.naverEpInfo.saleTpCd"/>', width :'100', align :'left', sortable : false });
		/* 판매 방식 구분 HIDDEN */ columns.push({name :'saleTpCd', label :'<spring:message code="column.goods.naverEpInfo.saleTpCd"/>', hidden : true });
		/* 주요사용연령대 */ columns.push({name :'stpUseAgeNm', label :'<spring:message code="column.goods.naverEpInfo.stpUseAgeCd"/>', width :'100', align :'left', sortable : false });
		/* 주요사용연령대 HIDDEN */ columns.push({name :'stpUseAgeCd', label :'<spring:message code="column.goods.naverEpInfo.stpUseAgeCd"/>', hidden : true });
		/* 주요사용성별 */ columns.push({name :'stpUseGdNm', label :'<spring:message code="column.goods.naverEpInfo.stpUseGdCd"/>', width :'100', align :'left', sortable : false });
		/* 주요사용성별 HIDDEN */ columns.push({name :'stpUseGdCd', label :'<spring:message code="column.goods.naverEpInfo.stpUseGdCd"/>', hidden : true });
		/* 검색 태그 */ columns.push({name :'srchTag', label :'<spring:message code="column.goods.naverEpInfo.srchTag"/>', width :'100', align :'left', sortable : false });
		/* 네이버 카테고리 ID */ columns.push({name :'naverCtgId', label :'네이버 카테고리 ID', width :'100', align :'left', sortable : false });
		/* 가격비교 페이지 ID */ columns.push({name :'prcCmprPageId', label :'가격비교 페이지 ID', width :'100', align :'left', sortable : false });
		/* 상품 개별 SEO 설정 사용여부 */ columns.push({name :'pageYn', label :'상품 개별 SEO 설정 사용여부', width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* SEO 타이틀/메타태그/메타태그 하나라도 없을 경우 SEO 설정여부 N 입력하지 않음 */
		/* SEO 타이틀 */ columns.push({name :'pageTtl', label :'<spring:message code="column.display.seo.info_page_ttl"/>', width :'100', align :'left', sortable : false });
		/* SEO 메타태그 작성자 */ columns.push({name :'pageAthr', label :'<spring:message code="column.display.seo.info_page_author"/>', width :'100', align :'left', sortable : false });
		/* SEO 메타태그 설명 */ columns.push({name :'pageDscrt', label :'<spring:message code="column.display.seo.info_page_dscrt"/>', width :'100', align :'left', sortable : false });
		/* SEO 메타태그 키워드 */ columns.push({name :'pageKwd', label :'<spring:message code="column.display.seo.info_page_kwd"/>', width :'100', align :'left', sortable : false });
		/* 대표카테고리로 등록. 카테고리명으로 검색되지 않는 값 있을 경우 상품등록 처리하지 않음 */
		/*주문제작여부*/  columns.push({name :'ordmkiYn', title:false,  label :'<spring:message code="column.goods.ordmkiYn"/>',hidden:true, width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 전시 카테고리 대분류 */ columns.push({name :'cateNmL', label :'대분류', width :'100', align :'left', sortable : false });
		/* 전시 카테고리 대분류 HIDDEN */ columns.push({name :'cateCdL', label :'전시 카테고리 대분류', hidden: true});
		/* 전시 카테고리 중분류 */ columns.push({name :'cateNmM', label :'중분류', width :'100', align :'left', sortable : false });
		/* 전시 카테고리 중분류 HIDDEN */ columns.push({name :'cateCdM', label :'전시 카테고리 중분류', hidden: true});
		/* 전시 카테고리 소분류 */ columns.push({name :'cateNmS', label :'소분류', width :'100', align :'left', sortable : false });
		/* 전시 카테고리 소분류 HIDDEN */ columns.push({name :'cateCdS', label :'전시 카테고리 소분류', hidden: true});
		/* 아이콘 코드 , 구분, 유효하지 않을 경우 입력 X */ columns.push({name :'icons', label :'코드', width :'100', align :'left', sortable : false });
		/* 아이콘 시작기간(기간제용) yyyy-mm-dd 미입력시 상품 등록 날짜 입력 */ columns.push({name :'iconStrtDtm', label :'시작기간', width :'100', align :'left', sortable : false, formatter:gridFormat.date, dateformat:'yyyy-MM-dd'});
		/* 아이콘 종료기간(기간제용) yyyy-mm-dd 미입력시 무기한 9999-12-31 */ columns.push({name :'iconEndDtm', label :'종료기간', width :'100', align :'left', sortable : false, formatter:gridFormat.date, dateformat:'yyyy-MM-dd'});
		/* 사은품 가능 여부 */ columns.push({name :'frbPsbYn', label :'<spring:message code="column.goods.frbPsbYn"/>', width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 유통기한 관리여부 */ columns.push({name :'expMngYn', label :'<spring:message code="column.goods.expMngYn"/>', width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* 유통기한 (월) 유통기한 관리여부 N일경우 무시, 36개월까지 입력 가능 */ columns.push({name :'expMonth', label :'<spring:message code="column.goods.expMonth"/>', width :'100', align :'left', sortable : false });
		/* MD Pick 여부 mdRcomYn */ columns.push({name :'mdRcomYn', label :'<spring:message code="column.goods.mdPick"/>', width :'100', align :'left', sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='true' />"} });
		/* MD 추천 메시지 MD Pick 여부 상관없이 내용 저장 */ columns.push({name :'mdRcomWds', label :'<spring:message code="column.goods.mdRcomWds"/>', width :'100', align :'left', sortable : false });
		/* 고시 아이디 HIDDEN */ columns.push({name :'ntfId', label :'고시 아이디', formatter:function(cellvalue, options, rowObject){return '35';}, hidden: true});
		/* ROW 아이디 HIDDEN */ columns.push({name :'excelRow', label :'ID', hidden: true});

		var gridOptions = {
			url : "<spring:url value='/goods/uploadExcelGrid.do' />"
			, paging : false
			, height : 400
			, searchParam : {
				uploadGb : ''
				, ntfId : ''
				, filePath : ''
				, fileName : ''
				, colName : ''
			}
			, colModels : columns
			, multiselect : false
			, loadComplete : function(data) {
				//데이터 없을 경우에도 스크롤
				if($(this).jqGrid('getGridParam', 'reccount') == 0){
					$(".jqgfirstrow").css("height","1px");
				}
			}
			, gridComplete : function () {
				bulkImage.checkImgMatch();
			}
		};

		$(document).ready(function() {
			createExcelGrid ();
		});

		/**
		 * [Grid] 목록 초기화
		 */
		function createExcelGrid () {
			// Grid 초기화
			$.jgrid.gridUnload('#'+listId);
			grid.create(listId, gridOptions);

			$('#'+listId).jqGrid('setGroupHeaders', {
				useColSpanStyle: false,
				groupHeaders:[
					{startColumnName: 'successYn', numberOfColumns: 2, titleText: '<em>결과</em>'},
					{startColumnName: 'stId', numberOfColumns: 38, titleText: '<em>기본정보</em>'},
					{startColumnName: 'attr1No', numberOfColumns: 20, titleText: '<em>속성</em>'},
					{startColumnName: 'img1Url', numberOfColumns: 11, titleText: '<em>이미지</em>'},
					{startColumnName: 'saleDtYn', numberOfColumns: 3, titleText: '<em>판매기간</em>'},
					{startColumnName: 'sndYn', numberOfColumns: 12, titleText: '<em>네이버쇼핑</em>'},
					{startColumnName: 'pageYn', numberOfColumns: 5, titleText: '<em>SEO</em>'},
					{startColumnName: 'cateNmL', numberOfColumns: 6, titleText: '<em>전시 카테고리 </em>'},
					{startColumnName: 'icons', numberOfColumns: 3, titleText: '<em>아이콘</em>'},
					{startColumnName: 'expMngYn', numberOfColumns: 2, titleText: '<em>유통기한</em>'},
					{startColumnName: 'mdRcomYn', numberOfColumns: 2, titleText: '<em>MD Pick</em>'}
				]
			});
		}

		/**
		 * [버튼]템플릿 다운로드
		 */
		function sampleDown () {
			var f = document.goodsBulkForm;
			f.target = 'hframe';
			f.action = '/template/excel/goodsSampleExcel.xlsx';
			f.submit();
		}

		/**
		 * [버튼] 엑셀 업로드
		 * @param file
		 */
		function xlsUpload() {
			fileUpload.xls (loadExcelList);
		}

		/**
		 * [일괄등록] 엑셀 데이터 그리드 표시
		 * @param file
		 */
		function loadExcelList (file ) {
			var columnNames = $('#' + listId).jqGrid('getGridParam', 'colModel');
			var cols = new Array();
			// resultMessage, successYn 제외
			for(var i = 2; i < columnNames.length; i++ ) {
				// 속성명, 사이트 제외 (, 구분자 사용 컬럼들)
				if (columnNames[i].hidden != true || columnNames[i].title == false) {
					cols.push(columnNames[i].name );
				}
			}

			var options = {
				searchParam : {
					uploadGb : 'UPLOAD_GB_GOODS_BASE'
					, filePath : file.filePath
					, fileName : file.fileName
					, colName : cols + ''
				},
			};

			grid.reload(listId, options);
		}

		/**
		 * [일괄등록] 일괄 업로드
		 */
		function bulkUploadGoods () {
			var sendData = null;
			var bulkList = grid.jsonData (listId);
			var uploadGb = $("#uploadGb").children("option:selected").val();
	
			if(bulkList.length < 1) {
				messager.alert("업로드 항목이 없습니다.", "Info");
				return;
			}
			for(var i = 0; i < bulkList.length; i++ ) {
				if(bulkList[i].goodsId && bulkList[i].goodsId != '') {
					// message 내용으로 인해 messager.alert의 icon 사용 X
					messager.alert("이미 등록된 상품입니다.", "Info");
					return;
				}
				if(bulkList[i].successYn == "${adminConstants.COMM_YN_N }" ) {					
					// message 내용으로 인해 messager.alert의 icon 사용 X
					//messager.alert("<spring:message code='admin.web.view.msg.goods.bulk.upload.list.error' arguments='" + bulkList[i].compGoodsId +","+ bulkList[i].goodsNm+","+bulkList[i].resultMessage +"'/>", "Info");
					messager.alert("<spring:message code='admin.web.view.msg.goods.bulk.upload.list.error'/>", "Info");
					return;
				}
			}

			sendData = {
				uploadGb : uploadGb
				, GoodsBulkUploadPO : JSON.stringify(bulkList )
			}
			//console.debug(sendData );

			messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
				if(r){
					var options = {
						url : "<spring:url value='/goods/bulkUploadGoods.do' />"
						, data : sendData
						, callBack : function (data ) {
							var result = '';
							$.each(data.goodsBulkUploadPOList, function(i, v){
								$('#'+listId).jqGrid('setCell', v.excelRow, 'successYn', v.successYn, {color:'red'});
								$('#'+listId).jqGrid('setCell', v.excelRow, 'resultMessage', v.resultMessage);
								
								result += '['+i+']' + (v.successYn == 'Y' ? '성공':'실패') + ':' + v.resultMessage + '<br/>';
							});
							messager.alert(result, "Info", "info", function(){
		    					updateTab();
		    		        });
						}
					};
					ajax.call(options);
				}
			});
		}

		/**
		 * [팝업] 템플릿 가이드 팝업
		 */
		function openGuide(){
			var options = {
				url : "<spring:url value='/goods/goodsBulkUploadGuidePopView.do' />"
				, data : ""
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "templateGuide"
						, width : 1200
						, height : 600
						, top : 200
						, title : "템플릿 가이드 팝업"
						, body : data
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}
		
		/**
		 * 이미지 벌크 업로드
		 */
		var bulkImage = {
			uploadedImageList : null,
			checkImgMatch : function() {
				var uploadImgsMap = new Map(), getKey =function(thisObj){return thisObj["fileName"];};
				var rowIds = $('#'+listId).getDataIDs();
				if(rowIds != null){
					var uploadImgs = bulkImage.uploadedImageList || null;
					if(uploadImgs != null){
					    uploadImgs.forEach(function (obj){
					    	uploadImgsMap.set(getKey(obj),obj);
					    });
					}
					$(".imgNomatch").remove();
					for(var idx = 0; idx < rowIds.length; idx++) {
						var data = $('#'+listId).getRowData(rowIds[idx] );
						// 이미지 맵핑 확인
						var noMatchImg = false;
						// 이미지 1~10
						for(var i = 1; i <= 10 ; i++ ){
							var thisImg = eval("data.img"+i+"Url");
							if(thisImg.trim() != "" && thisImg.indexOf("http") != 0){
								if(uploadImgsMap.get(thisImg) == undefined){
									var noMatchHtml = "<span class='imgNomatch'><b>[이미지"+i+"URL]</b> 이미지 "+thisImg +" 없음</span>";
									if(data.resultMessage.trim() != ""){
										noMatchHtml = data.resultMessage +"<span class='imgNomatch'><br/><b>[이미지"+i+"URL]</b> 이미지 "+thisImg +" 없음</span>";
									}
									$('#'+listId).jqGrid('setCell', rowIds[idx], "resultMessage", noMatchHtml);
									$('#'+listId).jqGrid('setCell', rowIds[idx], "successYn", "N", {color:'red'});
									noMatchImg = true;
								}else {
									$('#'+listId).jqGrid('setCell', rowIds[idx], "img"+i+"Url", uploadImgsMap.get(thisImg).filePath);
								}
								if(data.resultMessage.trim() == '' && !noMatchImg){
									$('#'+listId).jqGrid('setCell', rowIds[idx], "successYn", "Y", {color:'black'});
								}
							}
						}
						// 배너 이미지
						var bnnrImg = data.bannerImgUrl;
						if(bnnrImg.trim() != "" && bnnrImg.indexOf("http") != 0){
							if(uploadImgsMap.get(bnnrImg) == undefined){
								var noMatchHtml = "<span class='imgNomatch'><b>[이미지"+i+"URL]</b> 이미지 "+thisImg +" 없음</span>";
								if(data.resultMessage.trim() != ""){
									noMatchHtml = data.resultMessage +"<span class='imgNomatch'><br/><b>[이미지"+i+"URL]</b> 이미지 "+thisImg +" 없음</span>";
								}
								$('#'+listId).jqGrid('setCell', rowIds[idx], "resultMessage", noMatchHtml);
								$('#'+listId).jqGrid('setCell', rowIds[idx], "successYn", "N", {color:'red'});
								noMatchImg = true;
							}else{
								$('#'+listId).jqGrid('setCell', rowIds[idx], "bannerImgUrl", uploadImgsMap.get(bnnrImg).filePath);
							}	
							if(data.resultMessage.trim() == '' && !noMatchImg){
								$('#'+listId).jqGrid('setCell', rowIds[idx], "successYn", "Y", {color:'black'});
							}
						}
					}
				}
			},
			uploadeCallback : function(data) {
				$("#bulkImgResult").text("이미지 업로드 완료("+data.resultList.length+"/"+data.resultList.length+")");
				$("#bulkImgResult").css("color","");
				$("#bulkImgResult").show();
				$("#bulkImgBtn").hide();
				$("#imgMsg").hide();
				bulkImage.uploadedImageList = data.resultList;
				bulkImage.checkImgMatch();
			},
			progressCallBack : function(pcnt) {
				$("#bulkImgResult").show();
				$("#bulkImgResult").text("이미지 업로드 중("+pcnt+"%)");
			}
		}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<iframe name='hframe' width=0 height=0 frameborder=0></iframe>
		<form id="goodsBulkForm" name="goodsBulkForm" method="post">
			<table class="table_type1">
				<caption><spring:message code="admin.web.view.app.goods.search"/></caption>
				<colgroup>
					<col width="150px"/>
					<col />
					<col width="150px"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<!-- 이미지 업로드 -->
						<th scope="row">이미지 업로드</th>
						<td colspan="3">
							<span id="bulkImgResult" style="display: none"></span>
							<button type="button" id="bulkImgBtn" class="btn" onclick="fileUpload.goodsImageBulk(bulkImage.uploadeCallback, bulkImage.progressCallBack);">파일 찾기</button>
							&nbsp;&nbsp; <span id="imgMsg">* 엑셀파일 내 이미지명과 동일한 이미지명으로 업로드해주세요.</span>
						</td>
					</tr>
					<tr>
						<!-- 템플릿 다운로드 -->
						<th scope="row">Template</th>
						<td>
							<button type="button" class="btn" onclick="sampleDown();">
								<spring:message code="admin.web.view.common.button.download.template"/>
							</button>
						</td>
						<!-- 업로드 -->
						<th scope="row"><spring:message code="admin.web.view.common.button.upload"/></th>
						<td>
							<button type="button" class="btn" onclick="xlsUpload();"><spring:message code="admin.web.view.common.button.upload"/></button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<hr />
		<div class="mModule">
			<table id="goodsBulkList" style="overflow-x:auto;"></table>
			<div id="goodsBulkListPage"></div>
		</div>

		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="bulkUploadGoods();"><spring:message code="admin.web.view.common.button.insert"/></button>
			<button type="button" class="btn btn-cancel" onclick="closeTab();"><spring:message code="admin.web.view.common.button.cancel"/></button>
		</div>
	</t:putAttribute>

</t:insertDefinition>