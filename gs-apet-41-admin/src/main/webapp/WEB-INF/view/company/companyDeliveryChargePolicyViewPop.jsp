<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
		$(document).ready(function() {

			$(".popContent input").attr("disabled","disabled"); 
			$(".popContent select").attr("disabled","disabled"); 
			$(".popContent radio").attr("disabled","disabled"); 
			$(".popContent button").attr("disabled","disabled"); 
			
			<c:if test="${not empty companyDelivery and companyDelivery.cfmYn eq adminConstants.COMM_YN_N  }">
				$("#btn1").removeAttr("disabled");
				$("#btn3").removeAttr("disabled");
			</c:if>
				$("#btn2").removeAttr("disabled");
		});
		

		//MD승인
		function updateCompanyChargePolicy() {
			// MD 승인전 이미 취소된 배송정책은 승인할 수 없음
			var deliveryChargePolicyDelYn = '${companyDelivery.delYn}';
			if (deliveryChargePolicyDelYn.toUpperCase() == 'Y') {
				messager.alert("<spring:message code='admin.web.view.msg.company.delivery.info.exist_delete' />", "Info", "info");
				return;
			} 
			
			if(validate.check("companyDeliveryViewForm")) {
				
				messager.confirm('<spring:message code="column.common.confirm.approve" />', function(r){
	                if (r){
	                	var data = $("#companyDeliveryViewForm").serializeJson();
						
						var options = {
							url : "<spring:url value='/company/updateCompanyDeliveryChargePolicy.do' />"
							, data : data
							, callBack : function(result){
								messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
									reloadCompanyGrid();
									layer.close('companyDeliveryChargePolicyView');
								});
							}
						};

						ajax.call(options);
	                }
				});
			}
		}
		
		// 승인전 배송 정책 삭제
        function deleteCompanyDelivery() {
        	messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
                if (r){
	            	var data = $("#companyDeliveryViewForm").serializeJson();
	               	
                   	var options = {
                    	url : "<spring:url value='/company/companyDeliveryDel.do' />"
                    	, data : data
                       	, callBack : function(result){
                       		reloadCompanyGrid();
                       		layer.close('companyDeliveryChargePolicyView');
                       	}
                  	};

                   	ajax.call(options);     
                }
        	});
        }		
		 

		function rlsaPost(result){
			$("#rlsaPostNoOld").val(result.postcode);
			$("#rlsaPrclAddr").val(result.jibunAddress);
			$("#rlsaPostNoNew").val(result.zonecode);
			$("#rlsaRoadAddr").val(result.roadAddress);
		}

		function rtnaPost(result){
			$("#rtnaPostNoOld").val(result.postcode);
			$("#rtnaPrclAddr").val(result.jibunAddress);
			$("#rtnaPostNoNew").val(result.zonecode);
			$("#rtnaRoadAddr").val(result.roadAddress);
		}

		$(document).on("click", "input[name=dlvrcStdCd]", function(e) {
			if('${adminConstants.DLVRC_STD_20}' == $(this).val()){
				$("input[name=dlvrcPayMtdCd]").prop("disabled", false);
				objClass.add($("input[name=dlvrcPayMtdCd]"), "validate[required]");
			} else {
				// 선/착불 여부
				$("input[name=dlvrcPayMtdCd]").prop("checked", false);
				$("input[name=dlvrcPayMtdCd]").prop("disabled", true);
				objClass.remove($("input[name=dlvrcPayMtdCd]"), "validate[required]");

				// 배송 조권
				$("input[name=dlvrcCdtStdCd]").prop("checked", false);
				$("input[name=dlvrcCdtStdCd]").prop("disabled", true);
				objClass.remove($("input[name=dlvrcCdtStdCd]"), "validate[required]");

				$("input[name=dlvrcCdtCd]").prop("checked", false);
				$("input[name=dlvrcCdtCd]").prop("disabled", true);
				objClass.remove($("input[name=dlvrcCdtCd]"), "validate[required]");

				$("input[name=dlvrAmt]").prop("readonly", true);
				objClass.remove($("input[name=dlvrAmt]"), "validate[required]");
				objClass.add($("input[name=dlvrAmt]"), "readonly");
				$("input[name=dlvrAmt]").val("");

				$("input[name=buyPrc]").prop("readonly", true);
				objClass.remove($("input[name=buyPrc]"), "validate[required]");
				objClass.add($("input[name=buyPrc]"), "readonly");
				$("input[name=buyPrc]").val("");

				$("input[name=buyQty]").prop("readonly", true);
				objClass.remove($("input[name=buyQty]"), "validate[required]");
				objClass.add($("input[name=buyQty]"), "readonly");
				$("input[name=buyQty]").val("");

				$("select[name=areaGbCd]").prop("disabled", true);
				objClass.remove($("input[name=areaGbCd]"), "validate[required]");
				$("select[name=areaGbCd]").val("");
			}
		});


		$(document).on("click", "input[name=dlvrcPayMtdCd]", function(e) {
			objClass.add($("input[name=dlvrcCdtStdCd]"), "validate[required]");
			if('${adminConstants.DLVRC_PAY_MTD_20}' == $(this).val()){
				$("input[name=dlvrcCdtStdCd]").prop("disabled", true);
				$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("disabled", false);
				$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("checked", true);
				dlvrcCdtStdCdView('${adminConstants.DLVRC_CDT_STD_50}');
			} else {
				$("input[name=dlvrcCdtStdCd]").prop("disabled", false);
				$("input[name=dlvrcCdtStdCd]").prop("checked", false);
				$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("disabled", true);
				dlvrcCdtStdCdView('');
			}

		});

		$(document).on("click", "input[name=dlvrcCdtStdCd]", function(e) {
			dlvrcCdtStdCdView($(this).val());
		});

		function dlvrcCdtStdCdView(dlvrcCdtStdCd) {
			$("input[name=buyPrc]").prop("readonly", true);
			objClass.remove($("input[name=buyPrc]"), "validate[required]");
			objClass.add($("input[name=buyPrc]"), "readonly");
			$("input[name=buyPrc]").val("");

			$("input[name=buyQty]").prop("readonly", true);
			objClass.remove($("input[name=buyQty]"), "validate[required]");
			objClass.add($("input[name=buyQty]"), "readonly");
			$("input[name=buyQty]").val("");

			$("select[name=areaGbCd]").prop("disabled", true);
			objClass.remove($("input[name=areaGbCd]"), "validate[required]");
			$("select[name=areaGbCd]").val("");

			if('${adminConstants.DLVRC_CDT_STD_50}' != dlvrcCdtStdCd){
				$("input[name=dlvrcCdtCd]").prop("disabled", false);
				objClass.add($("input[name=dlvrcCdtCd]"), "validate[required]");

				$("input[name=dlvrAmt]").prop("readonly", false);
				objClass.add($("input[name=dlvrAmt]"), "validate[required]");
				objClass.remove($("input[name=dlvrAmt]"), "readonly");

				if('${adminConstants.DLVRC_CDT_STD_20}' == dlvrcCdtStdCd) {
					$("input[name=buyPrc]").prop("readonly", false);
					objClass.add($("input[name=buyPrc]"), "validate[required]");
					objClass.remove($("input[name=buyPrc]"), "readonly");
				}
				if('${adminConstants.DLVRC_CDT_STD_30}' == dlvrcCdtStdCd) {
					$("input[name=buyQty]").prop("readonly", false);
					objClass.add($("input[name=buyQty]"), "validate[required]");
					objClass.remove($("input[name=buyQty]"), "readonly");
				}
			} else {
				$("input[name=dlvrcCdtCd]").prop("disabled", true);
				$("input[name=dlvrcCdtCd]").prop("checked", false);
				objClass.remove($("input[name=dlvrcCdtCd]"), "validate[required]");

				$("input[name=dlvrAmt]").prop("readonly", true);
				$("input[name=dlvrAmt]").val("");
				objClass.remove($("input[name=dlvrAmt]"), "validate[required]");
				objClass.add($("input[name=dlvrAmt]"), "readonly");
			}
		}
		
        // 업체 배송정책 - 도서산간 추가배송비 부과일 때
        $(document).on("change", "#compDlvrPsbAreaCd", function(e) {
            if($(this).val() == '${adminConstants.COMP_DLVR_PSB_AREA_30}'){
                $(".addDlvrAmtView").show();
                $("#dlvrcStdCd10").attr("disabled", true);
                $("#dlvrcStdCd10").prop("checked", false);
            } else {
                $("#addDlvrAmt").val(0);
                $(".addDlvrAmtView").hide();
                $("#dlvrcStdCd10").attr("disabled", false);
            }
        });
		</script>
		
		<form name="companyDeliveryViewForm" id="companyDeliveryViewForm">
			<input type="hidden" name="compNo" id="compNo" value="${company.compNo}">
			<input type="hidden" name="dlvrcPlcNo" id="dlvrcPlcNo" value="${company.dlvrcPlcNo}">
			<input type="hidden" name="viewDlvrPlcyDetail" id="viewDlvrPlcyDetail" value="${viewDlvrPlcyDetail}">
			<jsp:include page="/WEB-INF/view/company/companyDeliveryView.jsp" />
		</form>
		
		<c:if test="${not empty companyDelivery and companyDelivery.cfmYn eq adminConstants.COMM_YN_Y  }">
			<br />
			<table class="table_type1 border_top_none">
			<caption>업체 배송정책</caption>
			<colgroup>
				<col style="width:150px;" />
				<col />
				<col style="width:150px;" />
				<col />
				<col style="width:150px;" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="column.confirmYn"/><!-- 승인여부 --></th>
					<td>
						 ${companyDelivery.cfmYn} 
					</td>
					<th><spring:message code="column.confirm_user_no"/><!-- 승인자명 --></th>
					<td>
						 ${companyDelivery.cfmUsrNm} (${companyDelivery.cfmUsrNo} )
					</td>
					<th><spring:message code="column.confirm_dtm"/><!-- 승인일시 --></th>
					<td> 
						 ${companyDelivery.cfmPrcsDtm} 
					</td>
				</tr>
			</tbody>
			</table>	
		</c:if>

