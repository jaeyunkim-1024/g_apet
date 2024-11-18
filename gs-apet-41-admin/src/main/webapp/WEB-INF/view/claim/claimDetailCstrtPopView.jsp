<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		createClaimDetailCstrtGrid();
	});
	
	function createClaimDetailCstrtGrid(){
		var options = {
			url : "<spring:url value='/claim/listClmDtlCstrt.do' />"
			, colModels : [
	            // 클레임 구성 순번
	            {name:"clmCstrtSeq", label:'NO', width:"80", align:"center", sortable:false}
                // 상품 번호
                , {name:"cstrtGoodsId", label:'<spring:message code="column.goods_id" />', width:"120", align:"center", sortable:false}
            	 // 구성 상품 명
                , {name:"goodsNm", label:'<spring:message code="column.claim_common.cstrt_goods_nm" />', width:"300", align:"center", sortable:false}
            	 // 구성 상품 구분
                , {name:"showCstrtGbCd", label:'<spring:message code="column.claim_common.cstrt_goods_gb" />', width:"120", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CSTRT_GOODS_GB}" />"}}
             	// 구성수량
			 	, {name:"cstrtQty", label:'<spring:message code="column.claim_common.cstrt_qty" />', width:"80", align:"center", formatter:'integer'}
	 		]
			, paging : false
			, height : 250
			, searchParam : {
				clmNo : '${claimDetail.clmNo}'
				,clmDtlSeq : '${claimDetail.clmDtlSeq}'
			}
		};

		grid.create( "layerCstrtList", options) ;
	}
</script>
	

<table class="table_type1 popup">
	<caption>클레임 상세 내역</caption>
	<tbody>
		<tr>
			<th scope="row"><spring:message code="column.goods_id" /></th>
			<td>
				${claimDetail.goodsId}
			</td>
			<th scope="row"><spring:message code="column.goods_nm" /></th>
			<td>
				${claimDetail.goodsNm}
			</td>
		</tr>

		<tr>
			<th scope="row"><spring:message code="column.clm_dtl_seq" /></th>
			<td>
				${claimDetail.clmDtlSeq}
			</td>
			<th scope="row"><spring:message code="column.goods.cstrt.tp.cd" /></th>
			<td>
				<frame:codeName grpCd="${adminConstants.GOODS_CSTRT_TP}" dtlCd="${claimDetail.goodsCstrtTpCd}"/>
			</td>
		</tr>
	</tbody>
</table>

<div class="mModule">
	<table id="layerCstrtList"></table>
</div>

