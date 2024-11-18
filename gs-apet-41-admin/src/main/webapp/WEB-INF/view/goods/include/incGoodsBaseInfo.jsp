<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!--
fstGoodsYn: ${fstGoodsYn} in goodsBaseInfo
-->
<script type="text/javascript">
	$(function() {				
		$(document).on("change","#saleEndDt, #saleEndHr, #saleEndMn", function(e) {
			if($("input:checkbox[id='unlimitEndDate']").is(":checked")){
				var endDt = $("#saleEndDt").val();
				var endHr = $("#saleEndHr option:selected").val();
				var endMn = $("#saleEndMn option:selected").val();		
				if(endDt != "9999-12-31" || endHr != "23" || endMn != "59"){
					//종료일 미지정 체크 해제 unlimitSaleEndDate			
					$('input:checkbox[id="unlimitEndDate"]').attr("checked", false);			
				}
			}	
			
		});
	});

	// 종료일 미지정
	function checkUnlimitEndDate (obj, id) {
		var orgEndDt = $("#"+ id +"StrtDt").val();
		var orgEndHr = $("#"+ id +"StrtHr option:selected").val();
		var ordEndMn = $("#"+ id +"StrtMn option:selected").val();
		
		if($(obj).is(":checked")) {
			orgEndDt = $("#"+ id +"EndDt").val();
			orgEndHr = $("#"+ id +"EndHr option:selected").val();
			ordEndMn = $("#"+ id +"EndMn option:selected").val();

			$("#"+ id +"EndDt").val("9999-12-31");
			$("#"+ id +"EndHr").val("23");
			$("#"+ id +"EndMn").val("59");
		} else {
			$("#"+ id +"EndDt").val(orgEndDt);
			$("#"+ id +"EndHr").val(orgEndHr);
			$("#"+ id +"EndMn").val(ordEndMn);
		}
	}
	
	// 상품 상세
	function viewGoodsDetail (goodsId) {
		updateTab('/goods/goodsDetailView.do?goodsId=' + goodsId, '상품 상세 - ' + goodsId);
	}
	
	// 상품 조회 팝업 연결 데이터 세팅
	function setOptionGoodsListPop(stIdsFlag, compNoFlag, goodsCstrtTpCds, tagsFlag, bndNoFlag, goodsStatCd, frbPsbYn, attrYn, callBack){
											
		var stIds = new Array();
		var tags = new Array();
		
		if(stIdsFlag){
			$("[name='stId']:checked").each(function(){
				stIds.push($(this).val());
			});	
		}
		
		if(tagsFlag){
			$(".goodsTagNos").each(function(){
				tags.push(($(this).data('tag')));
			});
		}
		
		var options = {
			multiselect : true
			, eptGoodsId : "${goodsBase.goodsId }"	// 상품상세 연관상품 추가 팝업 자기자신 제외용 goodsId by pkt on 20200115
			, compNo : compNoFlag ? $("[name='compNo']").val() : ""
			, compNm : compNoFlag ? $("[name='compNm']").val() : ""
			, stIds : stIds
			, goodsCstrtTpCds : goodsCstrtTpCds
			, frbPsbYn : frbPsbYn
			, bndNo : bndNoFlag ? $("[name='bndNo']").val() : ""
			, goodsStatCd : goodsStatCd
			, tags : tags
			, showYn : "${adminConstants.COMM_YN_Y}"
			, attrYn : attrYn
			, callBack : callBack
		}
		
		return options;
	}
	

	// 공급업체 배송정책 조회
	function compDlvrcPlcList () {
		var compNo = $("#compNo").val();
		var config = {
			url : "<spring:url value='/goods/compPlcList.do' />"
			, data : { compNo : compNo }
			, dataType : "json"
			, callBack : function (data ) {
				// 배송 정책
				var dlvrPlcList = data.dlvrPlcList;
				$("#dlvrcPlcNo").find("option").remove();
				for(var i = 0; i < dlvrPlcList.length; i++ ) {
					$("#dlvrcPlcNo").append("<option value='" + dlvrPlcList[i].dlvrcPlcNo + "'>" + dlvrPlcList[i].dlvrcPlcNo + '.' + dlvrPlcList[i].plcNm + "</option>");
				}
				
				
				<c:if test="${empty goodsBase.goodsId}" >
					// 상품 '등록'일 경우
			        // 묶음/세트 상품일때   배송정책리스트를 선택되지 않게 함. [배송정책리스트는 가져와 select박스를 셋팅함(compDlvrcPlcList())]
					var curCstrtTp = "${goodsCstrtTpCd}";
		
					if( curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_PAK}" || curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_ATTR}" ) { 
						
						$("#dlvrcPlcNo").append("<option value=''></option>");
						$("#dlvrcPlcNo").val("").prop("selected", true); // 기본선택을 하지 않는다.
					}
				</c:if>

				// 판매가 입력 허용
				$("input[name=saleAmt]").attr("readonly", false);
				// 정상가 입력 허용
				$("input[name=orgSaleAmt]").attr("readonly", false);
				// 공급가 입력 허용
				$("input[name=splAmt]").attr("readonly", false);

				// 수수료 정책
				var cclPlc = data.cclPlc;
				//$("#cmsRate").val (cclPlc.cmsRate );

				// 사이트목록 있는거 체크하기. hjko추가
				$("input[name='stId']").prop('checked',false);
				$("input[name=stId]").each(function(index,obj){
					$("input[name='stId']").prop("disabled",true);
				});

				// 업체브랜드 가져오기. hjko 추가
				var companyBrandList = data.companyBrandList;
				$("#bndNo").find("option").remove();
				for(var i=0 ; i< companyBrandList.length ; i++){
					$("#bndNo").append("<option value='"+ companyBrandList[i].bndNo +"'>" + companyBrandList[i].bndNmKo + "</option>");
				}

				$("#stIdCombo option").not(":selected").attr("disabled", "");

				var stIdList = data.stIdList;

				for(var i=0; i< stIdList.length; i++){
					$("input[name='stId'][value="+stIdList[i].stId+"]").prop("checked",true);
					$("input[name='stId'][value="+stIdList[i].stId+"]").prop("disabled",false);

					$("input[name=stIdCombo] ").prop('disabled', false);
					$("select[name='stIdCombo']").find("option[value="+stIdList[i].stId+"]").prop("disabled", false);

				}

			}
		};
		ajax.call(config );
	}
	
	function searchCompany () {
		var options = {
			multiselect : false
			, callBack : searchCompanyCallback
            , compStatCd : '${adminConstants.COMP_STAT_20}'
            , excludeCompTpCd : '${adminConstants.COMP_TP_30}'
            , readOnlyCompStatCd : 'Y'
		}
		layerCompanyList.create (options );
	}
	function searchCompanyCallback (compList ) {
		console.log("searchCompanyCallback()");
		
		if(compList.length > 0 ) {
			$("#compNo").val (compList[0].compNo );
			$("#compNm").val (compList[0].compNm );
			$("#compGbCd").val (compList[0].compGbCd );
			$("#bndNo").val ('');
			$("#bndNm").val ('');
			
			compDlvrcPlcList();
			
			// 단품이 아닐 경우 item 수정
			if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== $("[name='goodsCstrtTpCd']").val() ) {
				deleteAllGridRow('attrList');
			}else{
// 				TODO 화면제어 정책 협의 후(자사 위탁에 따라)
				if(compList[0].compGbCd === "${adminConstants.COMP_GB_10}"){
					// 자사 일 경우 단품의 재고 수량 입력 불가
					$("#defaultItemStockCnt").prop("readonly", true);
					$("#defaultItemStockCnt").addClass("readonly");
					
					$(".shoplinkerTable").show();
					$("[name='shoplinkerSndYn'][value='Y']").prop('checked', true);

					$("#phsCompNo").val ('');
					$("#phsCompNm").val ('');

					$("#phsCompNoBtn").prop('disabled', false).show();

					// 자사 일 경우 매입 업체 선택 가능 임시처리
// 					$("#phsCompNoBtn").prop('disabled', false);
				}else{
					$("#defaultItemStockCnt").prop("readonly", false);
					$("#defaultItemStockCnt").removeClass("readonly");
					
					$(".shoplinkerTable").hide();
					$("[name='shoplinkerSndYn'][value='N']").prop('checked', true);

					$("#phsCompNo").val (compList[0].compNo );
					$("#phsCompNm").val (compList[0].compNm );

					$("#phsCompNoBtn").prop('disabled', true).hide();

					// 자사 일 경우 매입 업체 선택 가능 임시 처리
// 					$("#phsCompNoBtn").prop('disabled', true);


				}				
			}
		}
	}
	
	function selectBrandSeries () {
		
		if($("#compNo").val() === ''){
			messager.alert("<spring:message code='admin.web.view.app.goods.company.no_select' />", "Info", "info" );
			return;
		}
		
		var	options = {
				multiselect : false
				, compNo : $("#compNo").val()
				, useYn : '${adminConstants.COMM_YN_Y }'
				, callBack : searchBrandCallback
			}
		
		layerBrandList.create (options );
	}
	function searchBrandCallback (brandList ) {
		if(brandList != null && brandList.length > 0 ) {
			$("#bndNo").val (brandList[0].bndNo );
			$("#bndNm").val (brandList[0].bndNmKo );
		}
	}
	
	// SEO 정보 등록/수정
	function fnGoodsSeoInfoPop() {
		var paramSeoInfoNo = $("#seoInfoNo").val();
		var paramDispClsfCd = $("#dispClsfCd").val();
			var buttonText;
			if (paramSeoInfoNo != '') {
				buttonText = "수정";
			} else {
				buttonText = "등록";
			}
			var options = {
				url : "<spring:url value='/display/seoInfoPop.do' />"
				, data : {seoInfoNo : paramSeoInfoNo, svcGbCd : paramDispClsfCd, seoTpCd : "${adminConstants.SEO_TP_20}"}
				, dataType : "html"
				, callBack : function (result) {
					var config = {
						id : "seoInfoDetail"
					, width : 960
					, height : 700
					, top : 70
					, title : "SEO 상세정보"
					, button : "<button type=\"button\" onclick=\"updateSeoInfoPopup();\" class=\"btn btn-ok\">" + buttonText + "</button>"
					, body : result
				};
				layer.create(config);
			}
		};
		ajax.call(options);
	}
	
	// SEO 정보 등록/수정 후 callBack
	function callBackSaveSeoInfo(seoInfoNo) {
		$("#seoInfoNo").val(seoInfoNo);
	}
	
	// Tag 추가 팝업
	function goodsTagSearchPop() {
		var options = {
			multiselect : true
			, callBack : function(result) {
				if(result != null && result.length > 0) {
					
					var tagHtml = '';
					var flagTagAdd = true;
					var goodsTagNos = $(".goodsTagNos");
					
					for(var i in result){
					
						flagTagAdd = true;
						
						$.each(goodsTagNos, function(index, tagNo) {
							if($(this).data('tag') === result[i].tagNo ){
								flagTagAdd = false;
							}
						});
						
						if(flagTagAdd){		
 							tagHtml += '<span class="rcorners1 selectedTag  goodsTagNos" id="sel_' + result[i].tagNo + '" data-tag="'+ result[i].tagNo +'">' + result[i].tagNm + '</span>'; 
 							tagHtml += '<img id="sel_' + result[i].tagNo + 'Delete" onclick="layerTagBaseList.deleteTag(\'sel_' + result[i].tagNo + "\',\'"+ escape(result[i].tagNm) +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
						}
					}
					
					$("#goodsTags").append (tagHtml);
				}
			}
		 }
		layerTagBaseList.create(options);
	}
	
	function dragAndDrop(dragId, targetColumn){
// 		$("#" + dragId).jqGrid("sortableRows");
		$("#" + dragId).jqGrid('sortableRows', {
			update: function (e, html) {
				
				var ids = $("#" + dragId).jqGrid("getDataIDs");
				for (var i=0; i<ids.length; i++) {
					var rank = i+1;
					$("#" + dragId).jqGrid("setCell", ids[i], targetColumn, rank);
				}
								
				<c:if test="${!empty goodsBase.goodsId}" >
				setdlgtGoodsYn(); // 대표상품 YN 체크
				</c:if>

				// 상품 '등록'일 경우
		        // 묶음/세트 상품일때  최상단의 상품 배송정책 가져옴(ajax)
				var curCstrtTp = "${goodsCstrtTpCd}";
	
				if( curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_PAK}" || curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_ATTR}" ) { 
					var goodsIdAtTop = "";
					
					if ( ids.length > 0 ) {
						goodsIdAtTop = ids[0];
						fn_getDlvrcPlcNo( goodsIdAtTop );
					} 
				}
				
			}
	   });
	}
	
	// 상품의 배송정책코드 가져옴(ajax). 최상단의 배송정책을 가져오기 위해 주로 사용.
    function fn_getDlvrcPlcNo( goodsId ) {
    	var options = {
			url : "<spring:url value='/goods/getDlvrcPlcNo.do' />"
			, data : {goodsId : goodsId}
			, dataType : "json"
			, callBack : function (data ) {
				
				// 배송정책 코드를 가져올 수 없을때
				if ( data.dlvrcPlcNo == '0') {
					alert( "해당상품(" + goodsId + ")의 배송정책코드가 존재하지 않습니다. 해당 상품에서 배송정책코드를 확인하십시오.");
				} else {
					$("#dlvrcPlcNo").val(data.dlvrcPlcNo).prop("selected", true);
				}
			}
		}
		ajax.call(options );
	}
	
	
    // 상품상세에서 묶음/옵션상품일 경우 최초 동작함(onLoad시). 대표상품(Main)의 배송정책임!! 대표상품 제고 없을경우, 다음순위..다음순위 를 가지고 온다.
	function fn_getMainDlvrcPlcNo() {
		var options = {
			url : "<spring:url value='/goods/getMainDlvrcPlcNo.do' />"
			, data : {goodsId : '${goodsBase.goodsId }'}
			, dataType : "json"
			, callBack : function (data ) {
								
				// 묶음 옵션 상품들이 모두 재고가 없는 경우, 가장 최상단의 배송정책을 가져온다.
				if ( data.mainDlvrcPlcNo == '0' ) {
					
					var ids = $("#attrList").jqGrid("getDataIDs");
					var goodsIdAtTop = "";
										
					if ( ids.length > 0 ) {
						goodsIdAtTop = ids[0];						
						fn_getDlvrcPlcNo( goodsIdAtTop );
					} 
				} else {
					$("#dlvrcPlcNo").val(data.mainDlvrcPlcNo).prop("selected", true);
					$("#dlvrcPlcNo").attr("disabled",true);
				}
				
			}
		}
		ajax.call(options );
	}
    
	/* 영상 상세 */
	function vodView(vdId) {
		addTab('영상 상세', '/contents/vodDetailView.do?vdId=' + vdId);
	}
	
	// 상품 평가 Layer
	var EstmLayerOptions = {
			callBack : undefined
			, dispClsfNo : undefined
			, firstYn : undefined
	};
	var layerEstmList = {
			create : function(option) {
				EstmLayerOptions = $.extend({}, EstmLayerOptions, option);
				var options = {
					url : "/goods/goodsEstmLayerView.do"
					, data : {
						dispClsfNo : EstmLayerOptions.dispClsfNo
					}
					, dataType : "html"
					, callBack : layerEstmList.callBackCreate
				}
				ajax.call(options);
			}
			, callBackCreate : function(data) {
				var config = {
						id : "goodsEstmSearch"
						, height : 700
						, width : 1100
						, title : "<spring:message code='column.goods.estmGrp' />"
						, body : data
						, button : "<button type=\"button\" onclick=\"layerEstmList.confirm();\" class=\"btn btn-ok\">저장</button>"
				}
				layer.create(config);
				layerEstmList.initEstmGrid(data);
			}
			, confirm : function() {
				if($("#goodsEstmForm #displayCategory3").val() !== ''){
					messager.confirm("<spring:message code='admin.web.view.msg.goods.confirm.estmDispClsfNo' />",function(r){
						if(r){
							messager.alert("<spring:message code='admin.web.view.msg.goods.ok.estmDispClsfNo' />", "Info", "info", function(){
								$("[name='goodsEstmDispClsfNo']").val($("#goodsEstmForm #displayCategory3").val());
								layer.close("goodsEstmSearch");	
							} );
						}
					})
				}else{
					messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.estmDispClsfNo' />", "Info", "info" );
					return;
				}
			}
			, searchEstmList : function () {
				var options = {
					searchParam : $("#goodsEstmForm").serializeJson()
				};
				grid.reload("searchEstmList", options);
			}
			, initEstmGrid : function(data) {
				var gridOptions = {
						url : "<spring:url value='/goods/listGoodsEstmCategoryMap.do' />"
						, height : 350
						, searchParam : { dispClsfNo : EstmLayerOptions.dispClsfNo }
						, colModels : [
							{name : "estmQstNo", label : '', width : "150", key : true, align : "center", hidden : true}
							, {name : "qstClsf", label : '<spring:message code="column.goods.qstClsf" />', width : "200", align : "center" }
							, {name : "qstContent", label : '<spring:message code="column.goods.qstContent" />', width : "350", align : "center" }
							, {name : "itemContent", label : '<spring:message code="column.goods.itemContent" />', width : "500", align : "center" }
							, {name : "dispCtgNoPath", label : '', width : "150", align : "center", hidden : true}
						]
						, loadComplete : function(data){
							if(data.data.length > 0){
								if($("#goodsEstmForm #displayCategory3").val() === '' && EstmLayerOptions.firstYn === 'Y'){
									
									var dispCtgNos = data.data[0].dispCtgNoPath.split(';');
									for(var i=0; i < 3; i++){
										createDisplayCategory(i+1, dispCtgNos[i-1], "displayCategory", "${adminConstants.DISP_CLSF_10 }", dispCtgNos[i]);
										$("#displayCategory" + i+1).val(dispCtgNos[i]);
										if(i === 2){
											$("#estmDispClsfNo").val(dispCtgNos[i]);	
										}
									}
									
									EstmLayerOptions.firstYn = '${adminConstants.COMM_YN_N}';
								}
							}
						}
						, beforeSelectRow: function(rowid, e) {
						    return false;
						}
				}
				grid.create("searchEstmList", gridOptions);
			}
	}
	
	// 전체 row 삭제
	function deleteAllGridRow (id ) {
		var ids = $("#"+id).getDataIDs();
		var jsonArray = [];
		for (var i = 0; i < ids.length; i++) {
			$("#"+id).jqGrid('delRowData', ids[i]);
		}
	}
	
	
