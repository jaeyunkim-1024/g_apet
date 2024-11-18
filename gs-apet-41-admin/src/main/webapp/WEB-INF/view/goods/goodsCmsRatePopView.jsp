<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			var saleAmt = 	 ${goodsBase.saleAmt} ; 
			
			$(document).ready(function() {
				createGoodsCmsRateGrid ();

	        });

		     // 상품 수수료율 Grid
	        function createGoodsCmsRateGrid () {
	            var gridOptions = {
	                url : "<spring:url value='/goods/goodsCmsRatePopViewGrid.do' />"
	                , height : 120
	                , paging : false
					, cellEdit : true
	                , searchParam : {
	                    goodsId : '${goodsBase.goodsId}'
	                }
	                , colModels : [
	                	  _GRID_COLUMNS.goodsId
	                    , {name:"stId", label:'<spring:message code="column.st_id" />', width:"120", align:"center", key: true , sortable:false  , hidden:true} /* 사이트 ID */
	                    , _GRID_COLUMNS.stNm
	                    , {name:"cmsRate", label:'<spring:message code="column.cms_rate" />(***.**%)', width:"150", align:"center" ,sorttype:"int",index:'id', sortable:false ,formatter:'int',editable:${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd} } /* 수수료율 */
	                    //TODO splAmt = saleAmt - (saleAmt * cmsRate);
	                    , {name:"splAmtWon", label:'<spring:message code="column.spl_prc" />', width:"120", align:"center" ,sorttype:"int",index:'id', sortable:false ,editable:false, formatter:function(rowId, val, rawObject, cm) {
	                    	var amt  = saleAmt - Math.floor(saleAmt * rawObject.cmsRate / 100 / 10) * 10; 
	                    	amt  = addComma(amt);
	                    	return  amt+"원";
	                    	} 
	                    } /* 공급가 */
	                    , {name:"saleAmt", label:'saleAmt', width:"120", align:"center" , hidden:true,sorttype:"int",index:'id', sortable:false ,editable:false, formatter:function(rowId, val, rawObject, cm) {
	                    	return  saleAmt;
	                    	} 
	                    }
	                    ]
	                , multiselect : true
	            }
	            grid.create("goodsCmsRateList", gridOptions);
	        }
	        function updateCmsRate() {
	        	var goodsCmsRateList = grid.jsonData ("goodsCmsRateList" );
	        	sendData = {
	        			stGoodsMapPO : JSON.stringify(goodsCmsRateList )
					}
	        	messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/updateStGoodsMap.do' />"
							, data : sendData
							, callBack : function (data ) {
								 
								if (data.rtn=="S"){
									messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
										var gridOptions = {searchParam : {goodsId : '${goodsBase.goodsId}' } };
										grid.reload("goodsCmsRateList",gridOptions);
									});
								}else{
									messager.alert("<spring:message code='column.common.try.again_msg' />", "Info", "info");
									
								}
								
							}
						};
						ajax.call(options);
					}
	        	});
	        }
		</script>

		<table id="goodsCmsRateList" ></table>
    
		


