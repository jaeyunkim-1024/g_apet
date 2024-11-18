<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script"> 
		<script type="text/javascript">
		$(document).ready(function() {
			var panels = $('#goods_pannel').accordion('panels');
			$.each(panels, function() {
				this.panel('expand');
			});
			$('#goods_pannel').accordion('resize');
			
			initEditor();
			initUI();

			createAttrList ();
			if("${goodsCstrtTpCd}" === "${adminConstants.GOODS_CSTRT_TP_ATTR}"){
				createOptGrpList();
			}
			genAttrItemList ();

			createDispCtgList ();
			createGoodsCstrtList ();

			<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
				compDlvrcPlcList()
			</c:if>
				
			if($("#goodsInsertForm [name='stId']").length < 2){
				$("#goodsInsertForm [name='stId']").prop('disabled', true);
			}

			/*
			FIXME[상품, 이하정, 20210428] 필요없는 로직, 확인 후 삭제하자
			$(function() {
				$("#compCmsRateSpan").hide();
				var saleAmtInputBox = $("#saleAmt");
				var compCmsRateSpan=false;
				saleAmtInputBox.blur(function() {
				    if (saleAmtInputBox.val() == null || saleAmtInputBox.val() == '') {
				        return;
				    }
				    $("#compCmsRateSpan").show();
				});
			});
			*/

			// 상품등록할 때 판매기간 종료일은 미지정값으로 기본설정함.
			$('input:checkbox[id="unlimitEndDate"]').attr("checked", true);
			checkUnlimitEndDate($('input:checkbox[id="unlimitEndDate"]'), 'sale');
			
			$("input:radio[name=webMobileGbCd]").change(function () {
				if($("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}'){
					$(".offLineCntrl").html("*");
				}else{
					$(".offLineCntrl").html("");
				}
			});
		});

		/* FIXME[상품, 이하정, 20210428] 필요없는 로직, 확인 후 삭제하자
		// 판매가를 입력하면 공급가를 자동으로 계산함.(공급가 = 판매가 - 판매가*상품수수료율)
		$(function() {
			var saleAmtInputBox = $("#saleAmt");
			saleAmtInputBox.blur(function() {
				console.log('판매가를 입력하면 공급가를 자동으로 계산함.(공급가 = 판매가 - 판매가*상품수수료율)');
				if (saleAmtInputBox.val() == null || saleAmtInputBox.val() == '') {
					return;
				}

				//var cmsRate = $("#cmsRate").val() * 0.01;
				//var saleAmt = saleAmtInputBox.val().replace(/,/gi, "");

				// splAmt = saleAmt - (saleAmt * cmsRate);
				//$("#splAmt").val(splAmt);
			});
		});
		 */

		$(function(){
			$("input[name=stId]").change(function(){
				//$("select[name='stIdCombo']").prop("disabled", false);

				if($(this).is(':checked')){
					var selVal = $(this).val();
					$("#"+selVal).show();
					$("select[name='stIdCombo']").find("option[value="+selVal+"]").prop("disabled", false);
					$("select[name='stIdCombo'] option[value="+selVal+"]").attr("selected",true);
				}else{
					var notSelVal = $(this).val();  // 체크 되지 않은 사이트
					$("#"+notSelVal).hide();
					$("select[name='stIdCombo']").find("option[value="+notSelVal+"]").attr("disabled", "disabled");
					//$("#stIdCombo option").not(":selected").attr("disabled", false);
				}
			});
			
			// 세트/묶음/옵션  속성 정리, 무료배송여부 텍스트 변경. 노출/미노출 >> 예/아니오
			hiddenItemInfoAttr();
			
		});
		 
		/* 
		  ** 세트/묶음/옵션 속성 정리, 무료배송여부 텍스트 변경. 노출/미노출 >> 예/아니오
		  ** http://wiki.aboutpet.co.kr/pages/viewpage.action?pageId=1166458
		*/
		function hiddenItemInfoAttr() {

			var curCstrtTp = "${goodsCstrtTpCd}";
			
			// 세트일 경우
			if ( curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_SET}" ) {
				
				// 재고 관리 여부 ( #stockTr 자식(0,1 번째) ) - 히든
				$("#stockTr").children().eq(0).css("display", "none");
				$("#stockTr").children().eq(1).css("display", "none");
				
				// 성분정보연동여부( #iigdtInfoLnkYn_table) - 히든
				$("#igdtInfoLnkYn_table").css("display", "none");
			} 
			// 묶음 또는 옵션일 경우
			else if( curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_PAK}" || curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_ATTR}" ) { 
				
				// 재고 관리 여부 ( #stockTr 자식(0,1 번째) ) - 히든
				$("#stockTr").children().eq(0).css("display", "none");
				$("#stockTr").children().eq(1).css("display", "none");
				
				// 최소/최대주문수량 ( #stockTr 자식(2,3번째) ) - 히든
				$("#stockTr").children().eq(2).css("display", "none");
				$("#stockTr").children().eq(3).css("display", "none");
				
				// 성분정보연동여부( #iigdtInfoLnkYn_table) - 히든
				$("#igdtInfoLnkYn_table").css("display", "none");
				
				// 배송정보-무료 배송 여부(#freeDlvrYnY) - 히든
				$("#freeDlvrYnY_th").css("display", "none");
				$("#freeDlvrYnY_td").css("display", "none");
				
				// 배송정보-재고 수량 노출 여부(#stkQtyShowYn) - 히든
				$("#stkQtyShowYn_th").css("display", "none");
				$("#stkQtyShowYn_td").css("display", "none");
			
				// 배송정보-재입고 알림 여부(#ioAlmYn) - 히든
				$("#ioAlmYn_th").css("display", "none");
				$("#ioAlmYn_td").css("display", "none");
				
				// 배송정보-반품가능여부(#rtnPsbYn) - 히든
				$("#rtnPsbYn_th").css("display", "none");
				$("#rtnPsbYn_td").css("display", "none");
				
				// 배송정보 hidden 처리로  td 가 끊기는 현상 수정
				$("#dlvrcPlcNo_td").width('100%');
				
				// 배송정책코드를 비활성화한다.
				$("#dlvrcPlcNo").attr("disabled",true);
				$("#dlvrcPlcNo").val("").prop("selected", true); //배송정책 첫번째 항목을 선택하지 않는다.
				
			} 
			
			// 무료배송여부 텍스트 변경. 노출/미노출 >> 예/아니오
			$("#span_freeDlvrYnY").text("예");
			$("#span_freeDlvrYnN").text("아니오");
		}
		
		function createOptGrpList(){
			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : [
					{name:"attrNo", label:'<spring:message code="column.attr_no" />', key: true, width:"80", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attrNm", label:'<spring:message code="column.attr_nm" />', width:"400", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"showNm", label:'<spring:message code="column.goods.showAttrNm" />', width:"400", align:"center", hidden:false, editable:true, sortable:false }
					, {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"100", align:"center", formatter:'integer' , editable:true }
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
				]
				, afterEditCell : function ( rowid, name, val, iRow, iCol){
					var grid = $("#optGrpList");
					$("#"+iRow+"_"+name).bind('blur',function(){
						grid.saveCell(iRow,iCol);
					  });
				}
			};
			
			grid.create("optGrpList", options);
		}
		
		// 상품 구성 유형에 따른 제어
		function setAttrColModels(goodsCstrtTpCd){
			
			var setColModels = '';
			
			// 단품 일 경우
			if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === goodsCstrtTpCd || goodsCstrtTpCd === ""){
				setColModels = [
					{name:"attrNo", index:"attrNo", label:'<spring:message code="column.goods.option" />', width:"200", align:"center", key: true, hidden:false, editable:true,
						edittype:'select', formatter:"select",
						//editoptions:{ value: "9998:사이즈;9999:색상",
						editoptions:{ value: listAttribute(),
						dataEvents:[
						   { type: "change", fn: function(e){
	
							   var griddataArray = new Array();
							   var row = $(e.target).closest('tr.jqgrow');
							   var attrCheck= false;
							   var rowid = row.attr('id');
	
							   $("#"+rowid+"_attrNo > option[value='"+$(e.target).val()+"']").attr("selected", "true");
							   var comboVal = $("#"+rowid+"_attrNo option:selected").val();
							   var comboText = $("#"+rowid+"_attrNo option:selected").text();
	
							   // 중복체크
							   var drowids = $("#attrList").jqGrid('getDataIDs');
	
								var beforeAttrNo = "";
								for(var j = 0; j < drowids.length; j++) {
									var d = drowids[j];
									$("#attrList").jqGrid('setCell', rowid, 'attrNm' , comboText);
	
									var rowdata = $("#attrList").getRowData(d);
									if((rowdata.length == 0) || (rowdata.attrNo =='' )){
										break;
									}
	
									if(beforeAttrNo == '' ){
										if ((rowdata.attrNo != 0) &&(rowdata.attrNo !='')){
											griddataArray.push(rowdata);
										}
									}
									if(rowdata.attrNo == comboVal) {
										
										$("#attrList").jqGrid('delRowData',rowid);
										jQuery("#attrList").clearGridData();
										jQuery("#attrList").trigger("reloadGrid");
	
										for( var k = 0 ; k < griddataArray.length ; k++){
											$("#attrList").jqGrid("addRowData",k+1, griddataArray[k]);
										}
										
										messager.alert("[ " +rowdata.attrNm + " ]" + "<spring:message code='admin.web.view.msg.common.dupl.attribute' />", "Info", "info");
									}else{
	
										if(beforeAttrNo != '' ){
											if ((rowdata.attrNo != 0) &&(rowdata.attrNo !='')){
												griddataArray.push(rowdata);
											}
										}
	
									}
									beforeAttrNo = rowdata.attrNo;
								}
							}
						   },
						   { type: "focus", fn: function(e){
	
							   var attrCheck= false;
	 							var row = $(e.target).closest('tr.jqgrow');
	 							if($(e.target).val() != 0){
		 							var rowid = row.attr('id');
									$("#"+rowid+"_attrNo > option[value='"+$(e.target).val()+"']").attr("selected", "true");
									var comboVal = $("#"+rowid+"_attrNo option:selected").val();
									var comboText = $("#"+rowid+"_attrNo option:selected").text();
	
									$("#attrList").jqGrid('setCell', rowid, 'attrNm' , comboText);
	
						   		}
							}
						   }
						]
						}, sortable:false } /* 단품옵션 */
					,{name:"attrNm", label:'<spring:message code="column.goods.option" />', width:"200", align:"center", editable: false, hidden:true ,sortable:false}
					, {name:"attrVal", label:'<spring:message code="column.goods.option.value" />', width:"500", align:"center", hidden:false ,editable:true, sortable:false } /* 단품옵션값 */
					, {name:"attrValNo", label:'', width:"200", align:"center", hidden:true, sortable:false } /* 단품옵션값 번호 */
					, {name:"attrValJson", label:'', width:"1000", align:"center", hidden:true, sortable:false } /*  */
					, {name:'useYn', label:'<spring:message code="column.use_yn" />', width:'90', align:'center', sortable:false, hidden:true , formatter:'select', editoptions:{value:_USE_YN } }  	// 사용 여부
				]
			}else if("${adminConstants.GOODS_CSTRT_TP_SET}" === goodsCstrtTpCd){
				setColModels = [
					{name:"subGoodsId", label:'<spring:message code="column.statistics.goods_id" />', key:true, width:"150", align:"center", editable:false, hidden:false ,sortable:false}
					, {name:"goodsNm", label:'<spring:message code="column.goodsNm" />', width:"480", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
					, {name:"cstrtQty", label:'<spring:message code="column.order_common.cstrt_qty" />', width:"120", align:"center", hidden:false, editable:true, sortable:false, formatter:'integer' }
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
					, {name:"dispPriorRank", label:'', width:"200", align:"center", hidden:true }
				]
			}else if("${adminConstants.GOODS_CSTRT_TP_PAK}" === goodsCstrtTpCd){
				setColModels = [
					{name:"subGoodsId", label:'<spring:message code="column.statistics.goods_id" />', key:true, width:"200", align:"center", editable:false, hidden:false ,sortable:false}
					, {name:"goodsNm", label:'<spring:message code="column.goodsNm" />', width:"400", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
					, {name:"saleAmt", label:'<spring:message code="column.price" />', formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','}, width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"radioShowYn", label:'<spring:message code="column.goods.comment.display_used" />', width:"200", align:"center", hidden:false , editable:false, sortable:false, 
						formatter: function(cellValue, options, rowObject) {
						
					    var checkedY = rowObject['showYn'] === 'Y' ? 'checked' : '';
					    var checkedN = rowObject['showYn'] === 'N' ? 'checked' : '';
					    
					    var	returnTxt = '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="Y" '+ checkedY +' onclick="radioCustomEvent(this, \'' + options.rowId  + '\')" ><span>노출</span></label>';
							returnTxt += '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="N" '+ checkedN +' onclick="radioCustomEvent(this, \'' + options.rowId + '\')" ><span>미노출</span></label>';
							
						return returnTxt;
					}}	
					, {name:"cstrtShowNm", label:'<spring:message code="column.goods.cstrtShowNm" />', width:"400", align:"center", hidden:true}
					, {name:"dispPriorRank", label:'', width:"200", align:"center", hidden:true }
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
					, {name:"showYn", label:'', width:"150", align:"center", hidden:true}
				]
			}else if("${adminConstants.GOODS_CSTRT_TP_ATTR}" === goodsCstrtTpCd){
				setColModels = [
					{name:"subGoodsId", label:'<spring:message code="column.statistics.goods_id" />', width:"150", key:true, align:"center", editable:false, hidden:false ,sortable:false}
					, {name:"compGoodsId", label:'<spring:message code="column.goods.compGoodsId" />', width:"150", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"goodsNm", label:'<spring:message code="column.goodsNm" />', width:"300", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
					, {name:"cstrtShowNm", label:'<spring:message code="column.goods.cstrtShowNm" />', width:"300", align:"center", hidden:true, editable:true, sortable:false }
					, {name:"saleAmt", label:'<spring:message code="column.price" />', formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','}, width:"100", align:"center", hidden:false , editable:false, sortable:false }
					
					, {name:"attr1Val", label:'<spring:message code="column.attr1_nm" />', width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attr1No", label:'', width:"200", align:"center", hidden:true }
					
					, {name:"attr2Val", label:'<spring:message code="column.attr2_nm" />', width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attr2No", label:'', width:"200", align:"center", hidden:true }
					
					, {name:"attr3Val", label:'<spring:message code="column.attr3_nm" />', width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attr3No", label:'', width:"200", align:"center", hidden:true }
					
					, {name:"attr4Val", label:'<spring:message code="column.attr4_nm" />', width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attr4No", label:'', width:"200", align:"center", hidden:true }
					
					, {name:"attr5Val", label:'<spring:message code="column.attr5_nm" />', width:"100", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"attr5No", label:'', width:"200", align:"center", hidden:true }
					
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
					, {name:"showYn", label:'', width:"150", align:"center", hidden:true}
				]
			}
			
			return { colModels : setColModels };
		}
		
		// 라디오 커스텀 이벤트
		function radioCustomEvent(obj, rowid){
			$("#attrList").jqGrid('setCell', rowid, 'showYn', $(obj).val());
		}
		
		function createAttrList () {
			
			var columns = setAttrColModels("${goodsCstrtTpCd}");

			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 200
				, multiselect : true
				, afterEditCell : function ( rowid, name, val, iRow, iCol){
					var grid = $("#attrList");
					$("#"+iRow+"_"+name).bind('blur',function(){
						grid.saveCell(iRow,iCol);
					  });
				}
				, loadComplete : function(data) {
					if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== "${goodsCstrtTpCd}"){
						dragAndDrop("attrList", "dispPriorRank");	
					}else{
// 						fnSetItemAttr();
					}
				}
				, afterSaveCell : function ( rowid, name, val, iRow, iCol){
					var grid = $("#attrList");
					
					$("#"+iRow+"_"+name).bind('blur',function(){
						grid.saveCell(iRow,iCol);
				  	});
					//세트상품등록 시 구성품의 단품재고수량을 통하여 세트 재고수량 조정
					<c:if test="${goodsCstrtTpCd eq 'SET'}">
					calcStkQty();
					</c:if>
				}
				
			};
			
			options = $.extend({}, columns, options);
			
			grid.create("attrList", options);
		}
		function calcStkQty(){			
			var attrGrid = $("#attrList");
			var rowIds = attrGrid.jqGrid("getDataIDs");
			var webSetStkQty = 0;
			for(var i = 0; i < rowIds.length; i++ ) {
				var attr = attrGrid.jqGrid("getRowData", rowIds[i]);
				if(i == 0 || webSetStkQty > Math.floor(attr.webStkQty/attr.cstrtQty)){
					webSetStkQty = Math.floor(attr.webStkQty/attr.cstrtQty);						
				}
			}				
			$("#webSetStkQty").val(valid.numberWithCommas(webSetStkQty));
		}
		

		function makeNewRowId(rowids){
		   var max =	rowids;

		   return eval(max) + 1;
		}

		function addAttrList () {
			var ln =$("#attrList").jqGrid('getGridParam', 'records');
			var newRowid = makeNewRowId(ln);
			var noSel = false;
			var drowids = $("#attrList").jqGrid('getDataIDs');

			if( !noSel ){
				var itemMngYn = $(":radio[name=itemMngYn]:checked").val();
				if(itemMngYn == "${adminConstants.COMM_YN_N }" ) {
					return;
				}

				var rowIds = $("#attrList").jqGrid("getDataIDs");

				// 5개 이상 추가 금지..
				if(rowIds.length >= 5 ) {
					messager.alert("<spring:message code='column.goods.option.max' arguments='5' />", "Info", "info");
					return;
				}

				var attrArrays = "";
				var aArrays = new Array();
				var resultAttrValNoArray = new Array();
				var options = {
					url : "<spring:url value='/goods/listAttribute.do' />"
					,data : ''
					,dataType : "json"
					,async : true
					,callBack : function(data) {
						$.each(data.result, function(index, result) {
							var aObj = result.attrNo+":"+ result.attrNm;
							aArrays.push(aObj);
							var resultAttrValNo = result.attrNo+":"+result.attrValNo ;
							resultAttrValNoArray.push(resultAttrValNo);
						});

						attrArrays = aArrays.join(";");
						attrArrays = "{"+attrArrays+"}";
						var addData = {
							 attrNo : attrArrays
							, attrNm :''
							, attrVal : ''
							, attrValNo : ''
							, attrValJson : ''
							, useYn : '${adminConstants.COMM_YN_Y }'
						}
						$("#resultAttrValNoArray").val(resultAttrValNoArray);
						$("#attrList").jqGrid('addRowData', newRowid, addData, 'last', null );
					}

				};
			ajax.call(options);

			}
		}
		
		function fnSetItemAttr(){
			
			var attrArrays = "";
			var aArrays = new Array();
			var resultAttrValNoArray = new Array();
			var options = {
				url : "<spring:url value='/goods/listAttribute.do' />"
				,data : ''
				,dataType : "json"
				,async : true
				,callBack : function(data) {
					$.each(data.result, function(index, result) {
						var aObj = result.attrNo+":"+ result.attrNm;
						aArrays.push(aObj);
						var resultAttrValNo = result.attrNo+":"+result.attrValNo ;
						resultAttrValNoArray.push(resultAttrValNo);
					});

					attrArrays = aArrays.join(";");
					attrArrays = "{"+attrArrays+"}";
					var addData = {
						 attrNo : attrArrays
						, attrNm :''
						, attrVal : ''
						, attrValNo : ''
						, attrValJson : ''
						, useYn : '${adminConstants.COMM_YN_Y }'
					}
					$("#resultAttrValNoArray").val(resultAttrValNoArray);
					for(var i=0; i<5; i++){
						var ln =$("#attrList").jqGrid('getGridParam', 'records');
						var newRowid = makeNewRowId(ln);
						$("#attrList").jqGrid('addRowData', newRowid, addData, 'last', null );
					}
				}

			};
			ajax.call(options);
		}

		function genAttrItemList () {
			var itemMngYn = $(":radio[name=itemMngYn]:checked").val();
			if(itemMngYn == "${adminConstants.COMM_YN_N }" ) {
				return;
			}
			
			var returnMsg = "";

			// 옵션 조회
			var attrGrid = $("#attrList");
			var rowIds;
			
			rowIds = attrGrid.jqGrid("getDataIDs");

			// 재고 관리 여부
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			var webStkQty = $("#defaultItemStockCnt").val();
			
			// Grid 초기화
			$.jgrid.gridUnload("#attrItemList");

			var columnIdx = 1;
			var columns = new Array();
			var checkAttrNull = false;
			// Key
			columns.push({name : 'itemNo', label : '<spring:message code="column.item_no" />', width : '100', align : 'center', hidden:false, sortable : false });
			columns.push({name : 'itemNm', label : '<spring:message code="column.item_nm" />', width : '150', align : 'center', editable:false, sortable : false });

			// 추가 [옵션 리스트]
			for(var i = 0; i < rowIds.length; i++ ) {
				var attr = attrGrid.jqGrid("getRowData", rowIds[i]);
				
				attr.attrNm = $.trim(attr.attrNm);
				var rowdata = $("#attrList").getRowData(rowIds[i+1]);
				rowdata.attrNm = $.trim(rowdata.attrNm);

				var attrValStr = "";
				var attrValArray = new Array();
				var m = 0;
				if( $("#resultAttrValNoArray").val() !=''){
					attrValStr = $("#resultAttrValNoArray").val();
					attrValArray = attrValStr.split(","); // 단품옵션값

					for(var j=1; j< attrValArray.length; j++){
						var attrVal = attrValArray[j].split(":");

						if(attr.attrNo == attrVal[0]){
							m = parseInt(attrVal[1]);
						}
					}
				}
				
				if($.trim(attr.attrVal) === ""){
					checkAttrNull = true;
					returnMsg = "<spring:message code='admin.web.view.msg.goods.invalidate.item.attrVal' />";
				}
				
				if($.trim(attr.attrNm) === "" || $.trim(attr.attrNm) === "선택"){
					checkAttrNull = true;
					returnMsg = "<spring:message code='admin.web.view.msg.goods.invalidate.item.attrNm' />";
				}
				
				if(attr.itemNo != "" && !checkAttrNull ) {
					var attrIdx = "attr" + columnIdx;
					columns.push({name : attrIdx + 'No', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'Nm', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'ValNo', label : '', width : '100', align : 'center', hidden:false, sortable : false });
					columns.push({name : attrIdx + 'Val', label : attr.attrNm, width : '100', align : 'center', editable:false, sortable : false });

// 					var attrVal = attr.attrVal.split(","); // 단품옵션값

					// 등록된 옵션에 대한 처리
					var tempAttrValObj;
					var tempAttrValList = new Array();

// 					for(var attrValIdx = 0; attrValIdx < attrVal.length; attrValIdx++ ) {
						tempAttrValObj = {attrNo : attr.attrNo
									, attrNm : $.trim(attr.attrNm)
									, attrValNo : m
// 									, attrVal : attrVal[attrValIdx]
									, attrVal : attr.attrVal
									, useYn : '${adminConstants.COMM_YN_Y }' };
						tempAttrValList.push(tempAttrValObj);
						m++;
// 					}
					//attrGrid.jqGrid("setCell", attr.attrNo, "attrValJson", JSON.stringify( tempAttrValList ));
					attrGrid.jqGrid("setCell", i+1, "attrValJson", JSON.stringify( tempAttrValList ));
					columnIdx++;
				}

			}
			
			if(checkAttrNull){
				return returnMsg;
			}
			
			// 웹 재고
			columns.push({name : 'webStkQty', label : '<spring:message code="column.web_stk_qty" />', width : '100', align : 'center', sortable:false, editable:true});
			
			// 사은품 가능 여부
			columns.push({name : 'frbPsbYn', label : '<spring:message code="column.goods.frbPsbYn" />', width : '100', align : 'center', sortable:false, editable:true , formatter:'select',edittype:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.FRB_PSB_YN}' showValue='false' />"}});

			// 판매여부
			columns.push({name : 'itemStatCd', label : '<spring:message code="column.item_stat_cd" />', width : '100', align : 'center', editable:true, sortable:false, formatter:'select',edittype:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.ITEM_STAT}' showValue='false' />"}} );
			// 추가 금액
			columns.push({name : 'addSaleAmt', label : '<spring:message code="column.add_sale_amt" />', width : '100', align : 'center', editable:true, sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} });
			// 노출 순서
			columns.push({name : 'showSeq', label : '<spring:message code="column.show_seq" />', width : '100', align : 'center', editable:true, sortable:false });
			// attribute List
			columns.push({name : 'attrValJson', label : '', width : '1000', align : 'center', hidden:false, sortable:false });
			//
			columns.push({name : 'itemListId', label : '', width : '100', align : 'center', hidden:false, key:true, sortable:false });

			// Create Item Grid
			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : columns
				, multiselect : true
				, afterSaveCell : function ( rowid, name, val, iRow, iCol){
					var grid = $("#attrItemList");
					if(name == 'addSaleAmt'){
						var fpVal = parseInt(val);
							if(fpVal<0){
								messager.alert("<spring:message code='admin.web.view.msg.goods.addSaleAmt.zero' />", "Info", "info", function(){
									grid.jqGrid("restoreCell",iRow,iCol);
								});
							}
					}
				}
			};
			grid.create("attrItemList", options);

			var defalutOption = {
				itemNm : ''
				, attr1No : ''
				, attr1Nm : ''
				, attr1ValNo : ''
				, attr1Val : ''
				, attr2No : ''
				, attr2Nm : ''
				, attr2ValNo : ''
				, attr2Val : ''
				, attr3No : ''
				, attr3Nm : ''
				, attr3ValNo : ''
				, attr3Val : ''
				, attr4No : ''
				, attr4Nm : ''
				, attr4ValNo : ''
				, attr4Val : ''
				, attr5No : ''
				, attr5Nm : ''
				, attr5ValNo : ''
				, attr5Val : ''
				, showSeq : 0
				, addSaleAmt : 0
				, attrValJson : ''
			};

			var itemList = new Array();
			var tempItemList = new Array();
			var itemObj;
			columnIdx = 1;

			for(var i = 0; i < rowIds.length; i++ ) {
				
				var attr = attrGrid.jqGrid("getRowData", rowIds[i] );
				if(attr.attrValJson !== "" ){
					var tempAttrValList = JSON.parse(attr.attrValJson );

					// Temp로 복사
					tempItemList = JSON.parse(JSON.stringify( itemList ));

					// 초기화
					if(itemList.length > 0 ) {
						itemList.splice(0, itemList.length );
					}

					// Item Gen
					for(var j = 0; j < tempAttrValList.length; j++ ) {
						if(columnIdx == 1 ) {
							tempObj = {attr1No : tempAttrValList[j].attrNo, attr1Nm : tempAttrValList[j].attrNm, attr1ValNo : tempAttrValList[j].attrValNo, attr1Val : $.trim(tempAttrValList[j].attrVal) };
						} else if(columnIdx == 2 ) {
							tempObj = {attr2No : tempAttrValList[j].attrNo, attr2Nm : tempAttrValList[j].attrNm, attr2ValNo : tempAttrValList[j].attrValNo, attr2Val : $.trim(tempAttrValList[j].attrVal) };
						} else if(columnIdx == 3 ) {
							tempObj = {attr3No : tempAttrValList[j].attrNo, attr3Nm : tempAttrValList[j].attrNm, attr3ValNo : tempAttrValList[j].attrValNo, attr3Val : $.trim(tempAttrValList[j].attrVal) };
						} else if(columnIdx == 4 ) {
							tempObj = {attr4No : tempAttrValList[j].attrNo, attr4Nm : tempAttrValList[j].attrNm, attr4ValNo : tempAttrValList[j].attrValNo, attr4Val : $.trim(tempAttrValList[j].attrVal) };
						} else if(columnIdx == 5 ) {
							tempObj = {attr5No : tempAttrValList[j].attrNo, attr5Nm : tempAttrValList[j].attrNm, attr5ValNo : tempAttrValList[j].attrValNo, attr5Val : $.trim(tempAttrValList[j].attrVal) };
						}
						if(tempItemList.length > 0 ) {
							for(var tempIdx = 0; tempIdx < tempItemList.length; tempIdx++ ) {
								itemList.push($.extend({}, tempItemList[tempIdx], tempObj ));
							}
						} else {
							itemList.push($.extend({}, defalutOption, tempObj) );
						}
					}
					columnIdx++;
				}
			}

			if(itemList.length > 0 ) {
				for(var i = 0; i < itemList.length; i++ ) {
					var attrValList = new Array();
					itemList[i].itemNm += itemList[i].attr1Val;
					attrValList.push ({attrNo : itemList[i].attr1No, attrValNo : itemList[i].attr1ValNo} );
					if(itemList[i].attr2Val != "") {
						itemList[i].itemNm += "/" + itemList[i].attr2Val;
						attrValList.push ({attrNo : itemList[i].attr2No, attrValNo : itemList[i].attr2ValNo} );
					}
					if(itemList[i].attr3Val != "") {
						itemList[i].itemNm += "/" + itemList[i].attr3Val;
						attrValList.push ({attrNo : itemList[i].attr3No, attrValNo : itemList[i].attr3ValNo} );
					}
					if(itemList[i].attr4Val != "") {
						itemList[i].itemNm += "/" + itemList[i].attr4Val;
						attrValList.push ({attrNo : itemList[i].attr4No, attrValNo : itemList[i].attr4ValNo} );
					}
					if(itemList[i].attr5Val != "") {
						itemList[i].itemNm += "/" + itemList[i].attr5Val;
						attrValList.push ({attrNo : itemList[i].attr5No, attrValNo : itemList[i].attr5ValNo} );
					}

					/**
					2017.05.15, 이성용, webStkQty 는 화면에서 입력하도록 수정함(기본값은 0)
					if(stkMngYn == "${adminConstants.COMM_YN_Y }") {
						webStkQty = 0;
					} else {
						webStkQty = 9999;
					}
					*/

					$("#attrItemList").jqGrid("addRowData", i, $.extend( {}, itemList[i],
							{	addSaleAmt : 0,
								webStkQty : webStkQty,
								attrValJson : JSON.stringify(attrValList ),
								frbPsbYn : $("[name=frbPsbYn]:checked").val(),
								itemStatCd : '${adminConstants.ITEM_STAT_10 }',
								itemListId : i } ),
							"last", null );
				}
			}
			
			return returnMsg;
		}

		/**
		 * [버튼] 상품 등록
		 */
		function insertGoods () {
			
			var lastprice = Number(removeComma($("#goodsInsertForm [name='saleAmt']").val()));
			if(!checkpr(lastprice, "goodsInsertForm")){
				return;
			}
			
			if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === $("[name='goodsCstrtTpCd']").val()){
				// 단품생성- 타입이 단품을 경우
				var reAttrMsg = genAttrItemList();
				if( reAttrMsg !== ""){
					messager.alert(reAttrMsg, "Info", "info");
					return;
				}
			}
		
			var rtnDispObj = dlgtDispYnCheck();
			if(rtnDispObj.length>0){
				var nocheckSt = rtnDispObj.join(",").toString() ;
				messager.alert(" '"+nocheckSt+" '" + "<spring:message code='admin.web.view.msg.goods.invalid.displaycategory' />", "Info", "info");
				return false;
			}else{
				var categorygridData= $("#dispCtgList");

				var beforeStId = "";
				// 그리드 데이터 가져오기
				var categridData = categorygridData.jqGrid('getRowData');
				
				if(categridData.length < 1){
					messager.alert("<spring:message code='admin.web.view.msg.goods.invalid.displaycategory' />", "Info", "info");
					return false;
				}

				for (var j = 0; j < categridData.length; j++) {
					var dupCnt = 0;
					var st = categridData[j].stId;
					beforeStId = st;
					for (var k = 0; k < categridData.length; k++) {
						var nowst = categridData[k].stId;

						if(beforeStId == nowst){
							var dlgt = categridData[k].dlgtDispYn;
							var curStNm = categridData[k].stNm;

							// 중복 check
							if(dlgt=='Y'){
								dupCnt++;
							}
						}
					}
					if(dupCnt > 1){
						messager.alert("<spring:message code='admin.web.view.msg.goods.only.displayYn' />", "Info", "info");
						return false;
					}
				}
			}

			var sendData = null;
			// 날짜..
			$("#saleStrtDtm").val(getDateStr ("saleStrt"));
			$("#saleEndDtm").val(getDateStr ("saleEnd"));
			
			var startDate = new Date($("#saleStrtDtm").val());
		    var endDate = new Date($("#saleEndDtm").val());
		    var nowDate = new Date();
		    var nowDateStr = toDateString(nowDate, "");

		    if(startDate.getTime() > endDate.getTime()) {
		        messager.alert("종료날짜보다 시작날짜가 작아야 합니다.", "Info", "info");
		        return false;
		    }
		    
		   /*  
		   if(nowDate.getTime() > startDate.getTime()) {
		        messager.alert("시작날짜가 현재날짜보다 크거나 같아야 합니다.", "Info", "info");
		        return false;
		    } 
		   */
		   
		   var saleStrtDt = $("#saleStrtDt").val();
		   
		   if(nowDateStr > saleStrtDt.replaceAll("-", "")) {
		        messager.alert("시작날짜가 현재날짜보다 크거나 같아야 합니다.", "Info", "info");
		        return false;
		    }
		    

			var stGoodsMapPO = new Array();
			$("#goodsInsertForm [name='stId']").prop('disabled', false);
			var chkStCnt = $("input[name='stId']:checked").length;
			if(chkStCnt ==0){
				messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
				return false;
			}else{
				$("input[name='stId']:checked").each(function(index, ob){
					stGoodsMapPO.push( {stId : $(this).val() , goodsId : $("#goodsId").val() } );
				});
			}
			
			// 최소, 최대 개수 체크
			if(parseInt($("#minOrdQty").val()) > parseInt($("#maxOrdQty").val())){
				messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.minOrdQty' />", "Info", "info", function(){
					$("#minOrdQty").focus();
				});
				return;
			}

			// 재고갯수 체크[ 재고관리Y, 단품관리N 일 경우] hjko 2017.06.23
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			var itemMngYn =$(":radio[name=itemMngYn]:checked").val();

			var webStkQty = 0;
			if(stkMngYn == "${adminConstants.COMM_YN_N }" ) {
				webStkQty = 9999;
			}else{
				if(itemMngYn =="${adminConstants.COMM_YN_N }" ) {
					var allRowsInGrid = $('#attrItemList').jqGrid('getGridParam', 'data');
					var stk = 0;
					for(var i = 0; i < allRowsInGrid.length; i++ ) {
						stk = allRowsInGrid[i].webStkQty;
						if(stk == '0'){
							messager.alert("<spring:message code='admin.web.view.msg.goods.mng.webStkQty.min' />", "Info", "info");
							return false;
						}
					}
				}
			}
			
			if($("[name='expMngYn']:checked").val() === '${adminConstants.COMM_YN_N}'){
				$("[name='expMonth']").prop('disabled', true);
				$("[name='expMonth']").val('');
			}
			
			// editor setting
			oEditors.getById["contentPc"].exec("UPDATE_CONTENTS_FIELD", []);
			oEditors.getById["contentMobile"].exec("UPDATE_CONTENTS_FIELD", []);