</script>
			<!-- 공급업체 히든 고정항목 -->
			<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}" >
				<input type="hidden" name="pplrtSetCd" value="${adminConstants.COMM_YN_N}">
			</c:if>
			<div title="기본 정보" data-options="" style="padding:10px">
				<table class="table_type1">
					<caption>GOODS 등록</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.goods_id" /><strong class="red">*</strong></th>	<!-- 상품 아이디-->
							<td>
								<input type="hidden" id="goodsId" name="goodsId" title="<spring:message code="column.goods_id" />" value="${goodsBase.goodsId }" />
								<c:choose>
									<c:when test="${goodsBase.goodsId eq null }">
										<b>자동입력</b>
									</c:when>
									<c:otherwise>
										<b>${goodsBase.goodsId }</b>
									</c:otherwise>
								</c:choose>
							</td>
							<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
							<td>
<%-- 								<frame:stIdCheckbox selectKey="${siteList }" compNo="${goodsBase.compNo}" selectKeyOnly="${not empty goodsBase}"/> --%>
								<label class="fCheck"><input type="checkbox" name="stId" id="st_1" value="1" checked="" disabled=""> <span>어바웃펫</span></label>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods_nm" /><strong class="red">*</strong></th>	<!-- 상품 명-->
							<td colspan="3">
								<input type="text" class="w400 validate[required, maxSize[50]]" name="goodsNm" id="goodsNm" title="<spring:message code="column.goods_nm" />" value="${goodsBase.goodsNm }" />
							</td>
						</tr>
						<tr>
							<c:choose>
								<c:when test="${(adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd or adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd )}" >
									<th><spring:message code="column.goods.compGoodsNm" /></th>	<!-- 위탁업체 상품 명-->
									<td>
										<input type="text" class="w400 validate[maxSize[50]]" name="compGoodsNm" id="compGoodsNm" title="<spring:message code="column.goods.compGoodsNm" />" value="${goodsBase.compGoodsNm }" />
									</td>
									<th><spring:message code="column.goods.strdCd" /></th>	<!-- 표준코드-->
									<td>
										<input type="text" class="w300 validate[maxSize[20]]" name="prdStdCd" title="<spring:message code="column.goods.strdCd" />" value="${goodsBase.prdStdCd }" />
									</td>
								</c:when>
								<c:otherwise>
									<th><spring:message code="column.goods.compGoodsNm" /></th>	<!-- 위탁업체 상품 명-->
									<td colspan="3">
										<input type="text" class="w400 validate[maxSize[50]]" name="compGoodsNm" id="compGoodsNm" title="<spring:message code="column.goods.compGoodsNm" />" value="${goodsBase.compGoodsNm }" />
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th><spring:message code="column.goods_stat_cd" /><strong class="red">*</strong></th>	<!-- 상품 상태 코드-->
							<td>
								<c:choose>
									<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
	<!-- TOBE 등록일 경우 대기/판매중 선택가능... 정책 확인 후 삭제 or 원복 필요 -->
	<%-- 								<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />"> --%>
	<%-- 									<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${empty goodsBase ? adminConstants.GOODS_STAT_20 : goodsBase.goodsStatCd }" /> --%>
	<!-- 								</select> -->
										<c:choose>
											<c:when test="${empty goodsBase  }">
												<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">
													<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${adminConstants.GOODS_STAT_10}"
													usrDfn2Val ="${adminConstants.COMM_YN_Y}" />
												</select>
											</c:when>
											<c:otherwise>
												<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">
													<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${goodsBase.goodsStatCd }" 
 													usrDfn2Val ="${adminConstants.COMM_YN_Y}" />
												</select>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}" >
										<c:choose>
											<c:when test="${empty goodsBase }">
