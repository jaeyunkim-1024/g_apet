<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			.cssGreen {
				color : green
			}
		</style>
		<script type="text/javascript">
		//목록 ID , 검색Form = 목록 ID + 'Form'
		var listId = 'goodsList';
		var searchForm = listId +'Form';
		var gridHid = false;
		<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">
			gridHid = true;
		</c:if>

		var gridOptions = {
			url : "<spring:url value='/goods/goodsBaseGrid.do' />"
			, height : 400
			, searchParam : $('#'+searchForm).serializeJson()
			, multiselect : true
			, colModels : [
				/* 상품 ID */ _GRID_COLUMNS.goodsId_b
				, /* 자체상품코드 */ _GRID_COLUMNS.compGoodsId
				, /* 이미지 */ {name:"imgPath", label:'이미지', width:"220", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.imgPath != "" &&   rowObject.imgPath != undefined ) {
							return "<img src='${frame:optImagePath('"+rowObject.imgPath+"', adminConstants.IMG_OPT_QRY_30)}' alt='' />";
							//return tag.goodsImage(_IMG_URL, rowObject.goodsId, rowObject.imgPath , rowObject.imgSeq, "", "${ImageGoodsSize.SIZE_70.size[0]}", "${ImageGoodsSize.SIZE_70.size[1]}", "hgt40 wth40");
						} else {
							return '<img src="/images/noimage.png" style="width:40px; height:40px;" alt="" />';
						}
					}
				}
				, /* 브랜드명 */ _GRID_COLUMNS.bndNmKo
				, /* 상품명 */ _GRID_COLUMNS.goodsNm_b
				, /* 상품상태 */ _GRID_COLUMNS.goodsStatCd
				, /* 상품 구성 유형 */ _GRID_COLUMNS.goodsCstrtTpCd				
				, /* 재고 */ {name:'webStkQty', label:'재고', width:'100', align:"center", sortable:false, formatter: function(cellValue, options, rowObject) {
						var stk = "";						
						if(rowObject.goodsCstrtTpCd == '${adminConstants.GOODS_CSTRT_TP_ITEM}' || rowObject.goodsCstrtTpCd == '${adminConstants.GOODS_CSTRT_TP_SET}'){
							var cellStk = 0;
							if(cellValue) {
								cellStk = valid.numberWithCommas(cellValue)
							}
							stk = ""+cellStk;
						}else{
							stk = "-";
						}	
						var html = '<p>' + stk + '</p>';				
						return html;
				}}
				, /* 업체 유형 */ {name:'compTpCd', label:"<spring:message code="column.comp_tp_cd" />", width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_TP }' showValue='false' />" } }
				/* 가격 start */
				, /* 가격 유형 */ {name:'goodsAmtTpCd', label:_GOODS_SEARCH_GRID_LABEL.goodsAmtTpCd, width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_AMT_TP }' showValue='false' />" } } /* 상품 금액 유형 */
				, /* 현재가 시작일시 */ {name:'priceSaleStrtDtm', label:'현재가 시작일자', align:'center', sortable:false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }' }
				, /* 현재가 종료일시 */ {name:'priceSaleEndDtm', label:'현재가 종료일자', align:'center', sortable:false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }' }
				, /* 정상가 */ {name:'orgSaleAmt', label:'정상가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
						var rowId = options.rowId;
						var orgSaleAmt = 0;
						if(cellValue) {
							orgSaleAmt = valid.numberWithCommas(cellValue)
						}
						var html = '<p style="width:150px;padding:3px 8px;text-align:right;">' + orgSaleAmt + ' 원</p>';
						//var html = orgSaleAmt + ' 원';
						//html += '<br/><br/>';
						html += '<input type="text" id="'+rowId+'_orgSaleAmt" name="orgSaleAmt" value="'+orgSaleAmt+'" onkeyup="fnWithCommas(\''+rowId+'\', this)" style="text-align:right;<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">display:none</c:if>"/>';

						return html;
				}}
				, /* 원 정상가 */ {name:'org_orgSaleAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
						return rowObject.orgSaleAmt;
				}}
				, /* 매입가(공급가) */ {name:'splAmt', label:'매입가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
						var rowId = options.rowId;
						var splAmt = 0;
						if (cellValue) {
							splAmt = valid.numberWithCommas(cellValue)
						}
						var html = '<p style="width:150px;padding:3px 8px;text-align:right;">' + splAmt + ' 원</p>';
						//html += '<br/><br/>';
						html += '<input type="text" id="'+rowId+'_splAmt" name="splAmt" value="' + splAmt + '" onkeyup="fnWithCommas(\''+rowId+'\', this)" style="text-align:right;<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">display:none</c:if>"/>';
						return html;
				}}
				, /* 원 매입가(공급가) */ {name:'org_splAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
						return rowObject.splAmt;
				}}
				, /* 적용방식 */ {name:'fvrAplyMeth', label:'<spring:message code="column.fvr_apl_meth_cd" />', width:'100',  hidden : gridHid, formatter:function(cellValue, options, rowObject) {
					var rowId = options.rowId;
					var html = '<select name="fvrAplyMeth" style="width: 80px" onchange="changeFvrAplyMeth(\''+rowId+'\', this)" >';
					html += '<frame:select grpCd="${adminConstants.FVR_APL_METH }" defaultName="선택" showValue="false"/>';
					html += '</select>';
					return html;
				}}
				, /* 가격변경 */ {name:'calPrice', label:'가격변경', width:'200', sortable:false, hidden : gridHid, formatter: function(cellValue, options, rowObject) {
					var rowId = options.rowId;
					return '<input type="text" id="'+rowId+'_calPrice" name="calPrice" value="" disabled onkeyup="fnWithCommas(\''+rowId+'\', this)" style="text-align:left;width:60%"/>&nbsp;<span id="' + rowId + '_unit"/>';
				}}
				, /* 판매가 */ {name:'saleAmt', label:'판매가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
					var rowId = options.rowId;
					var saleAmt = 0;
					if (cellValue) {
						saleAmt = valid.numberWithCommas(cellValue)
					}

					//var html = saleAmt + ' 원';
					var html = '<p style="width:150px;padding:3px 8px;text-align:right;">' + saleAmt + ' 원</p>';
					//html += '<br/><br/>';
					html += '<input type="text" id="'+rowId+'_saleAmt" name="saleAmt" value="' + saleAmt + '" onkeyup="fnWithCommas(\''+rowId+'\', this)" style="text-align:right;<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">display:none</c:if>"/>';
					return html;
				}}
				, /* 원 판매가 */ {name:'org_saleAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
						return rowObject.saleAmt;
				}}
				//, /* 판매가 */ {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"90", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' <spring:message code="column.goods.price.unit.won"/>', thousandsSeparator:','} } /* 판매가 */
				, {name:'rate', label:'이익율', width:'90', align:'center', sortable:false, formatter:function(cellValue, options, rowObject) {
						if(cellValue != undefined) {
							return cellValue + '%';
						} else {
							var saleAmt = rowObject.saleAmt;
							var splAmt = rowObject.splAmt;
							var rate = ((saleAmt - splAmt) / saleAmt * 100).toFixed(2);
							return rate + '%';
						}
					}
				}
				/* , 할인가  20210225 프로모션 x 할인가 주석처리
				{name:"button", label:'<spring:message code="column.goods.price.dc"/>', width:"90", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
						var str = '<button type="button" onclick="fnGoodsPrmtPriceView(\'' + rawObject.goodsId + '\')" class="btn_h25_type1"><spring:message code="column.goods.price.show"/></button>';
						return str;
				}}*/
				/* 가격 end */
				, /* 판매 시작일시 */ {name:"saleStrtDtm", label:"<spring:message code='column.sale_strt_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
				, /* 판매 종료일시 */ {name:"saleEndDtm", label:"<spring:message code='column.sale_end_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
				, /* 업체명 */ _GRID_COLUMNS.compNm
				, /* 제조사 */ {name:"mmft", label:"<spring:message code='column.mmft' />", width:"120", align:"center", sortable:false }
				/* 아이콘 */
				<c:if test="${iconCodeList != ''}">
					<c:forEach items="${iconCodeList}" var="icon" varStatus="status">
					, /* 아이콘 */ {name:'${icon.dtlShtNm}', label:'${icon.dtlShtNm}', width:"90", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var checked = (rowObject.icons == null) ? '' : ((rowObject.icons.search('${icon.dtlCd}') > -1 )? 'checked' : '');
							var disabled = '';
							<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
								disabled = 'disabled';
							</c:if>

							return '<input type="checkbox" name="chkIconCodes" value="${icon.dtlCd}" '+checked+' '+disabled+'/>';
						}}
					</c:forEach>
					, {name:"goodsIcons", label:"<spring:message code='column.icon' />", hidden: true, formatter: function(cellvalue, options, rowObject) {
						var goodsIcons = [];
						<c:forEach items="${iconCodeList}" var="icon" varStatus="status">
						if(rowObject.icons != null && rowObject.icons.search('${icon.dtlCd}') > -1 ) {
							goodsIcons.push('${icon.dtlCd}');
						}
						</c:forEach>
						return goodsIcons.join(',');
					}}
				</c:if>
				, /* 아이콘 변경 체크 상품 ID */ {name:'changeGoodsId', hidden:true, formatter: function(cellvalue, options, rowObject) {
						return (rowObject.icons == null) ? '' : rowObject.goodsId;
					}}
				, /* 노출여부 */ {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } }
				, /* 등록자 */ _GRID_COLUMNS.sysRegrNm
				, /* 등록일시 */ _GRID_COLUMNS.sysRegDtm
				, /* 수정자 */ _GRID_COLUMNS.sysUpdrNm
				, /* 수정일시 */ _GRID_COLUMNS.sysUpdDtm
				, /* 비고 */ {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false }
				, /* CIS NO */ {name:"cisNo", label:"cisNo", hidden: true }
			]
			, loadComplete : function(data) {
				//데이터 없을 경우에도 스크롤
				if($(this).jqGrid('getGridParam', 'reccount') == 0){
					$(".jqgfirstrow").css("height","1px");
				}

				var grid = $('#' +listId),
					ids = grid.getDataIDs();

				for (var i = 0; i < ids.length; i++) {
					grid.setRowData(ids[i], false, { height : 20 + (i * 2) });
				}

				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
					//상품 아이콘 체크 이벤트
					$('input[name="chkIconCodes"]').click(function(){
						var rowId = $(this).closest('tr').attr('id');
						$('input[name="chkIconCodes"]').click(function(){
							checkIcons(rowId);
						});
					});
				</c:if>
			}
			, onCellSelect : function (id, cellidx, cellvalue) {
				if(cellidx == 1) {
					var goodsTpCd = $('#'+listId).jqGrid ('getCell', id, 'goodsTpCd');
					viewGoodsDetail(id, goodsTpCd );
				} else if(cellidx == 5) {
					viewFoGoodsDetail(id );
				} else if(cellidx > 19) {
					//상품 아이콘 체크 이벤트
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
						checkbox = $('#'+listId + ' tr[id='+id+'] > td').eq(cellidx).find('input[name=chkIconCodes]');
						$(checkbox).prop('checked', !$(checkbox).is(':checked'));
						checkIcons(id);
					</c:if>
				}
			}
		}

		$(document).ready(function() {

			var icons = [];
			<c:forEach items="${iconCodeList}" var="icon" varStatus="status">
			icons.push('${icon.dtlShtNm}');
			</c:forEach>
			var prices = [
				'goodsAmtTpCd'
				, 'priceSaleStrtDtm'
				, 'priceSaleEndDtm'
				, 'splAmt'
				, 'orgSaleAmt'
				, 'saleAmt'
				, 'fvrAplyMeth'
				, 'calPrice'
				, 'button'
				, 'rate'
			];
			var stat = ['goodsStatCd'];
			var rate = [];
			var showYn = ['showYn'];

			/**
			 * [일괄변경][조건]항목에 따라 컬럼 hide /show
			 * 가격 : 정상가, 매입가, 판매가, 할인율 등
			 * 승인 :
			 * 노출 : showYn
			 * 이모티콘 : icons

			$('#goodsUpdateGb').change(function() {
				var goodsUpdateGb = $(this).val();
				if(goodsUpdateGb == '') {
					var showCol = icons.concat(stat, prices, rate, showYn);
					var rowids = $('#' + listId).jqGrid('getDataIDs');

					$('#' + listId).jqGrid('showCol',showCol);

					$.each(rowids, function(i, goodsId){
						$('#' + listId).jqGrid('setCell', goodsId, 'goodsStatCd', '', {'color': ''});
						$('#' + listId).jqGrid('setCell', goodsId, 'showYn', '', {'color': ''});
					});
				} else {
					var hideCol = icons.concat(stat, prices, rate, showYn);
					$('#' + listId).jqGrid('hideCol',hideCol);

					var rowids = $('#' + listId).jqGrid('getDataIDs');

					//승인
					if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_APPR }'){
						$('#' + listId).jqGrid('showCol',stat);
						$.each(rowids, function(i, goodsId){
							$('#' + listId).jqGrid('setCell', goodsId, 'goodsStatCd', '', {'color': 'red'});
						});
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_STAT }'){
						$('#' + listId).jqGrid('showCol',stat);
						$.each(rowids, function(i, goodsId){
							$('#' + listId).jqGrid('setCell', goodsId, 'goodsStatCd', '', {'color': 'red'});
						});
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_ICON }'){
						$('#' + listId).jqGrid('showCol', icons);
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_PRICE }'){
						$('#' + listId).jqGrid('showCol', prices);
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_SHOW }'){
						$('#' + listId).jqGrid('showCol', showYn);
						$.each(rowids, function(i, goodsId){
							$('#' + listId).jqGrid('setCell', goodsId, 'showYn', '', {'color': 'red'});
						});
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_RATE }'){
						$('#' + listId).jqGrid('showCol', rate);
						//$.each(rowids, function(i, goodsId){ $('#' + listId).jqGrid('setCell', goodsId, 'rate', '', {'color': 'red'}); });
					}
				}
			}) */
		});

		/**
		 * [GRID] get cell value with rowId
		 * @param rowId
		 * @param cellId
		 * @returns {string}
		 */
		function getCellValue(rowId, cellId) {
			var cell = $('#' + rowId + '_' + cellId);
			var val = '';
			if(!cell) {
			} else {
				val = cell.val();
				if(val == undefined) {
					val = $("#goodsList").jqGrid ('getCell', rowId, cellId);
				}
			}
			return val.replace(/\s/gi, '').replace(/,/gi, '');
		}

		/**
		 * [GRID][가격변경] 가격적용방식 변경
		 * FVR_APL_METH_10 : 정율, FVR_APL_METH_20 : 정액
		 */
		function changeFvrAplyMeth(rowId, obj) {
			var name = $(obj).attr('name');
			var idx = $('select[name='+name+']').index($(obj));
			var val = $(obj).val();

			$('#'+rowId + '_calPrice').attr('disabled', 'true');
			$('#'+rowId + '_unit').text('');

			//변경할때 새로 세팅하도록
			$('#'+rowId + '_calPrice').val(0);

			//정율 선택
			if(val== '${adminConstants.FVR_APL_METH_10 }') {
				$('#'+rowId + '_calPrice').removeAttr('disabled');
				$('#'+rowId + '_unit').text(' % 할인');
			} else if(val== '${adminConstants.FVR_APL_METH_20 }') {
				//정액 선택
				$('#'+rowId + '_calPrice').removeAttr('disabled');
				$('#'+rowId + '_unit').text(' 원 할인');
			} else {
				$('#'+rowId + '_calPrice').val(0);
				fnWithCommas(rowId, $('#'+rowId + '_calPrice'));
			}
		}

		/**
		 * [GRID][가격변경] set cell value with comma
		 * 금액 3자리수 , 표시
		 * 정상가, 매입가, 판매가 변경 항목 color red
		 * 이익율 계산 후 목록에 표시
		 * @param rowId
		 * @param obj
		 */
		function fnWithCommas(rowId, obj) {
			var name = $(obj).attr('name');
			var idx = $('input[name='+name+']').index($(obj));
			var val = $(obj).val();
			var orgValue = $('#'+listId).jqGrid ('getCell', rowId, 'org_'+name);
			var objName = $(obj).attr('name');

			if(val) {
				val = val.replace(/[^0-9]/g, "");
				$(obj).val(valid.numberWithCommas(val)) ;
				if(objName != 'calPrice') {
					if(orgValue == val) {
						$(obj).removeAttr('style');
					} else {
						$(obj).attr('style','color:red');
					}
				}
			} else {
				$(obj).val(val) ;
			}

			var splAmt = getCellValue(rowId, 'splAmt');         //정상가
			var org_splAmt = getCellValue(rowId, 'org_splAmt'); //정상가
			var orgSaleAmt = getCellValue(rowId, 'orgSaleAmt'); //매입가
			var org_orgSaleAmt = getCellValue(rowId, 'org_orgSaleAmt'); //매입가
			var saleAmt = getCellValue(rowId, 'saleAmt');       //판매가
			var org_saleAmt = getCellValue(rowId, 'org_saleAmt');//판매가
			var calPrice = getCellValue(rowId, 'calPrice');     //가격변경

			//정율/정액 계산하여 판매가 계산하기
			var fvrAplyMeth = $('select[name=fvrAplyMeth]').eq(idx).val();
			if(fvrAplyMeth) {
				if(fvrAplyMeth == '${adminConstants.FVR_APL_METH_10 }') {
					//정상가에서 정률 계산하여 판매가
					var calValue = Math.ceil((Number(org_orgSaleAmt) * (Number(calPrice) / 100)) / 10) * 10;
					saleAmt = Number(org_saleAmt) - calValue;
					//계산하여 -일 경우 0 세팅
					if(saleAmt < 0) {
						saleAmt = 0;
					}
				}

				if(fvrAplyMeth == '${adminConstants.FVR_APL_METH_20 }') {
					//정상가에서 정액 계산하여 판매가
					saleAmt = Number(org_orgSaleAmt) - Number(calPrice);
					//계산하여 -일 경우 0 세팅
					if(saleAmt < 0) {
						saleAmt = 0;
					}
				}

				$('#'+rowId+'_saleAmt').val(valid.numberWithCommas(saleAmt));
				var orgSaleAmt = $('#'+listId).jqGrid ('getCell', rowId, 'org_saleAmt');
				if(saleAmt == orgSaleAmt) {
					$('#'+rowId+'_saleAmt').removeAttr('style');
				} else {
					$('#'+rowId+'_saleAmt').attr('style','color:red');
				}
			}
			
			saleAmt = Number(saleAmt);
			splAmt = Number(splAmt);
			
			//이익율 계산 = (판매가-매입가)/판매가
			rate =  ((saleAmt - splAmt) / saleAmt * 100).toFixed(2);
			
			if(rate == 'NaN' || rate == '-Infinity') {
				rate = '0';
			}
			$('#'+listId).jqGrid('setCell', rowId, 'rate', rate);
		}

		/**
		 * [GRID][아이콘] 체크 박스
		 */
		function checkIcons(rowId) {
			var flag = false;
			var chkIconCodes = $('#' + rowId + ' input:checkbox[name=chkIconCodes]');

			$.each(chkIconCodes, function (i, v) {
				if ($(v).prop('checked')) {
					flag = true;
				}
			})

			var chk = $("input:checkbox[id='jqg_goodsList_" + rowId + "']").is(':checked');

			if (flag) {
				if (chk) {
					$('#' + listId).jqGrid('setSelection', rowId, flag);
				} else {
				}
			} else {
				var changedGoodsId = $('#' + listId).jqGrid('getRowData', rowId).changeGoodsId;
				if (changedGoodsId != '') {
					if (chk) {
						$('#' + listId).jqGrid('setSelection', rowId, true);
					} else {
					}
				} else {
					if (chk) {

					} else {
						$('#' + listId).jqGrid('setSelection', rowId, flag);
					}
				}
			}
		}

		/**
		 * [복사][버튼] 후기 복사
		 * 1개만 가능
		 *goodsCommentCopyProc
		 *
		 */
		function copyGoodsComment() {
			var grid = $('#' + listId);
			var goodsId = "";

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.copy.no_select' />", "Info", "info");
				return;
			}

			if(rowids.length > 1 ) {
				messager.alert("<spring:message code='column.common.copy.multi_select' />", "Info", "info");
				return;
			}

			goodsId = rowids[0];

			var stId = $("#stIdCombo option:selected").val();

			var options = {
				url : "<spring:url value='/goods/goodsCommentCopyLayerView.do' />"
				, data : {goodsId : goodsId, stId:stId }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "goodsCommentCopy"
						, width : 600
						, height : 250
						, top : 200
						, title : '상품 후기 복사'
						, body : data
						, button : "<button type=\"button\" onclick=\"goodsCommentCopyProc();\" class=\"btn btn-ok\"><spring:message code="admin.web.view.app.goods.button.copy" javaScriptEscape="true"/> </button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

		/**
		 * [복사] 후기 복사
		 */
		function goodsCommentCopyProc() {
			messager.confirm("<spring:message code='column.common.confirm.copy' />",function(r){
				if(r){
					if(validate.check("goodsCommentCopyForm") ) {
						var options = {
							url : "<spring:url value='/goods/goodsCommentCopy.do' />"
							, data : $("#goodsCommentCopyForm").serializeJson()
							, callBack : function(data ) {
								var msg = "<spring:message code='admin.web.view.app.goods.comment.copy.done' arguments='"+data.result+"'/>";
								if(data.dupCount>0) {
									msg = "<spring:message code='admin.web.view.app.goods.comment.copy.except' arguments='"+data.dupCount+"'/> " + msg;
								}
								messager.alert(msg, "Info", "info", function(){
									searchGoodsList ();
									layer.close ("goodsCommentCopy" );
								});
							}
						};
						ajax.call(options);
					}
				}
			});
		}

		/**
		 * [레이어] 상품 검색
		 */
		function goodsLayerView() {
			var stId = $("#stIdCombo option:selected").val();
			var fstGoodsId = $('#goodsCommentCopyForm #copyTargetGoodsId').val();

			var options = {
				multiselect : false
				, callBack : function(newGoods) {
					if(newGoods != null) {
						if(newGoods[0].goodsCstrtTpCd != "${adminConstants.GOODS_CSTRT_TP_ITEM}" && newGoods[0].goodsCstrtTpCd != "${adminConstants.GOODS_CSTRT_TP_SET}") {
							messager.alert("<spring:message code='admin.web.view.app.goods.comment.copy.available.item.set'/>", "Info", "info");
						}else if(fstGoodsId == newGoods[0].goodsId) {
							messager.alert("<spring:message code='admin.web.view.app.goods.comment.copy.no.same'/>", "Info", "info");
						}else{
							$("#fstGoodsId").val(newGoods[0].goodsId);
							$("#fstGoodsNm").val(newGoods[0].goodsNm);
						}
					}
				}
				, stIds : stId
				, fstGoodsId : fstGoodsId
				, goodsCstrtTpCds : ['${adminConstants.GOODS_CSTRT_TP_ITEM}', '${adminConstants.GOODS_CSTRT_TP_SET}']
				, disableAttrGoodsTpCd : true
			};
			layerGoodsList.create(options);
		}

		/**
		 * [복사][버튼] 상품 복사
		 * 단품만 가능
		 * 상품명 : [복사] 상품명
		 */
		function copyGoods() {
			var grid = $('#' + listId);
			var goodsId = "";

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.copy.no_select' />", "Info", "info");
				return;
			}

			if(rowids.length > 1 ) {
				messager.alert("<spring:message code='column.common.copy.multi_select' />", "Info", "info");
				return;
			}

			goodsId = rowids[0];
			var goodsCstrtTpCd = grid.jqGrid('getRowData', goodsId).goodsCstrtTpCd;

			// 상품 단품일 때만 복사 가능 20210121
			if(goodsCstrtTpCd != '${adminConstants.GOODS_CSTRT_TP_ITEM}') {
				messager.alert("<spring:message code='column.common.copy.only.item' />", "Info", "info");
				return;
			}

			var stId = $("#stIdCombo option:selected").val();

			var options = {
				url : "<spring:url value='/goods/goodsCopyLayerView.do' />"
				, data : {goodsId : goodsId, stId:stId }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "goodsCopy"
						, width : 600
						, height : 370
						, top : 200
						, title : '<spring:message code="admin.web.view.app.goods.copy" javaScriptEscape="true"/>'
						, body : data
						, button : "<button type=\"button\" onclick=\"goodsCopyProc();\" class=\"btn btn-ok\"><spring:message code="admin.web.view.app.goods.button.copy" javaScriptEscape="true"/> </button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

		/**
		 * [복사] 상품 복사
		 */
		function goodsCopyProc() {
			if(validate.check("goodsCopyForm") ) {
				messager.confirm("<spring:message code='column.common.confirm.copy' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/goodsCopy.do' />"
							, data : $("#goodsCopyForm").serializeJson()
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.copy.goods.final_msg' arguments='" + data.goodsId + "' />", "Info", "info", function(){
									searchGoodsList ();
									layer.close ("goodsCopy" );
								});
							}
						};
						ajax.call(options);
					}
				});
			}
		}

		/**
		 * [상품등록][버튼] 상품 등록
		 */
		function registGoods() {
			goUrl ('<spring:message code="admin.web.view.app.goods.insert" javaScriptEscape="true"/>', "<spring:url value='/goods/ITEM/goodsInsertView.do' />");
		}

		/**
		 * [일괄변경][버튼] 상품 일괄 변경
		 * [일괄변경][아이콘] 아이콘의 경우 바로 저장
		 */
		function updateGoodsBulk() {
			var grid = $('#' + listId);
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
				return;
			}

			var goodsUpdateGb = $("#goodsUpdateGb").children("option:selected").val();
			if (goodsUpdateGb == '') {
				messager.alert("<spring:message code='column.common.goods.update.gb' />", "Info", "info");

				$("#goodsUpdateGb").focus();
				return;
			}

			//상품 삭제일 경우
			if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_REMOVE }" ){
				messager.confirm("<spring:message code='admin.web.view.app.goods.confirm.update.remove' />",function(r) {
					if (r) {
						var goodsIds = new Array();
						var grid = $('#' + listId);
						var selectedIDs = grid.getGridParam ("selarrrow");
						for (var i = 0; i < selectedIDs.length; i++) {
							goodsIds.push (selectedIDs[i] );
						}

						var sendData = {
							goodsIds : goodsIds
							, goodsUpdateGb:goodsUpdateGb
							, goodsStatCd : '${adminConstants.GOODS_STAT_70}'
							, showYn : null
						};
						var url = '<spring:url value="/goods/goodsBulkUpdate.do" />';

						var options = {
							url : url
							, data : sendData
							, callBack : function(data ) {
								messager.alert("<spring:message code='admin.web.view.app.goods.update.remove.result.msg' arguments='"+data.successCnt+"'/>", "Info", "info", function(){
									searchGoodsList ();
								});
							}
						};
						ajax.call(options);
					}
				});
			} else if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_ICON }" ){

				var flag = true;

				$.each(rowids, function(i, goodsId) {
					var goodsIcons = (grid.jqGrid('getRowData', goodsId).goodsIcons).split(',');
					var checkboxes = $('#' + goodsId + ' input:checkbox[name=chkIconCodes]:checked');
					var codes = new Array();

					//기존 아이콘이 없을 경우
					if(goodsIcons == null || goodsIcons == '') {
						//체크된 아이콘도 없다면 리턴 (변경 x)
						if(checkboxes.length < 1) {
							flag = false;
						} else {
						}
					} else {
						//기존 아이콘이 있을 경우 변경 ㅇ

						//체크된 아이콘 값 세팅
						$.each(checkboxes, function(){
							codes.push($(this).val());
						});

						//길이가 다를 경우, 변경 ㅇ
						if(goodsIcons.length != codes.length) {
						} else {
							var codeIdx = 0;
							//체크된 아이콘과 기존 아이콘 비교
							$.each(codes, function( key, value ) {
								//var incYn = icons.includes(value);
								codeIdx ++;
								var idx = $.inArray(value, goodsIcons);
								if(idx > -1) {
									//1 체크박스 아이콘 - 기존 아이콘에 있을 경우
									flag = false;
								} else {
									//1 체크박스 아이콘 - 기존 아이콘에 없을 경우
								}
							});
						}
					}
				});

				if(!flag) {
					messager.alert("<spring:message code="admin.web.view.msg.goods.invalidate.not.changed" javaScriptEscape="true"/>", "Error", "error");
					return;
				}

				//아이콘 저장일 경우
				messager.confirm("<spring:message code='admin.web.view.app.goods.confirm.update.icons' />",function(r){
					if(r){

						var sendData = [];

						$.each(rowids, function(i, goodsId){
							var icons = grid.jqGrid('getRowData', goodsId).icons;
							var checkboxes = $('#' + goodsId + ' input:checkbox[name=chkIconCodes]:checked');
							var codes = new Array();

							$.each(checkboxes, function(){
								codes.push($(this).val());
							});

							var goods = {
								goodsId : goodsId
								, codes: codes
							};

							sendData.push(goods);
						});

						var options = {
							url : "<spring:url value='/goods/saveGoodsIcon.do' />"
							, data : JSON.stringify(sendData)
							, contentType : 'application/json'
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									searchGoodsList ();
								});
							}
						};
						ajax.call(options);

					} else {}
				});

			} else {
				var cisFlag = true;
				//CIS NO가 없을 경우 상품 상태 X
				if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_STAT }' || goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_SHOW }'){
					$.each(rowids, function(i, goodsId) {
						var cisNo = grid.jqGrid('getRowData', goodsId).cisNo;
						var goodsCstrtTpCd = grid.jqGrid('getRowData', goodsId).goodsCstrtTpCd;
						if(goodsCstrtTpCd == '${adminConstants.GOODS_CSTRT_TP_ITEM}') {
							if(cisNo == '' || cisNo < 1) {
								cisFlag = false;
								return false;
							}
						}
					});

					if(!cisFlag) {
						messager.alert("CIS 상품번호가 생성되지 않은 상품이 포함되어 있습니다", "Info", "info");
						return;
					}
				}

				//상품 승인일 경우 판매중, 판매중지, 판매종료는 x
				var passYN = true;
				if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_APPR }'){
					var goodsStatCd = 0;
					$.each(rowids, function(i, goodsId){
						goodsStatCd = parseInt(grid.jqGrid('getRowData', goodsId).goodsStatCd);
						if('${adminConstants.GOODS_STAT_40}' == goodsStatCd
								|| '${adminConstants.GOODS_STAT_50}' == goodsStatCd
								|| '${adminConstants.GOODS_STAT_60}' == goodsStatCd
								|| '${adminConstants.GOODS_STAT_70}' == goodsStatCd
						){
							passYN = false;
							return false;
						}
					});
				}

				//판매종료, 삭제일 경우 일괄 변경 불가
				if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_STAT }'){
					$.each(rowids, function(i, goodsId){
						var goodsStatCd = parseInt(grid.jqGrid('getRowData', goodsId).goodsStatCd);
						if('${adminConstants.GOODS_STAT_60 }' == goodsStatCd
							|| '${adminConstants.GOODS_STAT_70}' == goodsStatCd
						){
							passYN = false;
							return false;
						} else {
							return true;
						}
					});
				}

				//금액변경 없을 경우 경우 일괄 변경 불가
				if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_PRICE }'){
					// 금액 변동 없을 경우 알림
					$('#'+listId +' tr').css('color', 'black');

					if(!validatePrice()) {
						passYN = false;
					}
				}

				if(passYN){
					goodsBulkUpdateLayerView (goodsUpdateGb );
				} else {
					if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_APPR }'){
						messager.alert("<spring:message code='column.common.appr.no_obj' javaScriptEscape="true"/>", "Info", "info");
						return;
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_STAT }'){
						messager.alert("<spring:message code='admin.web.view.app.goods.update.stat.not.allowed' javaScriptEscape="true"/>", "Info", "info");
						return;
					} else if(goodsUpdateGb == '${adminConstants.GOODS_BULK_UPDATE_PRICE }'){
						messager.alert("<spring:message code="admin.web.view.msg.goods.invalidate.price.not.changed" javaScriptEscape="true"/>", "Error", "error");
						return;
					}
				}
			}
		}

		/**
		 * [일괄변경][레이어] 일괄 변경 레이어
		 */
		function goodsBulkUpdateLayerView (goodsUpdateGb ) {
			var titles = "<spring:message code="admin.web.view.app.goods.update" javaScriptEscape="true"/>";

			if (goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_RATE }" ){
				titles = "<spring:message code="admin.web.view.app.goods.update.rate" javaScriptEscape="true"/>";
			}

			var width = 600;
			var height = 300;

			if (goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_PRICE }" ){
				width = 1000;
				height = 320;
			}

			var options = {
				url : '<spring:url value="/goods/goodsBulkUpdateLayerView.do" />'
				, data : {goodsUpdateGb : goodsUpdateGb }
				, dataType : 'html'
				, callBack : function (data ) {
					var config = {
						id : 'goodsUpdate'
						, width : width
						, height : height
						, top : 200
						, title : titles
						, body : data
						, button : '<button type="button" onclick="goodsBulkUpdateProc(\''+goodsUpdateGb+'\');" class="btn btn-ok"><spring:message code="admin.web.view.common.button.ok" javaScriptEscape="true"/>'
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

		/**
		 * [일괄변경] 일괄 변경
		 */
		function goodsBulkUpdateProc (goodsUpdateGb ) {
			var confirm = '<spring:message code="column.common.confirm.batch_update" javaScriptEscape="true" />';

			if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_PRICE }" ) {
				// 현재시간보다 이전 시간의 경우 변경 불가능
				// 가격 적용 시작일시가 현재 시간보다 느릴 경우 알림
				// 금액 구성 유형 = 일반 제외 -> 종료일자 체크
				// [일괄변경][조건] 가격 시작일자, 종료일자 비교 체크
				if(!validateDateTime()) {
					return false;
				}

				confirm = '<spring:message code="admin.web.view.app.goods.confirm.update.price" javaScriptEscape="true" />';

			}

			messager.confirm(confirm, function(r) {
				if(r){
					var goodsIds = new Array();
					var grid = $('#' + listId);
					var selectedIDs = grid.getGridParam ("selarrrow");
					for (var i = 0; i < selectedIDs.length; i++) {
						goodsIds.push (selectedIDs[i] );
					}
		
					var sendData = {
						  goodsIds : goodsIds
						, goodsUpdateGb:goodsUpdateGb
						, goodsStatCd : null
						, webMobileGbCd : null
						, showYn : null
					};

					var url = '<spring:url value="/goods/goodsBulkUpdate.do" />';

					//상품승인
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_APPR }" ) {
						//상품 승인
						var goodsStatCd = $("#goodsBulkUpdateForm :radio[name=goodsStatCd]:checked").val();
						if(goodsStatCd == "${adminConstants.GOODS_STAT_30 }" && $("#goodsBulkUpdateForm #bigo").val() == "") {
							// 승인거절 & 승인사유 빈값일 경우 알림
							messager.alert("<spring:message code='column.goods_reject_noreason' />", "Info", "info");
							return;
						}
						sendData = $.extend({}, sendData
							, {goodsStatCd : goodsStatCd
							, bigo : $("#goodsBulkUpdateForm #bigo").val()
						});
					}
					//상품상태
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_STAT }" ) {
						sendData = $.extend({}, sendData, {goodsStatCd : $("#goodsBulkUpdateForm #goodsStatCd").val() } );

					}
					//노출여부
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_SHOW }" ) {
						//상품 노출 여부
						sendData = $.extend({}, sendData, {showYn: $("#goodsBulkUpdateForm #showYn").val()});
					}
					//수수료율
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_RATE }" ) {
						//수수료율 변경
						sendData = $.extend({}, sendData
							, {cmsRate : $("#goodsBulkUpdateForm #cmsRate").val()
								, stId : $("#stIdComboCms option:selected").val()
							});
					}
					//웹 모바일 구분
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_DEVICE }" ) {
						//웹 모바일 구분
						var webMobileGbCd =$("#goodsBulkUpdateForm input[name=webMobileGbCd]:checked").val();
						sendData = $.extend({}, sendData, {webMobileGbCd: webMobileGbCd});
					}
					//가격변경
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_PRICE }" ) {

						var goodsAmtTpCd = $('#goodsBulkUpdateForm :input[name=goodsAmtTpCd]:checked').val();
						var saleStrtDtm = getDateStr ("bulkPriceStd") + ':00';
						var saleEndDtm = getDateStr ("bulkPriceEnd") + ':59';
						var expDt = $("#goodsBulkUpdateForm #expDt").val();
						var rsvBuyQty = $("#goodsBulkUpdateForm #rsvBuyQty").val();

						var sendData = [];
						$.each(selectedIDs, function(i, goodsId){
							//가격변경
							var goodsCstrtTpCd = grid.jqGrid('getRowData', goodsId).goodsCstrtTpCd;
							var splAmt = getCellValue(goodsId, 'splAmt');               //정상가
							var orgSaleAmt = getCellValue(goodsId, 'orgSaleAmt');       //매입가
							var saleAmt = getCellValue(goodsId, 'saleAmt');             //판매가
							var idx = ($('#'+goodsId)[0].rowIndex) -1;
							var fvrAplMethCd = $('select[name=fvrAplyMeth]').eq(idx).val(); //혜택 적용 방식 코드
							var calPrice = null;

							if(fvrAplMethCd) {
								calPrice = $('input[name=calPrice]').eq(idx).val();     //혜택값
							}
							var stId = $('select[name=stId]').val();

							var price = {
								stId : stId
								, goodsId : goodsId
								, goodsAmtTpCd : goodsAmtTpCd
								, goodsCstrtTpCd : goodsCstrtTpCd
								//혜택적용방식코드
								, fvrAplMethCd : fvrAplMethCd
								, fvrVal  : Number(calPrice)
								//혜택값
								, saleStrtDtm : saleStrtDtm
								, saleEndDtm : saleEndDtm
								, splAmt: splAmt
								, orgSaleAmt: orgSaleAmt
								, saleAmt: saleAmt
								, expDt: expDt
								, rsvBuyQty: rsvBuyQty
							};

							sendData.push(price);
						});
					}
					var options = {};

					//아이콘은 팝업처리 하지 않음
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_ICON }" ) {}

					//가격변경
					if(goodsUpdateGb == "${adminConstants.GOODS_BULK_UPDATE_PRICE }" ) {
						var options = {
							url : "<spring:url value='/goods/saveGoodsBulkPrice.do' />"
							, data : JSON.stringify(sendData)
							, contentType : 'application/json'
							, callBack : function(data ) {
								if(data.successCnt > 0) {
									messager.alert("<spring:message code='admin.web.view.app.goods.update.price.result.msg'/>", "Info", "info", function(){
										searchGoodsList ();
										layer.close ("goodsUpdate" );
									});
								} else {
									messager.alert("<spring:message code='admin.web.view.app.goods.update.price.result.msg.arg' arguments='"+data.successCnt+"'/>", "Info", "info", function(){
										searchGoodsList ();
										layer.close ("goodsUpdate" );
									});
								}
								/* 20210331 APETQA-1672 기획서대로 성공적으로 입력이 되어 해당 가격 반영 예정일 시, 기획서에 나와있는 대로 “가격 일괄변경이 완료되었습니다.”로의 문구 수정 원함
								messager.alert("<spring:message code='admin.web.view.app.goods.update.price.result.msg.arg' arguments='"+data.successCnt+"'/>", "Info", "info", function(){
									searchGoodsList ();
									layer.close ("goodsUpdate" );
								});*/
							}
						};

					} else {
						options = {
							url : url
							, data : sendData
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.common.edit.cnt.final_msg' arguments='"+data.successCnt+"'/>", "Info", "info", function(){
									searchGoodsList ();
									layer.close ("goodsUpdate" );
								});
							}
						};
					}

					ajax.call(options);
				}
			});
		}

		/**
		 * [일괄변경][조건] 가격변경
		 * 가격 시작,종료 일자 유효성 체크
		 */
		function validateDateTime() {
			var flag = $('#unlimitEndDate').is(':checked');

			var bulkPriceStdDt = $('#bulkPriceStdDt').val();
			var bulkPriceEndDt = $('#bulkPriceEndDt').val();

			if(bulkPriceStdDt != '') {
				bulkPriceStdDt = bulkPriceStdDt.replace(/\s/gi, '').replace(/-/gi, '');
			}

			if(bulkPriceEndDt != '' ) {
				bulkPriceEndDt = bulkPriceEndDt.replace(/\s/gi, '').replace(/-/gi, '');
			}

			if(bulkPriceStdDt == '') {
				messager.alert('<spring:message code="admin.web.view.msg.goods.invalidate.price.stddate" javaScriptEscape="true"/> ', "Error", "error");
				return false;
			}

			if(!flag) {
				if(bulkPriceEndDt != '') {
					if(bulkPriceEndDt < bulkPriceStdDt) {
						//종료일자가 시작일자보다 빠를 경우 체크
						messager.alert('<spring:message code="admin.web.view.msg.common.compareDate" javaScriptEscape="true"/>', "Error", "error");
						//날짜를 빈값으로 만들까 말까
						return false;
					} else if(bulkPriceEndDt == bulkPriceStdDt) {
						//종료일자가 시작일자보다 클 경우 정상
						//종료일자와 시작일자가 동일할 경우 정상
						var bulkPriceStdHr = $('#bulkPriceStdHr').val();
						var bulkPriceStdMn = $('#bulkPriceStdMn').val();
						var bulkPriceEndHr = $('#bulkPriceEndHr').val();
						var bulkPriceEndMn = $('#bulkPriceEndMn').val();

						var bulkPriceStdTime = bulkPriceStdHr + bulkPriceStdMn;
						var bulkPriceEndTime = bulkPriceEndHr + bulkPriceEndMn;

						//시작, 종료시간 체크
						if(bulkPriceStdTime > bulkPriceEndTime) {
							messager.alert('<spring:message code="admin.web.view.msg.goods.invalidate.price.datetime" javaScriptEscape="true"/> ', "Error", "error");
							return false;
						}
					}

					return true;

				} else {
					//종료일자가 세팅되지 않았을 경우 체크
					messager.alert('<spring:message code="admin.web.view.msg.goods.invalidate.price.enddate" javaScriptEscape="true"/> ', "Error", "error");
					return false;
				}
			} else {
				//종료일자 미지정 체크시
				//종료일시 강제 세팅이기 때문에 그대로 진행
				return true;
			}
		}

		/**
		 * [일괄변경][조건]
		 * 체크 상품 가격 변동 여부 체크
		 * 변동없는 Row가 있을 경우 알림, return false
		 */
		function validatePrice() {
			var grid = $('#'+listId);

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			var flag = true;
			var blnkFlag = true;

			$.each(rowids, function(i, rowId) {
				var splAmt = getCellValue(rowId, 'splAmt'); //정상가
				var org_splAmt = getCellValue(rowId, 'org_splAmt'); //정상가
				var orgSaleAmt = getCellValue(rowId, 'orgSaleAmt'); //매입가
				var org_orgSaleAmt = getCellValue(rowId, 'org_orgSaleAmt'); //매입가
				var saleAmt = getCellValue(rowId, 'saleAmt');   //판매가
				var org_saleAmt = getCellValue(rowId, 'org_saleAmt');//판매가

				var idx = 3;
				var checkIdx = 0;
				var checkBlnkIdx = 0;

				if(splAmt == '') {
					checkBlnkIdx ++;
				}

				if(orgSaleAmt == '') {
					checkBlnkIdx ++;
				}

				if(saleAmt == '') {
					checkBlnkIdx ++;
				}

				if(checkBlnkIdx > 0) {
					blnkFlag = false;
					grid.setRowData(rowId, false, {'color':'red'});
				}

				if(blnkFlag) {
					if(splAmt == org_splAmt) {
						checkIdx ++;
					}

					if(orgSaleAmt == org_orgSaleAmt) {
						checkIdx ++;
					}

					if(saleAmt == org_saleAmt) {
						checkIdx ++;
					}

					if(idx == checkIdx) {
						flag = false;
						grid.setRowData(rowId, false, {'color':'red'});
					}
				}
			});

			if(!blnkFlag) {
				messager.alert("<spring:message code="admin.web.view.msg.goods.invalidate.price.no.data" javaScriptEscape="true"/>", "Error", "error");
				return blnkFlag;
			}

			if(!flag) {
				//messager.alert("<spring:message code="admin.web.view.msg.goods.invalidate.price.not.changed" javaScriptEscape="true"/>", "Error", "error");
				return flag;
			}

			return true;
		}

		/**
		 * [버튼]엑셀 다운로드
		 */
		function goodsBaseExcelDownload(type) {
			var selectedIDs = $("#goodsList").getGridParam ("selarrrow");
			var data = $('#' + searchForm).serializeJson();			
			var goodsIdNos = [];

			for (var i = 0; i < selectedIDs.length; i++) {
				goodsIdNos.push (selectedIDs[i]);
			}
			
			data.goodsIdNoStr = goodsIdNos.join();
			data.excelType = type;
			
			createFormSubmit('goodsBaseExcelDownload', '/goods/goodsBaseExcelDownload.do', data);
		}
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion " data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width: 99%" >
		<spring:message code="admin.web.view.common.button.select" var="selectPh"/>
		<div title="<spring:message code='admin.web.view.common.search' />" class="pd10">
		<form id="goodsListForm" name="goodsListForm" method="post">
			<input type="hidden" id="dispClsfNo" name="dispClsfNo" value="" /><%--전시분류번호--%>
			<jsp:include page="/WEB-INF/view/goods/include/incGoodsSearchInfo.jsp" />
		</form>
		<div class="btn_area_center ">
			<button type="button" onclick="searchGoodsList();" class="btn btn-ok"><spring:message code="admin.web.view.common.search"/></button>
			<button type="button" onclick="searchReset();" class="btn btn-cancel"><spring:message code="admin.web.view.common.button.clear"/></button>
		</div>
		</div>
		</div>
		<div class="mModule">
			<div id="resultArea">				
				<select class="w175" id="goodsUpdateGb" name="goodsUpdateGb">
					<option value="">${selectPh}</option>
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
					<option value="${adminConstants.GOODS_BULK_UPDATE_APPR }"><spring:message code="column.goods_confirm" /></option>
					<option value="${adminConstants.GOODS_BULK_UPDATE_STAT }"><spring:message code="column.goods_stat_cd" /></option>
					</c:if>
					<option value="${adminConstants.GOODS_BULK_UPDATE_SHOW }"><spring:message code="column.show_yn" /></option>
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
					<option value="${adminConstants.GOODS_BULK_UPDATE_PRICE }"><spring:message code="column.update.price"/></option>
					<option value="${adminConstants.GOODS_BULK_UPDATE_ICON }"><spring:message code="column.icon" /></option>
					<option value="${adminConstants.GOODS_BULK_UPDATE_DEVICE }"><spring:message code="column.web_mobile_gb_cd" /></option>
					<option value="${adminConstants.GOODS_BULK_UPDATE_REMOVE }"><spring:message code="column.common.delete" /></option>
					</c:if>
				</select>
				<button type="button" onclick="updateGoodsBulk();" class="btn btn-add">
					<spring:message code="admin.web.view.app.goods.button.edit.all"/>
				</button>
				<button type="button" onclick="copyGoods();" class="btn btn-add">
					<spring:message code="admin.web.view.app.goods.button.copy"/>
				</button>
				
				<button type="button" onclick="registGoods();" class="btn btn-add">
					<spring:message code="admin.web.view.app.goods.button.add"/>
				</button>
				<button type="button" onclick="copyGoodsComment();" class="btn btn-add">
					<spring:message code="admin.web.view.app.goods.button.copy.comment"/>
				</button>
				<div class="right" style="top:0px">
					<button type="button" onclick="goodsBaseExcelDownload('${adminConstants.GOODS_EXCEL_DOWNLOAD_GOODS }');" class="btn btn-add btn-excel" style="width:150px;">
						<spring:message code="admin.web.view.common.button.download.excel.all"/>
					</button>
					<button type="button" onclick="goodsBaseExcelDownload('${adminConstants.GOODS_EXCEL_DOWNLOAD_CATEGORY }');" class="btn btn-add btn-excel" style="width:180px;">
						<spring:message code="admin.web.view.common.button.download.excel.category"/>
					</button>
					<button type="button" onclick="goodsBaseExcelDownload('${adminConstants.GOODS_EXCEL_DOWNLOAD_PRICE }');" class="btn btn-add btn-excel" style="width:150px;">
						<spring:message code="admin.web.view.common.button.download.excel.price"/>
					</button>
				</div>
			</div>

			<table id="goodsList"></table>
			<div id="goodsListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>