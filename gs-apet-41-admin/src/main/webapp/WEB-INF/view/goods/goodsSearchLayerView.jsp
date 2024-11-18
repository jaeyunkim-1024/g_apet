<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	//목록 ID , 검색Form = 목록 ID + 'Form'
	var listId = 'layerGoodsList';
	var searchForm = listId +'Form';
	var isGridExists = true;

	/**
	 * 상품 구성 유형 추가
	 */
	$(function(){

		<c:if test="${!empty tags}">
			var tagHtml = '';
			<c:forEach items="${tags}" var="tag" varStatus="tagStatus">
				var tagNo = '${tag.tagNo}';
				var tagNm = '${tag.tagNm}';

				tagHtml += '<span class="rcorners1 searchTags" id="tag_'+tagNo+'" data-tag="'+tagNo+'">';
				tagHtml += '<input type="hidden" name="tags" value="'+tagNo+'"/>' + tagNm;
				tagHtml += '</span>';
				tagHtml += '<img id="tag_'+tagNo+'Delete" onclick="removeTag(\'tag_'+tagNo+'\',\''+tagNm+'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
			</c:forEach>
			$("#searchTags").append (tagHtml);
		</c:if>
		<c:if test="${!empty goodsSO.goodsCstrtTpCds}">
			<c:forEach items="${goodsSO.goodsCstrtTpCds}" var="goodsCstrtTpCd" step="1" varStatus="st">
				$('input:checkbox[name=goodsCstrtTpCds][value=${goodsCstrtTpCd}]').prop('checked',true);
				if('${goodsCstrtTpCd}' == '${adminConstants.GOODS_CSTRT_TP_CD_ITEM}') {
					$('input[name=frbPsbYn]').removeAttr('disabled');
				}
			</c:forEach>
			<c:if test="${!empty goodsSO.frbPsbYn}">
				$('input:radio[name=frbPsbYn][value=${goodsSO.frbPsbYn}]').prop('checked', true);
			</c:if>
		</c:if>

		$('#'+searchForm+' input:checkbox[name=goodsCstrtTpCds]').click(function(){
			var checked = $('#'+searchForm+' input:checkbox[name=goodsCstrtTpCds]').eq(0).is(':checked');
			if(checked) {
				$('#'+searchForm+' input[name=frbPsbYn]').removeAttr('disabled');
			} else {
				$('#'+searchForm+' input[name=frbPsbYn]').attr('disabled', 'true');
			}
		});

		$('#'+searchForm+' input:radio[name=frbPsbYn]').click(function(){
			var checked = $(this).val();
			if(checked === '10') {

			} else {

			}
		});
	});
		
	// 사이트 검색
	function searchSt () {
		var options = {
			multiselect : false
			, callBack : searchStCallback
		}
		layerStList.create (options );
	}

	function searchStCallback (stList ) {
		if(stList.length > 0 ) {
			$("#commonPopupStId").val (stList[0].stId );
			$("#commonPopupStNm").val (stList[0].stNm );
			jQuery("#popupDispClsfNo").val("");
			createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
		}
	}

    // 초기화 버튼클릭
    function searchReset() {
		//layerGoodsList.searchReset(); -> resetForm 으로 변경
	    resetFormGoodsSearchLayer();
		$("#eptGoodsId").val("${goodsSO.eptGoodsId }");
        layerGoodsList.searchGoodsList();
        $("#commonPopupStId").val(${goodsSO.stId });
    }

    /**
     *
     */
    // 사이트 Ids 제외 초기화
	function resetFormGoodsSearchLayer() {
		$('#goodsListForm').trigger('reset');

		var resetInput = $('#goodsListForm input[type=hidden]').not('input[name=stIds]');

		<c:choose>
			<c:when test="${empty goodsSO.goodsCstrtTpCds && !empty goodsSO.frbPsbYn}">
				resetInput = $(resetInput).not('input[name=frbPsbYn]');
			</c:when>
			<c:otherwise>
				//사은품 가능 여부 라디오박스 초기화
				$('input[name=frbPsbYn]').attr('disabled', 'true');
			</c:otherwise>
		</c:choose>

		<c:if test="${!empty goodsSO.bndNo}">
		$(resetInput).not('input[name=bndNo]');
		</c:if>

		<c:if test="${!empty goodsSO.goodsCstrtTpCds}">
			//TODO [상품, 이하정, 20210104] 초기화 제외 체크 후 작업 예정
		</c:if>

	    <c:if test="${!empty tags}">
	    //TODO [상품, 이하정, 20210105] 초기화 제외 체크 후 작업 예정
	    </c:if>

	    $('.searchTags').each(function(i, v){
		    no = $(this).data('tag');
		    removeTag('tag_'+no, '');
	    });

		$(resetInput).val('');
	}

	/**
	 * 태그 검색 팝업 호출
	 */
	function tagBaseSearchPop() {
		var options = {
			multiselect : true
			, callBack : function(tags) {

				var searchTags = $('.searchTags').map(function(i, v){
					return $(this).data('tag');
				});

				var tagHtml = '';

				for(var i in tags) {
					var tag = tags[i];
					var flag = searchTags.filter(function (j, v) {
						return v === tag.tagNo;
					}).length > 0;

					if(!flag) {
						tagHtml += '<span class="rcorners1 searchTags" id="tag_'+tag.tagNo+'" data-tag="'+tag.tagNo+'">';
						tagHtml += '<input type="hidden" name="tags" value="'+tag.tagNo+'"/>' + tag.tagNm;
						tagHtml += '</span>';
						tagHtml += '<img id="tag_'+tag.tagNo+'Delete" onclick="removeTag(\'tag_'+tag.tagNo+'\',\''+tag.tagNm+'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
					}
				}

				$("#searchTags").append (tagHtml);
			}
		};
		layerTagBaseList.create(options);
	}

	/**
	 * 태그 삭제
	 * 검색용 tags input box도 같이 삭제
	 * @param no
	 * @param nm
	 */
	function removeTag(no,nm) {
		$('#'+no).empty();
		layerTagBaseList.deleteTag(no, nm);
		//console.log($('#'+no+'Hidden').length);
	}

	/**
	 * 상품 검색
	 * array 파라미터는 세팅해줘야 함
	 */
	function searchGoodsList() {
		if(!document.layerGoodsListForm.stIds) {
			var input = document.createElement("input");
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'stIds');
			document.layerGoodsListForm.appendChild(input);
		}
		//태그 정보가 없을 경우
		if(!document.layerGoodsListForm.tags) {
			var input = document.createElement("input");
			input.setAttribute('type', 'hidden');
			input.setAttribute('name', 'tags');
			document.layerGoodsListForm.appendChild(input);
		}
		layerGoodsList.searchGoodsList();
	}

	/**
	 * 이미지
	 * @param imgPath
	 * @returns {string}
	 */
	function getImage(imgPath) {
		return "<img src='${frame:optImagePath('"+imgPath+"', adminConstants.IMG_OPT_QRY_30)}' alt='' />";
	}

	/**
	 * 상품 아이콘
	 * @returns {string}
	 */
	function getIcons(icons) {

		return '';
	}
</script>

<form id="layerGoodsListForm" name="layerGoodsListForm" method="post" >
	<c:if test="${siteList != null}">
		<c:forEach items="${siteList}" var="site" varStatus="status">
			<input type="hidden" name="stIds" value="${site.stId}"/>
		</c:forEach>
		</select>
	</c:if>
	<input type="hidden" id="dispClsfNo" name="dispClsfNo" value="" />
	<input type="hidden" id="attrYn" name="attrYn" value="${goodsSO.attrYn }" />
	<input type="hidden" id="eptGoodsId" name="eptGoodsId" value="${goodsSO.eptGoodsId }" />
	<spring:message code="admin.web.view.common.button.select" var="selectPh"/>
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsSearchInfo.jsp" />
</form>

<div class="btn_area_center mb30">
	<button type="button" onclick="searchGoodsList();" class="btn btn-ok"><spring:message code="admin.web.view.common.search"/></button>
	<button type="button" onclick="searchReset();" class="btn btn-cancel"><spring:message code="admin.web.view.common.button.clear"/></button>
</div>

<table id="layerGoodsList"></table>
<div id="layerGoodsListPage"></div>
