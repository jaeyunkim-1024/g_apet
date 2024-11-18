<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		var displayCategory1;
		var displayCategory2;
		var isGridExists = false;
		$(document).ready(function() {
			searchDateChange();
			createGiftGoodsGrid();
            jQuery("#dispClsfNo").val("");
            createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
            
            $("input[name='chkEndSaleYn']").click(function(){
				if ( $(this).prop('checked') ) {
			        $(this).addClass("checked");
			        $("#checkOptDate > option[value='']").attr("selected", "true");
			        searchDateChange();
			        $("#endSaleYn").val("Y");
			      } else {
			        $(this).removeClass("checked");
			        $("#checkOptDate > option[value='']").attr("selected",false);
			        $("#checkOptDate > option[value='${adminConstants.SELECT_PERIOD_40 }']").prop('selected', true);
			        searchDateChange();
			        $("#endSaleYn").val("N");
			      }
			});
		});
		// 상품 상세
		function viewGiftGoodsDetail (goodsId) {
			var url = "/goods/giftGoodsDetailView.do?goodsId=" + goodsId;
			
			addTab('사은품 상품 상세 - ' + goodsId, url);
		}

		// 상품 Grid
		function createGiftGoodsGrid () {
			var gridOptions = {
				  url : "<spring:url value='/goods/giftGoodsBaseGrid.do' />"	
 				, height : 400
				, searchParam : $("#goodsListForm").serializeJson()
				, colModels : [
					  {name:'goodsId', label:'<spring:message code="column.goods_id" />', width:'120', key: true, align:'center'}
					, _GRID_COLUMNS.goodsNm
					, {name:"imgPath", label:'<spring:message code="column.tn_img_path" />', width:"120", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							return tag.goodsImage(_IMG_URL, rowObject.goodsId, rowObject.imgPath , rowObject.imgSeq, "", "${ImageGoodsSize.SIZE_60.size[0]}", "${ImageGoodsSize.SIZE_60.size[1]}", "h50 w50", "/images/noimage.png", "Y");
						}
					}
					, {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } } /* 노출여부 */
                    , _GRID_COLUMNS.sysRegrNm
                    , _GRID_COLUMNS.sysRegDtm
                    , _GRID_COLUMNS.sysUpdrNm
                    , _GRID_COLUMNS.sysUpdDtm
	                ]

				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					var goodsTpCd = $("#goodsList").jqGrid ('getCell', id, 'goodsTpCd');
					viewGiftGoodsDetail(id);
				}
			}
			grid.create("goodsList", gridOptions);
			isGridExists = true;
		}

		// 상품 검색 조회
		function searchGoodsList () {
			if (! isGridExists) {
				createGiftGoodsGrid();
			}
			
			var options = {
				searchParam : $("#goodsListForm").serializeJson()
			};
			grid.reload("goodsList", options);
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("goodsListForm");
			<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
			$("#goodsListForm #compNo").val('${adminSession.compNo}');
			$("#goodsListForm #showAllLowCompany").val("N");
			</c:if>
			searchDateChange();
		}


		// 사은품 상품 등록
		function registGiftGoods () {
			goUrl ("사은품 상품 등록", "<spring:url value='/goods/giftGoodsInsertView.do' />");
		}

		/* 
		function goodsBaseExcelDownload(){

			var d = $("#goodsListForm").serializeJson();

			createFormSubmit( "goodsBaseExcelDownload", "/goods/giftgoodsBaseExcelDownload.do", d );
		}
 	    */
	      // 사이트 선택
        $(document).on("change", "#stIdCombo", function(e) {
        	var stId = $("select[name=stId]").val();
        	if (stId == null || stId == '') {
        		jQuery("#dispClsfNo").val("");
        		createDisplayCategory(0, "${adminConstants.DISP_CLSF_10 }");
        	} else {
	            jQuery("#dispClsfNo").val("");
	            createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
        	}
        	
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
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
				jQuery("#dispClsfNo").val("");
				createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
			}
		}

        $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
            if ($(this).is(":checked") == true) {
                $("#showAllLowCompany").val("Y");
            } else {
                $("#showAllLowCompany").val("N");
            }
        });

        // 등록일 변경
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
        
	      // 사이트 선택
        $(document).on("change", "#stIdCombo", function(e) {
        	var stId = $("select[name=stId]").val();
        	if (stId == null || stId == '') {
        		jQuery("#dispClsfNo").val("");
        		createDisplayCategory(0, "${adminConstants.DISP_CLSF_10 }");
        	} else {
	            jQuery("#dispClsfNo").val("");
	            createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }");
        	}
        });
	      
		// 전시 카테고리 select 생성
		function createDisplayCategory(dispLvl, upDispClsfNo) {
			var selectCategory = "<option value='' selected='selected'>선택</option>";

			if (dispLvl == 0) {
				jQuery("#displayCategory" + (dispLvl+1)).html("");
				jQuery("#displayCategory" + (dispLvl+1)).append(selectCategory);
				jQuery("#displayCategory" + (dispLvl+2)).hide();
				jQuery("#displayCategory" + (dispLvl+3)).hide();
				jQuery("#dispClsfNo").val("");
			} else {
				jQuery("#displayCategory" + (dispLvl)).html("");
				jQuery("#displayCategory" + (dispLvl)).hide();
				jQuery("#displayCategory" + (dispLvl+1)).hide();
				jQuery("#displayCategory" + (dispLvl+2)).hide();

				if (dispLvl == 1) {
					jQuery("#displayCategory" + (dispLvl)).show();
				}

				if (upDispClsfNo != "") {
					var stId = $("select[name=stId]").val();

					var options = {
						url : "<spring:url value='/display/listDisplayCategory.do' />"
						, data : {
							stId : stId
							, dispLvl : dispLvl
							, upDispClsfNo : upDispClsfNo
							, dispClsfCd : "${adminConstants.DISP_CLSF_10 }"
							, dispYn : "Y"
						}
						, callBack : function(result) {
							if (result.length > 0) {
			 					jQuery(result).each(function(i){
			 						selectCategory += "<option value='" + result[i].dispClsfNo + "'>" + result[i].dispClsfNm + "</option>";
								});

								jQuery("#displayCategory" + (dispLvl)).show();
							}
							jQuery("#displayCategory" + (dispLvl)).append(selectCategory);
						}
					};

					ajax.call(options);
				}
			}
		}
        
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="goodsListForm" name="goodsListForm" method="post">
					<input type="hidden" id="dispClsfNo" name="dispClsfNo" value="" />
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.sys_reg_dtm" /></th>
								<!-- 기간 -->
								<td><frame:datepicker startDate="sysRegDtmStart"
										endDate="sysRegDtmEnd"
										startValue="${adminConstants.COMMON_START_DATE }" />
									&nbsp;&nbsp; <select id="checkOptDate" name="checkOptDate"
									onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"
											defaultName="기간선택" />
								</select></td>
								<th scope="row"><spring:message code="column.st_nm" /></th>
								<!-- 사이트 명 -->
								<td><select id="stIdCombo" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
								</select></td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.goods_id" /></th>
								<!-- 상품 ID -->
								<td><textarea rows="3" cols="30" id="goodsIds"
										name="goodsIds"></textarea></td>
								<th scope="row"><spring:message code="column.goods_nm" /></th>
								<!-- 상품 명 -->
								<td><textarea rows="3" cols="30" id="goodsNms"
										name="goodsNms"></textarea></td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchGoodsList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule"> 
			<div id="resultArea">
			<button type="button" onclick="registGiftGoods();" class="btn btn-add">사은품 상품 등록</button>
				
<!-- 			<button type="button" onclick="goodsBaseExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button> -->
			</div>
			
			<table id="goodsList"></table>
			<div id="goodsListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>