<%-- 			                                   <b><frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_10}"/></b> --%>
												<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd"/>">
													<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${adminConstants.GOODS_STAT_10}" selectKeyOnly="${empty goodsBase}"/>
												</select>
			                                	<input type="hidden" name="goodsStatCd" value="${adminConstants.GOODS_STAT_10 }">
											</c:when>
											<c:otherwise>
	                                   			<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">													
													<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${goodsBase.goodsStatCd }" 
 													usrDfn2Val ="${adminConstants.COMM_YN_Y}" />
												</select>
											</c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>
							</td>
							<th><spring:message code="column.goods.comp_nm" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
							<td>
								<input type="hidden" id="compGbCd" value="${goodsBase.compGbCd}" />
								<c:choose>
									<c:when test="${empty goodsBase && adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
										<c:set var="compNmPlaceholder" ><spring:message code='column.goods.search.compNm' /></c:set>
										<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${goodsBase.compNo }" defaultCompNm="${goodsBase.compNm }" placeholder="${compNmPlaceholder}" />
									</c:when>
									<c:when test="${empty goodsBase && adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">
										<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${adminSession.compNo }" defaultCompNm="${adminSession.compNm }" disableSearchYn="Y"/>
										(${adminSession.compNo })
									</c:when>
									<c:otherwise>
										<c:if test="${fstGoodsYn eq 'false'}">
											<c:set var="compNmPlaceholder" ><spring:message code='column.goods.search.compNm' /></c:set>
											<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${goodsBase.compNo }" defaultCompNm="${goodsBase.compNm }" placeholder="${compNmPlaceholder}" />
										</c:if>
										<c:if test="${fstGoodsYn eq 'true'}">
											<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${goodsBase.compNo }" defaultCompNm="${goodsBase.compNm }" disableSearchYn="Y"/>
											(${goodsBase.compNo })
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods.compGoodsId" /></th>	<!-- 자체 상품 코드 -->
							<td>
								<input type="text" class="validate[maxSize[50]]" name="compGoodsId" id="compGoodsId" title="<spring:message code="column.comp_goods_id" />" value="${goodsBase.compGoodsId }" />
							</td>
							<th><spring:message code="column.mdl_nm" /></th>	<!-- 모델 명-->
							<td>
								<input type="text" class="validate[maxSize[200]]" name="mdlNm" id="mdlNm" title="<spring:message code="column.mdl_nm" />" value="${goodsBase.mdlNm }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods.brnd" /><strong class="red">*</strong></th>	<!-- 브랜드-->
							<td>
								<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="${goodsBase.bndNo}" />
								<input type="text" readonly class="readonly validate[required]" id="bndNm" name="bndNm"
								       title="<spring:message code="column.goods.brnd" />" value="${goodsBase.bndNmKo }"
								       placeholder="<spring:message code="admin.web.view.app.brand.popup.search.placeholder"/>"/>
								<button type="button" class="btn" onclick="selectBrandSeries('brand'); return false;">
									<spring:message code="admin.web.view.common.search"/>
								</button>
							</td>
							<th><spring:message code="column.goods.petGb" /><strong class="red">*</strong></th>	<!-- 애완 동물 종류 -->
							<td>
									<c:choose>
										<c:when test="${empty goodsBase || fstGoodsYn eq 'false'}">
											<select class="validate[required]" name="petGbCd" title="<spring:message code="column.goods.petGb" />">
												<option value=""><spring:message code="column.selectData" /></option>
												<frame:select grpCd="${adminConstants.PET_GB}" selectKey="${goodsBase.petGbCd}" usrDfn3Val="Y"  />
											</select>
										</c:when>
										<c:otherwise>
											<input type="text" class="readonly" value="<frame:codeName grpCd="${adminConstants.PET_GB}" dtlCd="${goodsBase.petGbCd}"/>" disabled="true" >
										</c:otherwise>
									</c:choose>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.ctr_org" /><strong class="red">*</strong></th>	<!-- 원산지-->
							<td>
								<select class="validate[required]" name="ctrOrg" id="ctrOrg" title="<spring:message code="column.ctr_org" />">
									<option value=""><spring:message code="column.selectData" /></option>
									<c:forEach items="${frame:listCode(adminConstants.ORIGIN_CD)}" var="item" >
										<option value="${item.dtlNm}" ${goodsBase.ctrOrg eq item.dtlNm ? 'selected' : ''} >${item.dtlNm}</option>
									</c:forEach>
								</select>
							</td>
							<th><spring:message code="column.mmft" /><strong class="red">*</strong></th>	<!-- 제조사-->
							<td>
								<input type="text" class="validate[required, maxSize[200]]" name="mmft" id="mmft" title="<spring:message code="column.mmft" />" value="${goodsBase.mmft }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.importer" /></th>	<!-- 수입사-->
							<td>
								<input type="text" class="validate[maxSize[200]]" name="importer" id="importer" title="<spring:message code="column.importer" />" value="${goodsBase.importer }" />
							</td>
							<th><spring:message code="column.tax_gb_cd" /><strong class="red">*</strong></th>	<!-- 과세 구분 코드-->
							<td>
								<select class="validate[required]" name="taxGbCd" id="taxGbCd" title="<spring:message code="column.tax_gb_cd" />">
									<option value=""><spring:message code="column.selectData" /></option>
									<frame:select grpCd="${adminConstants.TAX_GB }" selectKey="${goodsBase.taxGbCd }" />
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.show_yn" /></th>	<!-- 노출여부 -->
							<td>
								<frame:radio name="showYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${goodsBase.showYn eq null ? adminConstants.SHOW_YN_Y : goodsBase.showYn }" />
							</td>
							<th><spring:message code="column.web_mobile_gb_cd" /></th>	<!-- 웹/모바일 구분 -->
							<td>
								<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB }" selectKey="${goodsBase.webMobileGbCd }" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.goods.sale.period" /><strong class="red">*</strong></th>	<!-- 판매기간-->
							<td colspan="3">
								<frame:datepicker startDate="saleStrtDt"
												  startHour="saleStrtHr"
												  startMin="saleStrtMn"
												  startSec="saleStrtSec"
												  startValue="${goodsBase.saleStrtDtm }"
												  endDate="saleEndDt"
												  endHour="saleEndHr"
												  endMin="saleEndMn"
												  endSec="saleEndSec"
												  endValue="${goodsBase.saleEndDtm }" />
								<label class="fCheck ml10"><input name="unlimitEndDate" id="unlimitEndDate" type="checkbox" onclick="checkUnlimitEndDate(this, 'sale' );" ><span>종료일 미지정</span></label>
							</td>
						</tr>
						<tr>
						    <th><spring:message code="column.goods.tag" /><strong class="red">*</strong></th>  <!-- 태그-->
							<td colspan="3">
								<span id="goodsTags">
									<c:forEach items="${goodsTagMapList}" var="item">
										<span class="rcorners1 selectedTag  goodsTagNos" id="sel_${item.tagNo}" data-tag="${item.tagNo}">${item.tagNm}</span> 
										 <img id="sel_${item.tagNo}Delete" onclick="layerTagBaseList.deleteTag('sel_${item.tagNo}','${fn:escapeXml(item.tagNm)}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
									</c:forEach>
								</span>
								<button type="button" class="roundBtn" onclick="goodsTagSearchPop();" >+ <spring:message code="column.common.addition" /></button>
							</td>
						</tr>
						<tr>
						    <th><spring:message code="column.bigo" /></th>  <!-- 비고-->
							<td colspan="3" >
								<textarea name="bigo" id="bigo" cols="70" rows="2" >${goodsBase.bigo }</textarea>
							</td>
						</tr>
						<c:if test="${not empty goodsBase}" >
							<tr>
								<th>관련 영상</th>  <!-- 관련영상-->
								<td colspan="3">
									<c:forEach items="${contentList}" var="item" varStatus="idx">
										<c:if test="${idx.index eq 0}"><div class="apetContent" ></c:if>
											<c:if test="${idx.index eq 0 and fn:length(contentList) > 5}">	
												<span style="float:right;font-size:18px;padding:25px;cursor:fointer;">▼</span>
											</c:if>	
											<c:if test="${idx.index < 5}">
												<a href="javascript:;" onclick="vodView('${item.vdId}')">
													<img src="${fn:indexOf(item.phyPath, 'cdn.ntruss.com') > -1 ? item.phyPath : frame:optImagePath(item.phyPath, adminConstants.IMG_OPT_QRY_420) }" onerror="this.src='/images/noimage.png'" class="thumb ml10" style="width:50px;height:50px;" alt="" />
													<span>${item.vdId}</span>
												</a>
											</c:if>
										<c:if test="${idx.index eq 4}"></div></c:if>
										<c:if test="${idx.index eq 5}">	
										<div class="apetContentToggle" style="display:none;">
										</c:if>
											<c:if test="${idx.index > 4}">
												<c:if test="${idx.count % 5 eq 1 }"><div></c:if>
													<a href="javascript:;" onclick="vodView('${item.vdId}')">
														<img src="${fn:indexOf(item.phyPath, 'cdn.ntruss.com') > -1 ? item.phyPath : frame:optImagePath(item.phyPath, adminConstants.IMG_OPT_QRY_420) }" onerror="this.src='/images/noimage.png'" class="thumb ml10" style="width:50px;height:50px;" alt="" />
														<span>${item.vdId}</span>	
													</a>
												<c:if test="${idx.count % 5 eq 0 and idx.index ne 5}"></div></c:if>
											</c:if>
										<c:if test="${fn:length(contentList) eq idx.count}"></div></c:if>
									</c:forEach>
								</td>
							</tr>
						</c:if>
						
					</tbody>
				</table>
			<hr />
			<!-- incGoodsItemInfo.jsp 로 이동.2021-06-10 -->
			<%-- <table class="table_type1" >
				<caption>GOODS 등록</caption>
				<tbody>
					<tr id="stockTr">
						<th><spring:message code="column.stk_mng_yn" /></th>	<!-- 재고 관리 여부 -->
						<td>
							<frame:radio name="stkMngYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.stkMngYn eq null ? adminConstants.COMM_YN_Y : goodsBase.stkMngYn }" />
						</td>
						<th><spring:message code="column.min_max_ord_qty" /></th>	<!-- 최소/최대 주문 수량 -->
						<td>
							최소 : <input type="text" class="w50 numeric" name="minOrdQty" id="minOrdQty" title="<spring:message code="column.min_ord_qty" />" value="${goodsBase.minOrdQty }" />
							&nbsp;&nbsp;최대 : <input type="text" class="w50 numeric" name="maxOrdQty" id="maxOrdQty" title="<spring:message code="column.max_ord_qty" />" value="${goodsBase.maxOrdQty }" />
						</td>
					</tr>
				</tbody>
			</table>
			<hr /> --%>
			<!-- 단품일 경우  -->
			<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd and adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
			<div class="shoplinkerTable">
				<table class="table_type1">
					<caption>GOODS 등록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.goods.shoplinkerSndYn" /></th>	<!-- 샵링커 전송 여부 -->
							<td colspan="3">
								<frame:radio name="shoplinkerSndYn" grpCd="${adminConstants.SHOPLINKER_SND_YN }" selectKey="${goodsBase.shoplinkerSndYn eq null ? adminConstants.COMM_YN_Y : goodsBase.shoplinkerSndYn }" disabled="false"/>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- <hr /> -->
			</div>
			</c:if>
			<!-- incTwcProductInfo.jsp 로 이동.2021-06-10 -->
			<%-- <table class="table_type1">
				<caption>GOODS 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.twc.igdtInfoLnkYn" /></th>	<!-- 성분 정보 변동 여부 -->
						<td colspan="3">
							<label class="fCheck">
								<input type="checkbox" name="igdtInfoLnkYn" id="igdtInfoLnkYnY" value="${adminConstants.COMM_YN_Y}"
								 ${goodsBase.igdtInfoLnkYn eq adminConstants.COMM_YN_Y ? 'checked="checked"' : ''} ${fstGoodsYn eq 'true' ? 'disabled' : '' }  >
								<span id="span_>igdtInfoLnkYnY"><spring:message code="column.goods.twc.igdtInfoLnk" /></span>
							</label>
						</td>
					</tr>
				</tbody>
			</table> --%>
		</div>
		<hr />