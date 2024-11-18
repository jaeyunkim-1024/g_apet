<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			var saleAmt = 	 ${goodsBase.saleAmt} ; 
			
			$(document).ready(function() {
				createCompCmsRateGrid ();

	        });

		     // 상품 수수료율 Grid
	        function createCompCmsRateGrid () {
	            var gridOptions = {
	                url : "<spring:url value='/goods/compCmsRatePopViewGrid.do' />"
	                , height : 120
	                , paging : false
					, cellEdit : false
	                , searchParam : {
	                	compNo : '${goodsBase.compNo}'
	                }
	                , colModels : [
	                	  {name:"stId", label:'<spring:message code="column.st_id" />', width:"120", align:"center", key: true , sortable:false  , hidden:true} /* 사이트 ID */
	                	, _GRID_COLUMNS.stNm
	                    , {name:"cmsRate", label:'<spring:message code="column.cms_rate" />', width:"120", align:"center" ,sorttype:"int",index:'id', sortable:false ,formatter:function(rowId, val, rawObject, cm) {return  addComma(rawObject.cmsRate)+"%";}   } /* 수수료율 */
	                    , {name:"splAmt", label:'<spring:message code="column.spl_prc" />', width:"120", align:"center" ,sorttype:"int",index:'id', sortable:false ,editable:false, formatter:function(rowId, val, rawObject, cm) {
	                    	var amt  = saleAmt - Math.floor((  saleAmt * rawObject.cmsRate / 100   ) / 10) * 10; 
	                    	amt  = addComma(amt);
	                    	return  amt+"원";
	                    	} 
	                    } /* 공급가 */
	                    ]
	            }
	            grid.create("compCmsRateList", gridOptions);
	        }
	        
		</script>

		<table id="compCmsRateList" ></table>
		
	