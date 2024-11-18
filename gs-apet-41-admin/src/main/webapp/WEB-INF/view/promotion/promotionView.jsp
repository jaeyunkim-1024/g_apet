<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

			$(document).ready(function(){
<c:choose>
<c:when test="${promotionBase.editable}">
				// 프로모션 상품
				createPromotionGoodsGrid();
				// 사이트아이디 초기화
				fnStIdComboSpanHtml();
				// 프로모션 전시 리스트
				createDisplayTree();
				fnDispClsfCdComboSpanHtml('30');
				// 프로모션 기획전
				createpromotionExhbtGrid();
				// 프로모션 대상 업체
				promotionTargetCompNoListGrid();
				// 프로모션 대상브랜드
				promotionTargetBndNoListGrid();
</c:when>
<c:otherwise>
	<c:choose>
	<c:when test="${adminConstants.PRMT_TG_20 eq promotionBase.prmtTgCd}">
	                // 프로모션 상품
	            createPromotionGoodsGrid();
	</c:when>
	<c:when test="${adminConstants.PRMT_TG_30 eq promotionBase.prmtTgCd}">
	            // 사이트아이디 초기화
	            fnStIdComboSpanHtml();
	            // 프로모션 전시 리스트
	            createDisplayTree();
	</c:when>
	<c:when test="${adminConstants.PRMT_TG_40 eq promotionBase.prmtTgCd}">
	            // 프로모션 기획전
	            createpromotionExhbtGrid();
	</c:when>
	<c:when test="${adminConstants.PRMT_TG_50 eq promotionBase.prmtTgCd}">
	            // 프로모션 대상 업체
	            promotionTargetCompNoListGrid();
	</c:when>
	<c:when test="${adminConstants.PRMT_TG_60 eq promotionBase.prmtTgCd}">
	            // 프로모션 대상브랜드
	            promotionTargetBndNoListGrid();
	</c:when>
	</c:choose>
</c:otherwise>
</c:choose>
                // 프로모션 제외 상품 목록
                createPromotionGoodsExGrid();

				$("input:radio[name=prmtAplCd]").change(function() {
					prmtAplCdChange();
		        });

<c:if test="${not empty promotionBase.prmtAplCd}">
				$("#spanCpAplCd10").hide();
				$('input:radio[name=prmtAplCd]:input[value=' + '${promotionBase.prmtAplCd}' + ']').prop("checked", true);
				prmtAplCdChange();
</c:if>
				// 전시카테고리면 화면 크기 줄이기
				if (${adminConstants.PRMT_TG_30 eq promotionBase.prmtTgCd}) {
				    $("#promotionView").attr("style", 'width: 79%');
				}
			});

			// 프로모션 상태 변경
			$(document).on("change", "#prmtStatCd", function() {

				var currentPromotionState = "${promotionBase.prmtStatCd}";
				var newPromotionState = $(this).val();

				if (newPromotionState < currentPromotionState) {
					if (newPromotionState == '${adminConstants.PRMT_STAT_20}' && currentPromotionState == '${adminConstants.PRMT_STAT_30}') {
						// 중단 --> 진행 으로 변경은 허용함.
						messager.alert("<spring:message code="admin.web.view.app.promotion.manage.detail.alert.prmt_state_restart" />","Info","info");
					} else {
						// 이전 단계로 변경은 허용하지 않음.
						messager.alert("<spring:message code="admin.web.view.app.promotion.manage.detail.alert.prmt_state_invalid" />","Info","info",function(){
							$("#prmtStatCd").val(currentPromotionState);
						});						
					}
				}
			});

			// 프로모션 대상 변경
			$(document).on("change", "input[name=prmtTgCd]", function(e){
				$("#goodsView").hide();
				$("#goodsExView").hide();
				$("#displayView").hide();
				//$("#displayView30").hide();
				$("#displayView40").hide();
				$("#displayView50").hide();
	            $("#displayView60").hide();
				$("#promotionView").attr("style", 'width: 100%');
				if($(this).val() == '${adminConstants.PRMT_TG_20}') {
					$("#goodsView").show();
					grid.resize();
				} else if($(this).val() == '${adminConstants.PRMT_TG_30}') {
					$("#goodsExView").show();
					grid.resize();

                    //$("#displayView30").show();
                    $("#displayView").show();
					createDisplayTree();
					grid.resize();

                    $("#dispClsfCdCombo").val( "${adminConstants.DISP_CLSF_10}" ) ;

					$("#promotionView").attr("style", 'width: 79%');
				} else if($(this).val() == '${adminConstants.PRMT_TG_40}') {
					$("#goodsExView").show();
					grid.resize();
					$("#displayView40").show();
					//createDisplayTree();
					grid.resize();
					$("#promotionView").attr("style", 'width: 100%');
				}else if($(this).val() == '${adminConstants.PRMT_TG_50}') {
					$("#goodsExView").show();
					grid.resize();

					promotionTargetCompNoListGrid();
					$("#displayView50").show();
					grid.resize();

					$("#displayView50").attr("style", 'width: 100%');

				}else if($(this).val() == '${adminConstants.PRMT_TG_60}') {
					$("#goodsExView").show();
					grid.resize();
					// 프로모션대상브랜드
					promotionTargetBndNoListGrid();
					$("#displayView60").show();
					grid.resize();

					$("#displayView60").attr("style", 'width: 100%');
				}
			});

			// 전시카테고리 등록용 사이트 아이디 셀렉트박스
            function fnStIdComboSpanHtml() {
                var data = $("#promotionForm").serializeJson();
                var selected = "selected=\'selected\'";
                var stIdComboSpanHtml = "";
                    stIdComboSpanHtml += "<select id='stIdCombo' name='stIdCombo' ${promotionBase.editable ? '' : 'disabled=\'disabled\''}>";
<c:if test="${promotionBase.stStdList.size() > 1}">
                    stIdComboSpanHtml += "<option value=''>선택하세요</option>";
                    selected = "";
</c:if>
<c:forEach items="${promotionBase.stStdList}" var="stInfo" >
                    var stId    = "${stInfo.stId}";
                    var stNm    = "${stInfo.stNm}";
                    for(var i in data.stId) {
                        if(stId == data.stId[i]){
                            stIdComboSpanHtml += "<option value='" + stId + "' " + selected + ">" + stNm + "</option>";
                        }
                    }
</c:forEach>
                    stIdComboSpanHtml += "</select>";

                $("#stIdComboSpan").html(stIdComboSpanHtml);
            }

			//프로모션대상에 따른 콤보박스 변화
			function fnDispClsfCdComboSpanHtml(dos) {

	           	var dispClsfCdComboSpanHtml = "";
	           	dispClsfCdComboSpanHtml += "<select id='dispClsfCdCombo' name='dispClsfCdCombo' disabled=\'disabled\' >";
		    	dispClsfCdComboSpanHtml += "<option value='${adminConstants.DISP_CLSF_10 }'>전시카테고리</option>";
			    dispClsfCdComboSpanHtml += "</select>";

			    $("#dispClsfCdComboSpan").html(dispClsfCdComboSpanHtml);
			}

			// 프로모션 적용 변경
			function prmtAplCdChange(){
				var prmtAplCd = $(":input:radio[name=prmtAplCd]:checked").val();

				if(prmtAplCd == '${adminConstants.PRMT_APL_10}') {
					$("#spanCpAplCd10").show();
					$(".prmtAplCdView").show();
					$("#aplVal").attr("maxlength", 3);
					$("#aplVal").val("${promotionBase.aplVal}");
					objClass.add($("#aplVal"), "validate[required,custom[number],max[100]]");
					objClass.remove($("#aplVal"), "validate[required,custom[number]]");
				} else {
					$("#spanCpAplCd10").hide();
					$(".prmtAplCdView").hide();
					$("#aplVal").attr("maxlength", 8);
					$("#aplVal").val("${promotionBase.aplVal}");
					objClass.add($("#aplVal"), "validate[required,custom[number]]");
					objClass.remove($("#aplVal"), "validate[required,custom[number],max[100]]");
				}

				// DB 에서 읽어온 값과 다를 때 0으로 설정함
				if (prmtAplCd != "${promotionBase.prmtAplCd}") {
					$("#aplVal").val("0");
				}
			}

            // 프로모션적용 상품 목록
            function createPromotionGoodsGrid(){
                var options = {
                    url : "<spring:url value='/promotion/promotionGoodsListGrid.do' />"
                    , height : 400
                    , multiselect : true
                    , searchParam : {
                        prmtNo : '${promotionBase.prmtNo}'
                    }
                    , colModels : [
                    	{name:"prmtNo", hidden:true }
                        , {name:"aplSeq", hidden:true }
                        , {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
                        , {name:"compGoodsId", label:"<spring:message code='column.comp_goods_id' />", width:"120", align:"center", sortable:false} /* 업체 상품 번호 */
                        , {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"150", align:"center", sortable:false } /* 브랜드명 */
                        , {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"250", align:"center", sortable:false } /* 상품명 */
                        , {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
                        , {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
                        , {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        , {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
                        , {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"120", align:"center", sortable:false } /* 업체명 */
                        , {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"100", align:"center", sortable:false } /* 모델명 */
                        , {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"100", align:"center", sortable:false } /* 제조사 */
                        , {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center"} /* 사이트 명 */
                        , {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
                        ]
                    , paging : false
                };
                grid.create("promotionGoodsList", options);
            }

			// 프로모션 적용 전시 카테고리
            function createDisplayTree() {
                $("#displayTree").jstree("destroy");
                $("#displayTree").jstree({//tree 생성
                    core : {
                        multiple : true
                        , data : {
                            type : "POST"
                            , url : function (node) {
                                return "/promotion/promotionDisplayTree.do";
                            }
                            , data : function (node) {
                                var data = {
                                    prmtNo : '${promotionBase.prmtNo}'
                                    ,stId : $(':radio[name="stId"]:checked').val()
                                };
                                return data;
                            }
                        }
                    }
                    , plugins : [ "themes" , "checkbox" ]
                })
                .bind("ready.jstree", function (event, data) {
                    $("#displayTree").jstree("open_all");
                    
                    <c:if test = "${not empty promotionBase and not promotionBase.editable}">
                        $('#displayTree li.jstree-node').each(function() {
                            $('#displayTree').jstree("disable_node", this.id);
                        });
                    </c:if>
                });
            }

            // 프로모션 적용 기획전 목록
            function createpromotionExhbtGrid () {
                var options = {
                    url : "<spring:url value='/promotion/promotionTargetExhbtNoListGrid.do' />"
                    , searchParam : { prmtNo : '${promotionBase.prmtNo}' }
                    , paging : false
                    , cellEdit : true
                    , height : 150
                    , colModels : [
                        {name:"exhbtNo", label:'<spring:message code="column.exhbt_no" />', width:"80", align:"center", key: true, sortable:false }
                        , {name:"exhbtNm", label:'<spring:message code="column.exhbt_nm" />', width:"300", align:"center", sortable:false }
                        , {name:"prmtNo", label:'', width:"0", align:"center", hidden: true, sortable:false }
                        , {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"120", align:"center", sortable:false } /* 사이트 명 */
                        , {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden: true} /* 사이트 ID */
                        /* , {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"100", align:"center", editable:true, sortable:false } */
                    ]
                    , multiselect : true
                };
                grid.create("promotionExhbtList", options);
            }

            // 프로모션 적용 업체들
            function promotionTargetCompNoListGrid () {
                var options = {
                    url : "<spring:url value='/promotion/promotionTargetCompNoListGrid.do' />"
                    , searchParam : { prmtNo      : '${promotionBase.prmtNo}' }
                    , paging : false
                    , height : 150
                    , colModels : [
                          {name:"prmtNo", label:'prmtNo', width:"100", align:"center",  sortable:false , hidden:true}
                        , {name:"compNo", label:'<spring:message code="column.comp_no" />', width:"80", align:"center", key: true, formatter:'integer'}
                        , {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"120", align:"center"}
                        , {name:"compStatCd", label:'<spring:message code="column.comp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_STAT }' />"}}
                        , {name:"compGbCd", label:'<spring:message code="column.comp_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_GB }' />"}}
                        , {name:"compTpCd", label:'<spring:message code="column.comp_tp_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_TP }' />"}}
                        , {name:"ceoNm", label:'<spring:message code="column.ceo_nm" />', width:"80", align:"center"}
                        , {name:"bizNo", label:'<spring:message code="column.biz_no" />', width:"150", align:"center"}
                        , {name:"fax", label:'<spring:message code="column.fax" />', width:"120", align:"center"}
                        , {name:"tel", label:'<spring:message code="column.tel" />', width:"120", align:"center"}
                        , {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
                        , {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                    ]
                    , multiselect : true
                };
                grid.create("promotionTargetCompNoList", options);
            }

            // 프로모션 적용 브랜드
            function promotionTargetBndNoListGrid () {
                var options = {
                    url : "<spring:url value='/promotion/promotionTargetBndNoListGrid.do' />"
                    , searchParam : { prmtNo      : '${promotionBase.prmtNo}' }
                    , paging : false
                    , height : 150
                    , colModels : [
                            {name:"prmtNo", label:'prmtNo', width:"100", align:"center",  sortable:false , hidden:true}
                          , {name:"bndNo", label:"<spring:message code='column.bnd_no' />" , width:"80", key: true, align:"center" , hidden:true} /* 브랜드 번호 */
                          , {name:"bndNmKo", label:"<spring:message code='column.bnd_nm_ko' />" , width:"150", align:"center", sortable:false } /* 브랜드 국문 */
                          , {name:"bndNmEn", label:"<spring:message code='column.bnd_nm_en' />" , width:"150", align:"center", sortable:false } /* 브랜드 영문 */
                          , {name:"useYn", label:"<spring:message code='column.use_yn' />" , width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.USE_YN }' showValue='false' />" } } /* 사용여부 */
                          //, {name:"sortSeq", label:"<spring:message code='column.sort_seq' />" , width:"80", align:"center", sortable:false } /* 정렬순서 */
                          , {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />" , width:"120", align:"center", sortable:false } /* 업체명 */
                          , {name:"sysRegrNm", label:"<spring:message code='column.sys_regr_nm' />" , width:"100", align:"center"}
                          , {name:"sysRegDtm", label:"<spring:message code='column.sys_reg_dtm' />" , width:"150", align:"center", formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
                          , {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
                          , {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                    ]
                    , multiselect : true
                };
                grid.create("promotionTargetBndNoList", options);
            }

            // 프로모션적용 제외 상품 목록 
            function createPromotionGoodsExGrid(){
                var options = {
                    url : "<spring:url value='/promotion/promotionGoodsExListGrid.do' />"
                    , height : 400
                    , multiselect : true
                    , searchParam : {
                        prmtNo : '${promotionBase.prmtNo}'
                    }
                    , colModels : [
                          {name:"aplSeq", hidden:true }
                            , {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
                            , {name:"compGoodsId", label:"<spring:message code='column.comp_goods_id' />", width:"120", align:"center", sortable:false} /* 업체 상품 번호 */
                            , {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"120", align:"center", sortable:false } /* 브랜드명 */
                            , {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"250", align:"center", sortable:false } /* 상품명 */
                            , {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
                            , {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
                            , {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                            , {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                            , {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                            , {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
                            , {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"120", align:"center", sortable:false } /* 업체명 */
                            , {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"100", align:"center", sortable:false } /* 모델명 */
                            , {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"100", align:"center", sortable:false } /* 제조사 */
                            , {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center"} /* 사이트 명 */
                            , {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
                        ]
                    , paging : false
                };
                grid.create("promotionGoodsExList", options);
            }

            //상품 삭제
            function promotionGoodsDelete(paramPromotionGoodsList) {
                var rowids = $("#" + paramPromotionGoodsList).jqGrid('getGridParam', 'selarrrow');
                var delRow = new Array();
                if(rowids != null && rowids.length > 0) {
                    for(var i in rowids) {
                        delRow.push(rowids[i]);
                    }
                }
                if(delRow != null && delRow.length > 0) {
                    for(var i in delRow) {
                        $("#" + paramPromotionGoodsList).delRowData(delRow[i]);
                    }
                } else {
                	messager.alert("<spring:message code='admin.web.view.msg.invalid.good' />","Info","info");                    
                }
            }

            //전시카테고리 추가
            function displayCategoryAddPop() {
                // 사이트 선택값
                var stIdVal = $("#stIdCombo option:selected").val();
                // 전시카테고리 선택값
                var dispClsfCdVal = $("#dispClsfCdCombo option:selected").val();

                if(stIdVal == ""){
                	messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />","Info","info",function(){
                		 $("#stIdCombo").focus();
					});                                       
                    return false;
                }
                if(dispClsfCdVal == ""){
                	messager.alert("<spring:message code='admin.web.view.msg.invalid.dispclsfcd' />","Info","info",function(){
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
                            var idx = $('#promotionDispList').getDataIDs();
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
                                    $("#promotionDispList").jqGrid('addRowData', result[i].dispNo, addData, 'last', null);
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
                var rowids = $("#promotionDispList").jqGrid('getGridParam', 'selarrrow');
                var delRow = new Array();
                if(rowids != null && rowids.length > 0) {
                    for(var i in rowids) {
                        delRow.push(rowids[i]);
                    }
                }
                if(delRow != null && delRow.length > 0) {
                    for(var i in delRow) {
                        $("#promotionDispList").delRowData(delRow[i]);
                    }
                } else {
                	messager.alert("<spring:message code='admin.web.view.msg.invalid.displaycategory' />","Info","info");
                }
            }

			//기획전 추가
			function exhbtListAddPop() {
				var options = {
					  multiselect : true
					  ,url : "<spring:url value='/promotion/exhibitionListPopView.do' />"
					  , dataType : "html"
					  ,callBack : function(result) {
						  var config = {
									id : "exhibitionListPopViewLayer"
									, width : 1200
									, height : 800
									, top : 100
									, title : "기획전 목록"
									, body : result
									, button : "<button type=\"button\" onclick=\"exhbtListAddPopConfirm();\" class=\"btn btn-ok\">확인</button>"
						  }
						  layer.create(config);
					}
				}
				ajax.call(options );
			}

			function exhbtListAddPopConfirm(){

				var result = new Array();
				var grid = $("#exhibitionList" );
				var rowids = rowids = grid.jqGrid('getGridParam', 'selarrrow');
				for (var i = rowids.length - 1; i >= 0; i--) {
					result.push(grid.jqGrid('getRowData', rowids[i]));
				}

				layer.close("exhibitionListPopViewLayer");

				  if(result != null && result.length > 0) {
					var idx = $('#promotionExhbtList').getDataIDs();
					var message = new Array();
					for(var i in result){
						var addData = {
							  stNm: result[i].stNm
							, stId: result[i].stId
							, exhbtNo : result[i].exhbtNo
							, exhbtNm : result[i].exhbtNm
						}
						var check = true;
						for(var j in idx) {
							if(addData.exhbtNo == idx[j]) {
								check = false;
							}
						}
						if(check) {
							$("#promotionExhbtList").jqGrid('addRowData', result[i].exhbtNo, addData, 'last', null);
						} else {
							message.push(result[i].exhbtNm + " 중복된 기획전 입니다.");
						}
					}
					if(message != null && message.length > 0) {
						messager.alert(message.join("<br/>"),"Info","info");
					}
				 }
			}

			// 기획전  삭제
			function exhbtListDelDisp() {
				var rowids = $("#promotionExhbtList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#promotionExhbtList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.promotion.select.exhibition' />","Info","info");
				}
			}

			function promotionGoodsLayer(paramPromotionGoodsList) {
				var options = {
					multiselect : true
					, callBack : function(newGoods) {
						if(newGoods != null) {
							var promotionGoods = $('#' + paramPromotionGoodsList).getDataIDs();
							var message = new Array();

							// 현재 프로모션의 적용사이트 추출
							var promotionStIdArray = [];
							/*
							$("input:checkbox[name='stId']:checked").each(function () {
								promotionStIdArray.push($(this).val());
							});
							*/
							promotionStIdArray.push($(':radio[name="stId"]:checked').val());

							for(var ng in newGoods){
								var check = true;

								// 새로 추가할 상품의 사이트 아이디 추출
								var newGoodsStIdArray = newGoods[ng].stIds.split("|");

								// 새로 추가할 상품의 사이트 아이디가 현재 프로모션의 적용사이트에 속하는지 확인
								for (var si in newGoodsStIdArray) {
									if (jQuery.inArray(newGoodsStIdArray[si], promotionStIdArray) < 0) {
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

								// 새로 추가할 상품이 현재 프로모션적용상품과 겹치는지 확인
								for(var cg in promotionGoods) {
									if(newGoods[ng].goodsId == promotionGoods[cg]) {
										check = false;
										message.push(newGoods[ng].goodsNm + " 중복된 상품입니다.^^");
									}
								}

								if(check) {
 									$('#'+paramPromotionGoodsList).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
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

			// 업체 검색
			function fnCompanyAddPop () {
				var options = {
					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var idx = $('#promotionTargetCompNoList').getDataIDs();
							var message = new Array();
							for(var i in result){
								var addData = {
										    compNo             : result[i].compNo
										  , ceoNm              : result[i].ceoNm
										  , compGbCd           : result[i].compGbCd
										  , compNm             : result[i].compNm
										  , bizNo              : result[i].bizNo
										  , compStatCd         : result[i].compStatCd
										  , compTpCd           : result[i].compTpCd
										  , fax                : result[i].fax
										  , tel                : result[i].tel
										  , sysRegDtm          : result[i].sysRegDtm
										  , sysRegrNm          : result[i].sysRegrNm
										  , sysUpdDtm          : result[i].sysUpdDtm
										  , sysUpdrNm          : result[i].sysUpdrNm
								}

								var check = true;
								for(var j in idx) {
									if(addData.compNo == idx[j]) {
										check = false;
									}
								}

								if(check) {
									$("#promotionTargetCompNoList").jqGrid('addRowData', result[i].compNo, addData, 'last', null);
								} else {
									message.push(result[i].compNm + " 중복된 업체 입니다.");
								}
							}
							if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"),"Info","info");
							}
						}
					}
 				}
				layerCompanyList.create (options );
			}

			// 업체 삭제
			function fnCompanyDel() {
				var rowids = $("#promotionTargetCompNoList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#promotionTargetCompNoList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.sale.select.target' />","Info","info");
				}
			}

			// 브랜드 검색
			function fnBrandAddPop () {
				var options = {
					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var idx = $('#promotionTargetBndNoList').getDataIDs();
							var message = new Array();
							for(var i in result){
								var addData = {
										    bndNmEn          : result[i].bndNmEn
										  , bndNmKo          : result[i].bndNmKo
										  , bndNo            : result[i].bndNo
										  , compNm           : result[i].compNm
										  , sortSeq          : result[i].sortSeq
										  , sysRegDtm        : result[i].sysRegDtm
										  , sysRegrNm        : result[i].sysRegrNm
										  , useYn            : result[i].useYn

								}

								var check = true;
								for(var j in idx) {
									if(addData.bndNo == idx[j]) {
										check = false;
									}
								}

								if(check) {
									$("#promotionTargetBndNoList").jqGrid('addRowData', result[i].bndNo, addData, 'last', null);
								} else {
									message.push(result[i].bndNmKo + " 중복된 브랜드 입니다.");
								}
							}
							if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"),"Info","info");
							}
						}
					}
 				}
				layerBrandList.create (options );
			}

			// 브랜드 삭제
			function fnBrandDel() {
				var rowids = $("#promotionTargetBndNoList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#promotionTargetBndNoList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.sale.select.target' />","Info","info");
				}
			}

			//제외상품 엑셀팝업 콜백
			function fnGoodsExListExcelUploadPopCallBack(newGoods) {
					var paramPromotionGoodsList = "promotionGoodsExList";

					if(newGoods != null) {
						var promotionGoods = $('#' + paramPromotionGoodsList).getDataIDs();
						var message = new Array();

						// 현재 프로모션의 적용사이트 추출
						var promotionStIdArray = [];
						/*
						$("input:checkbox[name='stId']:checked").each(function () {
							promotionStIdArray.push($(this).val());
						});
						*/
						promotionStIdArray.push($(':radio[name="stId"]:checked').val());

						for(var ng in newGoods){
							var check = true;

							// 새로 추가할 상품의 사이트 아이디 추출
							var newGoodsStIdArray = newGoods[ng].stIds.split("|");

							// 새로 추가할 상품의 사이트 아이디가 현재 프로모션의 적용사이트에 속하는지 확인
							for (var si in newGoodsStIdArray) {
								if (jQuery.inArray(newGoodsStIdArray[si], promotionStIdArray) < 0) {
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

							// 새로 추가할 상품이 현재 프로모션적용상품과 겹치는지 확인
							for(var cg in promotionGoods) {
								if(newGoods[ng].goodsId == promotionGoods[cg]) {
									check = false;
									message.push(newGoods[ng].goodsNm + " 중복된 상품입니다.^^");
								}
							}

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
												$('#'+paramPromotionGoodsList).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
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

			//제외상품 엑셀업로드
			function promotioGoodsExListExcelUploadLayer() {
				layerGoodsExListExcelUpload.create();
			}

			function checkPromotionList() {
				var prmtStatCd = $("#prmtStatCd option:selected").val();
 				if (prmtStatCd == "${adminConstants.PRMT_STAT_20}") {
					var prmtTgCd = $(":input:radio[name=prmtTgCd]:checked").val();

					if (prmtTgCd == "${adminConstants.PRMT_TG_20}" && grid.jsonData ("promotionGoodsList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.sale.history.good' />","Info","info");
						return false;
					} else if (prmtTgCd == "${adminConstants.PRMT_TG_30}" && getDispClsfNoList() == null) {
						messager.alert("<spring:message code='admin.web.view.msg.sale.history.displaycategory' />","Info","info");
						return false;
					} else if (prmtTgCd == "${adminConstants.PRMT_TG_40}" && grid.jsonData ("promotionExhbtList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.sale.history.exhibition' />","Info","info");
						return false;
					} else if (prmtTgCd == "${adminConstants.PRMT_TG_50}" && grid.jsonData ("promotionTargetCompNoList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.sale.history.company' />","Info","info");						
						return false;
					} else if (prmtTgCd == "${adminConstants.PRMT_TG_60}" && grid.jsonData ("promotionTargetBndNoList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.sale.history.brand' />","Info","info");
						return false;
					}
 				}

				return true;
			}

            function updatePromotion() {
                if(validate.check("promotionForm")) {

                	if (!checkPromotionList()) {
    					return;
    				}

                	messager.confirm('<spring:message code="column.common.confirm.update" />',function(r){
                		if(r){
                			var data = $("#promotionForm").serializeJson();
                            var arrGoodsId = null;
                            var arrGoodsExId = null;
                            var arrDispClsfNo = null;
                            var arrExhbtNo = null;
                            var arrCompNo = null;
                            var arrBndNo = null;
                            var goodsIdx = $('#promotionGoodsList').getDataIDs();
                            if(goodsIdx != null && goodsIdx.length > 0) {
                                arrGoodsId = goodsIdx.join(",");
                            }

                            var goodsExIdx = $('#promotionGoodsExList').getDataIDs();
                            if(goodsExIdx != null && goodsExIdx.length > 0) {
                                arrGoodsExId = goodsExIdx.join(",");
                            }
                            var compNo  = $('#promotionTargetCompNoList').getDataIDs();
                            if(compNo != null && compNo.length > 0) {
                                arrCompNo  = compNo.join(","); 
                            }
                           
                            var bndNo  = $('#promotionTargetBndNoList').getDataIDs();
                            if(bndNo != null && bndNo.length > 0) {
                                arrBndNo  = bndNo.join(",");
                            }

                            var exhbtNo  = $('#promotionExhbtList').getDataIDs();
                            if(exhbtNo != null && exhbtNo.length > 0) {
                                arrExhbtNo  = exhbtNo.join(",");
                            }

                            /*
                            var dispClsfNo  = $('#promotionDispList').getDataIDs();
                            if(dispClsfNo != null && dispClsfNo.length > 0) {
                                arrDispClsfNo  = dispClsfNo.join(",");
                            }
                            */
                            arrDispClsfNo = getDispClsfNoList();

                            $.extend(data, { arrDispClsfNo : arrDispClsfNo }
                                         , { arrGoodsId : arrGoodsId }
                                         , { arrGoodsExId : arrGoodsExId }
                                         , { arrCompNo     : arrCompNo     }
                                         , { arrBndNo      : arrBndNo      }
                                         , { arrExhbtNo    : arrExhbtNo    }
                            );

                            var options = {
                                url : "<spring:url value='/promotion/promotionUpdate.do' />"
                                , data : data
                                , callBack : function(result){
                                	updateTab();
                                }
                            };

                            ajax.call(options);				
                		}
                	});
                }
            }

            function getDispClsfNoList() {            
	            // 카테고리/기획전 트리를 화면에 표시하지 않은 상태에서 업데이트 요청 시 에러발생 방지하려고 null 체크 추가 함.
	            if($("#displayTree").length > 0) {
	            	var arrDispClsfNo = null;
	                var displayTreeId = $("#displayTree").jstree().get_selected();
	                var dispClsfNoList = new Array();
	                for(var i in displayTreeId) {
	                    var node = $("#displayTree").jstree().get_node(displayTreeId[i]);
	                    if(node.children == null || node.children.length == 0){
	                        dispClsfNoList.push(node.id);
	                    }
	                }
	
	                if(dispClsfNoList != null && dispClsfNoList.length > 0) {
	                    arrDispClsfNo = dispClsfNoList.join(",");
	                }
	            }
	            
	            return arrDispClsfNo;
            }

            function deletePromotion() {
            	messager.confirm('<spring:message code="column.common.confirm.delete" />',function(r){
            		if(r){
            			var options = {
                                url : "<spring:url value='/promotion/promotionDelete.do' />"
                                , data :  {
                                    prmtNo : '${promotionBase.prmtNo}'
                                }
                                , callBack : function(result){
                                	closeGoTab('할인 목록', '/promotion/promotionListView.do');
                                }
                            };

                            ajax.call(options);				
            		}
            	});
            }
            
            function showPrmoCategory() {
				$('#displayView').show();
			}
			
			function hidePrmoCategory() {
				$('#displayView').hide();
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle">
			<h2>가격할인 프로모션 기본 정보</h2>
			<c:if test="${adminConstants.PRMT_TG_30 eq promotionBase.prmtTgCd}">
			<div class="buttonArea">
				<button type="button" onclick="showPrmoCategory();" class="btn btn-add">프로모션 적용 전시 카테고리</button>
			</div>
			</c:if>
		</div>
		<form name="promotionForm" id="promotionForm" method="post">
		<table class="table_type1">
			<caption>할인 프로모션 상세</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.prmt_nm"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 명-->
						<input type="hidden" name="prmtNo" value="${promotionBase.prmtNo}" />
						<input type="text" class="w300 validate[required]" ${promotionBase.editable ? '' : 'readonly="readonly"'} name="prmtNm" id="prmtNm" title="<spring:message code="column.cp_nm"/>" value="${promotionBase.prmtNm}" />
						(${promotionBase.prmtNo})
					</td>
					<th><spring:message code="column.prmt_stat_cd"/></th>
					<td>
						<!-- 프로모션 상태 코드-->
						<select name="prmtStatCd" id="prmtStatCd" title="<spring:message code="column.prmt_stat_cd"/>" ${empty promotionBase.prmtStatCd ? 'disabled="disabled"' : ''}>
							<frame:select grpCd="${adminConstants.PRMT_STAT}" selectKey="${promotionBase.prmtStatCd}" />
						</select>
<c:if test="${adminConstants.PRMT_STAT_10 ne promotionBase.prmtStatCd}">
						<strong class="blue">* 프로모션 기본정보, 적용 대상 정보는 변경할 수 없습니다.</strong>
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
					<!-- 사이트 정보는 수정할 수 없음 -->
						<frame:stIdRadio selectKey="${promotionBase.stStdList}" selectKeyOnly="true" required="true"/>
					</td>
						<th><spring:message code="column.prmt_tg_cd"/><strong class="red">*</strong></th>
						<td>
							<!-- 프로모션 대상 코드-->
<c:if test="${promotionBase.editable}">
							<frame:radio name="prmtTgCd" grpCd="${adminConstants.PRMT_TG}"  selectKey="${promotionBase.prmtTgCd}" required="true" />
</c:if>
<c:if test="${! promotionBase.editable}">
							<frame:radio name="prmtTgCd" grpCd="${adminConstants.PRMT_TG}"  selectKey="${promotionBase.prmtTgCd}" selectKeyOnly="true" required="true" />
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.prmt_view.date"/><strong class="red">*</strong></th>
					<td>
<c:if test="${promotionBase.editable}">
						<frame:datepicker startDate="aplStrtDtm"
										  startValue="${empty promotionBase.aplStrtDtm ? frame:toDate('yyyy-MM-dd') : frame:getFormatDate(promotionBase.aplStrtDtm, 'yyyy-MM-dd')}"
										  endDate="aplEndDtm"
										  endValue="${empty promotionBase.aplEndDtm ? frame:addMonth('yyyy-MM-dd', 1) : frame:getFormatDate(promotionBase.aplEndDtm, 'yyyy-MM-dd')}"
										  required="Y"
										  />
</c:if>	
<c:if test="${!promotionBase.editable }">
						<frame:datepicker startDate="aplStrtDtm"
										  startValue="${empty promotionBase.aplStrtDtm ? frame:toDate('yyyy-MM-dd') : frame:getFormatDate(promotionBase.aplStrtDtm, 'yyyy-MM-dd')}"
										  endDate="aplEndDtm"
										  endValue="${empty promotionBase.aplEndDtm ? frame:addMonth('yyyy-MM-dd', 1) : frame:getFormatDate(promotionBase.aplEndDtm, 'yyyy-MM-dd')}"
										  readonly="Y"
										  />
</c:if>	
					</td>
					<th><spring:message code="column.prmt_apl_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 적용 코드-->
<c:if test="${promotionBase.editable}">
						<frame:radio name="prmtAplCd" grpCd="${adminConstants.PRMT_APL}" selectKey="${promotionBase.prmtAplCd}" required="true" />
</c:if>
<c:if test="${! promotionBase.editable}">
						<frame:radio name="prmtAplCd" grpCd="${adminConstants.PRMT_APL}" selectKey="${promotionBase.prmtAplCd}" selectKeyOnly="true" required="true" />
</c:if>
					</td>
				</tr>
				<tr>
					<th>프로모션 비용<strong class="red">*</strong></th>
					<td colspan="3">
						<table class="table_sub" style="width:450px">
							<caption>가격할인 프로모션 비용</caption>
							<colgroup>
								<col style="width:150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.spl_comp_dvd_rate"/><strong class="red">*</strong></th>
									<td>
										<!-- 공급 업체 분담 율-->
										<input type="text" class="validate[required,custom[number]]" name="splCompDvdRate" id="splCompDvdRate" maxlength="4" title="<spring:message code="column.spl_comp_dvd_rate"/>" value="${promotionBase.splCompDvdRate}" ${promotionBase.editable ? '' : 'readonly="readonly"'}/>
										<span id="splCompDvdRateUnit"> %</span>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.apl_val"/><strong class="red">*</strong></th>
									<td>
										<!-- 적용 값-->
										<input type="text" class="comma validate[required,custom[number]${promotionBase.prmtAplCd ne adminConstants.PRMT_APL_20 ? ',max[100]' : ''}]" ${promotionBase.prmtAplCd ne adminConstants.PRMT_APL_20 ? 'maxlength="3"' : ''} name="aplVal" id="aplVal" title="<spring:message code="column.apl_val"/>" value="${promotionBase.aplVal}" ${promotionBase.editable ? '' : 'readonly="readonly"'}/>
										<span id="spanCpAplCd10"> %</span>
									</td>
								</tr>
								<tr style="display:none;">
									<th><spring:message code="column.rvs_mrg_pmt"/></th>
									<td>
										<!--  역마진 허용 여부  -->
<c:if test="${promotionBase.editable}">
										<frame:radio name="rvsMrgPmtYn" grpCd="${adminConstants.COMM_YN}" selectKey="${promotionBase.rvsMrgPmtYn}" required="true"/>
</c:if>
<c:if test="${! promotionBase.editable}">
										<frame:radio name="rvsMrgPmtYn" grpCd="${adminConstants.COMM_YN}" selectKey="${promotionBase.rvsMrgPmtYn}" selectKeyOnly="true" required="true"/>
</c:if>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		
<c:if test="${adminConstants.PRMT_TG_30 eq promotionBase.prmtTgCd}">
		<div id="displayView" style="display:none;">
			<div class="window-mask" style="display:block;z-index:9003;position:fixed;"></div>
			<div class="layer-display">
				<div class="mTitle">
					<h2>프로모션 적용 전시카테고리<strong class="red">*</strong></h2>
					<div class="buttonArea">
						<button type="button" onclick="hidePrmoCategory();" class="btn btn-cancel">닫기</button>
					</div>
				</div>
				<div class="tree-menu">
					<div style="height: 530px;" class="gridTree" id="displayTree"></div>
				</div>
			</div>
		</div>
</c:if>	
	
		<div id="displayView40"    ${( adminConstants.PRMT_TG_40 eq promotionBase.prmtTgCd) ? '' : 'style="display: none;"'} >
			<div class="mTitle mt30">
				<h2>프로모션 적용 기획전<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<button type="button" onclick='${promotionBase.editable ? 'exhbtListAddPop();' : ''}' class="btn btn-add">추가</button>
					<button type="button" onclick='${promotionBase.editable ? 'exhbtListDelDisp();' : ''}' class="btn btn-add">삭제</button>
				</div>
			</div>
			<div class="mModule no_m">
				<table id="promotionExhbtList" ></table>
			</div>
		</div>

		<div id="displayView50" ${adminConstants.PRMT_TG_50 eq promotionBase.prmtTgCd   ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>
					프로모션 적용 업체<strong class="red">*</strong>
				</h2>
				<div class="buttonArea">
					<button type="button" class="btn btn-add" onclick=${promotionBase.editable ? 'fnCompanyAddPop();'  : ''} >추가</button>
					<button type="button" class="btn btn-add" onclick=${promotionBase.editable ? 'fnCompanyDel();' : ''} >삭제</button>
				</div>
			</div>

			<div class="mModule no_m">
				<table id="promotionTargetCompNoList" ></table>
			</div>
		</div>
		
		<div id="displayView60" ${adminConstants.PRMT_TG_60 eq promotionBase.prmtTgCd   ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>
					프로모션 적용 브랜드<strong class="red">*</strong>
				</h2>
				<div class="buttonArea">
					<button type="button" class="btn btn-add" onclick=${promotionBase.editable ? 'fnBrandAddPop();'  : ''} >추가</button>
					<button type="button" class="btn btn-add" onclick=${promotionBase.editable ? 'fnBrandDel();' : ''} >삭제</button>
				</div>
			</div>

			<div class="mModule no_m">
				<table id="promotionTargetBndNoList" ></table>
			</div>
		</div>


		<div id="goodsView" ${adminConstants.PRMT_TG_20 eq promotionBase.prmtTgCd ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>프로모션 적용 상품<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<button type="button" onclick='${promotionBase.editable ? 'promotionGoodsLayer("promotionGoodsList");' : ''}' class="btn btn-add">추가</button>
					<button type="button" onclick='${promotionBase.editable ? 'promotionGoodsDelete("promotionGoodsList");' : ''}' class="btn btn-add">삭제</button>
				</div>
			</div>

			<div class="mModule no_m">
				<table id="promotionGoodsList" ></table>
			</div>
		</div>

		<div id="goodsExView" ${adminConstants.PRMT_TG_30 eq promotionBase.prmtTgCd
                             or adminConstants.PRMT_TG_40 eq promotionBase.prmtTgCd
                             or adminConstants.PRMT_TG_50 eq promotionBase.prmtTgCd
		                     or adminConstants.PRMT_TG_60 eq promotionBase.prmtTgCd ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>프로모션 적용 제외 상품</h2>
				<div class="buttonArea">
					<button type="button" onclick='${promotionBase.editable ? 'promotioGoodsExListExcelUploadLayer();' : ''}' class="btn btn-add">엑셀 일괄추가</button>
					<button type="button" onclick='${promotionBase.editable ? 'promotionGoodsLayer("promotionGoodsExList");' : ''}' class="btn btn-add">추가</button>
					<button type="button" onclick='${promotionBase.editable ? 'promotionGoodsDelete("promotionGoodsExList");' : ''}' class="btn btn-add">삭제</button>
				</div>
			</div>

			<div class="mModule no_m">
				<table id="promotionGoodsExList" ></table>
			</div>
		</div>

		<div class="btn_area_center">
			<button type="button" onclick="updatePromotion();" class="btn btn-ok">수정</button>
<c:if test="${adminConstants.PRMT_STAT_10 eq promotionBase.prmtStatCd}">
            <button type="button" onclick="deletePromotion();" class="btn btn-add">삭제</button>
</c:if>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>