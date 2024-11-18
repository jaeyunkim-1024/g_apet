<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			//목록 ID , 검색Form = 목록 ID + 'Form'
			var listId = 'goodsList';
			var searchForm = listId +'Form';

			//검색 목록 gridOptions
			var gridOptions = {
				url : '<spring:url value="/goods/goodsBulkPriceGrid.do" />'
				, height : 400
				, searchParam : $('#' + listId + 'Form').serializeJson()
				, multiselect : true
				, colModels : [
					$.extend(_GRID_COLUMNS.goodsId_b, {})
					, {name:"compGoodsId", label:"<spring:message code='column.comp_goods_no' />", width:"100", align:"center", sortable:false} /* 업체 상품 번호 */
					, {name:"imgPath", label:'<spring:message code="column.tn_img_path" />', width:"220", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							if(rowObject.imgPath != "" &&   rowObject.imgPath != undefined ) {
								return tag.goodsImage(_IMG_URL, rowObject.goodsId, rowObject.imgPath , rowObject.imgSeq, "", "${ImageGoodsSize.SIZE_70.size[0]}", "${ImageGoodsSize.SIZE_70.size[1]}", "hgt40 wth40");
							} else {
								return '<img src="/images/noimage.png" style="width:40px; height:40px;" alt="" />';
							}
						}
					}
					, _GRID_COLUMNS.bndNmKo
					, _GRID_COLUMNS.goodsNm_b
					, $.extend(_GRID_COLUMNS.goodsStatCd, {width:'90'})
					, {name:'goodsCstrtTpCd', label:"<spring:message code='column.goods.cstrt.tp.cd' />", width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_CSTRT_TP }' showValue='false' />" } } /* 상품 구성 */
					, {name:'compTpCd', label:"<spring:message code="column.comp_tp_cd" />", width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_TP }' showValue='false' />" } } /* 공급사 유형 */
					, {name:'goodsAmtTpCd', label:'금액 유형', width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_AMT_TP }' showValue='false' />" } } /* 상품 금액 유형 */
					, {name:'saleStrtDtm', label:'현재가 시작일자', align:'center', sortable:false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }' } /** 현재가 시작일자 */
					, {name:'saleEndDtm', label:'현재가 종료일자', align:'center', sortable:false, formatter:gridFormat.date, dateformat:'${adminConstants.COMMON_DATE_FORMAT }' } /** 현재가 종료일자 */
					, {name:'splAmt', label:'정상가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
							var rowId = options.rowId;
							var splAmt = 0;
							if(cellValue) {
								splAmt = valid.numberWithCommas(cellValue)
							}
							return '<input type="text" id="'+rowId+'_splAmt" name="splAmt" value="'+splAmt+'" onkeyup="fnWithCommas(\''+rowId+'\', this)"/>';
						}} /** 판매금액 */
					, {name:'org_splAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
							return rowObject.splAmt;
						}}
					, {name:'orgSaleAmt', label:'매입가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
							var rowId = options.rowId;
							var orgSaleAmt = 0;
							if (cellValue) {
								orgSaleAmt = valid.numberWithCommas(cellValue)
							}
							return '<input type="text" id="'+rowId+'_orgSaleAmt" name="orgSaleAmt" value="' + orgSaleAmt + '" onkeyup="fnWithCommas(\''+rowId+'\', this)"/>';

						}} /** 원 판매금액 */
					, {name:'org_orgSaleAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
							return rowObject.orgSaleAmt;
						}}
					, {name:'saleAmt', label:'판매가', width:'200', sortable:false, formatter: function(cellValue, options, rowObject) {
							var rowId = options.rowId;
							var saleAmt = 0;
							if (cellValue) {
								saleAmt = valid.numberWithCommas(cellValue)
							}
							return '<input type="text" id="'+rowId+'_saleAmt" name="saleAmt" value="' + saleAmt + '" onkeyup="fnWithCommas(\''+rowId+'\', this)"/>';
						}} /** 공급금액 */
					, {name:'org_saleAmt', hidden:true, formatter: function(cellValue, options, rowObject) {
							return rowObject.saleAmt;
						}}
					, {name:'rate', label:'이익율', width:'90', align:'center', sortable:false, formatter:function(cellValue, options, rowObject) {
							if(cellValue != undefined) {
								return cellValue + '%';
							} else {
								var saleAmt = rowObject.saleAmt;
								var orgSaleAmt = rowObject.orgSaleAmt;
								var rate = ((saleAmt - orgSaleAmt) * 0.1 / saleAmt).toFixed(2);
								return rate + '%';
							}
						}
					} /** 이익율 */
				]
			};

			$(function(){
				//[일괄변경][조건] 종료일 날짜 input box 활성화 여부 체크
				checkUnlimitEndDate();

				//[일괄변경][조건] 가격 시작일자, 종료일자 비교 체크
				$('#bulkPriceStdDt, #bulkPriceEndDt').on('propertychange keyup input change paste ', function() {
					var value = $(this).val().replace(/\s/gi,'');
					if(value != '' && value.length> 9) {
						validateDate();
					}
				});
			});

			/**
			 * [일괄변경][조건]
			 * 종료일 날짜 input box 활성화 여부 체크
			 * @param obj
			 */
			function checkUnlimitEndDate() {
				var chkbox = $('#unlimitEndDate');
				if(chkbox.is(':checked')) {
					$('#bulkPriceEndDt').val('9999-12-31');
					$('#bulkPriceEndHr').val('23');
					$('#bulkPriceEndMn').val('59');
					$('#bulkPriceEndDt').attr('disabled', 'true');
					$('#bulkPriceEndHr').attr('disabled', 'true');
					$('#bulkPriceEndMn').attr('disabled', 'true');
				} else {
					$('#bulkPriceEndDt').removeAttr('disabled');
					$('#bulkPriceEndHr').removeAttr('disabled');
					$('#bulkPriceEndMn').removeAttr('disabled');
				}
			}

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
			 * [GRID] set cell value with comma
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

				if(val) {
					val = val.replace(/\s/gi, '').replace(/,/gi, '');
					$(obj).val(valid.numberWithCommas(val)) ;
					if(orgValue == val) {
						$(obj).removeAttr('style');
					} else {
						$(obj).attr('style','color:red');
					}
				} else {
					$(obj).val(val) ;
				}

				var splAmt = getCellValue(rowId, 'splAmt');         //정상가
				var orgSaleAmt = getCellValue(rowId, 'orgSaleAmt'); //매입가
				var saleAmt = getCellValue(rowId, 'saleAmt');       //판매가

				//이익율 계산 = (판매가-매입가)/판매가
				console.log({orgSaleAmt:orgSaleAmt, saleAmt:saleAmt, flag:orgSaleAmt > saleAmt});
				if(orgSaleAmt > splAmt) {
					rate =  ((saleAmt - orgSaleAmt) * 0.1 / saleAmt).toFixed(2);
				} else {
					var rate = ((saleAmt - orgSaleAmt) / saleAmt).toFixed(2);
					if(rate ) {

					}
				}
				console.log({splAmt:splAmt, orgSaleAmt:orgSaleAmt, saleAmt:saleAmt, rate:rate})

				if(rate == 'NaN') {
					rate = '-';
				}
				$('#'+listId).jqGrid('setCell', rowId, 'rate', rate);
			}

			/**
			 * [일괄변경][조건]
			 * 일반 제외 종료일자 활성화, 종료일 미지정 체크박스 체크해제
			 * @param obj
			 */
			function checkGoodsAmtTpCd(obj) {
				if($(obj).val()!="${adminConstants.GOODS_AMT_TP_10}") {

					//일반 제외 종료일 미지정 체크박스 disabled
					//일반 제외 종료일자 세팅 필요
					$('#unlimitEndDate').prop('checked', false);
					$('#unlimitEndDate').attr('disabled', 'true');
					checkUnlimitEndDate($('#unlimitEndDate'));
				} else {
					$('#unlimitEndDate').removeAttr('disabled');
				}
			}

			/**
			 * [일괄변경][조건]
			 * 가격 시작,종료 일자 유효성 체크
			 */
			function validateDate() {
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
						if(bulkPriceEndDt > bulkPriceStdDt) {
							return true;
						} else if(bulkPriceEndDt == bulkPriceStdDt) {
							return true;
						} else {
							messager.alert('<spring:message code="admin.web.view.msg.goods.invalidate.price.period" javaScriptEscape="true"/>', "Error", "error");
							//날짜를 빈값으로 만들까 말까
							$('#bulkPriceEndDt').val('');
							return false;
						}
					} else {
						messager.alert('<spring:message code="admin.web.view.msg.goods.invalidate.price.enddate" javaScriptEscape="true"/> ', "Error", "error");
						return false;
					}
				} else {
					//종료일자 미지정일 경우, 편안..
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
					var splAmt = getCellValue(rowId, 'splAmt');         //정상가
					var org_splAmt = getCellValue(rowId, 'org_splAmt');  //정상가
					var orgSaleAmt = getCellValue(rowId, 'orgSaleAmt'); //매입가
					var org_orgSaleAmt = getCellValue(rowId, 'org_orgSaleAmt'); //매입가
					var saleAmt = getCellValue(rowId, 'saleAmt');       //판매가
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
					messager.alert("<spring:message code="admin.web.view.msg.goods.invalidate.price.not.changed" javaScriptEscape="true"/>", "Error", "error");
					return flag;
				}

				return true;
			}

			/**
			 * [일괄변경][조건]
			 * 조건
			 * 일반 제외 -> 진행중인 현재 가격이 상품 금액 유형 코드가 일반이 아닌 경우 수정 불가
			 */
			function validateOption() {
				//가격 구성 유형
				var goodsAmtTpCd = $('input[name=goodsAmtTpCd]:checked').val();
				var flag = true;

				//가격 적용 종료 기간 일반이 아닐 경우
				if(goodsAmtTpCd != '${adminConstants.GOODS_AMT_TP_10}') {
					//flag = false;

					var bulkPriceStdDtm = (getDateStr ("bulkPriceStd")).replace(/\s/gi, '').replace(/-/gi, '').replace(/:/gi, '') + '00';

					var grid = $('#'+listId);
					var rowIds = grid.getGridParam ("selarrrow");

					$.each(rowIds, function(i, rowId){
						var rowGoodsAmtTpCd = $('#' +listId).jqGrid ('getCell', rowId, 'goodsAmtTpCd');
						var saleEndDtm = $('#' +listId).jqGrid ('getCell', rowId, 'saleEndDtm');
						saleEndDtm = saleEndDtm.replace(/\s/gi, '').replace(/-/gi, '').replace(/:/gi, '');

						if(rowGoodsAmtTpCd != ${adminConstants.GOODS_AMT_TP_10} && saleEndDtm  >= bulkPriceStdDtm) {
							flag = false;

							grid.setRowData(rowId, false, {'color':'red'});
						}
					});

					if(!flag) {
						messager.alert('금액유형이 일반이 아닐 경우, 진행중인 가격 구성을 변경할 수 없습니다.', "Error", "error");
						return false;
					}
				}

				return flag;
			}

			/**
			 * [일괄변경][ajax] 일괄 변경
			 * @param e
			 */
			function editBulkPrice(e) {
				e.target.disabled = true;

				//step1 선택 여부 체크
				var grid = $('#'+listId);

				$('#'+listId +' tr').css('color', 'black');

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.content.no_select' />", "Info", "info");
					e.target.disabled = false;
					return;
				}

				//step2 현재시간보다 이전 시간의 경우 변경 불가능
				//step3 가격 적용 시작일시가 현재 시간보다 느릴 경우 알림
				//step4 금액 구성 유형 = 일반 제외 -> 종료일자 체크
				// [일괄변경][조건] 가격 시작일자, 종료일자 비교 체크
				if(!validateDate()) {
					e.target.disabled = false;
					return;
				}

				//step5 일반 제외 -> 진행중인 현재 가격이 상품 금액 유형 코드가 일반이 아닌 경우 수정 불가
				if(!validateOption()) {
					e.target.disabled = false;
					return;
				}

				//step6 금액 변동 없을 경우 알림
				if(!validatePrice()) {
					e.target.disabled = false;
					return;
				}

				messager.confirm("일괄변경 고?",function(r){
					if(r){
						var grid = $('#'+listId);
						var selectedIds = grid.getGridParam ("selarrrow");
						var sendData = [];

						var goodsAmtTpCd = $('input[name=goodsAmtTpCd]:checked').val();

						var saleStrtDtm = getDateStr ("bulkPriceStd") + ':00';
						var saleEndDtm = getDateStr ("bulkPriceEnd") + ':59';

						$.each(selectedIds, function(i, goodsId){
							var splAmt = getCellValue(goodsId, 'splAmt');         //정상가
							var orgSaleAmt = getCellValue(goodsId, 'orgSaleAmt'); //매입가
							var saleAmt = getCellValue(goodsId, 'saleAmt');       //판매가

							var price = {
								goodsId : goodsId
								, goodsAmtTpCd : goodsAmtTpCd
								, saleStrtDtm : saleStrtDtm
								, saleEndDtm : saleEndDtm
								, splAmt: splAmt
								, orgSaleAmt: orgSaleAmt
								, saleAmt: saleAmt
							};

							sendData.push(price);
						});

						//todo[상품, 이하정, 20210112] 등록
						//에러처리?
						var options = {
							url : "<spring:url value='/goods/saveGoodsBulkPrice.do' />"
							, data : JSON.stringify(sendData)
							, contentType : 'application/json'
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									searchGoodsList ();
									e.target.disabled = false;
								});
							}
						};
						ajax.call(options);

					} else {
						e.target.disabled = false;
						return;
					}
				});
			}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<style>
			.priceDate {
                margin-right: auto;
				text-align: right;
                vertical-align: middle;
			}
			.priceDate.title {
                font-weight: bolder;
				padding-right: 10px;
			}
		</style>
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsSearchInfo.jsp" />

		<div class="mModule" >
			<div class="priceDate">
				<span class="priceDate title">
					<spring:message code="admin.web.view.app.goods.bulk.price.period"/>
				</span>
				<frame:radio name="goodsAmtTpCd" grpCd="${adminConstants.GOODS_AMT_TP}" excludeOption="${adminConstants.GOODS_AMT_TP_30}" onClickYn="Y" funcNm="checkGoodsAmtTpCd(this)"/>
				<frame:datepicker startDate="bulkPriceStdDt"
				                  startHour="bulkPriceStdHr"
				                  startMin="bulkPriceStdMn"
				                  startValue="${frame:addMin('yyyy-MM-dd HH:mm:ss', 30)}"
				                  endDate="bulkPriceEndDt"
				                  endHour="bulkPriceEndHr"
				                  endMin="bulkPriceEndMn"
				                  endValue="9999-12-31 23:59:59"
				                  />
				<label class="fCheck ml10"><input name="unlimitEndDate" id="unlimitEndDate" type="checkbox" onclick="checkUnlimitEndDate(this );" checked="checked">
					<span><spring:message code="admin.web.view.app.goods.bulk.price.period.enddate.unlimit"/></span>
				</label>
				<button type="button" class="btn btn-add" onclick="editBulkPrice(event);">
					<spring:message code="admin.web.view.app.goods.button.edit.all"/>
				</button>
			</div>
			<table id="goodsList"></table>
			<div id="goodsListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>
