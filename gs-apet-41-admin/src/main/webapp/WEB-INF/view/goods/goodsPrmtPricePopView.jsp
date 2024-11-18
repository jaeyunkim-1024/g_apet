<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function() {
	            createGoodsPromotionPriceGrid ();

	        });

		     // 상품 프로모션 적용 가격 Grid
	        function createGoodsPromotionPriceGrid () {
	            var gridOptions = {
	                url : "<spring:url value='/goods/goodsPrmtPricePopViewGrid.do' />"
	                , height : 130
	                , searchParam : {
	                    goodsId : '${goodsBase.goodsId}'
	                }
	                , colModels : [
	                	  _GRID_COLUMNS.goodsId
	                    , {name:"stNm", label:'<spring:message code="column.st_nm" />', width:"120", align:"center", sortable:false } /* 사이트 명 */
	                    //, {name:"webMobileGbPc", label:"PC", width:"50", align:"center", sortable:false } /* 업체명 */
	                    , {name:"webMobileGbPcPrc", label:"PC 판매가격", width:"110", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
	                    , {name:"webMobileGbPcPrmtPrc", label:"PC 프로모션 가격", width:"110", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        //, {name:"webMobileGbMo", label:"MOBILE", width:"50", align:"center", sortable:false } /* 업체명 */
                        , {name:"webMobileGbMoPrc", label:"MOBILE 판매가격", width:"120", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        , {name:"webMobileGbMoPrmtPrc", label:"MOBILE 프로모션 가격", width:"130", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */ 
                        , {name:"prmtSysRegrNm", label:"프로모션 <spring:message code='column.sys_regr_nm' />", width:"120", align:"center", sortable:false } /* 프로모션 등록자 이름 */
	                    ]
	                , multiselect : false
	            }
	            grid.create("goodsPrmtPriceList", gridOptions);
	        }

		</script>
	
		<table id="goodsPrmtPriceList" ></table>
		<div id="goodsPrmtPriceListPage"></div>
		