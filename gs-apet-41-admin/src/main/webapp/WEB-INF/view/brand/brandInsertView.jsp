<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			// 이미지타입 1 웹 2 모바일  3 섬네일 4 섬네일 모바일 
			var imageType = 1 ;
			
			// 에디터 초기화
			//initEditor ();
			//카테고리 초기화 
			//createDisplayTree();
			
			//브랜드카테고리 
			//createbrandDispGrid ();
			// NEW 상품 그리드
			//createBrandNewGoodsGrid();
			// BEST 상품 그리드
			//createBrandBestGoodsGrid();
			
			//01.사이트아이디 초기화 
            //fnStIdComboSpanHtml();
			
			//03.사이트 클릭시 스타일 제어
			/* $("input[name=stId]").click(function(){    
				fnStIdComboSpanHtml();
			}); */ 
			
		});
		
		//사이트아이디 체크박스 변화에  선택에 따른 콤보박스 변화 
		function fnStIdComboSpanHtml() {
			var data = $("#brandInsertForm").serializeJson();
			var stIdComboSpanHtml = "";
			    stIdComboSpanHtml += "<select class='wth100' id='stIdCombo' name='stIdCombo'>";
			    stIdComboSpanHtml += "<option value=''>선택하세요</option>";
				<c:forEach items="${stIdList}" var="stIds" >
				var stIds    = "${stIds.stId}";
				var stNms    = "${stIds.stNm}";
				for(var i in data.stId) {
					if(stIds == data.stId[i]){
						stIdComboSpanHtml += "<option value='" + stIds + "'>" + stNms + "</option>";
					}
				}
				</c:forEach>
				stIdComboSpanHtml += "</select>";
				
			$("#stIdComboSpan").html(stIdComboSpanHtml);
		}
		
		function initEditor () {
			EditorCommon.setSEditor('bndItrdc', '${adminConstants.BRAND_IMAGE_PATH}');
			EditorCommon.setSEditor('bndMoItrdc', '${adminConstants.BRAND_IMAGE_PATH}');
			EditorCommon.setSEditor('bndStry', '${adminConstants.BRAND_IMAGE_PATH}');
			
		}
		
		function createbrandDispGrid () {
			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, cellEdit : true
				, height : 150
				, colModels : [
					  _GRID_COLUMNS.stNm
					, {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", key: true, sortable:false }
					, {name:"dispCtgPath", label:'<spring:message code="column.disp_ctg" />', width:"400", align:"center", sortable:false }
					, {name:"brandNo", label:'', width:"0", align:"center", hidden: true, sortable:false }
					, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden: true} /* 사이트 ID */
				]
				, multiselect : true
			};
			grid.create("brandDispList", options);
		}
		// 이미지 업로드 결과
		function resultImage (file ) {
			if (imageType =='1'){
				$("#bndItrdcImgPath").val(file.filePath);
				$("#bndItrdcImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );	
			}else if (imageType =='2'){
				$("#bndItrdcMoImgPath").val(file.filePath);
				$("#bndItrdcMoImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}else if (imageType =='3'){
				$("#tnImgPath").val(file.filePath);
				$("#tnImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}else if (imageType =='4'){
				$("#tnMoImgPath").val(file.filePath);
				$("#tnMoImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}
			
		}

		// 업체 검색
		/*
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#compNo").val (compList[0].compNo );
				$("#compNm").val (compList[0].compNm );
			}
		}
		*/

		function createDisplayTree() {
			$("#displayTree").jstree("destroy");
			$("#displayTree").jstree({//tree 생성
				core : {
					multiple : true
					, data : {
						type : "POST"
						, url : function (node) {
							return "/brand/brandDisplayTree.do";
						}
						, data : function (node) {
							var data = {
								bndNo : '${brandBase.bndNo}',
								dispClsfCd : '${adminConstants.DISP_CLSF_40}'
							};
							return data;
						}
					}
				}
				, plugins : [ "themes" , "checkbox" ]
			})
			.bind("ready.jstree", function (event, data) {
				$("#displayTree").jstree("open_all");
				
				/* <c:if test = "${not empty brandBase}">
					$('#displayTree li.jstree-node').each(function() {
						$('#displayTree').jstree("disable_node", this.id);
					});
				</c:if> */
			});
		}
		// NEW 상품 목록
		function createBrandNewGoodsGrid(){
			var options = {
				url : "<spring:url value='/brand/brandGoodsListGrid.do' />"
				, height : 200
				, multiselect : true
				, searchParam : {
					bndNo : '${brandBase.bndNo}'
				   ,bndGoodsDispGb : '${adminConstants.BND_GOODS_DISP_GB_10}'
				}
				, colModels : [
					  {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
					, _GRID_COLUMNS.goodsNm
					, _GRID_COLUMNS.bndNmKo
					, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"200", align:"center"} /* 사이트 명 */
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.goodsTpCd
					, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
					, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, _GRID_COLUMNS.compNm
					, _GRID_COLUMNS.showYn
					, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
				, paging : false
			};
			grid.create("brandNewGoodsList", options);
		}
		
		// BEST 상품 목록 
		function createBrandBestGoodsGrid(){
			var options = {
				url : "<spring:url value='/brand/brandGoodsListGrid.do' />"
				, height : 200
				, multiselect : true
				, searchParam : {
					bndNo : '${brandBase.bndNo}'
				   ,bndGoodsDispGb : '${adminConstants.BND_GOODS_DISP_GB_20}'
				}
				, colModels : [
					  {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
				  	, _GRID_COLUMNS.goodsNm  
					, _GRID_COLUMNS.bndNmKo
					, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"200", align:"center"} /* 사이트 명 */
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.goodsTpCd
					, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
					, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, _GRID_COLUMNS.compNm
					, _GRID_COLUMNS.showYn
					, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
				, paging : false
			};
			grid.create("brandBestGoodsList", options);
		}
		
		function brandGoodsLayer(paramBrandGoodsList) {
			var options = {
				multiselect : true
				, callBack : function(newGoods) {
					if(newGoods != null) {
						var brandGoods = $('#' + paramBrandGoodsList).getDataIDs();
						var message = new Array();
						
						// 현재 브랜드의 적용사이트 추출
						var brandStIdArray = [];
						$("input:checkbox[name='stId']:checked").each(function () {
							brandStIdArray.push($(this).val());
						});
						
						for(var ng in newGoods){
							var check = true;
							
							// 새로 추가할 상품의 사이트 아이디 추출
							var newGoodsStIdArray = newGoods[ng].stIds.split("|");
							
							// 새로 추가할 상품의 사이트 아이디가 현재 브랜드의 적용사이트에 속하는지 확인
							for (var si in newGoodsStIdArray) {
								if (jQuery.inArray(newGoodsStIdArray[si], brandStIdArray) < 0) {
									check = false;
								} else {
									// 일치하는 사이트아이디가 있으면 바로 통과
									check = true;
									break;
								}
							}
							
							// 적용사이트에 속하지 않아서 적용불가 메시지 추가
							if (check == false) {
								message.push(newGoods[ng].goodsNm + "<spring:message code='admin.web.view.msg.common.miss.site' />");
							}
							
							// 새로 추가할 상품이 현재 브랜드적용상품과 겹치는지 확인
							for(var cg in brandGoods) {
								if(newGoods[ng].goodsId == brandGoods[cg]) {
									check = false;
									message.push(newGoods[ng].goodsNm + "<spring:message code='admin.web.view.msg.common.dupl.goods' />");
								}
							}

							if(check) {
								$("#"+ paramBrandGoodsList ).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
							} 
						}

						if(message != null && message.length > 0) {
							messager.alert(message.join("<br/>"), "Info", "info");
						}
					}
				}
			}
			layerGoodsList.create(options);
		}

		function brandGoodsDelete(paramBrandGoodsList) {
			var rowids = $("#" + paramBrandGoodsList).jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();
			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					$("#" + paramBrandGoodsList).delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.invalid.good' />", "Info", "info");
			}
		}
		// Brand 등록
		function insertBrand () {
			if(validate.check("brandInsertForm")) {
	            // 사이트 선택 체크. hjko 2017.01.10
	            var chkStCnt = $("input[name='stId']:checked").length;
	            
	            if(chkStCnt ==0){
	            	messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
	                return false;
	            }
	            
				// 에디터
				//oEditors.getById["bndItrdc"].exec("UPDATE_CONTENTS_FIELD", []);
				//var strBndItrdc = $("#bndItrdc").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "");
				var strBndItrdc = "";
				if(strBndItrdc.trim() == ""){
					// 브랜드 소개 필수입력 제외
					//messager.alert("<spring:message code='admin.web.view.msg.brand.required.introduce' />", "Info", "info");
					//return;
				}
				
                if($("#bndItrdcImgPath").val() == "" ) {
                	// 브랜드 소개 이미지 필수입력 제외
                    //messager.alert("<spring:message code='admin.web.view.msg.brand.required.fixed.introduce.image' />", "Info", "info");
                    //return;
                }

				// 에디터
				//oEditors.getById["bndMoItrdc"].exec("UPDATE_CONTENTS_FIELD", []);
				//var strBndMoItrdc = $("#bndMoItrdc").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "");
				var strBndMoItrdc = "";
				if(strBndMoItrdc.trim() == ""){
					// 브랜드 모바일 소개 필수입력 제외
					//messager.alert("<spring:message code='admin.web.view.msg.brand.required.introduce.mobile' />", "Info", "info");
					//return;
				}

                if($("#bndItrdcMoImgPath").val() == "" ) {
                	// 브랜드 소개 모바일 소개 이미지 필수입력 제외
                    //messager.alert("<spring:message code='admin.web.view.msg.brand.required.fixed.introduce.image.mobile' />", "Info", "info");
                    //return;
                }

				//oEditors.getById["bndStry"].exec("UPDATE_CONTENTS_FIELD", []);
				
				var formData = $("#brandInsertForm").serializeJson();
				
				/* var arrDispClsfNo = null;
				 	
				var displayTreeId = grid.jsonData ("brandDispList" );
				var dispClsfNoList = new Array();
				for(var i in displayTreeId) {
					var node = displayTreeId[i];
						dispClsfNoList.push(node.dispClsfNo);
				}
				 
				if(dispClsfNoList != null && dispClsfNoList.length > 0) {
					arrDispClsfNo = dispClsfNoList.join(",");
				}
				 
				var arrNewGoodsId = null;
				var arrBestGoodsId = null;
				
				var goodsIdx = $('#brandNewGoodsList').getDataIDs();
				if(goodsIdx != null && goodsIdx.length > 0) {
					arrNewGoodsId = goodsIdx.join(",");
				}
				
				var goodsExIdx = $('#brandBestGoodsList').getDataIDs();
				if(goodsExIdx != null && goodsExIdx.length > 0) {
					arrBestGoodsId = goodsExIdx.join(",");
				} */
				
				// Form 데이터
				/*
				var sendData = {
					  brandBasePO : JSON.stringify(formData )
					, companyBrandPO : JSON.stringify(formData )
					, arrDispClsfNo : arrDispClsfNo
				}
				*/
				var sendData = formData;
				/* $.extend(sendData, { arrDispClsfNo   : arrDispClsfNo }
				             	 , { arrNewGoodsId   : arrNewGoodsId    }
				             	 , { arrBestGoodsId  : arrBestGoodsId  }
				             	 , { companyBrandPO  : JSON.stringify(formData ) }
	         			); */
				console.debug (sendData );
				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/brand/brandInsert.do' />"
							/* , data : $("#brandInsertForm").serialize() */
						    , data :sendData
							, callBack : function (data ) {
								if(data.duplYn == "Y"){
									messager.alert("등록되어 있는 브랜드명은 사용하실 수 없습니다.","Info","info");
								}else{
									messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
										updateTab("/brand/brandDetailView.do?bndNo=" + data.bndNo, "<spring:message code='admin.web.view.app.brand.detail' />");
									});
								}
							}
						};
						ajax.call(options);
						
					}
				});
			}
		}

		function deleteBrandImage () {
			if (imageType =='1'){
				$("#orgBndItrdcImgPath").val("");
				$("#bndItrdcImgPath").val("");
				$("#bndItrdcImgPathView").attr('src', '/images/noimage.png' );	
			}else if(imageType =='2'){
				$("#orgBndItrdcMoImgPath").val("");
				$("#bndItrdcMoImgPath").val("");
				$("#bndItrdcMoImgPathView").attr('src', '/images/noimage.png' );	
			}else if(imageType =='3'){
				$("#orgTnImgPath").val("");
				$("#tnImgPath").val("");
				$("#tnImgPathView").attr('src', '/images/noimage.png' );	
			}else if(imageType =='4'){
				$("#orgTnMoImgPath").val("");
				$("#tnMoImgPath").val("");
				$("#tnMoImgPathView").attr('src', '/images/noimage.png' );	
			}
			
		}
	/*
		function searchBrand () {
			var options = {
				bndGbCd : "${adminConstants.BND_GB_30}"
				, multiselect : false
				, callBack : function(result) {
					if(result.length > 0 ) {
						$("#dlgtBndNo").val(result[0].bndNo );
						$("#dlgtBndNmKo").val(result[0].bndNmKo);
						$("#dlgtBndNmEn").val(result[0].bndNmEn);
					}
				}
			}
			layerBrandList.create(options);
		}

		$(document).on("click", "input[name=bndGbCd]", function(e) {
			if('${adminConstants.BND_GB_30 }' == $(this).val()) {
				$("#dlgtBndView").hide();
			} else {
				$("#dlgtBndView").show();
			}
		});
*/
		//전시카테고리 추가
		function displayCategoryAddPop() {
			// 사이트 선택값		
			var stIdVal = $("#stIdCombo option:selected").val();
			// 전시카테고리 선택값
			var dispClsfCdVal = $("#dispClsfCdCombo option:selected").val();
			
			if(stIdVal == ""){				
				messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />", "Info", "info", function(){
					$("#stIdCombo").focus();
				});
				return false;
			}
			if(dispClsfCdVal == ""){
				messager.alert("<spring:message code='admin.web.view.msg.invalid.dispclsfcd' />", "Info", "info", function(){
					$("#dispClsfCdCombo").focus();
				});
				return false;
			}
			
			var options = {
				  multiselect : true
				  , stId : stIdVal
				  , dispClsfCd : dispClsfCdVal
				  , compNo : ''
				  , callBack : function(result) {
						
					 
					if(result != null && result.length > 0) {
						var idx = $('#brandDispList').getDataIDs();
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
								$("#brandDispList").jqGrid('addRowData', result[i].dispNo, addData, 'last', null);
							} else {
								message.push(result[i].dispNm + "<spring:message code='admin.web.view.msg.common.dupl.displaycategory' />");
							}
						}
						if(message != null && message.length > 0) {
							messager.alert(message.join("<br/>"), "Info", "info");
						}
					}
				}
			}
			layerCategoryList.create(options);
		}
		
		// 전시카테고리 삭제
		function displayCategoryDelDisp() {
			var rowids = $("#brandDispList").jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();
			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					$("#brandDispList").delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.invalid.displaycategory' />","Info","info");
			}
		}
		
		// 바이트 체크 
		function thisByteCheck (dos,maxByte) {
			var conts = document.getElementById(dos.id);
			var i = 0;
			var cnt = 0;
			var exceed = 0;
			var ch = '';
			for (i=0; i<conts.value.length; i++) {
				ch = conts.value.charAt(i);
				if (escape(ch).length > 4) {
					cnt += 2;
				} else {
					cnt += 1;
				}
			}
			if (cnt > maxByte) {
				exceed = cnt - maxByte;
				var tcnt = 0;
				var xcnt = 0;
				var tmp = conts.value;
				for (i=0; i<tmp.length; i++) {
					ch = tmp.charAt(i);
					if (escape(ch).length > 4) {
						tcnt += 2;
					} else {
						tcnt += 1;
					}
					if (tcnt > maxByte) {
						tmp = tmp.substring(0,i);
						break;
					} else {
						xcnt = tcnt;
					}
				}
				conts.value = tmp;
				return;
			}

		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
<form id="brandInsertForm" name="brandInsertForm" method="post" >
	<div class="mTitle">
		<h2>브랜드 기본 정보</h2>
	</div>
	<table class="table_type1">
		<caption>Brand 등록</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.bnd_no" /><strong class="red">*</strong></th>	<!-- 브랜드 번호-->
				<td>
					<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.bnd_no" />" value="" />
					<b>자동입력</b>
				</td>
                <th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
                <td>
                    <frame:stIdCheckbox selectKey="${companyBase.stStdList}" compNo="${loginCompNo}"/>
                </td>								
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.bnd_nm" /><strong class="red">*</strong></th>	<!-- 브랜드 명-->
				<td colspan="3">
					<input type="text" class="w400 validate[required, maxSize[100]]" id="bndNmKo" name="bndNmKo" title="<spring:message code="column.bnd_nm" />" value=""/>
				</td>
				<%-- <th scope="row"><spring:message code="column.bnd_nm_en" /><strong class="red">*</strong></th>	<!-- 영문 브랜드 명-->
				<td>
					<input type="text" class="w250 validate[required]" id="bndNmEn" name="bndNmEn" title="<spring:message code="column.bnd_nm_en" />" value="" maxlength="50" />
				</td> --%>
			</tr>
			<%-- <tr>
				<th scope="row"><spring:message code="column.ko_init_char_cd" /></th>	<!-- 국문 초성 -->
				<td>
					<select name="koInitCharCd" id="koInitCharCd" title="<spring:message code="column.ko_init_char_cd" />">
						<frame:select grpCd="${adminConstants.INIT_CHAR }" usrDfn1Val="${adminConstants.INIT_CHAR_GB_KO }" defaultName="선택"/>
					</select>
				</td>
				<th scope="row"><spring:message code="column.en_init_char_cd" /></th>	<!-- 영문 초성 -->
				<td>
					<select name="enInitCharCd" id="enInitCharCd" title="<spring:message code="column.en_init_char_cd" />">
						<frame:select grpCd="${adminConstants.INIT_CHAR }" usrDfn1Val="${adminConstants.INIT_CHAR_GB_EN }" defaultName="선택"/>
					</select>
				</td>
			</tr>
			<tr>
                            <th scope="row"><spring:message code="column.bnd_tp_cd" /><strong class="red">*</strong></th> <!-- 브랜드 유형, 10:일반, 20:VECI  -->
                            <td>
                                <frame:radio name="bndTpCd" grpCd="${adminConstants.BND_TP }" useYn="Y" required="true" />
                            </td>
                            <th scope="row"><spring:message code="column.bnd" /><spring:message code="column.show_yn" /><strong class="red">*</strong></th>
                            <td>
                                <frame:radio name="bndShowYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${brandBase.bndShowYn }" required="true" />
                                <input type="hidden" name="useYn" value="${adminConstants.USE_YN_Y }">
                            </td>  
			</tr> --%>
			<%--
			<tr>
				<th scope="row"><spring:message code="column.bnd_cnts_tp" />(VECI 전용)</th><!-- 브랜드 콘텐츠 유형 -->
				<td>
					<frame:radio name="bndCntsTpCd" grpCd="${adminConstants.BND_CNTS_TP}" selectKey="${brandBase.bndCntsTpCd}" useYn="Y" />
				</td>
			</tr>
			--%>
			<!--  
			<tr id="dlgtBndView">
				<th><spring:message code="column.brand.dlgt_bnd_nm" /><strong class="red">*</strong></th>//대표브랜드번호
				<td colspan="3">
					<input type="hidden" class="validate[required]" name="dlgtBndNo" id="dlgtBndNo" title="<spring:message code="column.dlgt_bnd_no" />" value="" />
					<input type="text" class="w175 readonly validate[required]" id="dlgtBndNmKo" name="dlgtBndNmKo" title="<spring:message code="column.brand.dlgt_bnd_nm" />" value="" />
					<input type="text" class="w175 readonly validate[required]" id="dlgtBndNmEn" name="dlgtBndNmEn" title="<spring:message code="column.brand.dlgt_bnd_nm" />" value="" />
					<button type="button" class="btn_h25_type1" onclick="searchBrand();" >검색</button>
				</td>
			</tr>
			-->
			<!-- 
			<tr>
				<th><spring:message code="column.goods.comp_no" /><strong class="red">*</strong></th>	//업체번호
				<td colspan="3">
					<frame:compNo funcNm="searchCompany" requireYn="Y" />
				</td>
			</tr>-->
			<%--
			<tr>
				<th><spring:message code="column.bnd_ctg" />(VECI 전용)</th>	<!-- 브랜드카테고리 --></th>
				<td colspan="3">
					 <div class="mButton typeBorad">
						<div class="leftInner">
						
							<span id="stIdComboSpan"></span>
			 --%>				 
							<%-- <select id="stIdCombo" name="stIdCombo">
								<frame:stIdStSelect defaultName="사이트선택" />
							</select> --%>
			 <%--				
							<select class="wth200" id="dispClsfCdCombo" name="dispClsfCdCombo">
								<!--frame:select grpCd="${adminConstants.DISP_CLSF }" defaultName="전시분류" />--> 
								<option value=""  title="전시분류">전시분류</option>
								<option value="${adminConstants.DISP_CLSF_40 }"  title="브랜드카테고리">브랜드카테고리</option> 
							</select>
							 			
							<button type="button" onclick="displayCategoryAddPop();" class="btn_h25_type1">추가</button>
							<button type="button" onclick="displayCategoryDelDisp();" class="btn_h25_type1">삭제</button>
						</div>
					</div>	
					 <table id="brandDispList" ></table>
					 <div id="brandDispListPage"></div>
				</td>
			</tr>
			--%>					
			<%-- <tr>
				<th scope="row"><spring:message code="column.bnd_itrdc" /></th>	<!-- 브랜드 소개 -->
				<td colspan="3">
					<textarea name="bndItrdc" id="bndItrdc" cols="30" rows="10" style="width: 100%"></textarea>
				</td>
			</tr> --%>
			<tr>
				<th scope="row"><spring:message code="column.bnd_logo_img_path_pc" /></th>	<!-- 브랜드 로고(PC) -->
				<td colspan="3">
					<div class="inner">
						<input type="hidden" id="bndItrdcImgPath" name="bndItrdcImgPath" value="" />
						<img id="bndItrdcImgPathView" name="bndItrdcImgPathView" src="/images/noimage.png" class="thumb" alt="" />
					</div>
					<div class="inner ml10" style="vertical-align:bottom">
						<button type="button" class="btn" onclick="imageType=1;fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
						<button type="button" class="btn" onclick="imageType=1;deleteBrandImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
					</div>
				</td>
			</tr>
			<%-- <tr>
				<th scope="row"><spring:message code="column.bnd_itrdc_mo" /></th>	<!-- 브랜드 소개 -->
				<td colspan="3">
					<textarea name="bndMoItrdc" id="bndMoItrdc" cols="30" rows="10" style="width: 100%"></textarea>
				</td>
			</tr> --%>
			<tr>
				<th scope="row"><spring:message code="column.bnd_logo_img_path_mo" /></th>	<!-- 브랜드 로고(MOBILE) -->
				<td colspan="3">
					<div class="inner">
						<input type="hidden" id="bndItrdcMoImgPath" name="bndItrdcMoImgPath" value="" />
						<img id="bndItrdcMoImgPathView" name="bndItrdcMoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
					</div>
					<div class="inner ml10" style="vertical-align:bottom">
						<button type="button" class="btn" onclick="imageType=2;fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
						<button type="button" class="btn" onclick="imageType=2;deleteBrandImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
					</div>
				</td>
			</tr>
			<%-- <tr>
				<th scope="row"><spring:message code="column.bnd_stry" /></th>	<!-- 브랜드 스토리   -->
				<td colspan="3">
					<textarea name="bndStry" id="bndStry" cols="30" rows="10" style="width: 100%"></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.bnd.dtl_img_path" /><br/>(380*370)</th>	<!-- PC 상품상세 브랜드 이미지 -->
				<td colspan="3">
					<div class="inner">
						<input type="hidden" id="tnImgPath" name="tnImgPath" value="" />
						<img id="tnImgPathView" name="tnImgPathView" src="/images/noimage.png" class="thumb" alt="" />
					</div>
					<div class="inner ml10" style="vertical-align:bottom">
						<button type="button" class="btn" onclick="imageType=3;fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
						<button type="button" class="btn" onclick="imageType=3;deleteBrandImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.bnd.dtl_mo_img_path" /><br/>(220*270)</th>	<!-- 모바일 상품상세 브랜드 이미지 -->
				<td colspan="3">
					<div class="inner">
						<input type="hidden" id="tnMoImgPath" name="tnMoImgPath" value="" />
						<img id="tnMoImgPathView" name="tnMoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
					</div>
					<div class="inner ml10" style="vertical-align:bottom">
						<button type="button" class="btn" onclick="imageType=4;fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
						<button type="button" class="btn" onclick="imageType=4;deleteBrandImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
					</div>
				</td>
			</tr> --%>
		</tbody>
	</table>
	
		
<c:if test="${not empty brandBase}">					
	<div id="goodsNewView">
		<div class="mTitle">
			<h2>브랜드 NEW 적용 상품</h2>
			<div class="buttonArea">
				<button type="button" onclick='brandGoodsLayer("brandNewGoodsList");' class="btn btn-add">추가</button>
				<button type="button" onclick='brandGoodsDelete("brandNewGoodsList");' class="btn btn-add">삭제</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="brandNewGoodsList" ></table>
		</div>
		<hr />
	</div>
	
	<div id="goodsExView">
		<div class="mTitle">
			<h2>브랜드 BEST 적용 상품</h2>
			<div class="buttonArea">
				<button type="button" onclick='brandGoodsLayer("brandBestGoodsList");'  class="btn btn-add">추가</button>
				<button type="button" onclick='brandGoodsDelete("brandBestGoodsList");'  class="btn btn-add">삭제</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="brandBestGoodsList" ></table>
		</div>
	</div>
</c:if>	

</form>

<div class="btn_area_center">
	<button type="button" class="btn btn-ok" onclick="insertBrand();" >등록</button>
	<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
</div>

	</t:putAttribute>

</t:insertDefinition>