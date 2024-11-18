<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	java.util.Date d = new java.util.Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String startValue = df.format(d);
%>
<script type="text/javascript">
	var displayCategory1;
	var displayCategory2;
	var isGridExists = false;
	$(function(){

		//[검색] 등록일 날짜 변경
		goodsSearchDateChange();

		//[검색] 가격 유형 날짜 변경
		$('#'+searchForm+' #priceStrtDt').val('');
		$('#'+searchForm+' #priceEndDt').val('');

		<c:choose>
			<c:when test="${category == null }">
				//[검색] 상품 전시 카테고리 콤보박스 Options 세팅
				createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
			</c:when>
			<c:otherwise>
				$('#'+searchForm+' #dispClsfNo').val('<c:out value="${category.dispClsfNo}"/>');

				createDisplayCategory('${category.dispLvl + 1}', "${category.dispClsfNo }");
			</c:otherwise>
		</c:choose>

		//[검색] 상품 전시 카테고리 변경 이벤트
		$('#'+searchForm+' #displayCategory1, #'+searchForm+' #displayCategory2, #'+searchForm+' #displayCategory3').on('change', function() {
			var displayCategoryId = $(this).attr('id');
			var displayCategoryIdx = Number(displayCategoryId.slice('displayCategory'.length));
			var displayCategory = $(this).val();

			if(displayCategory != '') {
				$('#'+searchForm+' #dispClsfNo').val(displayCategory);
				window[displayCategoryId] = displayCategory;
			} else {
				if(displayCategoryIdx == 1) {
					$('#'+searchForm+' #dispClsfNo').val(window[displayCategoryId]);
				}
				if(displayCategoryIdx > 1) {
					$('#'+searchForm+' #dispClsfNo').val(window['displayCategory' + (displayCategoryIdx - 1)]);
				}
			}
			if(displayCategoryIdx < 3) {
				createDisplayCategory(displayCategoryIdx + 1, displayCategory);
			}
		});

		//[검색] 상품 구성 유형 체크 이벤트
		$('#'+searchForm+' input:checkbox[name=goodsCstrtTpCds]').click(function(){
			var checked = $('#'+searchForm+' input:checkbox[name=goodsCstrtTpCds]').eq(0).is(':checked');
			if(checked) {
				$('#'+searchForm+' input[name=frbPsbYn]').removeAttr('disabled');
			} else {
				$('#'+searchForm+' input[name=frbPsbYn]').attr('disabled', 'true');
			}
		});

		//[검색] 판매기간이 종료된 상품 체크 이벤트
		$('#'+searchForm+' input[name="chkEndSaleYn"]').click(function(){
			//checkEndSaleYn($(this));
		});


		$(document).on("change","#priceStrtDt , #priceEndDt",function(){
			if( $("#priceStrtDt").val() && $("#priceEndDt").val() ) {
				var priceStrtDt = $("#priceStrtDt").val();
				var priceEndDt = $("#priceEndDt").val();

				var limitDays = 92;
				var diff = getDifDays(priceStrtDt.replace(/-/g,''),priceEndDt.replace(/-/g,''));

				if(diff<0){
					messager.alert("<spring:message code="admin.web.view.msg.common.compareDate"/>","Info","Info",function(){
						$("#priceStrtDt").val($("#priceStrtDt").data("origin"));
						$("#priceEndDt").val($("#priceEndDt").data("origin"));
					});
				}else{
					$("#priceStrtDt").data("origin",priceStrtDt);
					$("#priceEndDt").data("origin",priceEndDt);
				}
			}
		});
		
		/* 공통으로처리
		$(document).on("change","#goodsSearchSysRegDtmStart , #goodsSearchSysRegDtmEnd",function(){
			
			var goodsSearchSysRegDtmStart = $("#goodsSearchSysRegDtmStart").val();
			var goodsSearchSysRegDtmEnd = $("#goodsSearchSysRegDtmEnd").val();

			var limitDays = 92;
			var diff = getDifDays(goodsSearchSysRegDtmStart.replace(/-/g,''),goodsSearchSysRegDtmEnd.replace(/-/g,''));

			if(diff<0){
				messager.alert("<spring:message code="admin.web.view.msg.common.compareDate"/>","Info","Info",function(){
					$("#goodsSearchSysRegDtmStart").val($("#goodsSearchSysRegDtmStart").data("origin"));
					$("#goodsSearchSysRegDtmEnd").val($("#goodsSearchSysRegDtmEnd").data("origin"));
				});
			}else{
				$("#goodsSearchSysRegDtmStart").data("origin",goodsSearchSysRegDtmStart);
				$("#goodsSearchSysRegDtmEnd").data("origin",goodsSearchSysRegDtmEnd);
			}
			
		}); */
 				
		
/* 		//조회기간 비교 공통	
		 $("#goodsSearchSysRegDtmStart").change(function(){
			compareDate("goodsSearchSysRegDtmStart", "goodsSearchSysRegDtmEnd");
		});
		
		$("#goodsSearchSysRegDtmEnd").change(function(){
			compareDate2("goodsSearchSysRegDtmStart", "goodsSearchSysRegDtmEnd");
		});  
 */		

		newSetCommonDatePickerEventOptions('#goodsSearchSysRegDtmStart','#goodsSearchSysRegDtmEnd','#goodsSearchCheckOptDate');
		
		/**
		 * 키 엔터
		 */
		$('#goodsIdArea, #goodsNmArea, #compGoodsIdArea').on('keydown', function(event) {

			if (event.keyCode == 13) {
				if (!event.ctrlKey ){ //|| !event.metaKey
					event.preventDefault();
					console.log('enter key')
					searchGoodsList();
				} else {
					console.log('ctrl + enter key')
					var start = this.selectionStart;
					var end = this.selectionEnd;
					this.value = this.value.substring(0, end) + '\r\n' + this.value.substring(end);
					this.selectionEnd = end;
					this.selectionStart = this.selectionEnd = start + 1;
				}
			}
		});

		//[목록] 상품 목록 Grid
		searchGoodsList();
	});

	/**
	 * [검색] 등록일 날짜 변경
	 */
	function goodsSearchDateChange() {
		var term = $('#'+searchForm+' #goodsSearchCheckOptDate').children('option:selected').val();
		if(term == '') {
			$('#'+searchForm+' #goodsSearchSysRegDtmStart').val('');
			$('#'+searchForm+' #goodsSearchSysRegDtmEnd').val('');
		} else if(term == "50") {
			setSearchDateThreeMonth("goodsSearchSysRegDtmStart","goodsSearchSysRegDtmEnd");
		} else {
			setSearchDate(term, searchForm+' #goodsSearchSysRegDtmStart', searchForm+' #goodsSearchSysRegDtmEnd');
		}
	}

	/**
	 * [검색] 상품 전시 카테고리 Options 세팅
	 * @param dispLvl
	 * @param upDispClsfNo
	 */
	function createDisplayCategory(dispLvl, upDispClsfNo) {
		var selectCategory = '<option value="" selected="selected"><spring:message code="admin.web.view.common.button.select" javaScriptEscape="true"/></option>';
		if (dispLvl == 0) {
			$('#'+searchForm+' #displayCategory' + (dispLvl+1)).html('');
			$('#'+searchForm+' #displayCategory' + (dispLvl+1)).append(selectCategory);
			$('#'+searchForm+' #displayCategory' + (dispLvl+2)).hide();
			$('#'+searchForm+' #displayCategory' + (dispLvl+3)).hide();
			$('#'+searchForm+' #dispClsfNo').val("");
		} else {
			$('#'+searchForm+' #displayCategory' + (dispLvl)).html('');
			$('#'+searchForm+' #displayCategory' + (dispLvl)).hide();
			$('#'+searchForm+' #displayCategory' + (dispLvl+1)).hide();
			$('#'+searchForm+' #displayCategory' + (dispLvl+2)).hide();

			if (dispLvl == 1) {
				$('#'+searchForm+' #displayCategory' + (dispLvl)).show();
			}

			if (upDispClsfNo != '') {
				var stId = $('select[name=stId]').val();

				var options = {
					url : '<spring:url value="/display/listDisplayCategory.do" />'
					, data : {
						stId : stId
						, dispLvl : dispLvl
						, upDispClsfNo : upDispClsfNo
						, dispClsfCd : '${adminConstants.DISP_CLSF_10 }'
						, dispYn : 'Y'
						//, cfmYn : "${adminConstants.COMM_YN_Y}"   CSR-1127. 2021-06-22 주석처리함.
					}
					, callBack : function(result) {
						if (result.length > 0) {
							$(result).each(function(i){
								selectCategory += "<option value='" + result[i].dispClsfNo + "'>" + result[i].dispClsfNm + "</option>";
							});

							$('#'+searchForm+' #displayCategory' + (dispLvl)).show();
						}
						$('#'+searchForm+' #displayCategory' + (dispLvl)).append(selectCategory);
					}
				};

				ajax.call(options);
			}
		}
	}

	/**
	 * [검색] 업체 검색
	 */
	function searchGoodsCompany () {
		var options = {
			multiselect : false
			, excludeCompTpCd : '${adminConstants.COMP_TP_30}'
			, callBack : searchGoodsCompanyCallback
		}
		layerCompanyList.create (options );
	}

	/**
	 * [검색] 업체 검색 콜백
	 */
	function searchGoodsCompanyCallback (compList ) {
		if(compList.length > 0 ) {
			$('#' + searchForm + ' #compNo').val (compList[0].compNo );
			$('#' + searchForm + ' #compNm').val (compList[0].compNm );
		}
	}

	/**
	 * [검색] 브랜드 검색
	 */
	function selectGoodsBrandSeries (gubun ) {
		var options = null;
		if(gubun == 'brand') {
			options = {
				multiselect : false
				, bndGbCd : '${adminConstants.BND_GB_20 }'
				, useYn : '${adminConstants.COMM_YN_Y }'
				<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
				, compNo : '${adminSession.compNo}'
				, compNm : '${adminSession.compNm}'
				</c:if>
				, callBack : searchGoodsBrandCallback
			}
		} else {
			options = {
				multiselect : false
				, bndGbCd : '${adminConstants.BND_GB_10 }'
				, callBack : searchSeriesCallback
			}
		}
		layerBrandList.create (options );
	}

	/**
	 * [검색] 브랜드 검색 콜백
	 */
	function searchGoodsBrandCallback (brandList ) {
		if(brandList != null && brandList.length > 0 ) {
			$('#' + searchForm + ' #bndNo').val (brandList[0].bndNo );
			$('#' + searchForm + ' #bndNm').val (brandList[0].bndNmKo );
		}
	}

	/**
	 * [검색] 가격종료 상품 체크 이벤트
	 */
	function checkEndSaleYn(obj) {
		if ( $(obj).prop('checked') ) {
			$(obj).addClass('checked');
			$('#'+searchForm+" #goodsSearchCheckOptDate > option[value='']").attr('selected', 'true');
			goodsSearchDateChange();
		} else {
			$(obj).removeClass('checked');
			$('#'+searchForm+' #goodsSearchCheckOptDate > option[value=""]').attr('selected',false);
			$('#'+searchForm+' #goodsSearchCheckOptDate > option[value="${adminConstants.SELECT_PERIOD_20 }"]').prop('selected', true);
			goodsSearchDateChange();
		}
	}

	/**
	 * [검색] 상품 검색 조회
	 * 검색 날리기 전에 데이터 초기화
	 * jQuery('#goodsList').setGridParam({postData: null});
	 */
	function searchGoodsList () {
		<c:if test="${empty popup}">
		if (! isGridExists) {
			createGoodsGrid();
		}
		</c:if>
		compareDateAlertOptions('goodsSearchSysRegDtmStart','goodsSearchSysRegDtmEnd','goodsSearchCheckOptDate');		
		//공통으로 처리
		/*
		if($("#goodsSearchSysRegDtmStart").val() != null && $("#goodsSearchSysRegDtmEnd").val()!=null){
			var starr = $("#goodsSearchSysRegDtmStart").val().split("-");
			var endarr = $("#goodsSearchSysRegDtmEnd").val().split("-");
			var stdate = new Date(starr[0], starr[1], starr[2] );
			var enddate = new Date(endarr[0], endarr[1], endarr[2] );
			var diff = enddate - stdate;
			var diffDays = parseInt(diff/(24*60*60*1000));
			if(diffDays<0){
				messager.alert("등록일 검색기간 시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info" );
				return;
			}
		}
		*/

		//판매 기간 종료된 상품만 검색
		if ($('#'+searchForm+' input:checkbox[id="chkEndSaleYn"]').is(':checked')) {
			$('#'+searchForm+' #endSaleYn').val('Y');
		} else {
			$('#'+searchForm+' #endSaleYn').val('N');
		}

		//삭제 상품만 검색
		if ($('#'+searchForm+' input:checkbox[id="chkDelYn"]').is(':checked')) {
			$('#'+searchForm+' #delYn').val('Y');
		} else {
			$('#'+searchForm+' #delYn').val('N');
		}

		//품절 상품만 검색
		if ($('#'+searchForm+' input:checkbox[id="chkSoldOutYn"]').is(':checked')) {
			$('#'+searchForm+' #soldOutYn').val('Y');
		} else {
			$('#'+searchForm+' #soldOutYn').val('N');
		}

		var options = {
			searchParam : $('#' + searchForm).serializeJson()
		};

 		//검색 날리기 전에 데이터 초기화
		jQuery('#'+ listId).setGridParam({postData: null});
		gridReloadVariableTerm('goodsSearchSysRegDtmStart','goodsSearchSysRegDtmEnd',listId,'goodsSearchCheckOptDate',options);
	}

	/**
	 * [검색] 상품 검색 초기화
	 */
	function searchReset () {
		resetFormIncGoods (searchForm);
		//내부 사용자가 아닐 경우 업체 코드
		<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
			$('#' + searchForm + ' #compNo').val('${adminSession.compNo}');
		</c:if>

		$('#goodsSearchCheckOptDate option[value="${adminConstants.SELECT_PERIOD_40}"]').siblings().prop("selected", false);
		$('#goodsSearchCheckOptDate option[value="${adminConstants.SELECT_PERIOD_40}"]').prop("selected", true);

		goodsSearchDateChange();
	}

	/**
	 *
	 */	// 사이트 Ids 제외 초기화
	function resetFormIncGoods(searchForm) {

		//사이트 아이디 제외
		var resetInput = $('#' + searchForm).find('input, select, textarea').not('input[name=stIds]').not('select[name=stId]');

		//히든값 제외
		resetInput = $(resetInput).not('input[type=hidden]');
		//체크박스는 val('') 을 날리면 안된다.. 제외하고 체크해제만 진행한다
		resetInput = $(resetInput).not('input[type=checkbox]');
		resetInput = $(resetInput).not('input[type=radio]');

		//상품 구성유형 세팅시 제외
		<c:choose>
			<c:when test="${!empty goodsSO.goodsCstrtTpCds}">
			resetInput = $(resetInput).not('input[name=goodsCstrtTpCds]');
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>

		//사은품 가능 세팅시 제외
		<c:choose>
			<c:when test="${!empty goodsSO.goodsCstrtTpCds && !empty goodsSO.frbPsbYn}">
				resetInput = $(resetInput).not('input[name=frbPsbYn]');
			</c:when>
			<c:otherwise>
				//사은품 가능 여부 라디오박스 초기화
				$('#'+searchForm+' input[name=frbPsbYn]').attr('disabled', 'true');
				resetInput = $(resetInput).add('input[name=frbPsbYn]');
			</c:otherwise>
		</c:choose>

		//업체명 미리 세팅시 제외
		<c:choose>
			<c:when test="${!empty goodsSO.compNo}">
				resetInput = $(resetInput).not('input[name=compNo]');
				resetInput = $(resetInput).not('input[name=compNm]');
			</c:when>
			<c:otherwise>
				resetInput = $(resetInput).add('input[name=compNo]');
				resetInput = $(resetInput).add('input[name=compNm]');
			</c:otherwise>
		</c:choose>

		//브랜드 미리 세팅시 제외
		<c:choose>
			<c:when test="${!empty goodsSO.bndNo}">
			resetInput = $(resetInput).not('input[name=bndNo]');
			</c:when>
			<c:otherwise>
				resetInput = $(resetInput).add('input[name=bndNo]');
			</c:otherwise>
		</c:choose>

		//상품 상태 미리 세팅시 제외
		<c:choose>
			<c:when test="${!empty goodsSO.goodsStatCd}">
				resetInput = $(resetInput).not('select[name=goodsStatCd]');
			</c:when>
			<c:otherwise>
				resetInput = $(resetInput).add('select[name=goodsStatCd]');
			</c:otherwise>
		</c:choose>

		//상품 전시 카테고리 콤보박스 Options 세팅시 제외
		<c:choose>
			<c:when test="${category == null }">
				resetInput = $(resetInput).add('input[name=dispClsfNo]');
			</c:when>
			<c:otherwise>
				resetInput = $(resetInput).not('select[name=displayCategory1]');
				resetInput = $(resetInput).not('select[name=displayCategory2]');
				resetInput = $(resetInput).not('select[name=displayCategory3]');
				resetInput = $(resetInput).not('input[name=dispClsfNo]');
			</c:otherwise>
		</c:choose>

		<c:if test="${!empty popup}">
			resetInput = $(resetInput).not('input[name=eptGoodsId]');
		</c:if>

		//노출여부 미리 세팅시 제외
		<c:if test="${!empty goodsSO.showYn}">
			resetInput = $(resetInput).not('select[name=showYn]');
		</c:if>

		//태그 초기화
		$('.searchTags').each(function(i, v){
			no = $(this).data('tag');
			removeTag('tag_'+no, '');
		});

		$(resetInput).val('');

		<c:if test="${empty goodsSO.goodsCstrtTpCds}">
			//상품구성유형 초기화
			$('#' + searchForm + ' input[name=goodsCstrtTpCds]').removeAttr('checked');
		</c:if>

		//상품 카테고리 선택 초기화
		<c:if test="${category == null }">
			$('select[name=displayCategory3]').hide();
			$('select[name=displayCategory2]').hide();
		</c:if>

		<c:if test="${empty goodsSO.goodsCstrtTpCds && empty goodsSO.frbPsbYn}">
			//사은품 가능 여부 라디오박스 초기화
			$('#'+searchForm+' input[name=frbPsbYn]').attr('disabled', 'true');
			$('#' + searchForm + ' input[name=frbPsbYn]:eq(0)').prop('checked', true);
		</c:if>

		//가격유형 라디오 초기화
		$('#' + searchForm + ' input[name=goodsAmtTpCd]:eq(0)').prop('checked', true);
		//아이콘 체크박스 초기화
		$('#' + searchForm + ' input[name=goodsIconCd]').removeAttr('checked');
		//업체 체크박스 초기화
		$('#' + searchForm + ' input[name=compTpCds]').removeAttr('checked');

		//판매기간이 종료된 상품 체크 초기화
		$('#' + searchForm + ' input[name=chkEndSaleYn]').prop('checked', false);
		//삭제 상품 체크 초기화
		$('#' + searchForm + ' input[name=chkDelYn]').prop('checked', false);
		//품절 상품 체크 초기화
		$('#' + searchForm + ' input[name=chkSoldOutYn]').prop('checked', false);
	}

	/**
	 * [검색] 상품 목록 Grid
	 */
	function createGoodsGrid() {
		gridOptions.searchParam = $('#'+searchForm).serializeJson();
		if(gridOptions.loadComplete) {

		} else {
			var ids = $('#' +listId).getDataIDs();

			for (var i = 0; i < ids.length; i++) {
				$('#' +listId).setRowData(ids[i], false, { height : 20 + (i * 2) });
			}
		}

		if(gridOptions.onCellSelect) {

		} else {
			gridOptions.onCellSelect = function (rowId, cellIdx, cellValue) {
				var cellName = $('#' + listId).jqGrid("getGridParam").colModel[cellIdx].name;
				//console.log(cellName);
				if(cellName == 'goodsId') {
					var goodsTpCd = $('#' +listId).jqGrid ('getCell', rowId, 'goodsTpCd');
					viewGoodsDetail(rowId, goodsTpCd );
				} else if(cellName == 'goodsNm') {
					viewFoGoodsDetail(rowId );
				}
			};
		}

		grid.create(listId, gridOptions);
		isGridExists = true;
	}

	/**
	 * [BO] 상품 상세 이동
	 * @param goodsId
	 * @param goodsTpCd
	 */
	function viewGoodsDetail (goodsId, goodsTpCd ) {
		var url = "/goods/goodsDetailView.do?goodsId=" + goodsId;
		if (goodsTpCd == "${adminConstants.GOODS_TP_10 }" ) {
			url = "/goods/goodsDetailView.do?goodsId=" + goodsId;
		} else  if (goodsTpCd == "${adminConstants.GOODS_TP_20 }" ) {	// DEAL
			url = "/goods/goodsDealView.do?goodsId=" + goodsId;
		} else  if (goodsTpCd == "${adminConstants.GOODS_TP_30 }" ) {	// GIFT
			url = "/goods/giftGoodsDetailView.do?goodsId=" + goodsId;
		}

		addTab('상품 상세 - ' + goodsId, url);
	}

	/**
	 * [FO] 상품 상세 이동
	 * @param goodsId
	 */
	function viewFoGoodsDetail (goodsId) {

		var foForm = document.createElement('form');
		foForm.setAttribute('charset', 'UTF-8');
		foForm.setAttribute('method', 'Post');
		foForm.setAttribute('target', '_blank');
		foForm.setAttribute("action", location.protocol + '//<spring:eval expression="@webConfig['site.fo.domain']" />/goods/previewGoodsDetail');

		var hiddenField1 = document.createElement('input');
		hiddenField1.setAttribute('type', 'hidden');
		hiddenField1.setAttribute('name', 'goodsId');
		hiddenField1.setAttribute('value', goodsId);
		foForm.appendChild(hiddenField1);
		var hiddenField2 = document.createElement('input');
		hiddenField2.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'adminId');
		hiddenField2.setAttribute('value', ${adminSession.usrNo});
		foForm.appendChild(hiddenField2);

		document.body.appendChild(foForm);
		foForm.submit();
	}

	/**
	 * [레이어] 할인가격 보기
	 * @param goodsId
	 */
	function fnGoodsPrmtPriceView(goodsId) {
		var options = {
			url : '/goods/goodsPrmtPricePopView.do'
			, data : {
				goodsId : goodsId
			}
			, dataType : "html"
			, callBack : function (html ) {
				var config = {
					id : "goodsPrmtPriceView"
					, width : 900
					, height : 350
					, top : 200
					, title : "상품 프로모션 적용 가격"
					, body : html
				}
				layer.create(config);
			}
		};
		ajax.call(options);
	}