// 			oEditors.getById["content_caution"].exec("UPDATE_CONTENTS_FIELD", []);

			// 상품 상세 목록 노출 여부...... 
			if($("[name='attrShowYn']").prop('checked')) {
				$("#attrShowTpCd").val("${adminConstants.ATTR_SHOW_TP_00}");
			} else {
				$("#attrShowTpCd").val("${adminConstants.ATTR_SHOW_TP_20}");
			}
			
			// 상품명 좌우공백 제거
			var originalGoodsNm = $('#goodsNm').val();

			if(originalGoodsNm != null){
				var trimGoodsNm = originalGoodsNm.replace(/&nbsp;/gi,"").replace(/&nbsp/gi,"").replace(/&#160;/gi,"").replace(/&#160/gi,"").trim();
				$('#goodsNm').val(trimGoodsNm);
			}
			
			if(validate.check("goodsInsertForm")) {
				var formData = $("#goodsInsertForm").serializeJson();
				var attrList;
				var optGrpList;
				var itemList;
				var goodsCstrtList = grid.jsonData ("goodsCstrtList" );
				var dispCtgList = grid.jsonData ("dispCtgList" );
				var goodsNotifyList = new Array();
				var goodsDescList = new Array();
				var goodsImgList = new Array();
				var goodsCaution;
				var goodsIconList = new Array();
				var filtAttrMapList = new Array();
				var goodsTagMapList = new Array();
				var arg = "";

				// 상품 구성에 따른 validCheck
				if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === $("[name='goodsCstrtTpCd']").val()){
					attrList = grid.jsonData ("attrList" );
					
					// 유통기한 월 입력
					if($("[name='expMngYn']:checked").val() == '${adminConstants.COMM_YN_Y}' && $("[name='expMonth']").val() =='' ){
						messager.alert("유통기한 월을 입력하여 주세요.", "Info", "info");
						return;
					}
					
					// 옵션을 먼저 등록하세요.
					if(attrList.length <= 0 ) {
						messager.alert("<spring:message code='column.goods.no_attr' />", "Info", "info");
						return;
					}
					
					// 단품
					itemList = grid.jsonData ("attrItemList");
					if(itemList.length <= 0 || attrList.length <= 0 ) {
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.item' />", "Info", "info");
						return;
					}
					
				}else if("${adminConstants.GOODS_CSTRT_TP_SET}" === $("[name='goodsCstrtTpCd']").val()){

					// 세트 1개이상 등록
					attrList = grid.jsonData ("attrList" );
					var listLength = attrList.length;

					if(listLength < 1 ) {
						arg = "<spring:message code='column.goods.cstrtTpCd.set' />";
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.count' arguments='"+ arg +", 1' />", "Info", "info" );
						return;
					}else{

						var cstrtQty = 0;

						if(listLength == 1){ // 세트 구성 상품이 1개일때

							if(attrList[0].cstrtQty < 2){
								arg = "<spring:message code='column.goods.cstrtTpCd.set' />";
								messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.qty' arguments='"+ arg +", 2' />", "Info", "info" );
								return;
							}

						}else{ // 세트 구성 상품이 1개 이상 일때

							for(var i = 0; i < listLength; i++){
								if(attrList[i].cstrtQty < 1){
									arg = "<spring:message code='column.goods.cstrtTpCd.set' />";
									messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.qty' arguments='"+ arg +", 1' />", "Info", "info" );
									return;
								}
							}
						}
					}

				}else if("${adminConstants.GOODS_CSTRT_TP_ATTR}" === $("[name='goodsCstrtTpCd']").val()){
					// 옵션 2개이상등록
					attrList = grid.jsonData ("attrList" );
					
					optGrpList = grid.jsonData ("optGrpList" )
					if(attrList.length < 2 ) {
						arg = "<spring:message code='column.goods.cstrtTpCd.attr' />";
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.count' arguments='"+ arg +", 2' />", "Info", "info" );
						return;
					}
				}else if("${adminConstants.GOODS_CSTRT_TP_PAK}" === $("[name='goodsCstrtTpCd']").val()){
					attrList = grid.jsonData ("attrList" );
					// 묶음 2개이상 등록
					if(attrList.length < 2 ) {
						arg = "<spring:message code='column.goods.cstrtTpCd.pak' />";
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.count' arguments='"+ arg +", 2' />", "Info", "info" );
						return;
					}
				}

				// 공정위 품목군 Load
				$("input[name=ntfItemId]").each (function () {
					var itemVal = $(this).siblings("#itemVal" + $(this).val()).val();
					goodsNotifyList.push ({
						ntfItemId : $(this).val()
						, itemVal : itemVal
					});
				});

				if( $('#contentPc').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "" ) {	// 공백일 경우
					if($("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}'){
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.contentPc' />", "Info", "info");
						return false;
					}
				}else{
					goodsDescList.push({
						svcGbCd : '${adminConstants.SVC_GB_10 }'
						, content : $('#contentPc').val()
					});
				}
				
				if($('#contentMobile').val() != "<p>&nbsp;</p>" ) {	// 공백인 경우
					goodsDescList.push({
						svcGbCd : '${adminConstants.SVC_GB_20 }'
						, content : $('#contentMobile').val()
					});
				}

				// 상품 이미지
				var dlgtYnCnt = 0;
				var bannerImgCnt = 0;
				$("input[name=imgPath]").each (function (idx ) {
					var goodsImgIdx = $(this).siblings("input[name=imgSeq]").val();
					var imgPath = $("#imgPath" + goodsImgIdx).val();
					var dlgtYn = $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N';
					var imgTpCd = $("#imgTpCd" + goodsImgIdx).val();

					if(dlgtYn == 'Y' && imgPath == ""){
						dlgtYnCnt++;
					}
					
					// 배너 이미지 체크
					if(goodsImgIdx === '11' && imgPath != "" && imgPath != null){
						bannerImgCnt = 1;	
					}

					if(imgPath != "") {
						goodsImgList.push({
							imgPath : imgPath
							, dlgtYn : $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N'
							, imgSeq : goodsImgIdx
							, imgTpCd : imgTpCd
						});
					}

				});
				
// 				if (bannerImgCnt < 1) {
// 					messager.alert("<spring:message code='column.goods.img.regist.banner' />", "Info", "info");
// 					return;
// 				}
				
				if ($("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}' && goodsImgList.length < (bannerImgCnt < 1 ? 1 : 2 )) { // webMobileGbCd 오프라인 이미지 유효성 제외
					messager.alert("<spring:message code='column.goods.img.regist' />", "Info", "info");
					return;
				}

				if(dlgtYnCnt > 0){
					messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.unregistered.image' />", "Info", "info");
					return;
				}
				
				// 아이콘
				$("[name='iconCode']:checked").each (function (idx ) {
					goodsIconList.push({
						goodsIconCd : $(this).val()
						, strtDtm : $("#iconStrtDtm" + $(this).val()).val()
						, endDtm : $("#iconEndDtm" + $(this).val()).val()
					});
				})
				
				// 필터
				$("[name='filtAttrSeq']:checked").each (function (idx ) {
					filtAttrMapList.push({
						filtAttrSeq : $(this).val()
						, filtGrpNo : $(this).data('filtgrpno')
					});
				})
				
				// 태그
				$(".goodsTagNos").each (function (idx ) {
					goodsTagMapList.push({
						tagNo : $(this).data('tag')
					});
				})
				
				if(goodsTagMapList.length < 1){
					messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.tag' />", "Info", "info");
					return;
				}

				// Form 데이터
				sendData = {
					goodsBasePO : JSON.stringify(formData )
					, goodsPricePO : JSON.stringify(formData )
					, goodsNaverEpInfoPO : JSON.stringify(formData )
					, attributePO : JSON.stringify(attrList )
					, optGrpPO : JSON.stringify(optGrpList )
					, itemPO : JSON.stringify(itemList )
					, goodsNotifyPO : JSON.stringify(goodsNotifyList)
					, goodsCstrtInfoPO : JSON.stringify(goodsCstrtList )
					, displayGoodsPO : JSON.stringify(dispCtgList )
					, filtAttrMapPO : JSON.stringify(filtAttrMapList )
					, goodsTagMapPO : JSON.stringify(goodsTagMapList )
					, goodsIconPO : JSON.stringify(goodsIconList )
					, goodsImgPO : JSON.stringify(goodsImgList )
					, contentPc : $("#goodsInsertForm #contentPc").val()
					, contentMobile : $("#goodsInsertForm #contentMobile").val() == '<p>&nbsp;</p>' ? '' : $("#goodsInsertForm #contentMobile").val()
					, goodsCautionPO : JSON.stringify(goodsCaution )
					, stGoodsMapPO : JSON.stringify(stGoodsMapPO )
				}
				//console.debug (sendData );

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/goodsInsert.do' />"
							, data : sendData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
									viewGoodsDetail (data.result.goodsId );
								});									
							}
						};
						ajax.call(options);
					}
				});
			}
		}

		/**
		 * [버튼] 단품/세트/묶음/옵션 정보 삭제
		 * @param id
		 */
		function deleteGridRow (id ) {
				
			var grid = $("#" + id );
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');

			if(rowids.length < 1 ){
				messager.alert("<spring:message code='admin.web.view.msg.deal.select.good' />", "Info", "info");
			}

			for (var i = rowids.length - 1; i >= 0; i--) {
				grid.jqGrid('delRowData', rowids[i]);
			}
			<c:if test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}">
			calcStkQty();			
			</c:if>
		}

		//FIXME 확인 후 삭제 - 어디서 쓰는지 확인해야 함
		function resetAttrList(){
			var grid= $("#attrList");
			grid.setColProp("attrNo",{ editoptions: { value: listAttribute}});
		}

		//update insert 공통  이지만 시간차 오류가 있어 분리
		function initEditor () {
			EditorCommon.setSEditor('contentPc', '${adminConstants.GOODS_DESC_IMAGE_PTH}');
			EditorCommon.setSEditor('contentMobile', '${adminConstants.GOODS_DESC_IMAGE_PTH}');
			//EditorCommon.setSEditor('content_caution', '${adminConstants.GOODS_CAUTION_IMAGE_PTH}');
		}
			
		// ui 제어 공통  이지만 시간차 오류가 있어 분리
		function initUI(){
			fnControlUI();
		}
	
		// PCARE-11 kjh02 2021-08-09 관상어, 소동물 성분정보연동여부 disabled 처리
		$(function(){
			$("select[name=petGbCd]").bind("change", function(){
				var petGbCd = $(this).val();
				if(petGbCd ==40||petGbCd ==50){
					$("#igdtInfoLnkYnY").attr("disabled",true);
					$("#igdtInfoLnkYnY").attr("checked",false);
				}else if(petGbCd ==10||petGbCd ==20){
					$("#igdtInfoLnkYnY").attr("disabled",false);
				} else {
					$("#igdtInfoLnkYnY").attr("disabled",false);
					$("#igdtInfoLnkYnY").attr("checked",false);
				}
			})
		}) 

		
	</script>
	</t:putAttribute>

		<t:putAttribute name="content">

