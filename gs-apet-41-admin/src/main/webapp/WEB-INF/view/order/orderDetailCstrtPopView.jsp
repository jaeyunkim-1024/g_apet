<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		createOrderDetailCstrtGrid();
	});
	
	function createOrderDetailCstrtGrid(){
		var options = {
			url : "<spring:url value='/order/orderDetailCstrtListGrid.do' />"
			, colModels : [
	            // 주문 구성 순번
	            {name:"ordCstrtSeq", label:'NO', width:"80", align:"center", sortable:false}
                // 상품 번호
                , {name:"cstrtGoodsId", label:'<spring:message code="column.goods_id" />', width:"120", align:"center", sortable:false}
            	 // 구성 상품 명
                , {name:"goodsNm", label:'<spring:message code="column.order_common.cstrt_goods_nm" />', width:"300", align:"center", sortable:false}
            	 // 구성 상품 구분
                , {name:"showCstrtGbCd", label:'<spring:message code="column.order_common.cstrt_goods_gb" />', width:"120", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CSTRT_GOODS_GB}" />"}}
             	// 구성수량
			 	, {name:"cstrtQty", label:'<spring:message code="column.order_common.cstrt_qty" />', width:"80", align:"center", formatter:'integer'}
	 		]
			, paging : false
			, height : 250
			, searchParam : {
				ordNo : '${orderDetail.ordNo}'
				,ordDtlSeq : '${orderDetail.ordDtlSeq}'
			}
		};

		grid.create( "layerCstrtList", options) ;
	}
</script>
	

<table class="table_type1 popup">
	<caption>주문 상세 내역</caption>
	<tbody>
		<tr>
			<th scope="row"><spring:message code="column.goods_id" /></th>
			<td>
				${orderDetail.goodsId}
			</td>
			<th scope="row"><spring:message code="column.goods_nm" /></th>
			<td>
				${orderDetail.goodsNm}
			</td>
		</tr>

		<tr>
			<th scope="row"><spring:message code="column.ord_dtl_seq" /></th>
			<td>
				${orderDetail.ordDtlSeq}
			</td>
			<th scope="row"><spring:message code="column.goods.cstrt.tp.cd" /></th>
			<td>
				<frame:codeName grpCd="${adminConstants.GOODS_CSTRT_TP}" dtlCd="${orderDetail.goodsCstrtTpCd}"/>
			</td>
		</tr>
	</tbody>
</table>

<div class="mModule">
	<table id="layerCstrtList"></table>
</div>