</script>
<style>
    .pd10 {
        padding: 10px
    }
</style>
<spring:message code="admin.web.view.common.button.select" var="selectPh"/>
<table class="table_type1 <c:out value="${popup}"/>">
	<caption><spring:message code="column.statistics.goods.search"/></caption>
	<tbody>
	<tr>
		<!-- 기간 -->
		<th scope="row"><spring:message code="column.sys_reg_dt" /></th>
		<td>
			<frame:datepicker prefixId="goodsSearch" startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${frame:toDate('yyyy-MM-dd')}" endValue="${frame:toDate('yyyy-MM-dd')}"/>
			<spring:message code='admin.web.view.app.goods.search.date' var="searchDatePh"/>
			<select id="goodsSearchCheckOptDate" name="goodsSearchCheckOptDate" onchange="goodsSearchDateChange();">
				<frame:select grpCd="${adminConstants.SELECT_PERIOD }"
				              selectKey="${adminConstants.SELECT_PERIOD }"
				              defaultName="${searchDatePh}"/>
			</select>
		</td>
		<!-- 사이트 ID -->
		<th scope="row"><spring:message code="column.st_id" /></th>
		<td>
			<spring:message code="column.site.select.placeholder" var="selectSitePh"/>
			<select id="stIdCombo" name="stId">
				<frame:stIdStSelect defaultName="${selectSitePh}" />
			</select>
		</td>
	</tr>
	<tr>
		<!-- 업체번호 -->
		<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
		<td>
			<spring:message code="admin.web.view.common.search.company" var="searchCompPh"/>
			<%--disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}"--%>
			<frame:compNo funcNm="searchGoodsCompany"
			              defaultCompNo="${goodsSO.compNo}"
			              defaultCompNm="${goodsSO.compNm}"
			              disableSearchYn="${ !empty goodsSO.compNo? 'Y' : (adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y')}"
			              placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? searchCompPh : ''}"
			/>
			${not empty goodsSO.compNo ? '&nbsp;(' : ''}${not empty goodsSO.compNo ? goodsSO.compNo : ''}${not empty goodsSO.compNo ? ')' : ''}
		</td>
		<!-- 브랜드 -->
		<th scope="row"><spring:message code="column.goods.brnd" /></th>
		<td>
			<c:choose>
				<c:when test="${!empty goodsSO.bndNo}">
					<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="${goodsSO.bndNo}" />
					<input type="text" readonly id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value="${goodsSO.bndNmKo}" />
				</c:when>
				<c:otherwise>
					<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="" />
					<input type="text" readonly id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value=""
					       placeholder="<spring:message code="admin.web.view.app.brand.popup.search.placeholder"/>"/>
					<c:if test="${mallAdminSession}" >
						<button type="button" class="btn" onclick="selectGoodsBrandSeries('brand');" >
							<spring:message code="admin.web.view.common.search"/>
						</button>
					</c:if>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<!-- 상품 상태 -->
		<th scope="row"><spring:message code="column.goods_stat_cd" /></th>
		<td>
			<select id="goodsStatCd" name="goodsStatCd">
				<%--<frame:select grpCd="${adminConstants.GOODS_STAT }" usrDfn2Val="${adminConstants.COMM_YN_Y}" defaultName="${selectPh}" showValue="false" selectKey="${goodsSO.goodsStatCd}" />--%>
				<frame:select grpCd="${adminConstants.GOODS_STAT }" usrDfn2Val="${adminConstants.COMM_YN_Y}" selectKey="${goodsSO.goodsStatCd}" selectKeyOnly="${!empty goodsSO.goodsStatCd ? 'true' : 'false'}" defaultName="${!empty goodsSO.goodsStatCd ? null : selectPh}" />
			</select>
		</td>
		<!-- 상품 구성 유형 -->
		<th scope="row"><spring:message code="column.goods.cstrt.tp.cd"/></th>
		<td>
			<spring:message code="admin.web.view.common.all" var="defalutNameAll"/>
			<c:set var="disabled" value="N" />
			<c:if test="${!empty goodsSO.goodsCstrtTpCds}"><c:set var="disabled" value="Y" /></c:if>
			<frame:checkbox name="goodsCstrtTpCds" grpCd="${adminConstants.GOODS_CSTRT_TP }" excludeOption="${adminConstants.GOODS_CSTRT_TP_ATTR },${adminConstants.GOODS_CSTRT_TP_SET },${adminConstants.GOODS_CSTRT_TP_PAK }" checkedArray="${goodsSO.goodsCstrtTpCds}" disabled="${disabled}"/>
			(
			<input type="radio" name="frbPsbYn" id="frbPsbYnAll" value="" checked="checked" disabled><label for="frbPsbYnAll"><spring:message code="admin.web.view.common.all"/></label>
			<input type="radio" name="frbPsbYn" id="frbPsbYnY" value="Y" disabled><label for="frbPsbYnY"><spring:message code="admin.web.view.app.goods.gift.y"/></label>
			<input type="radio" name="frbPsbYn" id="frbPsbYnN" value="N" disabled><label for="frbPsbYnN"><spring:message code="admin.web.view.app.goods.gift.n"/></label>
			)
			<p/>
			<frame:checkbox name="goodsCstrtTpCds" grpCd="${adminConstants.GOODS_CSTRT_TP }" excludeOption="${adminConstants.GOODS_CSTRT_TP_ITEM }" checkedArray="${goodsSO.goodsCstrtTpCds}" disabled="${disabled}"/>
		</td>
	</tr>
	<tr>
		<!-- 상품 ID -->
		<th scope="row"><spring:message code="column.goods_id" /></th>
		<td>
			<textarea rows="3" cols="30" id="goodsIdArea" name="goodsIdArea" ><c:forEach items="${goodsSO.goodsIds}" var="goodsId" varStatus="st">${goodsId}
				<c:if test="${!st.last}"><% out.println("");%></c:if></c:forEach></textarea>
		</td>
		<!-- 상품 명 -->
		<th scope="row"><spring:message code="column.goods_nm" /></th>
		<td>
			<textarea rows="3" cols="30" id="goodsNmArea" name="goodsNmArea" ><c:forEach items="${goodsSO.goodsNms}" var="goodsNm" varStatus="st">${goodsNm}
				<c:if test="${!st.last}"><% out.println("");%></c:if></c:forEach>
		</textarea>
		</td>
	</tr>
	<tr>
		<!-- 전시 카테고리 -->
		<th scope="row"><spring:message code="column.disp_ctg" /></th>
		<td>
			<c:choose>
				<c:when test="${empty category}">
					<select name="displayCategory1" id="displayCategory1"></select>
					<select name="displayCategory2" id="displayCategory2" style="display: none;"></select>
					<select name="displayCategory3" id="displayCategory3" style="display: none;"></select>
				</c:when>
				<c:otherwise>
					<c:if test="${!empty category.displayCategory1}">
						<select name="displayCategory1" id="displayCategory1">
							<option value="${category.displayCategory1}"><c:out value="${category.displayCategoryNm1}"/></option>
						</select>
					</c:if>
					<c:choose>
						<c:when test="${!empty category.displayCategory2}">
							<select name="displayCategory2" id="displayCategory2">
								<option value="${category.displayCategory2}"><c:out value="${category.displayCategoryNm2}"/></option>
							</select>
						</c:when>
						<c:otherwise><select name="displayCategory2" id="displayCategory2" style="display: none;"></select></c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${!empty category.displayCategory3}">
							<select name="displayCategory3" id="displayCategory3">
								<option value="${category.displayCategory3}"><c:out value="${category.displayCategoryNm3}"/></option>
							</select>
						</c:when>
						<c:otherwise><select name="displayCategory3" id="displayCategory3" style="display: none;"></select></c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

		</td>
		<!-- 상품 노출 여부 -->
		<th scope="row"><spring:message code="column.show_yn" /></th>
		<td>
			<select id="showYn" name="showYn">
				<frame:select grpCd="${adminConstants.SHOW_YN }" showValue="false" selectKey="${goodsSO.showYn}" selectKeyOnly="${!empty goodsSO.showYn ? 'true' : 'false'}" defaultName="${!empty goodsSO.showYn ? null : selectPh}" />
			</select>
		</td>
	</tr>
	<tr>
		<!-- 자체 상품 코드 -->
		<th scope="row"><spring:message code="column.goods.comp.goods.id" /></th>
		<td>
			<textarea rows="3" cols="30" id="compGoodsIdArea" name="compGoodsIdArea"></textarea>
		</td>
		<th scope="row"><spring:message code="admin.web.view.app.goods.extra"/></th>
		<td>
			<!-- 판매기간이 종료된 상품만 -->
			<label class="fCheck"><input type="checkbox" name="chkEndSaleYn" id="chkEndSaleYn" />
				<span><spring:message code="admin.web.view.app.goods.sale.n.only"/></span>
			</label>
			<input type="hidden" name="endSaleYn" id="endSaleYn" value="${goodsSO.endSaleYn }" >

			<!-- 삭제 상품만 -->
			<label class="fCheck"><input type="checkbox" name="chkDelYn" id="chkDelYn" />
				<span><spring:message code="admin.web.view.app.goods.delete.only"/></span>
			</label>
			<input type="hidden" name="delYn" id="delYn" value="${goodsSO.delYn }" >

			<!-- 품절 상품만 -->
			<label class="fCheck"><input type="checkbox" name="chkSoldOutYn" id="chkSoldOutYn" />
				<span><spring:message code="admin.web.view.app.goods.soldout.only"/></span>
			</label>
			<input type="hidden" name="soldOutYn" id="soldOutYn" value="${goodsSO.soldOutYn }" >
		</td>
	</tr>
	<tr>
		<!-- 가격 유형 -->
		<th scope="row"><spring:message code="column.goods.amt.tp.cd"/></th>
		<td colspan="3">
				<label class="fRadio" for="goodsAmtTpCd_default">
					<input type="radio" id="goodsAmtTpCd_default" name="goodsAmtTpCd" value="" checked="checked"/>
					<span><spring:message code="column.goods.no.select"/></span>
				</label>
				<c:if test="${!empty amtTpCodeList}">
					<c:forEach items="${amtTpCodeList}" var="goodsAmtTpCd">
						<label class="fRadio" for="goodsAmtTpCd_<c:out value="${goodsAmtTpCd.dtlCd}"/>">
							<input type="radio" name="goodsAmtTpCd" id="goodsAmtTpCd_<c:out value="${goodsAmtTpCd.dtlCd}"/>" value="<c:out value="${goodsAmtTpCd.dtlCd}"/>"/>
							<span><c:out value="${goodsAmtTpCd.dtlNm}"/></span>
						</label>
					</c:forEach>
				</c:if>
			<frame:datepicker startDate="priceStrtDt" endDate="priceEndDt" startValue="" endValue=""/>
		</td>
	</tr>
	<tr>
		<!-- 아이콘 수동 목록 -->
		<th scope="row"><spring:message code="admin.web.view.app.goods.icon"/></th>
		<td colspan="3">
			<frame:checkbox grpCd="${adminConstants.GOODS_ICON }" name="goodsIconCd" dtlShtNm="${adminConstants.USE_YN_Y}" usrDfn2Val="${adminConstants.USE_YN_N}"/>
		</td>
	</tr>
	<tr <c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}"> style="display:none"</c:if> >
		<th scope="row"><spring:message code="column.comp_tp_cd"/></th>
		<td colspan="3">
			<frame:checkbox grpCd="${adminConstants.COMP_TP }" name="compTpCds"/>
		</td>
	</tr>
	<c:if test="${!empty popup}">
		<tr>
			<!-- 태그 -->
			<th scope="row"><spring:message code="column.vod.tag"/></th>
			<td colspan="3">
				<span id="searchTags"></span>
				<button type="button" class="roundBtn" onclick="tagBaseSearchPop();" >+ <spring:message code="column.common.addition"/></button>
			</td>
		</tr>
	</c:if>
	</tbody>
</table>
