<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<c:set var="fstGoodsYn" value="${checkPossibleCnt.firstUpdateCnt > 0 or empty goodsBase ? 'false' : 'true'}" scope="request" />

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.77.0.min.js"></script>
	<script type="text/javascript">
		var invaldateCloudFront;
		
		$(document).ready(function() {
			var panels = $('#goods_pannel').accordion('panels');
			$.each(panels, function() {
				this.panel('expand');
			});
			
			// 에디터
			initEditor ();

			invaldateCloudFront = false;

			<c:if test="${layout eq 'popupLayout'}">
				$(".popContent input").attr("disabled","disabled");
				$(".popContent select").attr("disabled","disabled");
				$(".popContent radio").attr("disabled","disabled");
				$(".popContent button").attr("disabled","disabled");

				$("#goodsHistoryBtn").removeAttr("disabled");
				$("#btn2").removeAttr("disabled");
				$("#btn2").attr("onclick", "").unbind("click");
				$("#btn2").bind("click", function (){
						popupClose();
					});
			</c:if>

			// 전시 카테고리
			createDispCtgList ();
			// 연관 상품
			createGoodsCstrtList ();
			// 옵션 / 단품
			createAttrList ();
			
			if("${goodsCstrtTpCd}" === "${adminConstants.GOODS_CSTRT_TP_ATTR}"){
				createOptGrpList();
			}
						
			$("[name=iconCode]").each(function(index,obj){
				<c:forEach items="${goodsIconList}" var="icon" varStatus="status">
					if($(this).val() === "${icon.goodsIconCd}"){
						$(this).prop("checked", true);
						if("${not empty icon.strtDtm}"){
							$("#iconStrtDtm"+$(this).val()).val("${icon.strtDtm}");	
							$("#iconEndDtm"+$(this).val()).val("${icon.endDtm}");	
						}
					}
				</c:forEach>
			});

			$(":radio[name=stkMngYn]").change(function () {
				//checkStkMngYn ();
			});

			var itemOrgTotCnt ;
			//-------------------------------------------------------------------------
			// siteId 때문에 hjko 추가. 2017.01.10
			//1. 상세페이지는 사이트관리에 체크되어 있는 사이트만 가져와서 체크박스를 뿌려줌.
			//2. 업체상품 매핑에 들어있으면 체크박스 체크함.
			//3. 체크된 값 가지고 와서 밑에 전시카테고리 추가 할 사이트를  disable/ enable 해줌
			$("input[name='stId']").click(function(){
				if ( $(this).prop('checked') ) {
			        $(this).addClass("checked");
			      } else {
			        $(this).removeClass("checked");
			      }
			});
			// 사이트 체크된 값들 목록
			var chkSts = new Array();
			$("input[name=stId]:checked").each(function(index,obj){
				chkSts.push( $(this).val() );
			});
			// 사이트셀렉트박스 체크 안된것들 disable
			$("#stIdCombo option").not(":selected").attr("disabled", "");

			// 사이트셀렉트박스 체크 안된것들 중에서 사이트 체크된 값들을 enable
			for(var i=0 ; i< chkSts.length ; i++){
				$("select[name='stIdCombo']").find("option[value="+chkSts[i]+"]").prop("disabled", false);
			}

			if($("#goodsUpdateForm [name='stId']").length < 2){
				$("#goodsUpdateForm [name='stId']").prop('disabled', true);
			}
			//상품상태 콤보박스 제어			
			<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd and !empty goodsBase}">
				$('#goodsStatCd option').each(function(){ 
					if (this.value != "${adminConstants.GOODS_STAT_10}" && this.value != "${adminConstants.GOODS_STAT_20}" && this.value !="${goodsBase.goodsStatCd}"){
						$(this).attr("disabled", "disabled");
					}				
				});
			</c:if>
			

			$("input:radio[name=webMobileGbCd]").change(function () {
				if($("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}'){
					$(".offLineCntrl").html("*");
				}else{
					$(".offLineCntrl").html("");
				}
			});
		});
		
		function goodsHistory () {
			var options = {
				histGb : 'GOODS_DETAIL'
				, goodsId : '${goodsBase.goodsId }'
			}
			layerHistoryList.create (options );
		}

		var firstloadYn = false;

		// 처음 로딩할 때 단품갯수 . hjko
		var defaultItemListCnt  = 0 ;

		// 개별 - 합쳐야됨
		function deleteGridRow (id ) {
			
			// 단품 삭제 불가
			if("${checkPossibleCnt.checkCstrtUpdCnt != '0'}" === 'true' && "${adminConstants.GOODS_CSTRT_TP_ITEM}" === "${goodsCstrtTpCd}" && id !== "goodsCstrtList"){
				messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.item.delete' />", "Info", "info");
				return;
			}
			
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
			<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM ne goodsCstrtTpCd}">
			setdlgtGoodsYn();		
			</c:if>
		}

		// 상품 상태 변경
		$(document).on("change", "#goodsStatCd", function() {

			var goodsStatCd = "${goodsBase.goodsStatCd}";
			var newGoodsState = $(this).val();

			if (newGoodsState < goodsStatCd) {
				if (newGoodsState == '${adminConstants.GOODS_STAT_10}' && goodsStatCd == '${adminConstants.GOODS_STAT_20}') {
					// 승인요청 --> 대기로 변경은 허용함.
					messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_wait" />", "Info", "info");
				} else if (newGoodsState == '${adminConstants.GOODS_STAT_40}' && goodsStatCd == '${adminConstants.GOODS_STAT_50}') {
					// 판매중지 --> 판매중으로 변경은 허용함.
					messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_restart" />", "Info", "info");
				} else if (newGoodsState == '${adminConstants.GOODS_STAT_10}' && goodsStatCd == '${adminConstants.GOODS_STAT_30}') {
                    // 승인거절 --> 대기로 변경은 허용함.
                    messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_rejectwait" />", "Info", "info");
                } else if (newGoodsState == '${adminConstants.GOODS_STAT_20}' && goodsStatCd == '${adminConstants.GOODS_STAT_30}') {
                    // 승인거절 --> 승인요청으로 변경은 허용함.
                    messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_reapply" />", "Info", "info");
                } else {
					// 이전 단계로 변경은 허용하지 않음.
					messager.alert("<spring:message code='admin.web.view.app.goods.manage.detail.alert.goods_state_invalid' />", "Info", "info", function(){
						$("#goodsStatCd").val(goodsStatCd);
					});
				}
			}
		});
		
		// 라디오 커스텀 이벤트
		function radioCustomEvent(obj, rowid){
			$("#attrList").jqGrid('setCell', rowid, 'showYn', $(obj).val());
		}

		// attribute 옵션 목록
		function createAttrList () {
			
			var setOption = setAttrColModels("${goodsCstrtTpCd}");
			
			var options = {
				searchParam : {goodsId : '${goodsBase.goodsId }' }
				, paging : false
				, cellEdit : true
				, height : 200
				, multiselect : true // TODO  수정 가능에 따라 멀티 셀렉트 제어 필요
				, afterEditCell : function ( rowid, name, val, iRow, iCol){
					var grid = $("#attrList");
					$("#"+iRow+"_"+name).bind('blur',function(){
						grid.saveCell(iRow,iCol);
					 });
				}
				, afterSaveCell : function ( rowid, name, val, iRow, iCol){
					
					if(name === "attrVal"){
						var tempAttrValList = new Array();
						var attr = $("#attrList").getRowData(rowid);
						var	tempAttrValObj = {attrNo : attr.attrNo
								, attrNm : $.trim(attr.attrNm)
								, attrValNo : attr.attrValNo
								, attrVal : val
								, useYn : '${adminConstants.COMM_YN_Y }' };
						
						tempAttrValList.push(tempAttrValObj);
						
						$("#attrList").jqGrid("setCell", rowid, "attrValJson", JSON.stringify(tempAttrValList));
					}
					<c:if test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}">
					calcStkQty();			
					</c:if>
				}
				, loadComplete : function(data) {
					if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== "${goodsCstrtTpCd}"){
						if("${checkPossibleCnt.checkCstrtUpdCnt}" === '0'){
							dragAndDrop("attrList", "dispPriorRank");					
						}
						//대표상품여부 컬럼 추가. 최 상단 row 가 Y.20210611
						setdlgtGoodsYn();
					
					}else{
// 						fnSetItemAttr();
					}
					
					// 옵션상품일 경우, 옵션명을 셋팅해 준다.
					if( "${adminConstants.GOODS_CSTRT_TP_ATTR}" == "${goodsCstrtTpCd}" ) {
						 if ( data.data.length > 0 ) {
							// 옵션명 라벨 변경
							jQuery("#attrList").jqGrid("setLabel", "attr1Val", data.data[0].attr1Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr2Val", data.data[0].attr2Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr3Val", data.data[0].attr3Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr4Val", data.data[0].attr4Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr5Val", data.data[0].attr5Nm);
						}
					}
					// 기존 정보 저장
					orgAttrList = grid.jsonData ("attrList" );
				}
			};
			
			options = $.extend({}, setOption, options);

			grid.create("attrList", options);
		}
		
		function makeNewRowId(rowids){
		   var max =	rowids;

		   return eval(max) + 1;
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
					for(var i=0; i< 4-$("#attrList").length ; i++){
						var ln =$("#attrList").jqGrid('getGridParam', 'records');
						var newRowid = makeNewRowId(ln);
						$("#attrList").jqGrid('addRowData', newRowid, addData, 'last', null );
					}
				}

			};
			ajax.call(options);
		}

		
		// 상품 구성 유형에 따른 옵션 세팅
		function setAttrColModels(goodsCstrtTpCd){
			
			var setColModels = '';
			var setUrl = '';
			var setGridComplete = '';
	        var firstAttrChk = true;
	        var firstAttrArr = new Array();
		
			// 단품 일 경우
			if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === goodsCstrtTpCd || goodsCstrtTpCd === ""){
				
				setUrl = "<spring:url value='/goods/goodsAttributeGrid.do' />";
				setColModels = [
					{name:"attrNo", label:'<spring:message code="column.goods.option" />', width:"200", align:"center", key: true
						, hidden:true
						<c:choose>
							<c:when test="${goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_10 || goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_30}">
								, hidden:false
								<c:if test="${checkPossibleCnt.checkCstrtUpdCnt eq '0'}" >
								, editable:true
								</c:if>
								, edittype:'select'
								, formatter:"select"
								, editoptions:{ value: listAttribute()
								, dataEvents:[
								   { type: "change", fn: function(e){
		
									   var griddataArray = new Array();
									   var row = $(e.target).closest('tr.jqgrow');
									   var attrCheck= false;
									   var rowid = row.attr('id');
									   var selectboxId = $('tr#' + rowid + ' select').attr('id').split('_')[0];
		
									   $("#"+selectboxId+"_attrNo > option[value='"+$(e.target).val()+"']").attr("selected", "true");
									   var comboVal = $("#"+selectboxId+"_attrNo option:selected").val();
									   var comboText = $("#"+selectboxId+"_attrNo option:selected").text();
		
									   // 중복체크
									   var drowids = $("#attrList").jqGrid('getDataIDs');
		
										var duplicateYn = false;
										var toDelRowid = "";
		
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
												toDelRowid = rowid;
												messager.alert("[ " +rowdata.attrNm + " ]" + "<spring:message code='admin.web.view.msg.common.dupl.attribute' />", "Info", "info");
												duplicateYn = true;
												continue;
											}else{
		
												if(beforeAttrNo != '' ){
													if ((rowdata.attrNo != 0) &&(rowdata.attrNo !='')){
														griddataArray.push(rowdata);
													}
												}
		
											}
											beforeAttrNo = rowdata.attrNo;
										}
		
										if(duplicateYn){
											$("#attrList").jqGrid('delRowData',toDelRowid);
											jQuery("#attrList").clearGridData();
											jQuery("#attrList").trigger("reloadGrid");
										}
		
										if( toDelRowid != '' ){
											for( var k = 0 ; k < griddataArray.length ; k++){
												$("#attrList").jqGrid("addRowData",k+1, griddataArray[k]);
											}
										}
									}
								   },
								   { type: "focus", fn: function(e){
									   var attrCheck= false;
			 							var row = $(e.target).closest('tr.jqgrow');
			 							if($(e.target).val() != 0){
			 								var selectboxId = $('tr#' + $(e.target).val() + ' select').attr('id').split('_')[0];
				 							var rowid = row.attr('id');
											$("#"+selectboxId+"_attrNo > option[value='"+$(e.target).val()+"']").attr("selected", "true");
											var comboVal = $("#"+selectboxId+"_attrNo option:selected").val();
											var comboText = $("#"+selectboxId+"_attrNo option:selected").text();
											$("#attrList").jqGrid('setCell', rowid, 'attrNm' , comboText);
								   		}
									}
								   }
								]
								}
							</c:when>
							<c:otherwise>
								, hidden:true
							</c:otherwise>
						</c:choose>
					, sortable:false} /* 단품옵션 번호 */
					, {name:"attrNm", label:'<spring:message code="column.goods.option" />', width:"200", align:"center", editable:false, sortable:false
						<c:if test="${goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_10 || goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_30}">
							, hidden:true
						</c:if>
					} /* 단품옵션 */
					, {name:"attrVal", label:'<spring:message code="column.goods.option.value" />', width:"500", align:"center", sortable:false 
						<c:if test="${checkPossibleCnt.checkCstrtUpdCnt eq '0'}" >
							// 수정가능
							, editable:true
						</c:if>
					}
					, {name:"attrValNo", label:'', width:"200", align:"center", hidden:true, sortable:false } /* 단품옵션값 번호 */
					, {name:"attrValJson", label:'', width:"1000", align:"center", hidden:true, sortable:false } /*  */
					, {name:"useYn", label:'', width:"100", align:"center", hidden:true, sortable:false } /*  */
				]
				setGridComplete = function () {
					if (firstAttrChk) {
						firstAttrArr = $("#attrList").getRowData();
					}
					firstAttrChk = false;
					createItemList ();

					// 주문수량, 세트수량, 묶음 수량, 최초수정 카운트
					// checkPossibleCnt.ordCnt
					// checkPossibleCnt.setCnt
					// checkPossibleCnt.pakCnt
					// checkPossibleCnt.firstUpdateCnt
					
				}
			
			} else if("${adminConstants.GOODS_CSTRT_TP_SET}" === goodsCstrtTpCd){
				
				setUrl = "<spring:url value='/goods/goodsCstrtSetGrid.do' />";
				setColModels = [
					{name:"subGoodsId", label:'<spring:message code="column.statistics.goods_id" />', width:"150", key:true, align:"center", editable:false, hidden:false ,sortable:false}
					, {name:"goodsNm", label:'<spring:message code="column.goodsNm" />', width:"480", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
					, {name:"cstrtQty", label:'<spring:message code="column.order_common.cstrt_qty" />', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer'  
						<c:if test="${checkPossibleCnt.checkCstrtUpdCnt eq '0'}" >
							// 수정가능
							, editable:true
						</c:if>
					}
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
					, {name:"isChanged", hidden:true}
					, {name:"dlgtGoodsYn", label:'<spring:message code="column.goods.dlgt_goods_yn" />', width:"150", align:"center", hidden:false , editable:false, sortable:false}
				]
				
			}else if("${adminConstants.GOODS_CSTRT_TP_PAK}" === goodsCstrtTpCd){
				
				setUrl = "<spring:url value='/goods/goodsCstrtPakGrid.do' />";
				setColModels = [
					{name:"subGoodsId", label:'<spring:message code="column.statistics.goods_id" />', width:"200", key:true, align:"center", editable:false, hidden:false ,sortable:false}
					, {name:"goodsNm", label:'<spring:message code="column.goodsNm" />', width:"400", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"webStkQty", label:'단품재고수량', width:"120", align:"center", hidden:false, sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}  }
					, {name:"saleAmt", label:'<spring:message code="column.price" />', formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','}, width:"150", align:"center", hidden:false , editable:false, sortable:false }
					, {name:"radioShowYn", label:'<spring:message code="column.goods.comment.display_used" />', width:"200", align:"center", hidden:false , editable:false, sortable:false, 
						formatter: function(cellValue, options, rowObject) {
						
					    var checkedY = rowObject['showYn'] === 'Y' ? 'checked' : '';
					    var checkedN = rowObject['showYn'] === 'N' ? 'checked' : '';
					    
					    var	returnTxt = '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="Y" '+ checkedY +' onclick="radioCustomEvent(this, \'' + options.rowId  + '\')" ><span>노출</span></label>';
							returnTxt += '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="N" '+ checkedN +' onclick="radioCustomEvent(this, \'' + options.rowId + '\')" ><span>미노출</span></label>';
							
						return returnTxt;
					}}	
					, {name:"cstrtShowNm", label:'<spring:message code="column.goods.cstrtShowNm" />', width:"400", align:"center", hidden:false, sortable:false, hidden:true}
					, {name:"dispPriorRank", label:'', width:"200", align:"center", hidden:true }
					, {name:"goodsId", label:'', width:"200", align:"center", hidden:true }
					, {name:"showYn", label:'', width:"150", align:"center", hidden:true}
					, {name:"isChanged", hidden:true}
					, {name:"dlgtGoodsYn", label:'<spring:message code="column.goods.dlgt_goods_yn" />', width:"150", align:"center", hidden:false , editable:false, sortable:false}
				]

			}else if("${adminConstants.GOODS_CSTRT_TP_ATTR}" === goodsCstrtTpCd){
				setUrl = "<spring:url value='/goods/goodsCstrtPakGrid.do' />";
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
					, {name:"isChanged", hidden:true}
					, {name:"radioShowYn", label:'<spring:message code="column.goods.comment.display_used" />', width:"200", align:"center", hidden:false , editable:false, sortable:false, 
						formatter: function(cellValue, options, rowObject) {
						
					    var checkedY = rowObject['showYn'] === 'Y' ? 'checked' : '';
					    var checkedN = rowObject['showYn'] === 'N' ? 'checked' : '';
					    
					    var	returnTxt = '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="Y" '+ checkedY +' onclick="radioCustomEvent(this, \'' + options.rowId  + '\')" ><span>노출</span></label>';
							returnTxt += '<label class="fRadio"><input type="radio" name="radioShowYn_'+ options.rowId +'" id="radioShowYn_'+ options.rowId +'" value="N" '+ checkedN +' onclick="radioCustomEvent(this, \'' + options.rowId + '\')" ><span>미노출</span></label>';
							
						return returnTxt;
					}}
					, {name:"dlgtGoodsYn", label:'<spring:message code="column.goods.dlgt_goods_yn" />', width:"150", align:"center", hidden:false , editable:false, sortable:false}
				]
			}
			
			return { colModels : setColModels
					, url : setUrl
					, gridComplete : setGridComplete };
			
		}
				
		function createItemList () {
				
			// 옵션 조회
			var attrGrid = $("#attrList");
			var rowIds = attrGrid.jqGrid("getDataIDs");

			// 재고 관리 여부
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			var webStkQty = 0;

			var allNewCol = 0;
			var columnIdx = 1;
			var columns = new Array();
			// Key
			columns.push({name : 'itemNo', label : '<spring:message code="column.item_no" />', width : '100', align : 'center', hidden:false, sortable : false });

			columns.push({name : 'itemNm', label : '<spring:message code="column.item_nm" />', width : '150', align : 'center', editable:false, sortable : false });
			// 추가 [옵션 리스트]
			//------------ 컬럼들 생성
			for(var i = 0; i < rowIds.length; i++ ) {
				var attr = attrGrid.jqGrid("getRowData", rowIds[i]);
				if (attr.attrNo === '' || attr.attrVal === '') {
					allNewCol += 1;
				}
				if(attr.attrNm != "" ) {
					var attrIdx = "attr" + columnIdx;
					columns.push({name : attrIdx + 'No', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'Nm', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'ValNo', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'Val', label : attr.attrNm, width : '100', align : 'center', editable:false, sortable : false });

					var attrVal = attr.attrVal.split(",");
					// 등록된 옵션에 대한 처리
					var tempAttrValObj;
					var tempAttrValList = new Array();

					for(var attrValIdx = 0; attrValIdx < attrVal.length; attrValIdx++ ) {
						tempAttrValObj = {attrNo : attr.attrNo
									, attrNm : $.trim(attr.attrNm)
									, attrValNo : (attrValIdx + 1)
									, attrVal : attrVal[attrValIdx]
									, useYn : '${adminConstants.COMM_YN_Y }' };

						tempAttrValList.push(tempAttrValObj);
					}
// 					attrGrid.jqGrid("setCell", attr.attrNo, "attrValJson", JSON.stringify( tempAttrValList ));
					columnIdx++;
				}
			}
			// 웹 재고
			columns.push({name : 'webStkQty', label : '<spring:message code="column.web_stk_qty" />', width : '100', align : 'center', editable:true, sortable : false });
			// 사은품 가능 여부
			columns.push({name : 'frbPsbYn', label : '<spring:message code="column.goods.frbPsbYn" />', width : '100', align : 'center', sortable:false, editable:true , formatter:'select',edittype:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.FRB_PSB_YN}' showValue='false' />"}});
			// 판매여부
			columns.push({name : 'itemStatCd', label : '<spring:message code="column.item_stat_cd" />', width : '100', align : 'center', editable:true, sortable:false, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.ITEM_STAT}' showValue='false' />"}} );
			// 추가 금액
			columns.push({name : 'addSaleAmt', label : '<spring:message code="column.add_sale_amt" />', width : '100', align : 'center', editable:true, sortable : false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} });
			// 노출 순서
			columns.push({name : 'showSeq', label : '<spring:message code="column.show_seq" />', width : '100', align : 'center', editable:true, sortable : false });
			// attribute List
			columns.push({name : 'attrValJson', label : '', width : '1000', align : 'center', hidden:true, sortable : false });
			//
			columns.push({name : 'itemListId', label : '', width : '100', align : 'center', hidden:true, key:true, sortable:false });
			//---------- 컬럼생성끝

			// 옵션 조회
			var attrItemGrid = $("#attrItemList");
			var rowIdsItem = attrItemGrid.jqGrid("getDataIDs");
			var newItemCol = 0;
			for(var i = 0; i < rowIdsItem.length; i++ ) {
				var attrItem = attrItemGrid.jqGrid("getRowData", rowIdsItem[i]);
				if (attrItem.itemNo === "") {
					newItemCol += 1;
				}
			}

			if (allNewCol != rowIds.length && newItemCol != rowIdsItem.length){
				// Grid 초기화
				$.jgrid.gridUnload("#attrItemList");
				$.jgrid.gridUnload("#attrItemListCopy"); //hjko
				
			}
			
			if (newItemCol == 0 && rowIdsItem.length == 0) {
				// Create Item Grid
				var options = {
					url : "<spring:url value='/goods/goodsItemGrid.do' />"
					, searchParam : {goodsId : '${goodsBase.goodsId }' }
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
					, gridComplete : function () {
						if(!firstloadYn){
							defaultItemListCnt = $("#attrItemList").getDataIDs().length;
						}
						
						firstloadYn = true;
					}
				};
				grid.create("attrItemList", options);
			}
			
			if (newItemCol != rowIdsItem.length) {
				// Create Item Grid
				var options = {
					url : "<spring:url value='/goods/goodsItemGrid.do' />"
					, searchParam : {goodsId : '${goodsBase.goodsId }' }
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
					, gridComplete : function () {
						if(!firstloadYn){
							defaultItemListCnt = $("#attrItemList").getDataIDs().length;
						}
						firstloadYn = true;
					}
				};
				grid.create("attrItemList", options);
			}
		}
		
		function resetItemList () {
			// 재고 관리 여부
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			var webStkQty = 0;

			// Grid 초기화
			$.jgrid.gridUnload("#attrItemList");
			$.jgrid.gridUnload("#attrItemListCopy"); //hjko

			var columnIdx = 1;
			var columns = new Array();
			// Key
			columns.push({name : 'itemNo', label : '<spring:message code="column.item_no" />', width : '100', align : 'center', hidden:false, sortable : false });

			columns.push({name : 'itemNm', label : '<spring:message code="column.item_nm" />', width : '150', align : 'center', editable:false, sortable : false });
			// 추가 [옵션 리스트]
			//------------ 컬럼들 생성
			for(var i = 0; i < firstAttrArr.length; i++ ) {
				//var attr = attrGrid.jqGrid("getRowData", rowIds[i]);
				if(firstAttrArr[i].attrNm != "" ) {
					var attrIdx = "attr" + columnIdx;
					columns.push({name : attrIdx + 'No', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'Nm', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'ValNo', label : '', width : '100', align : 'center', hidden:true, sortable : false });
					columns.push({name : attrIdx + 'Val', label : firstAttrArr[i].attrNm, width : '100', align : 'center', editable:false, sortable : false });

					var attrVal = firstAttrArr[i].attrVal.split(",");
					// 등록된 옵션에 대한 처리
					var tempAttrValObj;
					var tempAttrValList = new Array();

					for(var attrValIdx = 0; attrValIdx < attrVal.length; attrValIdx++ ) {
						tempAttrValObj = {attrNo : firstAttrArr[i].attrNo
									, attrNm : $.trim(firstAttrArr[i].attrNm)
									, attrValNo : (attrValIdx + 1)
									, attrVal : attrVal[attrValIdx]
									, useYn : '${adminConstants.COMM_YN_Y }' };

						tempAttrValList.push(tempAttrValObj);
					}
// 					attrGrid.jqGrid("setCell", attr.attrNo, "attrValJson", JSON.stringify( tempAttrValList ));
					columnIdx++;
				}
			}
			// 웹 재고
			columns.push({name : 'webStkQty', label : '<spring:message code="column.web_stk_qty" />', width : '100', align : 'center', editable:true, sortable : false });
			// 판매여부
			columns.push({name : 'itemStatCd', label : '<spring:message code="column.item_stat_cd" />', width : '100', align : 'center', editable:true, sortable:false, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.ITEM_STAT}' showValue='false' />"}} );
			// 추가 금액
			columns.push({name : 'addSaleAmt', label : '<spring:message code="column.add_sale_amt" />', width : '100', align : 'center', editable:true, sortable : false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} });
			// 노출 순서
			columns.push({name : 'showSeq', label : '<spring:message code="column.show_seq" />', width : '100', align : 'center', editable:true, sortable : false });
			// attribute List
			columns.push({name : 'attrValJson', label : '', width : '1000', align : 'center', hidden:true, sortable : false });
			//
			columns.push({name : 'itemListId', label : '', width : '100', align : 'center', hidden:true, key:true, sortable:false });

			//---------- 컬럼생성끝
			// Create Item Grid
			var options = {
				url : "<spring:url value='/goods/goodsItemGrid.do' />"
				, searchParam : {goodsId : '${goodsBase.goodsId }' }
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : columns
				, multiselect : true
				, onSelectRow: function(rowid) {
					//rowid  = $(“#attrItemList”).jqGrid(‘getGridParam’, “selrow” );
					//var rowdata = $("#attrItemList").getRowData(rowid);
					//var rowid  = $(“#attrItemList”).jqGrid(‘getGridParam’, “selrow” );
				}
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
				, gridComplete : function () {
					if(!firstloadYn){
						defaultItemListCnt = $("#attrItemList").getDataIDs().length;
					}
					firstloadYn = true;
				}
			};
			grid.create("attrItemList", options);
		}

		/* 새로 추가되는 옵션값 최대값 가져오기  2017.08.31 */
		function getMaxAttributeValue(attrNo){
			var maxAttrValNo = 0;
			var options = {
					url : "<spring:url value='/goods/getSeqAttrValNo.do' />"
					,data : {attrNo :attrNo }
					,dataType : "json"
					,async : false
					,callBack : function(data){
						maxAttrValNo = data.result;
					}
			};
			ajax.call(options);
			return maxAttrValNo;
		}
		
		/* 단품 생성 스크립트 */
		function genAttrItemList () {
			
			$("#attrItemList").jqGrid('clearGridData');

			var returnMsg = "";
			
			// 옵션 조회
			var attrGrid = $("#attrList");
			var rowIds = attrGrid.jqGrid("getDataIDs");

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
									, attrVal : attr.attrVal
									, useYn : '${adminConstants.COMM_YN_Y }' };
						tempAttrValList.push(tempAttrValObj);
						m++;
// 					}

					attrGrid.jqGrid("setCell", attr.attrNo, "attrValJson", JSON.stringify( tempAttrValList ));
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
		
		// CloudFront Invalidate TODO 삭제
		function createInvalidate() {
		    var cloudfront = new AWS.CloudFront({apiVersion : '2017-03-25', accessKeyId : 'AKIAIFNQKCO5K24TW7JQ', secretAccessKey : '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'});
		    var distributionId = 'E3F5U71DV5QPSY';
		    var callerReference = Math.floor(new Date().getTime()/1000).toString();
		    var goodsId = '${goodsBase.goodsId }';
		    /*
		    var invalidationPath = ['/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_600x600.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_440x440.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_374x374.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_315x315.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_280x280.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_224x224.jpg',
		    	'/goods/'+goodsId+'/'+goodsId+'_'+imgSeq+'_167x167.jpg'];
            */
            var invalidationPath = ['/goods/'+goodsId+'/*'];
		    var params = {
		        DistributionId: distributionId,
		        InvalidationBatch: {
		            CallerReference: callerReference,
		            Paths: {
		                Quantity: invalidationPath.length,
		                Items: invalidationPath
		            }
		        }
		    };

		    return cloudfront.createInvalidation(params, function(err, data) {
		        if (err) {
					/* TODO : 데모 작업을 위해 주석처리
					messager.alert("<spring:message code='admin.web.view.msg.goods.image.invalidate.error' />", "Error", "error")
					*/
		        	console.log(err, err.stack);
		        } else {
		        	console.log(data);
		        }
		    });
		}

		// 상품 수정
		function updateGoods () {

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

		    if(startDate.getTime() > endDate.getTime()) {
		        messager.alert("판매시작일시분이 판매종료일시분보다 크거나 같을 수 없습니다.", "Info", "info");
		        return false;
		    }
		    

			var stGoodsMapPO = new Array();
			// 사이트 선택 체크. hjko 2017.01.10
			var chkStCnt = $("input[name='stId']:checked").length;
			var styleCnt= $("input[name='goodsStyleCd']").length;
			var noChkStyleCnt = 0;  // 스타일 체크안된 것
			$("input[name='goodsStyleCd']").each(function(){
				if($(this).val() ==''){
					noChkStyleCnt ++;
				}
			});
			if(chkStCnt ==0){
				messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
				return false;
			}else{

				$("input[name='stId']:checked").each(function(index, ob){
					stGoodsMapPO.push( { "stId" : $(this).val() , "goodsId" : $("#goodsId").val() } );
				});

				// 스타일 체크된 값들 목록
				var goodsStyleSt = new Array();
				var sobj = null;
				var temp = "";
				var tempId = "";
				var chkStyleCd = "";
				var stGoodsStyleMapPO = new Array();

				$("input[name='goodsStyleCd']").each(function(){

					tempId = $(this).attr('id');
					chkStyleCd = $(this).val();
					temp = tempId.split("_");
					var siteNo = temp[2];

					for(key in stGoodsMapPO) {

						if(stGoodsMapPO.hasOwnProperty(key)){
							var v = stGoodsMapPO[key];

							if( siteNo == v.stId){
								$.extend(v, {"goodsStyleCd" : chkStyleCd });
							}
						}
					}
				});
			}
			// 재고갯수 체크[ 재고관리Y, 단품관리N 일 경우] 2017.06.23
			var stkMngYn = $(":radio[name=stkMngYn]:checked").val();
			var itemMngYn =$("#itemMngYn").val();

			var webStkQty = 0;
			if(stkMngYn == "${adminConstants.COMM_YN_N }" ) {
				webStkQty = 9999;
			}else{
				if(itemMngYn =="${adminConstants.COMM_YN_N }" ) {
					if(deleteAttr.length > 0){
						var allRowsInGrid = $('#attrItemList').jqGrid('getGridParam', 'data');
					} else {
						var allRowsInGrid = $("#attrItemList").jqGrid('getRowData');
					}
					for(var i = 0; i < allRowsInGrid.length; i++ ) {
						var stk = allRowsInGrid[i].webStkQty;
						if(stk == '0' ){
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
			
			if(validate.check("goodsUpdateForm")) {
				var formData = $("#goodsUpdateForm").serializeJson();
				var optGrpList;
				var attrList;
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

				// 상품 구성에 따른 validCheck
				if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === $("[name='goodsCstrtTpCd']").val()){
					attrList = grid.jsonData ("attrList" );
					itemList = grid.jsonData("attrItemList");
					
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
					
					if(itemList.length <= 0 ) {
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
					optGrpList = grid.jsonData ("optGrpList" );
					if(attrList.length < 2 ) {
						arg = "<spring:message code='column.goods.cstrtTpCd.attr' />";
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsCstrtTp.count' arguments='"+ arg +", 2' />", "Info", "info" );
						return;
					}
				}else if("${adminConstants.GOODS_CSTRT_TP_PAK}" === $("[name='goodsCstrtTpCd']").val()){
					// 묶음 2개이상 등록
					attrList = grid.jsonData ("attrList" );
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

				// 상품 상세 설명
				if($("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}' && $('#contentPc').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "" ) {	// 공백일 경우
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

				// 상품 주의사항
// 				if($('#content_caution').val() != "<p>&nbsp;</p>" ) {	// 공백인 경우
// 					goodsCaution = {
// 						content : $('#content_caution').val()
// 					};
// 				}
				
				// 상품 이미지
				var dlgtYnCnt = 0;
				var rvsImgOnlyCnt = 0;
				var bannerImgCnt = 0;
				$("input[name=imgPath]").each (function (idx ) {
					var goodsImgIdx = $(this).siblings("input[name=imgSeq]").val();
					var imgPath = $("#imgPath" + goodsImgIdx).val();
					var imgSrc = $("#imgPath"+ goodsImgIdx + "View").attr('src');
					var rvsImgPath = $("#rvsImgPath" + goodsImgIdx).val();
					var dlgtYn = $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N';
					var regYn = $("#regYn" + goodsImgIdx).val();
					var imgTpCd = $("#imgTpCd" + goodsImgIdx).val();

					//todo 왜 여기가 이렇게 되는지 소스 정리가 필요함
					if((imgPath == "" && regYn != "Y")) {
						if(imgSrc != '' && imgSrc != '/images/noimage.png') {
							imgPath = imgSrc.split('=')[1]; //새로 등록한 이미지
						}
					}

					//이미지가 등록되지 않았는데 대표여부가 되는 경우
					if(dlgtYn == 'Y' && (imgPath == "" && regYn != "Y")){
						dlgtYnCnt++;
					}
					
					// 배너 이미지 체크
					if(goodsImgIdx === '11' && (imgPath != "" || regYn == "Y") ){
						bannerImgCnt = 1;	
					}

					// 기본이미지 없이  반전이미지만 등록하지 못하도록 한다.
					if((regYn != "Y" && imgPath == "") && (rvsImgPath != "" && rvsImgPath != null)) {
						rvsImgOnlyCnt++;
					}

					//상품 이미지 데이터 생성
					if(imgPath != "" || regYn == "Y" ) {
						goodsImgList.push({
							imgPath : imgPath
							, rvsImgPath : rvsImgPath
							, dlgtYn : dlgtYn
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

				if (rvsImgOnlyCnt > 0) {
					messager.alert("<spring:message code='column.goods.img.regist.rvsonly' />", "Info", "info");
				    return;
				}

				if(dlgtYnCnt > 0){
					messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.unregistered.image' />", "Info", "info");
					return;
				}
				
				if($("input:radio[name=dlgtYn]:checked").val() != "Y" && $("input:radio[name=webMobileGbCd]:checked").val() != '${adminConstants.WEB_MOBILE_GB_30}'){
					messager.alert("<spring:message code='admin.web.view.msg.goods.choose.image' />", "Info", "info", function(){
						$("#dlgtYn_"+goodsImgList[0].imgSeq ).focus();
					});
					return;
				}

				// 아이콘
				$("[name='iconCode']:checked").each (function (idx ) {
					goodsIconList.push({
						goodsId : $("#goodsId").val()
						, codes : [ $(this).val()]
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
                    //, goodsDescPO : JSON.stringify(goodsDescList )
                    , contentPc : $("#goodsUpdateForm #contentPc").val()
                    , contentMobile : $("#goodsUpdateForm #contentMobile").val() == '<p>&nbsp;</p>' ? '' : $("#goodsUpdateForm #contentMobile").val()
					, goodsCautionPO : JSON.stringify(goodsCaution )
					, stGoodsMapPO : JSON.stringify(stGoodsMapPO )
				}
// 				console.log(sendData);

				messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
	                    // 콜백메소드 안에서 처리할 때 갱신이 안되는 문제가 있어서 위치를 변경함.
						if (invaldateCloudFront) {
	                        createInvalidate();
	                    }
	
						var options = {
							url : "<spring:url value='/goods/goodsUpdate.do' />"
							, data : sendData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									// 상품 상세
									var data = {
										goodsId : $("#goodsId").val()
									}
		
									updateTab('/goods/goodsDetailView.do?goodsId=' + $("#goodsId").val(), '상품 상세 - ' + $("#goodsId").val());
								});									
							}
						};
						
						// 셋트, 옵션, 묶음 상품의 경우 판매여부 확인(미판매 : return true, 판매 : return false)
						checkSoldGoods();
						if(isOkChangeAttr){
							ajax.call(options);
						}
					}
				});
			}
		}

		// 셋트, 옵션, 묶음 상품의 경우 판매여부 확인(미판매 : return true, 판매 : return false)
		var orgAttrList;
		var orgOptGrpList;
		var isOkChangeAttr = null;
		function checkSoldGoods() { 
			var goodsCstrtTpCd = "${goodsCstrtTpCd}";
			// 셋트는 변경 불가, 묶음/옵션은 추가만 가능
			var thisAttrList = grid.jsonData ("attrList");
			var thisOptGrpList = grid.jsonData ("optGrpList");
			if("${adminConstants.GOODS_CSTRT_TP_SET }" == goodsCstrtTpCd){	// 셋트는 변경 불가
				var sameCnt = 0;
				for( i in orgAttrList){
					var isSame = false;
					for( j in thisAttrList){
						if(orgAttrList[i].subGoodsId ==  thisAttrList[j].subGoodsId && orgAttrList[i].cstrtQty ==  thisAttrList[j].cstrtQty){
							isSame = true;
						}
					}
					if(isSame){
						sameCnt += 1;
					}
				}
				if(orgAttrList.length == thisAttrList.length && orgAttrList.length == sameCnt){
					isOkChangeAttr = true;
				}else{
					var options = {
							url : "<spring:url value='/goods/checkPossibleCnt.do' />"
							, async: false
							, data : {goodsId : '${goodsBase.goodsId}'}
							, callBack : function (data) { 
								if(data.ordCnt > 0){
									messager.alert("세트정보를 수정하실 수 없습니다.", "Info", "info");
									isOkChangeAttr = false;
								}else{
									isOkChangeAttr = true;
								}
							}
						}
						ajax.call(options );
				}
			}else if("${adminConstants.GOODS_CSTRT_TP_ATTR }" == goodsCstrtTpCd || "${adminConstants.GOODS_CSTRT_TP_PAK }" == goodsCstrtTpCd){	// 묶음/옵션은 추가만 가능
				var sameCnt = 0;
				for( i in orgAttrList){
					var isSame = false;
					for( j in thisAttrList){
						if(orgAttrList[i].subGoodsId ==  thisAttrList[j].subGoodsId){
							isSame = true;
						}
					}
					if(isSame){
						sameCnt += 1;
					}
				}
				if(orgAttrList.length == sameCnt){
					isOkChangeAttr = true;
				}else{
					var options = {
							url : "<spring:url value='/goods/checkPossibleCnt.do' />"
							, async: false
							, data : {goodsId : '${goodsBase.goodsId}'}
							, callBack : function (data) { 
								if(data.ordCnt > 0){
									messager.alert("묶음 정보를 수정하실 수 없습니다.", "Info", "info");
									isOkChangeAttr = false;
								}else{
									isOkChangeAttr = true;
								}
							}
						}
						ajax.call(options );
				}
			}else{
				isOkChangeAttr = true;
			}
		}
		
		function resetAttrList () {
			jQuery("#attrList").clearGridData();
			jQuery("#attrList").trigger("reloadGrid");
			resetItemList();
			deleteAttr.length = 0;
		}

		function addAttrList () {
			
			// 단품 수정 불가
			if("${checkPossibleCnt.checkCstrtUpdCnt != '0'}" === 'true'){
				messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.item.add' />", "Info", "info");
				return;
			}
			
			var itemMngYn = $("#itemMngYn").val();
			if(itemMngYn == "${adminConstants.COMM_YN_N }" ) {
				return;
			}

			var rowIds = $("#attrList").jqGrid("getDataIDs");
			// 5개 이상 추가 금지..
			if(rowIds.length >= 5 ) {
				messager.alert("<spring:message code='column.goods.option.max' arguments='5' />", "Info", "info");
				return;
			}

			var options = {
				url : "<spring:url value='/goods/getAttributeSeq.do' />"
				, data : {seqId : '${adminConstants.SEQUENCE_ATTRIBUTE_SEQ }' }
				, callBack : function(data ) {
					var addData = {
						attrNm : ''
						, attrVal : ''
						, attrNo : data.seqNo
						, attrValNo : ''
						, attrValJson : ''
						, useYn : '${adminConstants.COMM_YN_Y }'
					}
					$("#attrList").jqGrid('addRowData', data.seqNo, addData, 'last', null );
				}
			};
			ajax.call(options);
			
			//$("#attrItemList").jqGrid('clearGridData');
		}

		function itemHistory () {
			var options = {
				histGb : 'ITEM_DETAIL'
				, goodsId : '${goodsBase.goodsId }'
			}
			layerHistoryList.create (options );
		}
		
		function goodsImgReview (imgSeq ) {
			var options = {
				url : "<spring:url value='/goods/goodsImageLayerView.do' />"
				, data : {goodsId : '${goodsBase.goodsId }', imgSeq : imgSeq }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "goodsImgReview"
						, width : 1500
						, height : 600
						, top : 200
						, title : "상품 이미지 리뷰"
						, body : data
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}
		
		//update insert 공통  이지만 시간차 오류가 있어 분리
		function initEditor () {
			EditorCommon.setSEditor('contentPc', '${adminConstants.GOODS_DESC_IMAGE_PTH}');
			EditorCommon.setSEditor('contentMobile', '${adminConstants.GOODS_DESC_IMAGE_PTH}');
// 			EditorCommon.setSEditor('content_caution', '${adminConstants.GOODS_CAUTION_IMAGE_PTH}');
		}
		
		// ui 제어
		function initUI(){
			fnControlUI();
		}
		
		// /goods/goodsOptGrpGrid.do
		function createOptGrpList(){
			var options = {
				url : "<spring:url value='/goods/goodsOptGrpGrid.do' />"
				, searchParam : {goodsId : '${goodsBase.goodsId }' }
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
				, loadComplete : function(data) {
					// 기존 정보 저장
					orgOptGrpList =  grid.jsonData ("optGrpList" );
				}
			};
			
			grid.create("optGrpList", options);
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
		
		function setdlgtGoodsYn(){			
			var attrGrid = $("#attrList");
			var rowIds = attrGrid.jqGrid("getDataIDs");			
			for(var i = 0; i < rowIds.length; i++ ) {
				var attr = attrGrid.jqGrid("getRowData", rowIds[i]);
				if(i == 0){						
					$("#attrList").jqGrid('setCell',rowIds[i],'dlgtGoodsYn','Y');
				}else{
					$("#attrList").jqGrid('setCell',rowIds[i],'dlgtGoodsYn','N');
				}
			}				
			
		}

		</script>
		<script tyle="text/javascript">
			$(function(){
				// 사이트 클릭시 스타일 제어
				$("input[name=stId]").click(function(){
				    if($(this).is(':checked')){
				    	 var selVal = $(this).val();
				    	 $("#"+selVal).show();
				    	 $("select[name='stIdCombo']").find("option[value="+selVal+"]").prop("disabled", false);
				    	 $("select[name='stIdCombo'] option[value="+selVal+"]").attr("selected",true);
				    }else{
				    	var notSelVal = $(this).val();  // 체크 되지 않은 사이트
				    	$("#"+notSelVal).hide();
				    	$("select[name='stIdCombo']").find("option[value="+notSelVal+"]").attr("disabled", "disabled");
				    }
				});
				
				
				// 관련 영상 더보기 제어
				$(".apetContent").on('click', function(){
					$(".apetContentToggle").toggle('slow');
				})
				
				// 세트/묶음/옵션 속성 정리
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
					
					// 배송정책 대표상픔으로, 대표상품 제고 없을경우,  다음 상품으로
					fn_getMainDlvrcPlcNo();
					
					// 배송정책코드를 비활성화한다.
					$("#dlvrcPlcNo").attr("disabled",true);
				} 
				
				// 무료배송여부 텍스트 변경. 노출/미노출 >> 예/아니오
				$("#span_freeDlvrYnY").text("예");
				$("#span_freeDlvrYnN").text("아니오");
			}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<!--
		fstGoodsYn: ${fstGoodsYn}
-->
<form id="goodsUpdateForm" name="goodsUpdateForm" method="post" >
	<input type="hidden" id="saleStrtDtm" name="saleStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="saleEndDtm" name="saleEndDtm" class="validate[required]" value="" />
	<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${goodsBase.goodsTpCd }" />
	<input type="hidden" id="resultAttrValNoArray" name="resultAttrValNoArray" value=""/>
	<input type="hidden" name="compGbCd" value="${goodsBase.compGbCd}"/>

	<div class="mButton">
		<div class="leftInner">
			<button type="button" name="goodsHistoryBtn" id="goodsHistoryBtn"  onclick="goodsHistory();" class="btn btn-add">상품변경이력</button>
		</div>
	</div>

	<div id="goods_pannel" class="easyui-accordion" data-options="multiple:true" style="width:100%">
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsBaseInfo.jsp" /> <!-- 상품 기본정보 -->
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsItemInfo.jsp" /> <!-- 상품 단품 정보 -->
	<jsp:include page="/WEB-INF/view/goods/include/incTwcProductInfo.jsp" /> <!-- 영양정보, 주원료, 상세정보, 상품필수정보  : 연동정보 -->
<%--     <jsp:include page="/WEB-INF/view/goods/include/incGoodsNaverEpInfo.jsp" /> <!-- 네이버 ep 정보 --> --%>
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsDeliveryInfo.jsp" /> <!-- 배송 정보  분리 -->
    <jsp:include page="/WEB-INF/view/goods/include/incGoodsDispInfo.jsp" /> <!-- 상품 전시 정보 -->
    <jsp:include page="/WEB-INF/view/goods/include/incGoodsFilterInfo.jsp" /> <!-- 상품 필터 정보 -->
    <jsp:include page="/WEB-INF/view/goods/include/incGoodsIconInfo.jsp" /> <!-- 상품 아이콘 정보 -->
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsPriceInfo.jsp" /> <!-- 상품 가격정보 -->
	<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd or adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}" >
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsEstmInfo.jsp" />	<!-- 상품 평가정보 -->
	</c:if>
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsImageInfo.jsp" /> <!-- 상품 이미지 정보 -->
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsDescInfo.jsp" /> <!-- 상품 설명 정보 -->
<%-- 	<jsp:include page="/WEB-INF/view/goods/include/incGoodsCautionInfo.jsp" /> <!-- 상품 주의사항 --> --%>
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsNotifyInfo.jsp" /> <!-- 상품 공정위 품목군 정보 -->
	<jsp:include page="/WEB-INF/view/goods/include/incGoodsCstrtInfo.jsp" /> <!-- 상품 연관 상품 정보 -->
	<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
		<jsp:include page="/WEB-INF/view/goods/include/incGoodsMdPickInfo.jsp" /> <!-- 상품 md pick 정보 -->
	</c:if>
	</div>
</form>

		<div class="btn_area_center">
		<c:if test="${layout ne 'popupLayout'}">
			<button type="button" class="btn btn-ok" onclick="updateGoods();" >수정</button>
		</c:if>
			<button type="button" name="btn2" id="btn2" class="btn btn-cancel" onclick="closeTab();" >닫기</button>
		</div>
	</t:putAttribute>

</t:insertDefinition>