<form id="goodsInsertForm" name="goodsInsertForm" method="post" >
	<input type="hidden" id="saleStrtDtm" name="saleStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="saleEndDtm" name="saleEndDtm" class="validate[required]" value="" />
	<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${adminConstants.GOODS_TP_10 }" />
	<input type="hidden" id="resultAttrValNoArray" name="resultAttrValNoArray" value=""/>
	
	<div id="goods_pannel" class="easyui-accordion" data-options="multiple:true" style="width:100%">
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsBaseInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsItemInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incTwcProductInfo.jsp" /> <!-- 영양정보, 주원료, 상세정보, 상품필수정보  : 연동정보 -->
	    <jsp:include page="/WEB-INF/view/goods/include/incGoodsNaverEpInfo.jsp" /> <!-- 네이버 ep 정보 -->
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsDeliveryInfo.jsp" /> <!-- 배송 정보  분리 -->
	    <jsp:include page="/WEB-INF/view/goods/include/incGoodsDispInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsFilterInfo.jsp" />
	    <jsp:include page="/WEB-INF/view/goods/include/incGoodsIconInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsPriceInfo.jsp" />
		<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd or adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}" >
			<jsp:include page="/WEB-INF/view/goods/include/incGoodsEstmInfo.jsp" />
		</c:if>
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsImageInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsDescInfo.jsp" />
	<%-- 	<jsp:include page="/WEB-INF/view/goods/include/incGoodsCautionInfo.jsp" /> --%>
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsNotifyInfo.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsCstrtInfo.jsp" />
		<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
			<jsp:include page="/WEB-INF/view/goods/include/incGoodsMdPickInfo.jsp" /> <!-- md Pick -->
		</c:if>
	</div>
</form>

		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="insertGoods();" >등록</button>
			<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
		</div>


		</t:putAttribute>

</t:insertDefinition>