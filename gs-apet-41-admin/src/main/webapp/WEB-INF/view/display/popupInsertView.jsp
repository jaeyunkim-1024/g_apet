<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			
			// 팝업 상품 그리드
			createPopupGoodsGrid();
			
			createpopupDispGrid ();
			initEditor ();
			
			$("input:radio[name=popupTpCd]").change(function() {
				if ($(":input:radio[name=popupTpCd]:checked").val() != '${adminConstants.POPUP_TP_20 }') {
					$("#goodsId").val('');
	            }
            });
		});

		function initEditor () {
			EditorCommon.setSEditor('content', '${adminConstants.POPUP_IMAGE_PTH}');
		}

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
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
			}
		}
		
		// 팝업용 상품 검색
        function searchGoods() {
			// 팝업 유형이 상품이 아니면 상품검색 못하도록 함.
			if ($(":input:radio[name=popupTpCd]:checked").val() != '${adminConstants.POPUP_TP_20 }') {
				messager.alert("<spring:message code='admin.web.view.msg.popup.searchgoods' />","Info","info");
				return;
			}
			
            var options = {
                multiselect : false
                , callBack : searchGoodsCallback
            }
            layerGoodsList.create(options);
        }
		
        function searchGoodsCallback (goodsList) {
            if(goodsList.length > 0 ) {
                $("#goodsId").val (goodsList[0].goodsId);
            }
        }

		function createpopupDispGrid () {
			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : [
					  {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"100", align:"center", sortable:false } /* 사이트 명 */
					, {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", key: true, sortable:false }
					, {name:"dispCtgPath", label:'<spring:message code="column.disp_ctg" />', width:"400", align:"center", sortable:false }
					, {name:"popupNo", label:'', width:"0", align:"center", hidden: true, sortable:false }
					, {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"100", align:"center", editable:true, sortable:false }
					, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden: true} /* 사이트 ID */
				]
				, multiselect : true
			};
			grid.create("popupDispList", options);
			
			// 마우스 drag & drop
			   $("#popupDispList").jqGrid("sortableRows");
			   $("#popupDispList").jqGrid('sortableRows', {
			      update: function (e, html) {
			         var ids = $("#popupDispList").jqGrid("getDataIDs");
			         var gridData = $("#popupDispList").jqGrid("getRowData");
			         for (var i=0; i<gridData.length; i++) {
			            var rank = i+1;
			            $("#popupDispList").jqGrid("setCell", ids[i], 'dispPriorRank', rank);
			         }
			      }
			   });
		}

		function insertPopup () {
			
            // 팝업 유형이 상품이면 상품번호를 반드시 등록해야 함.
            if ($(":input:radio[name=popupTpCd]:checked").val() == '${adminConstants.POPUP_TP_20 }'){
	            var goodsIdx = $('#popupGoodsList').getDataIDs();
				if(goodsIdx == null && goodsIdx.length <= 0) {
					messager.alert("<spring:message code='admin.web.view.msg.popup.searchgoodsid' />","Info","info");
	                return;
             	}			
            } 
            
			var sendData = null;
			// 날짜..
			$("#dispStrtDtm").val(getDateStr ("dispStrt"));
			$("#dispEndDtm").val(getDateStr ("dispEnd"));

			if(validate.check("popupInsertForm")) {
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				var formData = $("#popupInsertForm").serializeJson();
				var popupDispList = grid.jsonData ("popupDispList" );
				var popupGoodsList = grid.jsonData ("popupGoodsList" );
				// Form 데이터
				sendData = {
					popupPO : JSON.stringify(formData )
					, popupShowDispClsfPO : JSON.stringify(popupDispList )
					, popupTargetPO : JSON.stringify(popupGoodsList )
				}

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/popupInsert.do' />"
								, data : sendData
								, callBack : function (data ) {
									messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
										viewPopupDetail (data.popupNo );
									});							
									
								}
							};
							ajax.call(options);					
					}
				});
			}
		}

		function viewPopupDetail (popupNo ) {
			updateTab('/display/popupDetailView.do?popupNo=' + popupNo, '팝업 상세');
		}

		// 전시카테고리 추가
		function displayCategoryAddPop() {
			// 사이트 선택값
			var stIdVal = $("#stIdCombo option:selected").val();
			// 전시카테고리 선택값
			var dispClsfCdVal = $("#dispClsfCdCombo option:selected").val();

			if(stIdVal == ""){
				messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />","Info","info");				
				$("#stIdCombo").focus();
				return false;
			}
			if(dispClsfCdVal == ""){
				messager.alert("<spring:message code='admin.web.view.msg.invalid.dispclsfcd' />","Info","info");
				$("#dispClsfCdCombo").focus();
				return false;
			}

			var options = {
				  multiselect : true
				  , stId : stIdVal
				  , dispClsfCd : dispClsfCdVal
				  , compNo : ''
				  , arrDispClsfCd : [_CATEGORY_SEARCH_LAYER_DISP_CLSF_10,_CATEGORY_SEARCH_LAYER_DISP_CLSF_30]
				  , callBack : function(result) {


					if(result != null && result.length > 0) {
						var idx = $('#popupDispList').getDataIDs();
						var message = new Array();
						for(var i in result){
							var addData = {
								  stNm: result[i].stNm
								, dispClsfNo : result[i].dispNo
								, dispCtgPath : result[i].dispPath
								, stId: result[i].stId

							}

							var check = true;
							for(var j in idx) {
								if(addData.dispClsfNo == idx[j]) {
									check = false;
								}
							}

							if(check) {
								$("#popupDispList").jqGrid('addRowData', result[i].dispNo, addData, 'last', null);
							} else {
								message.push(result[i].dispNm + " 중복된 카테고리 입니다.");
							}
						}
						if(message != null && message.length > 0) {
							messager.alert(message.join("<br/>"),"Info","info");
						}
					}
				}
			}

			layerCategoryList.create(options);
		}

		// 전시카테고리 삭제
		function displayCategoryDelDisp() {
			var rowids = $("#popupDispList").jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();
			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					$("#popupDispList").delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.invalid.displaycategory' />","Info","info");
			}
		}

		
		
		$(document).on("click", "input[name=popupTpCd]", function(e){
			 
			if($(this).val() == '${adminConstants.POPUP_TP_10}') {
				$("#goodsView").hide();
				grid.resize();
			} else if($(this).val() == '${adminConstants.CP_TG_20}') {
				$("#goodsView").show();
				grid.resize();
			} 
		});
 
		function popupGoodsLayer(paramPopupGoodsList) {
			var options = {
				multiselect : true
				, callBack : function(newGoods) {
					if(newGoods != null) {
						var popupGoods = $('#' + paramPopupGoodsList).getDataIDs();
						var message = new Array();
						/* 
						// 현재 팝업의 적용사이트 추출
						var popupStIdArray = [];
						popupStIdArray.push( $("#stIdCombo option:selected").val());
						 */
						 
						//전시우선순위 넣기 
						var MaxdispPriorRank = 0 ;
						 
						for(var ng in newGoods){
							var check = true;
							/* 
							// 새로 추가할 상품의 사이트 아이디 추출
							var newGoodsStIdArray = newGoods[ng].stIds.split("|");
							
							// 새로 추가할 상품의 사이트 아이디가 현재 팝업의 적용사이트에 속하는지 확인
							for (var si in newGoodsStIdArray) {
								if (jQuery.inArray(newGoodsStIdArray[si], popupStIdArray) < 0) {
									check = false;
								} else {
									// 일치하는 사이트아이디가 있으면 바로 통과
									check = true;
									break;
								}
							}
							
							// 적용사이트에 속하지 않아서 적용불가 메시지 추가
							if (check == false) {
								message.push(newGoods[ng].goodsNm + " 적용 사이트가 일치하지 않습니다.^^");
							}
							 */
							// 새로 추가할 상품이 현재 팝업상품과 겹치는지 확인
							
							
							 
							for(var cg in popupGoods) {
								if(newGoods[ng].goodsId == popupGoods[cg]) {
									check = false;
									message.push(newGoods[ng].goodsNm + " 중복된 상품입니다.^^");
								}
							}
							 
							 var popupGoodsData =  grid.jsonData ( paramPopupGoodsList );
							 for(var cp in popupGoodsData) {
								 if ( MaxdispPriorRank  <  popupGoodsData[cp].dispPriorRank){
										MaxdispPriorRank = popupGoodsData[cp].dispPriorRank;
								 }  
							 }
							 	MaxdispPriorRank ++;
								newGoods[ng].dispPriorRank = MaxdispPriorRank;
							 
							
							if(check) {

								// 착불 여부 check
								var optionsNest = {
										url : "<spring:url value='/promotion/goodsDlvrcPayMth.do' />"
										, data :  {
											goodsId : newGoods[ng].goodsId
										}
										, async : false
										, callBack : function(resultNest){
											if(resultNest == '${adminConstants.DLVRC_PAY_MTD_20}'){
												message.push(newGoods[ng].goodsNm + " 배송비 결제 방법이 착불 상품입니다.");
											}else{
												$('#'+paramPopupGoodsList).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);				
											}
										}
									};

								ajax.call(optionsNest);									

							}
						}

						if(message != null && message.length > 0) {
							messager.alert(message.join("<br/>"),"Info","info");
						}
					}
				}
			}
			layerGoodsList.create(options);
		}

		function popupGoodsDelete(paramPopupGoodsList) {
			var rowids = $("#" + paramPopupGoodsList).jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();
			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					$("#" + paramPopupGoodsList).delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.invalid.good' />","Info","info");
			}
		}  
		
		
		
		// 팝업 상품 목록
		function createPopupGoodsGrid(){
			var options = {
				//url : "<spring:url value='/popup/popupGoodsListGrid.do' />"
				//, searchParam : {
			    //  popupNo : '${popupBase.popupNo}'
				//}
				  url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : [
					  {name:"popupNo", hidden:true }
					 
					, {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
					, _GRID_COLUMNS.dispPriorRank
					, _GRID_COLUMNS.goodsNm
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.goodsTpCd
					, {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false } /* 비고 */
					, {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"200", align:"center", sortable:false } /* 모델명 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, _GRID_COLUMNS.compNm
					, _GRID_COLUMNS.bndNmKo
					, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:"<spring:message code='column.sale_strt_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"saleEndDtm", label:"<spring:message code='column.sale_end_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, _GRID_COLUMNS.showYn
				]
			    , multiselect : true
			};
			grid.create("popupGoodsList", options);
		}
		
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<form id="popupInsertForm" name="popupInsertForm" method="post" >
	<input type="hidden" id="dispStrtDtm" name="dispStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="dispEndDtm" name="dispEndDtm" class="validate[required]" value="" />

				<table class="table_type1">
					<caption>POPUP 등록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.popup_no" /><strong class="red">*</strong></th>	<!-- 팝업 번호 -->
							<td colspan='3'>
								<input type="hidden" id="popupNo" name="popupNo" value="${popup.popupNo }" />
<c:choose>
<c:when test="${popup.popupNo eq null }">
								<b>자동입력</b>
</c:when>
<c:otherwise>
								<b>${popup.popupNo }</b>
</c:otherwise>
</c:choose>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.popup_nm" /><strong class="red">*</strong></th>    <!-- 제목 -->
                            <td>
                                <input type="text" class="w300 validate[required]" name="popupNm" id="popupNm" title="<spring:message code="column.popup_nm" />" value="${popup.popupNm }" />
                            </td>
	                        <th><spring:message code="column.popup_tp_cd"/></th>
	                        <td>
	                            <!-- 팝업 유형 코드-->
	                            <frame:radio name="popupTpCd" grpCd="${adminConstants.POPUP_TP }" selectKey="${popup.popupTpCd }" disabled="false" />
	                        </td>
	                        
                               <%-- <th><spring:message code="column.goods_id" /></th>    <!-- 상품 ID -->
                               
                               <td>
                                   <input type="text" class="readonly" id="goodsId" name="goodsId" title="상품ID" value="" readonly>
                                   &nbsp;
                                   <button type="button" class="btn" onclick="searchGoods();">검색</button>
                               </td> --%>
							<%-- <th><spring:message code="column.st_id" /><strong class="red">*</strong></th>	<!-- 사이트 ID-->
							<td>
								<frame:stId funcNm="searchSt()" requireYn="Y" defaultStNm="${popup.stNm }" defaultStId="${popup.stId }" />
							</td> --%>
						</tr>
						<tr>
                               <th><spring:message code="column.disp_yn" /><strong class="red">*</strong></th> <!-- 전시 여부 -->
                               <td>
                                   <frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${popup.dispYn eq null ? adminConstants.DISP_YN_Y : popup.dispYn }" />
                               </td>							                           
                               <th><spring:message code="column.svc_gb_cd" /><strong class="red">*</strong></th>   <!-- 서비스 구분 -->
                               <td>
                                   <frame:radio name="svcGbCd" grpCd="${adminConstants.SVC_GB }" selectKey="${popup.svcGbCd eq null ? adminConstants.SVC_GB_10 : popup.svcGbCd }" />
                               </td>
						</tr>
						<tr>
							<th><spring:message code="column.wdt_sz" /><strong class="red">*</strong></th>	<!-- 가로크기 -->
							<td>
								<input type="text" class="validate[required] numeric" name="wdtSz" id="wdtSz" title="<spring:message code="column.wdt_sz" />" value="${popup.wdtSz }" />
							</td>
							<th><spring:message code="column.heit_sz" /><strong class="red">*</strong></th>	<!-- 세로크기 -->
							<td>
								<input type="text" class="validate[required] numeric" name="heitSz" id="heitSz" title="<spring:message code="column.heit_sz" />" value="${popup.heitSz }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.pst_top" /><strong class="red">*</strong></th>	<!-- 위치 TOP -->
							<td>
								<input type="text" class="validate[required] numeric" name="pstTop" id="pstTop" title="<spring:message code="column.pst_top" />" value="${popup.pstTop }" />
							</td>
							<th><spring:message code="column.pst_left" /><strong class="red">*</strong></th>	<!-- 위치 LEFT -->
							<td>
								<input type="text" class="validate[required] numeric" name="pstLeft" id="pstLeft" title="<spring:message code="column.pst_left" />" value="${popup.pstLeft }" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.display_view.disp_date" /><strong class="red">*</strong></th>	<!-- 전시 기간-->
							<td colspan="3" >
								<frame:datepicker startDate="dispStrtDt"
												  startHour="dispStrtHr"
												  startMin="dispStrtMn"
												  startSec="dispStrtSec"
												  startValue="${popup.dispStrtDtm }"
												  endDate="dispEndDt"
												  endHour="dispEndHr"
												  endMin="dispEndMn"
												  endSec="dispEndSec"
												  endValue="${popup.dispEndDtm }"
												  period="30" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.content" /></th>	<!-- 내용 -->
							<td colspan="3" >
								<textarea name="content" id="content" class="validate[required]" cols="30" rows="10" style="width: 98%">${popup.content }</textarea>
							</td>
						</tr>
					</tbody>
				</table>

</form>

				<div class="mTitle mt30">
					<h2></h2>
					<div class="buttonArea">
					<%-- <select id="stIdCombo" name="stIdCombo">
							<frame:stIdStSelect defaultName="사이트선택" />
						</select>

						<select id="dispClsfCdCombo" name="dispClsfCdCombo">
							<!--frame:select grpCd="${adminConstants.DISP_CLSF }" defaultName="전시분류" />-->
							<option value=""  title="전시분류">전시분류</option>
							<option value="${adminConstants.DISP_CLSF_10 }"  title="전시카테고리">전시카테고리</option>
							<option value="${adminConstants.DISP_CLSF_60 }"  title="업체카테고리">업체카테고리</option>
						</select> --%>

						<input type="hidden" id="stIdCombo" name="stIdCombo" value="1" />
						<input type="hidden" id="dispClsfCdCombo" name="dispClsfCdCombo" value="${adminConstants.DISP_CLSF_10 }" />

						<button type="button" onclick="displayCategoryAddPop();" class="btn btn-add">추가</button>
						<button type="button" onclick="displayCategoryDelDisp();" class="btn btn-add">삭제</button>
					</div>
				</div>
				<div class="mModule no_m">
					<table id="popupDispList" ></table>
					<div id="popupDispListPage"></div>
				</div>


<div id="goodsView" style="display: none;" >
			<div class="mTitle mt30">
				<h2>팝업 적용 상품</h2>
				<div class="buttonArea">
					<button type="button" onclick="popupGoodsLayer('popupGoodsList');" class="btn btn-add">추가</button>
					<button type="button" onclick="popupGoodsDelete('popupGoodsList');" class="btn btn-add">삭제</button>
				</div>
			</div>

			<div class="mModule no_m">
				<table id="popupGoodsList" ></table>
			</div>
</div>
		
		

				<div class="btn_area_center">
					<button type="button" class="btn btn-ok" onclick="insertPopup(); return false;" >등록</button>
					<button type="button" class="btn btn-cancel" onclick="closeTab();" >취소</button>
				</div>

	</t:putAttribute>

</t:insertDefinition>