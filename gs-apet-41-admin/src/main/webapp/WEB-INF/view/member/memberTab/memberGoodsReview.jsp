<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnCreateMemberGoodsReviewList(){
                var searchParam = {
                        estmMbrNo : "${so.mbrNo}"
                    ,   maskingUnlock : "${so.maskingUnlock}"
                    ,   stId : "${so.stId}"
                };
                var options = {
                        url : "<spring:url value='/member/listGoodsCommentView.do' />"
                    ,   height : "${so.mbrNo}" != '' ? 330 : ''
                    ,	rowNum : 5
					, 	rowList : [5]
                    ,   searchParam : searchParam
                    ,   colModels : [
                        {name:"goodsEstmNo", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_no' /></tt></u></b>", width:"80", sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
                        , {name:"rowNum", label:'<b><u><tt><spring:message code="column.no" /></tt></u></b>', width:"60", align:"center", formatter:'integer', classes:'pointer fontbold'}
                        , {name:"imgRegYn", hidden:true, label:"<spring:message code='column.img_reg_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } } /* 이미지 여부 */
                        , {name:"goodsEstmTp", hidden:true, label:"<b><u><tt><spring:message code='column.goods_estm_tp' /></tt></u></b>", width:"80", key: false, sortable:false, align:"center", classes:'pointer fontbold'} /* 상품 평가 번호 */
                        , {name:"goodsEstmTpNm", label:"<spring:message code='column.goods_estm_tp_nm' />", width:"100", align:"center", sortable:false} /* 후기 유형 */
                        , {name:"estmScore", label:"<spring:message code='column.goods_estm_score' />", width:"100", align:"center", sortable:false, formatter:gridFormat.numEstmCoreFormat} /* 평점 */
                        , {name:'goodsId', label:'<spring:message code="column.goods_id" />', width:'120', align:'center', sortable:false}		// 상품 ID
                        , _GRID_COLUMNS.goodsNm		// 상품명
                        , {name:"content", label:"<b><u><tt><spring:message code='column.content' /></tt></u></b>", width:"500", align:"left", sortable:false, classes:'pointer fontbold', formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            } } /* 내용 */
                        , {name:"estmId", label:"<spring:message code='column.login_id' />", width:"120", align:"center", sortable:false } /* 로그인 ID */
                        , {name:"estmActnLke", label:"<spring:message code='column.estm_actn_lke' />", width:"120", align:"center", sortable:false } /* 도움(좋아요개수) */
                        , {name:"dispYn", label:"<spring:message code='column.goods.disp_yn' />", width:"120", align:"center", sortable:false, formatter:strDispNmFormat } /* 전시 */
                        , {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
                    ]
                	, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) {
							if(cellidx == 8){
								var rowData = $("#memberGoodsReViewList").getRowData(ids);
								fnGoodsCommentNormalPopup(rowData.goodsEstmNo, rowData.imgRegYn, rowData.goodsEstmTp);
							}
						}
					}
                    ,   paging : true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberGoodsReViewListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };

                grid.create("memberGoodsReViewList",options);
            }

            //후기 상세
           function fnGoodsCommentNormalPopup(goodsEstmNo, imgRegYn, goodsEstmTp) {
				var paramGoodsEstmNo = goodsEstmNo;
				var goodsBestYn = $("#bestYn").val();
				console.log("imgRegYn : " + imgRegYn + ", goodsBestYn : " + goodsBestYn);

				var buttonText = "<spring:message code='column.save' />";
				var detailPopTitle = "<spring:message code='column.goods.comment.detail' />";
				if(imgRegYn != "Y" && goodsEstmTp == "NOR") {
					detailPopTitle = "<spring:message code='column.simple' /> " + detailPopTitle;
				}
				// url 설정.
				var optionUrl = "/goods/goodsCommentNormalPopup.do";
				if(goodsEstmTp == "PLG"){
					detailPopTitle = "<spring:message code='column.pet_log' /> " + detailPopTitle;
					optionUrl = "/goods/goodsCommentPetLogPopup.do";
				}
				var options = {
					url : optionUrl
					, data : {goodsEstmNo : paramGoodsEstmNo, goodsEstmTp : goodsEstmTp, goodsBestYn : goodsBestYn}
					, dataType : "html"
					, callBack : function (result) {
						var config = {
							id : "goodsCommentDetailView"
							, width : 760
							, height : 1000
							, top : 200
							, scroll:'N'
							, title : detailPopTitle
							, button : "<button type=\"button\" onclick=\"updateMemberGoodsComment();\" class=\"btn btn-ok\">" + buttonText + "</button>"
							, body : result
						};
						layer.create(config);
					}
				};
				ajax.call(options);
			}

       	function updateMemberGoodsComment () {
    		var sendData = $("#goodsCommentForm").serializeJson();
    		
    		messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
    			if(r){
    				var options = {
    					url : "<spring:url value='/goods/goodsCommentDetailUpdate.do' />"
    					, data : sendData
    					, callBack : function(data ) {
    						messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info");
    						layer.close("goodsCommentDetailView");
    						fnReloadMemberGoodsReviewList();
    					}
    				};
    				ajax.call(options);
    			}
    		});
    	}
            
       	function fnReloadMemberGoodsReviewList(){
            var options = {
                    searchParam : {
                        estmMbrNo : "${so.mbrNo}"
                            ,   maskingUnlock : "${so.maskingUnlock}"
                            ,   stId : "${so.stId}"
                        }
             };
            grid.reload("memberGoodsReViewList", options);
       	}
            
            // 높이 설정
            function fnJqGridMaxHeight (v ) {
                return '<div style="max-height: 70px">' + v + '</div>';
            }

            // 전시
            function strDispNmFormat(cellvalue, options, rowObject){

                var dispNm = "<spring:message code='column.show_not' />";
                if(cellvalue == "Y"){
                    dispNm = "<spring:message code='column.show' />";
                }
                return dispNm;
            }

            $(function(){
                fnCreateMemberGoodsReviewList();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div clas="mModule mt30">
            <table id="memberGoodsReViewList"></table>
            <div id="memberGoodsReViewListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>
