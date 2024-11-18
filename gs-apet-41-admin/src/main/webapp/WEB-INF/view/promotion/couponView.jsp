<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

			$(document).ready(function(){
				$("#aplStrtDtm").data("origin",$("#aplStrtDtm").val());
				$("#aplEndDtm").data("origin",$("#aplEndDtm").val());

				EditorCommon.setSEditor('notice', '${adminConstants.COUPON_IMAGE_PATH}');

				$("#vldPrdStrtDtm ,#aplStrtDtm").change(function(){
					var id = this.id;
					var check = true;
					var aplEndDtm = $("#aplEndDtm").val().replace(/-/gi, "");
					var aplStrtDtm = $("#aplStrtDtm").val().replace(/-/gi, "");

					if(aplEndDtm == "") {
						$('#aplEndDtm').focus();
						check = false;
					}
					if(aplStrtDtm == ""){
						$('#aplStrtDtm').focus();
						check = false;
					}

					if(aplStrtDtm != "" && aplEndDtm != ""){
						if(parseInt(aplStrtDtm) > parseInt(aplEndDtm)){
							messager.alert("종료일이 시작일보다 크게 선택해 주세요. ", "Info", "info", function(){
								$('#aplStrtDtm').val($('#aplStrtDtm').data("origin"));
								$('#aplEndDtm').val($('#aplEndDtm').data("origin"));
							});
							check = false;
						}

						if($("#vldPrdStrtDtm").length > 0){
							var vldPrdStrtDtm = $("#vldPrdStrtDtm").val().replace(/-/gi, "");
							if(parseInt(aplStrtDtm) > parseInt(vldPrdStrtDtm)){
								messager.alert("유효기간의 시작일이 쿠폰기간의 시작일 이전으로 등록이 불가능합니다. ", "Info", "info", function(){
									$('#'+id).val($('#'+id).data("origin"));
								});
								check = false;
							}
						}
					}

					if(check){
						$("#vldPrdStrtDtm").data("origin",$("#vldPrdStrtDtm").val());
						compareDate("vldPrdStrtDtm", "vldPrdEndDtm");
					}
				});
				
				$("#vldPrdEndDtm ,#aplEndDtm").change(function(){
					var id = this.id;
					var check = true;
					var aplEndDtm = $("#aplEndDtm").val().replace(/-/gi, "");
					var aplStrtDtm = $("#aplStrtDtm").val().replace(/-/gi, "");

					if(aplEndDtm == "") {
						$('#aplEndDtm').focus();
						check = false;
					}
					if(aplStrtDtm == ""){
						$('#aplStrtDtm').focus();
						check = false;
					}


					if(aplStrtDtm != "" && aplEndDtm != ""){
						if(parseInt(aplStrtDtm) > parseInt(aplEndDtm)){
							messager.alert("종료일이 시작일보다 크게 선택해 주세요. ", "Info", "info", function(){
								$('#aplStrtDtm').val($('#aplStrtDtm').data("origin"));
								$('#aplEndDtm').val($('#aplEndDtm').data("origin"));
							});
							check = false;
						}

						if($("#vldPrdEndDtm").length > 0){
							var vldPrdEndDtm = $("#vldPrdEndDtm").val().replace(/-/gi, "");
							if(parseInt(aplEndDtm) > parseInt(vldPrdEndDtm)){
								messager.alert("유효기간의 종료일이 쿠폰기간의 종료일 이전으로 등록이 불가능합니다. ", "Info", "info", function(){
									console.log($('#'+id).data("origin"));
									$('#'+id).val($('#'+id).data("origin"));
								});
								check = false;
							}
						}
					}

					if(check){
						$("#vldPrdEndDtm").data("origin",$("#vldPrdEndDtm").val());
						compareDate2("vldPrdStrtDtm", "vldPrdEndDtm");
					}
				});
				
<c:if test="${not empty couponBase.cpNo}"> 			
	<c:choose>
		<c:when test="${couponBase.editable}">
					// 쿠폰 적용 상품
					createCouponGoodsGrid();
					// 사이트아이디 초기화
					fnStIdComboSpanHtml();
					// 쿠폰 적용 전시카테고리
					//createCouponDispGrid ();
					createDisplayTree();
					fnDispClsfCdComboSpanHtml('30');
					// 쿠폰 적용 기획전
					createCouponExhbtGrid();
					// 쿠폰대상업체
					couponTargetCompNoListGrid();
					// 쿠폰대상브랜드
					couponTargetBndNoListGrid();
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${adminConstants.CP_TG_20 eq couponBase.cpTgCd}">
						// 쿠폰 적용 상품
						createCouponGoodsGrid();
				</c:when>
				<c:when test="${adminConstants.CP_TG_30 eq couponBase.cpTgCd}">
						// 사이트아이디 초기화
						fnStIdComboSpanHtml();
						// 쿠폰 적용 전시 카테고리
						createDisplayTree();
						//createCouponDispGrid();
				</c:when>
				<c:when test="${adminConstants.CP_TG_40 eq couponBase.cpTgCd}">
						// 쿠폰 적용 기획전
						createCouponExhbtGrid();
				</c:when>
				<c:when test="${adminConstants.CP_TG_50 eq couponBase.cpTgCd}">
						// 쿠폰 적용 업체
						couponTargetCompNoListGrid();
				</c:when>
				<c:when test="${adminConstants.CP_TG_60 eq couponBase.cpTgCd}">
						// 쿠폰 적용 브랜드
						couponTargetBndNoListGrid();
				</c:when>
			</c:choose>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${couponBase.cpPvdMthCd eq adminConstants.CP_PVD_MTH_20}">
			//수동 쿠폰 발급 리스트
			createCouponIssueGrid();
		</c:when>
	<c:otherwise>
			//쿠폰 발급 리스트
			createCouponMemberGrid();
	</c:otherwise>
	</c:choose>
	
	//수정시 회원등급코드 '전체' 체크 해제
	$("#arrMbrGrdCd_default").prop("checked", false);
	
</c:if>
				// 쿠폰 제외상품 그리드
				createCouponGoodsExGrid();
				
				// 유효기간 설정
				changeVldPrdCd("${couponBase.vldPrdCd}");

				// 쿠폰 종류별
				<c:if test="${empty couponBase.cpNo}">
                	$("#cpKindCd${adminConstants.CP_KIND_20}").prop("checked", true);
				</c:if>
				$("input[name=cpKindCd]:checked").trigger('change');
				$("input[name=vldPrdCd]:checked").trigger('change');
				
				// 쿠폰 지급방식 설정
				changeCpPvdMthCd("${couponBase.cpPvdMthCd}");
                
                // 전시카테고리면 화면 크기 줄이기
                if (${adminConstants.CP_TG_30 eq couponBase.cpTgCd}) {
                    $("#couponView").attr("style", 'width: 79%');
                }
                
                $("input[name=outsideCpYn]:checked").trigger('change');
                
              	//결함처리
				$.each($(".comma"), function(){
					$(this).val(addComma($(this).val()));
				});
              	
				<c:if test="${empty couponBase.cpNo}">
					$("input[name=msgSndYn]").prop("checked", false);
					$("input[name=exprItdcYn]").prop("checked", false);
				</c:if>
                
			});
			
			// 발급  회원 등급 전체 컨트롤
			$(function(){
				$("input:checkbox[name=arrMbrGrdCd]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrMbrGrdCd"]:checked').length == 0 ) {
						$('input:checkbox[name="arrMbrGrdCd"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrMbrGrdCd"]').each( function() {
							if ( all ) {
								if ( validation.isNull( $(this).val() ) ) {
									$(this).prop("checked", true);
								} else {
									$(this).prop("checked", false);
								}
							} else {
								if ( validation.isNull($(this).val() ) ) {
									$(this).prop("checked", false);
								}
							}
						});
					}
				});

			});

			// 쿠폰 상태 변경
			$(document).on("change", "#cpStatCd", function() {

				var currentCouponState = "${couponBase.cpStatCd}";
				var newCouponState = $(this).val();

				if (newCouponState < currentCouponState) {
					if (newCouponState == '${adminConstants.CP_STAT_20}' && currentCouponState == '${adminConstants.CP_STAT_30}') {
						// 중단 --> 진행 으로 변경은 허용함.
						messager.alert("<spring:message code="admin.web.view.app.coupon.manage.detail.alert.cp_state_restart" />","Info","info");
					} else {
						// 이전 단계로 변경은 허용하지 않음.
						messager.alert('<spring:message code="admin.web.view.app.coupon.manage.detail.alert.cp_state_invalid" />',"Info","info",function(){
							$("#cpStatCd").val(currentCouponState);
						});
					}
				}
			});

            function hideCouponTargetView() {
                $("#goodsView").hide();
                $("#goodsExView").hide();

                //$("#displayView30").hide();
                $("#displayView").hide();
                $("#displayView40").hide();
                $("#displayView50").hide();
                $("#displayView60").hide();
                $("#showCpnCategoryBtn").hide();
                $("#couponView").attr("style", 'width: 100%');
            }

            $(document).on("change", "input[name=cpTgCd]", function(e){
            	if (${couponBase.editable}) {
	                var cpKindCd = $(":input:radio[name=cpKindCd]:checked").val();

	                if (cpKindCd == '${adminConstants.CP_KIND_20}' || cpKindCd == '${adminConstants.CP_KIND_30}') {
	                    return false;
	                } else {
	                	changeCpTgCd($(this).val());
	                }
            	} else {
            		return false;
            	}
            });

            // 쿠폰 대상 변경
            function changeCpTgCd(cpTgCd) {
                var data = $("#couponForm").serializeJson();
                
				<c:if test="${not empty couponBase.cpNo}">
                hideCouponTargetView();

                if(cpTgCd == '${adminConstants.CP_TG_20}') {
                    $("#goodsView").show();
                    grid.resize();
                } else if(cpTgCd == '${adminConstants.CP_TG_30}') {
                    $("#goodsExView").show();
                    grid.resize();

                    //createCouponDispGrid ();
                    //$("#displayView30").show();
                    createDisplayTree();
                    $("#displayView").show();
                    $("#showCpnCategoryBtn").show();
                    grid.resize();

                    $("#couponView").attr("style", 'width: 79%');

                } else if(cpTgCd == '${adminConstants.CP_TG_40}') {
                    $("#goodsExView").show();
                    grid.resize();

                    $("#displayView40").show();
                    grid.resize();

                    $("#couponView").attr("style", 'width: 100%');
                }else if(cpTgCd == '${adminConstants.CP_TG_50}') {
                    $("#goodsExView").show();
                    grid.resize();

                    couponTargetCompNoListGrid();
                    $("#displayView50").show();
                    grid.resize();

                    $("#displayView50").attr("style", 'width: 100%');
                }else if(cpTgCd == '${adminConstants.CP_TG_60}') {
                    $("#goodsExView").show();
                    grid.resize();
                    // 쿠폰대상브랜드
                    couponTargetBndNoListGrid();
                    $("#displayView60").show();
                    grid.resize();

                    $("#displayView60").attr("style", 'width: 100%');
                }
                </c:if>
            }

            // 전시카테고리 등록용 사이트 아이디 셀렉트박스
            function fnStIdComboSpanHtml() {
                var data = $("#couponForm").serializeJson();
                var selected = "selected=\'selected\'";
                var stIdComboSpanHtml = "";
                stIdComboSpanHtml += "<select id='stIdCombo' name='stIdCombo'>";
<c:if test="${couponBase.stStdList.size() > 1}">
                stIdComboSpanHtml += "<option value=''>선택하세요</option>";
                selected = "";
</c:if>

<c:forEach items="${couponBase.stStdList}" var="stInfo" >
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

            //쿠폰대상에 따른 콤보박스 변화
            function fnDispClsfCdComboSpanHtml(dos) {

                var dispClsfCdComboSpanHtml = "";
                dispClsfCdComboSpanHtml += "<select id='dispClsfCdCombo' name='dispClsfCdCombo' disabled=\'disabled\' >";
                dispClsfCdComboSpanHtml += "<option value='${adminConstants.DISP_CLSF_10 }'>전시카테고리</option>";
                dispClsfCdComboSpanHtml += "</select>";

                $("#dispClsfCdComboSpan").html(dispClsfCdComboSpanHtml);
            }

            $(document).on("click", "input[name=cpAplCd]", function(e){
            	if (${couponBase.editable}) {
                    var cpKindCd = $("input:radio[name=cpKindCd]:checked").val();

                    if (cpKindCd == '${adminConstants.CP_KIND_30}') {
                        return false;
                    }

                    changeCpAplCd();
            	} else {
            		return false;
            	}
            });

            // 쿠폰 적용 변경
            function changeCpAplCd(){
                var cpAplCd = $("input:radio[name=cpAplCd]:checked").val();

                if(cpAplCd == '${adminConstants.CP_APL_10}') {
                    $("#spanCpAplCd10").text('%');
                    $(".maxDcAmtView").show();
                    $("#aplVal").attr("maxlength", 3);
                    objClass.add($("#aplVal"), "validate[max[100]]");
                    
                    if($("input[name=cpKindCd]:checked").val() == '${adminConstants.CP_KIND_10}'){
                    	$("input:radio[name=multiAplYn][value=Y]").prop("checked", true);
                    	
                    	$("#minBuyAmt").prop("readonly", true);
                    	$("#minBuyAmt").val("");
                		objClass.add($("#minBuyAmt"), "readonly");
                		objClass.remove($("#minBuyAmt"), "validate[required]");
                    }else{
                    	$("input:radio[name=multiAplYn][value=N]").prop("checked", true);
                    }
                    $("input[name=multiAplYn]").prop("disabled", true);
                } else {
                    $("#spanCpAplCd10").text('원');
                    $(".maxDcAmtView").hide();
                    $("#maxDcAmt").val("");
                    $("#aplVal").attr("maxlength", 8);
                    objClass.remove($("#aplVal"), "validate[max[100]]");
                    
                    if($("input[name=cpKindCd]:checked").val() == '${adminConstants.CP_KIND_10}'){
                    	$("input:radio[name=multiAplYn]").filter(function(){
                    		return $(this).val() == "${empty couponBase.cpNo ? 'N' : couponBase.multiAplYn}";
                    	}).prop("checked", true);
                    	$("input[name=multiAplYn]").prop("disabled", false);
                    	$("#minBuyAmt").prop("readonly", false);
                		objClass.remove($("#minBuyAmt"), "readonly");
                		objClass.add($("#minBuyAmt"), "validate[required]");
                    }else{
                    	$("input:radio[name=multiAplYn][value=N]").prop("checked", true);
                    	$("input[name=multiAplYn]").prop("disabled", true);
                    }
                    
                }
            }

            $(document).on("change", "input[name=cpKindCd]", function(e){
            	changeCpKindCd($(this).val());
            });

            // 쿠폰 종류 변경 - 장바구니 쿠폰이 아니면 최소구매금액 0으로 고정, 공급업체 분담율은 0으로 고정, 쿠폰 대상은 전체
            function changeCpKindCd(cpKindCd) {
            	 $("#splCompDvdRate").val("${couponBase.splCompDvdRate}");
                 $("#aplVal").val("${couponBase.aplVal}");
                 $("#minBuyAmt").val("${couponBase.minBuyAmt}");
                 $("#maxDcAmt").val("${couponBase.maxDcAmt}");
                 $("#cpKindCd30Info").hide();
                 
            	if(cpKindCd == '${adminConstants.CP_KIND_10}'){
            		showCpTgCd20to60();
    				<c:if test="${empty couponBase.cpNo}">
                    $("#cpTgCd${adminConstants.CP_TG_20}").prop("checked", true);
    				</c:if>

                    showCpAplCd20();
                    
            		$("#splCompDvdRate").prop("readonly", false);
            		objClass.remove($("#splCompDvdRate"), "readonly");
            		objClass.add($("#splCompDvdRate"), "validate[required]");
            		
            		$("#aplVal").prop("readonly", false);
            		objClass.remove($("#aplVal"), "readonly");
            		objClass.add($("#aplVal"), "validate[required]");
            		
            		var cpAplCd = $("input:radio[name=cpAplCd]:checked").val();

            		$("#minBuyAmt").prop("readonly", false);
            		objClass.remove($("#minBuyAmt"), "readonly");
            		objClass.add($("#minBuyAmt"), "validate[required]");
            		
            		$("#maxDcAmt").prop("readonly", false);
            		objClass.remove($("#maxDcAmt"), "readonly");
            		objClass.add($("#maxDcAmt"), "validate[required]");
            		
            	}else if(cpKindCd == '${adminConstants.CP_KIND_20}'){
            		$("#splCompDvdRate").prop("readonly", true);
            		objClass.add($("#splCompDvdRate"), "readonly");
            		objClass.remove($("#splCompDvdRate"), "validate[required]");
            		$("#splCompDvdRate").val("");
            		
            		$("#aplVal").prop("readonly", false);
            		objClass.remove($("#aplVal"), "readonly");
            		objClass.add($("#aplVal"), "validate[required]");
            		
            		$("#minBuyAmt").prop("readonly", false);
            		objClass.remove($("#minBuyAmt"), "readonly");
            		objClass.add($("#minBuyAmt"), "validate[required]");
            		
            		$("#maxDcAmt").prop("readonly", false);
            		objClass.remove($("#maxDcAmt"), "readonly");
            		objClass.add($("#maxDcAmt"), "validate[required]");
            		
            		hideCpTgCd20to60();
                    $("input[name='cpTgCd']").removeAttr("checked");
                    $("input[name='cpTgCd']:radio[value='${adminConstants.CP_TG_10}']").prop("checked", true);
                    showCpAplCd20();
                    changeCpTgCd('${adminConstants.CP_TG_10}');
            	}else if(cpKindCd == '${adminConstants.CP_KIND_30}'){
                    // 쿠폰적용 정률 고정
                    hideCpAplCd20();
                    $("#splCompDvdRate").prop("readonly", true);
            		objClass.add($("#splCompDvdRate"), "readonly");
            		objClass.remove($("#splCompDvdRate"), "validate[required]");
            		$("#splCompDvdRate").val("");
            		
            		$("#minBuyAmt").prop("readonly", false);
            		objClass.remove($("#minBuyAmt"), "readonly");
            		objClass.add($("#minBuyAmt"), "validate[required]");
            		
            		$("#maxDcAmt").prop("readonly", true);
            		objClass.add($("#maxDcAmt"), "readonly");
            		objClass.remove($("#maxDcAmt"), "validate[required]");
            		$("#maxDcAmt").val("");
            		
            		
            		$("#aplVal").prop("readonly", true);
            		objClass.add($("#aplVal"), "readonly");
            		objClass.remove($("#aplVal"), "validate[required]");
            		$("#aplVal").val('100');
                    $("#cpAplCd${adminConstants.CP_APL_10}").prop("checked", true);
                    
                    hideCpTgCd20to60();
                    $("input[name='cpTgCd']").removeAttr("checked");
                    $("input[name='cpTgCd']:radio[value='${adminConstants.CP_TG_10}']").prop("checked", true);
                    changeCpTgCd('${adminConstants.CP_TG_10}');
                    
                    $("#cpKindCd30Info").show();
            	}
            	changeCpAplCd();
            	
            	if (${!couponBase.editable}) {
            		$("#splCompDvdRate").prop("readonly", true);
            		objClass.add($("#splCompDvdRate"), "readonly");
            		objClass.remove($("#splCompDvdRate"), "validate[required]");
            		$("#minBuyAmt").prop("readonly", true);
            		objClass.add($("#minBuyAmt"), "readonly");
            		objClass.remove($("#minBuyAmt"), "validate[required]");
            		$("#maxDcAmt").prop("readonly", true);
            		objClass.add($("#maxDcAmt"), "readonly");
            		objClass.remove($("#maxDcAmt"), "validate[required]");
            		$("#aplVal").prop("readonly", true);
            		objClass.add($("#aplVal"), "readonly");
            		objClass.remove($("#aplVal"), "validate[required]");
            	}
            	
            	//공급업체 분담율 100으로 고정
            	$("#splCompDvdRate").val("100");
            }

            function hideCpAplCd20() {
                $("#cpAplCd${adminConstants.CP_APL_20}").hide();
                $("#span_cpAplCd${adminConstants.CP_APL_20}").hide();
            }

            function showCpAplCd20() {
                $("#cpAplCd${adminConstants.CP_APL_20}").show();
                $("#span_cpAplCd${adminConstants.CP_APL_20}").show();
            }

            function hideCpTgCd20to60() {
                $("#cpTgCd${adminConstants.CP_TG_20}").hide();
                $("#span_cpTgCd${adminConstants.CP_TG_20}").hide();
                $("#cpTgCd${adminConstants.CP_TG_30}").hide();
                $("#span_cpTgCd${adminConstants.CP_TG_30}").hide();
                $("#cpTgCd${adminConstants.CP_TG_40}").hide();
                $("#span_cpTgCd${adminConstants.CP_TG_40}").hide();
                $("#cpTgCd${adminConstants.CP_TG_50}").hide();
                $("#span_cpTgCd${adminConstants.CP_TG_50}").hide();
                $("#cpTgCd${adminConstants.CP_TG_60}").hide();
                $("#span_cpTgCd${adminConstants.CP_TG_60}").hide();
            }
            
            function showCpTgCd20to60() {
                $("#cpTgCd${adminConstants.CP_TG_20}").show();
                $("#span_cpTgCd${adminConstants.CP_TG_20}").show();
                $("#cpTgCd${adminConstants.CP_TG_30}").show();
                $("#span_cpTgCd${adminConstants.CP_TG_30}").show();
                $("#cpTgCd${adminConstants.CP_TG_40}").show();
                $("#span_cpTgCd${adminConstants.CP_TG_40}").show();
                $("#cpTgCd${adminConstants.CP_TG_50}").show();
                $("#span_cpTgCd${adminConstants.CP_TG_50}").show();
                $("#cpTgCd${adminConstants.CP_TG_60}").show();
                $("#span_cpTgCd${adminConstants.CP_TG_60}").show();
                
                $("input[name='cpTgCd']").removeAttr("style");
            }

            $(document).on("change", "input[name=vldPrdCd]", function(e){
                changeVldPrdCd($(this).val());
            });

            // 쿠폰 유효 기간
            function changeVldPrdCd(vldPrdCd) {
                if(vldPrdCd == '${adminConstants.VLD_PRD_10}') {
                	objClass.add($("#vldPrdDay"), "validate[required,custom[number]]");
                    objClass.remove($("#vldPrdDay"), "readonly");
                    if (${couponBase.editable}) {
                    	$("#vldPrdDay").prop("readonly", false);
                    } else {
                    	$("#vldPrdDay").prop("readonly", true);
                    	objClass.add($("#vldPrdDay"), "readonly");
                    }
                    $("#vldPrdStrtDtm").datepicker("destroy");
                    $("#vldPrdEndDtm").datepicker("destroy");
                    $("#vldPrdDay").val('${couponBase.vldPrdDay}');
                    $("#vldPrdStrtDtm").val("");
                    $("#vldPrdEndDtm").val("");
                    objClass.add($("#vldPrdStrtDtm"), "readonly");
                    objClass.add($("#vldPrdStrtDtm").parent(), "readonly");
                    objClass.remove($("#vldPrdStrtDtm"), "datepicker");
                    objClass.remove($("#vldPrdStrtDtm"), "validate[required,custom[date]]");
                    $("#vldPrdStrtDtm").prop("readonly", true);
                    objClass.add($("#vldPrdEndDtm"), "readonly");
                    objClass.add($("#vldPrdEndDtm").parent(), "readonly");
                    objClass.remove($("#vldPrdEndDtm"), "datepicker");
                    objClass.remove($("#vldPrdEndDtm"), "validate[required,custom[date],future[#vldPrdStrtDtm]]");
                    $("#vldPrdEndDtm").prop("readonly", true);
                } else {
                	var vldPrdStrtDtm = "${empty couponBase.vldPrdStrtDtm ? frame:toDate('yyyy-MM-dd') : frame:getFormatDate(couponBase.vldPrdStrtDtm, 'yyyy-MM-dd')}";
                    var vldPrdEndDtm = "${empty couponBase.vldPrdEndDtm ? frame:addMonth('yyyy-MM-dd', 2) : frame:getFormatDate(couponBase.vldPrdEndDtm, 'yyyy-MM-dd')}";
                    
                    $("#vldPrdDay").val("");
                    $("#vldPrdStrtDtm").val(vldPrdStrtDtm);
                    $("#vldPrdEndDtm").val(vldPrdEndDtm);
                    <c:if test="${empty couponBase.vldPrdStrtDtm}">
						$("#vldPrdStrtDtm").val($("#aplStrtDtm").val());
					</c:if>
                    <c:if test="${empty couponBase.vldPrdEndDtm}">
						$("#vldPrdEndDtm").val($("#aplEndDtm").val());
					</c:if>

					$("#vldPrdStrtDtm").data("origin",vldPrdStrtDtm);
					$("#vldPrdEndDtm").data("origin",vldPrdEndDtm);

					objClass.add($("#vldPrdDay"), "readonly");
                    objClass.remove($("#vldPrdDay"), "validate[required,custom[number]]");
                    $("#vldPrdDay").prop("readonly", true);
                    
                    if (${couponBase.editable}) {
                        objClass.add($("#vldPrdStrtDtm"), "datepicker validate[required,custom[date]]");
                        objClass.remove($("#vldPrdStrtDtm"), "readonly");
                        objClass.remove($("#vldPrdStrtDtm").parent(), "readonly");
                        objClass.add($("#vldPrdEndDtm"), "datepicker validate[required,custom[date],future[#vldPrdStrtDtm]]");
                        objClass.remove($("#vldPrdEndDtm"), "readonly");
                        objClass.remove($("#vldPrdEndDtm").parent(), "readonly");
                    }else{
                    	objClass.add($("#vldPrdEndDtm"), "readonly");
                    	objClass.add($("#vldPrdEndDtm").parent(), "readonly");
                    }
                    $("#vldPrdStrtDtm").prop("readonly", true);
                    $("#vldPrdEndDtm").prop("readonly", true);
                    
                    common.datepicker();
                }
            }

            $(document).on("change", "input[name=cpPvdMthCd]", function(e){
            	changeCpPvdMthCd($(this).val());
            });

            // 쿠폰 지급 방식
            // 쿠폰전시여부 수정가능하도록 수정 QA
            function changeCpPvdMthCd(cpPvdMthCd) {
            	if(cpPvdMthCd == '${adminConstants.CP_PVD_MTH_10}') {
            		$("#cpPvdMtdCd40Msg").hide();
                    $("input[name=cpIsuCd]").prop("disabled", false);
                    $("input[name=cpShowYn]").prop("disabled", false);

                    $("#cpCd").val("");
                    objClass.remove($("#cpCd"), "validate[required,custom[onlyKoAndNmAndEn]]");
                    objClass.add($("#cpCd"), "readonly");
                    $("#cpCd").prop("readonly", true);
                } else if(cpPvdMthCd == '${adminConstants.CP_PVD_MTH_20}') {
                	$("#cpPvdMtdCd40Msg").show();
                    $("input[name=cpIsuCd]").prop("disabled", true);
                    $("input[name=cpShowYn]").prop("disabled", false);
                    $("#cpIsuCd${adminConstants.CP_ISU_20}").prop("checked", true);
                    $("input[name=cpShowYn][value=N]").prop("checked", true);
                    //$("input[name=cpShowYn]").prop("disabled", true);

                    $("#cpCd").val("");
                    objClass.remove($("#cpCd"), "validate[required,custom[onlyKoAndNmAndEn]]");
                    objClass.add($("#cpCd"), "readonly");
                    $("#cpCd").prop("readonly", true);
                } else if(cpPvdMthCd == '${adminConstants.CP_PVD_MTH_30}') {
                	$("#cpPvdMtdCd40Msg").hide();
                    $("input[name=cpIsuCd]").prop("disabled", true);
                    $("input[name=cpShowYn]").prop("disabled", false);
                    $("#cpIsuCd${adminConstants.CP_ISU_10}").prop("checked", true);
                    $("input[name=cpShowYn][value=N]").prop("checked", true);
                    //$("input[name=cpShowYn]").prop("disabled", true);

                    $("#cpCd").val("");
                    objClass.remove($("#cpCd"), "validate[required,custom[onlyKoAndNmAndEn]]");
                    objClass.add($("#cpCd"), "readonly");
                    $("#cpCd").prop("readonly", true);
                }else if(cpPvdMthCd == '${adminConstants.CP_PVD_MTH_40}'){
                	$("#cpPvdMtdCd40Msg").hide();
                	$("input[name=cpIsuCd]").prop("disabled", true);
                    $("input[name=cpShowYn]").prop("disabled", false);
                	$("#cpIsuCd${adminConstants.CP_ISU_10}").prop("checked", true);
                	 $("input[name=cpShowYn][value=N]").prop("checked", true);
                     //$("input[name=cpShowYn]").prop("disabled", true);

                     $("#cpCd").val("");
                     objClass.remove($("#cpCd"), "validate[required,custom[onlyKoAndNmAndEn]]");
                     objClass.add($("#cpCd"), "readonly");
                     $("#cpCd").prop("readonly", true);
                }else if(cpPvdMthCd == '${adminConstants.CP_PVD_MTH_50}'){
                	$("#cpPvdMtdCd40Msg").hide();
                    $("input[name=cpIsuCd]").prop("disabled", false);
                    $("input[name=cpShowYn]").prop("disabled", true);
                    $("input[name=cpShowYn][value=N]").prop("checked", true);
                     
                    $("#cpCd").val("${couponBase.cpCd}");
                    objClass.remove($("#cpCd"), "readonly");
                    objClass.add($("#cpCd"), "validate[required,custom[onlyKoAndNmAndEn]]");
                    if (${couponBase.editable}) {
                        $("#cpCd").prop("readonly", false);
                    } else {
                        $("#cpCd").prop("readonly", true);
                        objClass.add($("#cpCd"), "readonly");
                    }
                }
            	
            	$("input[name=cpIsuCd]:checked").trigger('change');
            }

            $(document).on("change", "input[name=cpIsuCd]", function(e){
            	changeCpIsuCd($(this).val());
            });

            // 쿠폰 발급 변경
            function changeCpIsuCd(cpIsuCd) {
            	if(cpIsuCd == '${adminConstants.CP_ISU_10}') {
                    $("#cpIsuQty").val("");
                    objClass.remove($("#cpIsuQty"), "validate[required,custom[number]]");
                    objClass.add($("#cpIsuQty"), "readonly");
                    $("#cpIsuQty").prop("readonly", true);
                } else if(cpIsuCd == '${adminConstants.CP_ISU_20}'){
                    $("#cpIsuQty").val("${couponBase.cpIsuQty}");
                    objClass.remove($("#cpIsuQty"), "readonly");
                    objClass.add($("#cpIsuQty"), "validate[required,custom[number]]");
                    if (${couponBase.editable}) {
                        $("#cpIsuQty").prop("readonly", false);
                    } else {
                        $("#cpIsuQty").prop("readonly", true);
                        objClass.add($("#cpIsuQty"), "readonly");
                    }
                }
            }
			
            $(document).on("change", "input[name=outsideCpYn]", function(e){
                if($(this).val() == 'Y'){
                	$("#outsideCpCd").val('${couponBase.outsideCpCd}');
                	$("#outsideCpCd").show();
                }else{
                	$("#outsideCpCd").hide();
                }
            });
            
			function resultCouponImage(result) {
				$("#cpImgPathnm").val(result.filePath);
				$("#cpImgFlnm").val(result.fileName);
			}

			// 쿠폰적용 상품 목록
			function createCouponGoodsGrid(){
				var options = {
					url : "<spring:url value='/promotion/couponGoodsListGrid.do' />"
					, height : 150
					, multiselect : true
					, searchParam : {
						cpNo : '${couponBase.cpNo}'
					}
					, sortname : "A.SYS_REG_DTM" // 2021.05.17 -> 상품 번호 ( 영문숫자 조합으로 PK가 따지기에, 등록 일시로 정렬조건 변경)
					, sortorder : "DESC"
					, colModels : [
						{name:"cpNo", hidden:true }
                        , {name:"aplSeq", hidden:true }
                        , {name:"sysRegDtm",hidden:true,sortable:true}
                        , {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
                        , {name:"compGoodsId", label:"<spring:message code='column.comp_goods_id' />", width:"120", align:"center", sortable:false} /* 업체 상품 번호 */
                        , {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"240", align:"center", sortable:false } /* 브랜드명 */
                        , {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"330", align:"center", sortable:false } /* 상품명 */
                        , {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
                        , {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
                        , {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        , {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"140", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"140", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
                        , {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"240", align:"center", sortable:false } /* 업체명 */
                        , {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"100", align:"center", sortable:false } /* 모델명 */
                        , {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"100", align:"center", sortable:false } /* 제조사 */
                        , {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center", sortable:false} /* 사이트 명 */
                        , {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
					, paging : false
				};
				grid.create("couponGoodsList", options);
			}

            // 쿠폰적용 전시카테고리 - 그리드형태
            function createCouponDispGrid () {
                var options = {
                    url : "<spring:url value='/promotion/couponShowDispClsfGrid.do' />"
                    , searchParam : { cpNo      : '${couponBase.cpNo}' }
                    , paging : false
                    , cellEdit : true
                    , height : 150
                    , colModels : [
                        {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", key: true, sortable:false }
                        , {name:"dispCtgPath", label:'<spring:message code="column.disp_clsf_nm_path" />', width:"400", align:"center", sortable:false }
                        , {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"100", align:"center", sortable:false } /* 사이트 명 */
                        , {name:"cpNo", label:'', width:"0", align:"center", hidden: true, sortable:false }
                        , {name:"stId",   hidden: true} /* 사이트 ID */
                    ]
                    , multiselect : true
                };
                grid.create("couponDispList", options);
            }

            //  쿠폰적용 기획전
            function createCouponExhbtGrid () {
                var options = {
                    url : "<spring:url value='/promotion/couponTargetExhbtNoListGrid.do' />"
                    , searchParam : { cpNo      : '${couponBase.cpNo}'}
                    , paging : false
                    , cellEdit : true
                    , height : 150
                    , colModels : [
                        {name:"exhbtNo", label:'<spring:message code="column.exhbt_no" />', width:"80", align:"center", key: true, sortable:false }
                        , {name:"exhbtNm", label:'<spring:message code="column.exhbt_nm" />', width:"850", align:"center", sortable:false }
                        , {name:"cpNo", label:'', width:"0", align:"center", hidden: true, sortable:false }
                        //, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"120", align:"center", sortable:false } /* 사이트 명 */
                        , {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden: true} /* 사이트 ID */
                    ]
                    , multiselect : true
                };
                grid.create("couponExhbtList", options);
            }

            // 쿠폰적용 업체들
            function couponTargetCompNoListGrid () {
                var options = {
                    url : "<spring:url value='/promotion/couponTargetCompNoListGrid.do' />"
                    , searchParam : { cpNo      : '${couponBase.cpNo}' }
                    , paging : false
                    , height : 150
                    , colModels : [
                        {name:"cpNo", label:'쿠폰번호', width:"100", align:"center",  sortable:false , hidden:true}
                        , {name:"compNo", label:'<spring:message code="column.comp_no" />', width:"80", align:"center", key:true, formatter:'integer'}
                        , {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"240", align:"center"}
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
                grid.create("couponTargetCompNoList", options);
            }

            // 쿠폰적용 브랜드
            function couponTargetBndNoListGrid () {
                var options = {
                    url : "<spring:url value='/promotion/couponTargetBndNoListGrid.do' />"
                    , searchParam : { cpNo      : '${couponBase.cpNo}' }
					, sortname : "COL_ORD,BND_NM_KO" // 2021.05.17 -> 국문,영문,숫자 순의 오름차순 정렬 : 명확한 요건 없어 첫번째 글자로 비교
					, sortorder : "ASC"
                    , paging : false
                    , height : 150
                    , colModels : [
                          {name:"cpNo", label:'쿠폰번호', width:"100", align:"center", sortable:false, hidden:true}
                          , {name:"bndNo", label:"<spring:message code='column.bnd_no' />" , width:"80", key: true, align:"center" , hidden:true} /* 브랜드 번호 */
                          , {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />" , width:"260", align:"center", sortable:false } /* 브랜드 국문 */
                          , {name:"useYn", label:"<spring:message code='column.use_yn' />" , width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.USE_YN }' showValue='false' />" } } /* 사용여부 */
                          //, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />" , width:"120", align:"center", sortable:false } /* 업체명 */
                          , {name:"sysRegrNm", label:"<spring:message code='column.sys_regr_nm' />" , width:"100", align:"center", sortable:false}
                          , {name:"sysRegDtm", label:"<spring:message code='column.sys_reg_dtm' />" , width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
                          , {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center", sortable:false}
                          , {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                    ]
                    , multiselect : true
                };
                grid.create("couponTargetBndNoList", options);
            }

			// 쿠폰적용 제외 상품 목록
			function createCouponGoodsExGrid(){
				var options = {
					url : "<spring:url value='/promotion/couponGoodsExListGrid.do' />"
					, height : 150
					, multiselect : true
					, searchParam : {
						cpNo : '${couponBase.cpNo}'
					}
					, sortname : "A.SYS_REG_DTM" // 2021.05.17 -> 상품 번호 ( 영문숫자 조합으로 PK가 따지기에, 등록 일시로 정렬조건 변경)
					, sortorder : "DESC"
					, colModels : [
						{name:"cpNo", hidden:true }
						, {name:"aplSeq", hidden:true }
                        , {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
                        , {name:"compGoodsId", label:"<spring:message code='column.comp_goods_id' />", width:"120", align:"center", sortable:false} /* 업체 상품 번호 */
                        , {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"250", align:"center", sortable:false } /* 브랜드명 */
                        , {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"250", align:"center", sortable:false } /* 상품명 */
                        , {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
                        , {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
                        , {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        , {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"130", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
                        , {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
                        , {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"240", align:"center", sortable:false } /* 업체명 */
                        , {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"150", align:"center", sortable:false } /* 모델명 */
                        , {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"100", align:"center", sortable:false } /* 제조사 */
                        , {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"120", align:"center", sortable:false} /* 사이트 명 */
                        , {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
					, paging : false
				};
				grid.create("couponGoodsExList", options);
			}

			// 쿠폰발급 목록
			function createCouponMemberGrid(){

				var options = {
					url : "<spring:url value='/promotion/downloadCouponIssueListGrid.do' />"
					, height : 400
					, searchParam : {
						cpNo : '${couponBase.cpNo}'
						, prmtAplGbCd : '${adminConstants.PRMT_APL_GB_20}'
					}
					,	rowNum : [1000,5000,10000]
					, colModels : [
						//쿠폰 번호
						{name:"cpNo", label:'<spring:message code="column.cp_no" />', hidden:true}
						//발급 일시
						, {name:"sysRegDtm", label:'발급 일시', width:"200", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//회원 쿠폰 번호
						, {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"100", align:"center"}
						//회원 번호
						, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center"}
						//회원 명
						, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center"}
						//사용 여부
						, {name:"useYn", label:'<spring:message code="column.use_yn" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_YN}" />"}}
						//사용 일시
						, {name:"useDtm", label:'<spring:message code="column.use_dtm" />', width:"200", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//주문 번호
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"250", align:"center"}
					]
				
				// 쿠폰 발급 대기 대상 삭제를 위한 기능 추가 - 수동 방식인 경우만
				<c:if test="${couponBase.cpPvdMthCd eq adminConstants.CP_PVD_MTH_40}">
					, multiselect : true
					, gridComplete: function() {  /** 데이터 로딩시 함수 **/
						var ids = $('#couponIssueList').jqGrid('getDataIDs');
						
						for(var i=0 ; i < ids.length; i++){
							var ret =  $("#couponIssueList").getRowData(ids[i]); // 해당 id의 row 데이터를 가져옴
							if( !validation.isNull(ret.sysRegDtm) ) {
								$("#jqg_couponIssueList_"+ids[i]).prop("disabled", true); 		
							}
						}
					}
					, beforeSelectRow: function (rowid, e) {
						var rowData = $("#couponIssueList").getRowData(rowid);
						if( !validation.isNull(rowData.sysRegDtm) ) {
							return false;
						}
						return true;
					}
			        , onSelectAll: function(aRowids,status) {
						if (status) {
							var cbs = $("tr.jqgrow > td > input.cbox:disabled", $("#couponIssueList")[0]);
							cbs.removeAttr("checked");
						
							$("#couponIssueList")[0].p.selarrrow = $("#couponIssueList").find("tr.jqgrow:has(td > input.cbox:checked)").map(function() { return this.id; }).get();
						}							
			        }
				</c:if>
				};
				grid.create("couponIssueList", options);
			}
			 // 수동발행
			function createCouponIssueGrid(){
				var searchParam = {
						cpNo : '${couponBase.cpNo}'
					,	cpPvdMthCd  : "${couponBase.cpPvdMthCd}"
					,	cpIsuQty : "${couponBase.cpIsuQty}"
				};

				var options = {
					url : "<spring:url value='/promotion/couponIssueListGrid.do' />"
					, height : 400
					, searchParam : searchParam
					, colModels : [
						//쿠폰 번호
						{name:"cpNo", label:'<spring:message code="column.cp_no" />', hidden:true}
						//발급 일련 번호
						, {name:"isuSrlNo", label:'<spring:message code="column.isu_srl_no" />', width:"150", align:"center"}
						//회원 쿠폰 번호
						, {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"80", align:"center"}
						//회원 번호
						, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center"}
						//회원 명
						, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center"}
						//사용 여부
						, {name:"useYn", label:'<spring:message code="column.use_yn" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_YN}" />"}}
						//사용 일시
						, {name:"useDtm", label:'<spring:message code="column.use_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//주문 번호
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}
					]
				};
				grid.create("couponIssueList", options);
			}

            function couponGoodsLayer(paramCouponGoodsList) {
                var options = {
                    multiselect : true
                    , callBack : function(newGoods) {
                        if(newGoods != null && newGoods.length != 0) {
                            var couponGoods = $('#' + paramCouponGoodsList).getDataIDs();

                            var message = new Array();

                            // 현재 쿠폰의 적용사이트 추출
                            var couponStIdArray = [];
                            /*
                            $("input:checkbox[name='stId']:checked").each(function () {
                                couponStIdArray.push($(this).val());
                            });
                            */
                            couponStIdArray.push($(':radio[name="stId"]:checked').val());

                            for(var ng in newGoods){
                                var check = true;

                                // 새로 추가할 상품의 사이트 아이디 추출
                                var newGoodsStIdArray = newGoods[ng].stIds.split("|");

                                // 새로 추가할 상품의 사이트 아이디가 현재 쿠폰의 적용사이트에 속하는지 확인
                                for (var si in newGoodsStIdArray) {
                                    if (jQuery.inArray(newGoodsStIdArray[si], couponStIdArray) < 0) {
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

                                // 새로 추가할 상품이 현재 쿠폰적용상품과 겹치는지 확인
                                for(var cg in couponGoods) {
                                    if(newGoods[ng].goodsId == couponGoods[cg]) {
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
                                                    //$('#'+paramCouponGoodsList).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
                                                }
                                            }
                                        };

                                    ajax.call(optionsNest);

                                }
                            }

                            if(message != null && message.length > 0) {
                            	messager.alert(message.join("<br/>"),"Info","info");
                            }else{
                            	//재정렬 후 add
								var mergeList = $("#"+paramCouponGoodsList).getRowData().concat(newGoods);
								console.dir(mergeList);
								mergeList.sort(function(a,b){
									var sysRegDtm_1 = isNaN(new Date(a.sysRegDtm).getTime()) ? new Date(parseInt(a.sysRegDtm)).getTime() : new Date(a.sysRegDtm).getTime();
									var sysRegDtm_2 = isNaN(new Date(b.sysRegDtm).getTime()) ? new Date(parseInt(b.sysRegDtm)).getTime() : new Date(b.sysRegDtm).getTime();
									return sysRegDtm_2 - sysRegDtm_1;
								});
								$("#"+paramCouponGoodsList).clearGridData();
								for(var o in mergeList){
									$('#'+paramCouponGoodsList).jqGrid('addRowData', mergeList[o].goodsId, mergeList[o], 'last', null);
								}
							}
                        }
                    }
	                , goodsCstrtTpCds : ['${adminConstants.GOODS_CSTRT_TP_ITEM }', '${adminConstants.GOODS_CSTRT_TP_SET }']
                }
                layerGoodsList.create(options);
            }

            function couponGoodsDelete(paramCouponGoodsList) {
                var rowids = $("#" + paramCouponGoodsList).jqGrid('getGridParam', 'selarrrow');
                var delRow = new Array();
                if(rowids != null && rowids.length > 0) {
                    for(var i in rowids) {
                        delRow.push(rowids[i]);
                    }
                }
                if(delRow != null && delRow.length > 0) {
                    for(var i in delRow) {
                        $("#" + paramCouponGoodsList).delRowData(delRow[i]);
                    }
                } else {
                	messager.alert("<spring:message code='admin.web.view.msg.invalid.good' />","Info","info");                    
                }
            }
            
            // 전시카테고리 트리 생성
            function createDisplayTree() {
                $("#displayTree").jstree("destroy");
                $("#displayTree").jstree({//tree 생성
                    core : {
                        multiple : true
                        , data : {
                            type : "POST"
                            , url : function (node) {
                                return "/promotion/couponDisplayTree.do";
                            }
                            , data : function (node) {
                                var data = {
                                    cpNo : '${couponBase.cpNo}'
                                    , stId : $(':radio[name="stId"]:checked').val()
                                };
                                return data;
                            }
                        }
                    }
                    , plugins : [ "themes" , "checkbox" ]
                })
                .bind("ready.jstree", function (event, data) {
                    $("#displayTree").jstree("open_all");
                    
                    <c:if test = "${not empty couponBase and not couponBase.editable}">
                        $('#displayTree li.jstree-node').each(function() {
                            $('#displayTree').jstree("disable_node", this.id);
                        });
                    </c:if>
                });
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
					  , upDispYn : "Y"
                      , callBack : function(result) {


                        if(result != null && result.length > 0) {
                            var idx = $('#couponDispList').getDataIDs();
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
                                    $("#couponDispList").jqGrid('addRowData', result[i].dispNo, addData, 'last', null);
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
                var rowids = $("#couponDispList").jqGrid('getGridParam', 'selarrrow');
                var delRow = new Array();
                if(rowids != null && rowids.length > 0) {
                    for(var i in rowids) {
                        delRow.push(rowids[i]);
                    }
                }
                if(delRow != null && delRow.length > 0) {
                    for(var i in delRow) {
                        $("#couponDispList").delRowData(delRow[i]);
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
									, title : "기획전 조회"
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
				    var idx = $('#couponExhbtList').getDataIDs();
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
							$("#couponExhbtList").jqGrid('addRowData', result[i].exhbtNo, addData, 'last', null);
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
				var rowids = $("#couponExhbtList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#couponExhbtList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.promotion.select.exhibition' />","Info","info");
				}
			}

			// 업체 검색
			function fnCompanyAddPop () {
				var options = {
					  multiselect : true
					, compStatCd : '${adminConstants.COMP_STAT_20}'
					, readOnlyCompStatCd : 'Y'
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var idx = $('#couponTargetCompNoList').getDataIDs();
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
									$("#couponTargetCompNoList").jqGrid('addRowData', result[i].compNo, addData, 'last', null);
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
				var rowids = $("#couponTargetCompNoList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#couponTargetCompNoList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.coupon.select.company' />","Info","info");					
				}
			}

			// 브랜드 검색
			function fnBrandAddPop () {
				var options = {
					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var idx = $('#couponTargetBndNoList').getDataIDs();
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
									$("#couponTargetBndNoList").jqGrid('addRowData', result[i].bndNo, addData, 'last', null);
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
				var rowids = $("#couponTargetBndNoList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#couponTargetBndNoList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.invalid.brand' />","Info","info");
				}
			}

			//제외상품 엑셀팝업 콜백
			function fnGoodsExListExcelUploadPopCallBack(newGoods) {
				var paramCouponGoodsList = "couponGoodsExList";
				if(newGoods != null) {
					var couponGoods = $('#' + paramCouponGoodsList).getDataIDs();
					var message = new Array();

					// 현재 쿠폰의 적용사이트 추출
					var couponStIdArray = [];
					/*
					$("input:checkbox[name='stId']:checked").each(function () {
						couponStIdArray.push($(this).val());
					});
					*/
					couponStIdArray.push($(':radio[name="stId"]:checked').val());

					for(var ng in newGoods){
						var check = true;
						// 새로 추가할 상품의 사이트 아이디 추출
						var newGoodsStIdArray = newGoods[ng].stIds.split("|");
						// 새로 추가할 상품의 사이트 아이디가 현재 쿠폰의 적용사이트에 속하는지 확인
						for (var si in newGoodsStIdArray) {
							if (jQuery.inArray(newGoodsStIdArray[si], couponStIdArray) < 0) {
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

						// 새로 추가할 상품이 현재 쿠폰적용상품과 겹치는지 확인
						for(var cg in couponGoods) {
							if(newGoods[ng].goodsId == couponGoods[cg]) {
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
											//$('#'+paramCouponGoodsList).jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
										}
									}
								};

							ajax.call(optionsNest);
						}
					}

				    if(message != null && message.length > 0) {
				    	messager.alert(message.join("<br/>"),"Info","info");
				    }else{
						//재정렬 후 add
						var mergeList = $("#"+paramCouponGoodsList).getRowData().concat(newGoods);
						console.dir(mergeList);
						mergeList.sort(function(a,b){
							var sysRegDtm_1 = isNaN(new Date(a.sysRegDtm).getTime()) ? new Date(parseInt(a.sysRegDtm)).getTime() : new Date(a.sysRegDtm).getTime();
							var sysRegDtm_2 = isNaN(new Date(b.sysRegDtm).getTime()) ? new Date(parseInt(b.sysRegDtm)).getTime() : new Date(b.sysRegDtm).getTime();
							return sysRegDtm_2 - sysRegDtm_1;
						});
						$("#"+paramCouponGoodsList).clearGridData();
						for(var o in mergeList){
							$('#'+paramCouponGoodsList).jqGrid('addRowData', mergeList[o].goodsId, mergeList[o], 'last', null);
						}
					}
				}
			}

			//제외상품 엑셀업로드
			function couponGoodsExListExcelUploadLayer() {
				layerGoodsExListExcelUpload.create();
			}

            function saveCoupon() {
            	oEditors.getById["notice"].exec("UPDATE_CONTENTS_FIELD", []);
                if(validate.check("couponForm")) {
               		var aplEndDtm = $("#aplEndDtm").val().replace(/-/gi, "");
               		var aplStrtDtm = $("#aplStrtDtm").val().replace(/-/gi, "");

					if(aplEndDtm == "") {
						$('#aplEndDtm').focus();
						return false;
					}
					if(aplStrtDtm == ""){
						$('#aplStrtDtm').focus();
						return false;
					}

					if(aplStrtDtm != "" && aplEndDtm != ""){
						if(parseInt(aplStrtDtm) > parseInt(aplEndDtm)){
							messager.alert("종료일이 시작일보다 크게 선택해 주세요. ", "Info", "info", function(){
								$('#aplStrtDtm').val($('#aplStrtDtm').data("origin"));
								$('#aplEndDtm').val($('#aplEndDtm').data("origin"));
								$('#aplStrtDtm').focus();
							});
							return false;
						}
					}

               		//발급일일경우 처리
               		if($("#vldPrdEndDtm").length > 0){
					var vldPrdEndDtm = $("#vldPrdEndDtm").val().replace(/-/gi, "");
						if(parseInt(aplEndDtm) > parseInt(vldPrdEndDtm)){
					    	messager.alert("유효기간의 종료일이 쿠폰기간의 종료일 이전으로 등록이 불가능합니다. ", "Info", "info", function(){
					    		$('#vldPrdEndDtm').focus();
					    	});
							return false;
					    }
               		}
               		
             		if($("#vldPrdStrtDtm").length > 0){
    					var vldPrdStrtDtm = $("#vldPrdStrtDtm").val().replace(/-/gi, "");
    						if(parseInt(aplStrtDtm) > parseInt(vldPrdStrtDtm)){
    					    	messager.alert("유효기간의 시작일이 쿠폰기간의 시작일 이전으로 등록이 불가능합니다. ", "Info", "info", function(){
    					    		$('#vldPrdStartDtm').focus();
    					    	});
    							return false;
    					    }
                   	}
				    
                	
                	if( $('#notice').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "" ) {	// 공백일 경우
                		$('#notice').val('');
    				}
                	
                	if (!checkCouponList()) {
    					return;
    				}
					
                	<c:choose>
	    				<c:when test="${empty couponBase.cpNo }">
		    				var msg = '<spring:message code="column.common.confirm.insert" />';
	                		var url = "<spring:url value='/promotion/couponInsert.do' />";
	    				</c:when>
	    				<c:otherwise>
		    				var msg = '<spring:message code="column.common.confirm.update" />';
	                		var url = "<spring:url value='/promotion/couponUpdate.do' />";
	    				</c:otherwise>
	    			</c:choose>
    			
                	messager.confirm(msg,function(r){
                		if(r){
                			var data = $("#couponForm").serializeJson();
                            var arrGoodsId = null;
                            var arrGoodsExId = null;
                            var arrDispClsfNo = null;
                            var arrExhbtNo = null;
                            var arrCompNo = null;
                            var arrBndNo = null;
                            var goodsIdx = $('#couponGoodsList').getDataIDs();
                            if(goodsIdx != null && goodsIdx.length > 0) {
                                arrGoodsId = goodsIdx.join(",");
                            }

                            var goodsExIdx = $('#couponGoodsExList').getDataIDs();
                            if(goodsExIdx != null && goodsExIdx.length > 0) {
                                arrGoodsExId = goodsExIdx.join(",");
                            }
                            var compNo  = $('#couponTargetCompNoList').getDataIDs();
                            if(compNo != null && compNo.length > 0) {
                                arrCompNo  = compNo.join(",");
                            }

                            var bndNo  = $('#couponTargetBndNoList').getDataIDs();
                            if(bndNo != null && bndNo.length > 0) {
                                arrBndNo  = bndNo.join(",");
                            }

                            var exhbtNo  = $('#couponExhbtList').getDataIDs();
                            if(exhbtNo != null && exhbtNo.length > 0) {
                                arrExhbtNo  = exhbtNo.join(",");
                            }

                            /*
                            var dispClsfNo  = $('#couponDispList').getDataIDs();
                            if(dispClsfNo != null && dispClsfNo.length > 0) {
                                arrDispClsfNo  = dispClsfNo.join(",");
                            }
                            */
                            arrDispClsfNo = getDispClsfNoList();
            	            
            	            // 발급  회원 등급
                            var arrMbrGrdCd = new Array();
            	            if ( undefined != data.arrMbrGrdCd && data.arrMbrGrdCd != null && Array.isArray(data.arrMbrGrdCd) ){ //데이터 있는 경우만
            	            	arrMbrGrdCd = data.arrMbrGrdCd.join(",");
            	            } else {
            	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
            	                // 전체를 선택하면 검색조건의 모든 회원등급코드를 배열로 만들어서 파라미터 전달함.
            	                if ($("#arrMbrGrdCd_default").is(':checked')) {
            	                    $('input:checkbox[name="arrMbrGrdCd"]').each( function() {
            	                        if (! $(this).is(':checked')) {
            	                        	arrMbrGrdCd.push($(this).val());
            	                        }
            	                    });

            	                    arrMbrGrdCd = arrMbrGrdCd.join(",");
            	                } else {
                	            	arrMbrGrdCd = data.arrMbrGrdCd;
            	                }
            	            }

                            $.extend(data
                                      , { arrDispClsfNo : arrDispClsfNo }
                                      , { arrGoodsId    : arrGoodsId    }
                                      , { arrGoodsExId  : arrGoodsExId  }
                                      , { arrCompNo     : arrCompNo     }
                                      , { arrBndNo      : arrBndNo      }
                                      , { arrExhbtNo    : arrExhbtNo    }
                                      , { arrMbrGrdCd   : arrMbrGrdCd   }
                            );

                            var options = {
                                url : url
        						, data : data
                                , callBack : function(result){
                                	<c:choose>
	            	    				<c:when test="${empty couponBase.cpNo }">
	            	    					closeGoTab('쿠폰 상세', '/promotion/couponView.do?cpNo=' + result.couponBase.cpNo);
	            	    				</c:when>
	            	    				<c:otherwise>
	            	    					updateTab();
	            	    				</c:otherwise>
	            	    			</c:choose>
                                }
                            };

                            ajax.call(options);				
                		}
                	});
                }
            }

            function getDispClsfNoList() {            
                // 카테고리/기획전 트리를 화면에 표시하지 않은 상태에서 업데이트 요청 시 에러발생 방지하려고 null 체크 추가 함.
                if( $("#showCpnCategoryBtn").css('display') != 'none' ) {
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

            function deleteCoupon() {
            	messager.confirm('<spring:message code="column.common.confirm.delete" />',function(r){
            		if(r){
            			var options = {
                                url : "<spring:url value='/promotion/couponDelete.do' />"
                                , data :  {
                                    cpNo : '${couponBase.cpNo}'
                                }
                                , callBack : function(result){
                                	closeGoTab('쿠폰 목록', '/promotion/couponListView.do');
                                }
                            };

                            ajax.call(options);				
            		}
            	});
            }

			function checkCouponList() {
 				if ($("#cpStatCd").val() == "${adminConstants.CP_STAT_20}") {
					var cpTgCd = $(":input:radio[name=cpTgCd]:checked").val();

					if (cpTgCd == "${adminConstants.CP_TG_20}" && grid.jsonData ("couponGoodsList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.coupon.history.good' />","Info","info");						
						return false;
					} else if (cpTgCd == "${adminConstants.CP_TG_30}" && getDispClsfNoList() == null) {
						messager.alert("<spring:message code='admin.web.view.msg.coupon.history.displaycategory' />","Info","info");
						return false;
					} else if (cpTgCd == "${adminConstants.CP_TG_40}" && grid.jsonData ("couponExhbtList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.coupon.history.exhibition' />","Info","info");
						return false;
					} else if (cpTgCd == "${adminConstants.CP_TG_50}" && grid.jsonData ("couponTargetCompNoList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.coupon.history.company' />","Info","info");
						return false;
					} else if (cpTgCd == "${adminConstants.CP_TG_60}" && grid.jsonData ("couponTargetBndNoList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.coupon.history.brand' />","Info","info");
						return false;
					}
 				}

				return true;
			}
			
			function showCpnCategory() {
				$('#displayView').show();
			}
			
			function hideCpnCategory() {
				$('#displayView').hide();
			}

			//쿠폰 발급 정보 엑셀 다운로드
			function fnCouponIssueListExcelDownload(){
				var searchParam = {
						cpNo :  "${couponBase.cpNo}"
					, 	prmtAplGbCd : "${adminConstants.PRMT_APL_GB_20}"
					,   cpPvdMthCd : "${couponBase.cpPvdMthCd}"
					,	cpIsuQty : "${couponBase.cpIsuQty}"
				};
				createFormSubmit("couponIssueList", "/promotion/couponIssueListExcelDownload.do", searchParam);
			}
			
			//쿠폰발급 팝업 호출
			function couponIssuePopup(popupGbn){
				var cpNo = "${couponBase.cpNo}";
				var isSearchView = ("01" == popupGbn);
				var issueLayerId = isSearchView?"layerCouponIssueSearchView":"layerCouponIssueExcelView";
				var issueFnc = isSearchView?"saveCouponIssueList":"saveCouponIssueExcel";
				var issuePopTitle = isSearchView?"쿠폰 발급":"쿠폰 일괄 발급";
				
				var options = {
			        url : '/promotion/couponIssuePop.do'
					, dataType : "html"
					, data : {cpNo : cpNo, popupGbn : popupGbn}
					, callBack : function(result) {
						var config = {
							id : issueLayerId
							, top : 100
							, width : 800
							, height : 710
							, title : issuePopTitle
							, body : result
							, button : "<button type=\"button\" onclick=\""+issueFnc+"();\" class=\"btn btn-ok\">쿠폰 발급</button>"
						}
						layer.create(config);
						
					}
				}
				ajax.call(options );
			}
			
			// 쿠폰발급 삭제 - 대기 건만 삭제 가능
			function couponIssueDelete () {
				var gridIssue = $("#couponIssueList");
				var cpNos = [];

				var rowids = gridIssue.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						for (var i = 0; i < rowids.length; i++) {
							var rowData = gridIssue.jqGrid('getRowData', rowids[i]);
							var mbrData = {};
							mbrData.cpNo = rowData.cpNo;
							mbrData.mbrNo = rowData.mbrNo;
							cpNos.push (mbrData );
						}
		
						var options = {
							url : "<spring:url value='/promotion/couponIssueDelete.do' />"
							, data : JSON.stringify(cpNos)
							, contentType : 'application/json'
							, callBack : function(data ) {
								grid.reload("couponIssueList", options);
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info");
							}
						};
						ajax.call(options);
					}
				});
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>쿠폰 기본 정보</h2>
		</div>
		<form name="couponForm" id="couponForm" method="post">
		<input type="hidden" name="cpNo" value="${couponBase.cpNo }" />
		<table class="table_type1">
			<caption>쿠폰 프로모션 상세</caption>
			<colgroup>
				<col width="125px"/>
				<col />
				<col width="125px"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="column.cp_nm"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 명-->
						<%-- <input type="text" class="w300 validate[required]" ${couponBase.editable ? '' : 'readonly="readonly"'} name="cpNm" id="cpNm" title="<spring:message code="column.cp_nm"/>" value="${couponBase.cpNm}" maxLength="30"/> --%>
						<input type="text" class="w300 validate[required, maxSize[200]]"  name="cpNm" id="cpNm" title="<spring:message code="column.cp_nm"/>" value="${couponBase.cpNm}" maxLength="30"/>
						<c:if test="${not empty couponBase.cpNo}">
						(${couponBase.cpNo})
						</c:if>
					</td>
					<th><spring:message code="column.cp_stat_cd"/></th>
					<td>
						<!-- 쿠폰 상태 코드-->
						<select name="cpStatCd" id="cpStatCd" title="<spring:message code="column.cp_stat_cd"/>" ${empty couponBase.cpStatCd ? 'class="readonly" disabled="disabled"' : ''}>
							<frame:select grpCd="${adminConstants.CP_STAT}" selectKey="${empty couponBase.cpStatCd ? adminConstants.CP_STAT_10 : couponBase.cpStatCd}" />
						</select>
<c:if test="${not empty couponBase.cpNo and adminConstants.CP_STAT_10 ne couponBase.cpStatCd}">
						<span class="blue-desc">* 쿠폰 기본정보, 적용 대상 정보는 변경할 수 없습니다.</span>
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.cp_dscrt"/></th>
					<td colspan="3">
						<!-- 쿠폰 설명-->
						<input type="text" class="w800 validate[maxSize[2000]]" ${couponBase.editable ? '' : 'readonly="readonly"'} name="cpDscrt" id="cpDscrt" title="<spring:message code="column.cp_dscrt"/>" value="${couponBase.cpDscrt}" />
					</td>
                </tr>
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<!-- 사이트 정보는 수정할 수 없음 -->
<c:if test="${couponBase.editable }">
						<frame:stIdRadio selectKey="${couponBase.stStdList}" required="true"/>
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:stIdRadio selectKey="${couponBase.stStdList}" selectKeyOnly="true" required="true"/>
</c:if>
						
					</td>
					<th><spring:message code="column.outside_cp_yn"/></th>
					<td>
<c:if test="${couponBase.editable }">
						<frame:radio name="outsideCpYn" grpCd="${adminConstants.COMM_YN}" selectKey="${empty couponBase.outsideCpYn ? adminConstants.COMM_YN_N : couponBase.outsideCpYn }" required="true"/>
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="outsideCpYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.outsideCpYn}" selectKeyOnly="true" required="true"/>
</c:if>						
						<!-- TODO : 외부쿠폰 예로 변경 시 쿠폰 속성 고정 필요, 예)쿠폰종류 - 상품쿠폰, 지급방법 - 다운로드 지급 등등 -->
						<select name="outsideCpCd" id="outsideCpCd" class="validate[required] ${couponBase.editable ? '' : ' readonly'}" title="외부 쿠폰 코드" ${couponBase.editable ? '' : ' disabled="disabled"'}>
							<frame:select grpCd="${adminConstants.OUTSIDE_CP}" selectKey="${couponBase.outsideCpCd}" defaultName="선택"/>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.isu_mbr_prd"/><strong class="red">*</strong></th>
					<td>

<c:set var="aplStrtDtm" value="${couponBase.aplStrtDtm}"/>
<c:if test="${empty couponBase.aplStrtDtm }">
	<c:set var="aplStrtDtm" value="${frame:toDate('yyyy-MM-dd')}"/>
</c:if>
<c:set var="aplEndDtm" value="${couponBase.aplEndDtm}"/>
<c:if test="${empty couponBase.aplEndDtm }">
	<c:set var="aplEndDtm" value="${frame:addMonth('yyyy-MM-dd', 1)}"/>
</c:if>


<c:if test="${couponBase.editable}">
						<frame:datepicker startDate="aplStrtDtm"
										  startValue="${aplStrtDtm}"
										  endDate="aplEndDtm"
										  endValue="${aplEndDtm}"
										  required="N"
										  />
</c:if>	
<c:if test="${!couponBase.editable }">
						<frame:datepicker startDate="aplStrtDtm"
										  startValue="${aplStrtDtm}"
										  endDate="aplEndDtm"
										  endValue="${aplEndDtm}"
										  readonly="N"
										  />
</c:if>									  
					</td>
					<!-- 쿠폰 유효 기간-->
					<th><spring:message code="column.vld_prd_cd"/><strong class="red">*</strong></th>
					<td>
<c:if test="${couponBase.editable}">                                    
						<div class="mg5">
							<!-- 발급일-->
							<label class="fRadio">
								<input type="radio" class="validate[required]" ${couponBase.vldPrdCd eq adminConstants.VLD_PRD_10 or empty couponBase.vldPrdCd ? 'checked="checked"' : ''} name="vldPrdCd" id="vldPrdCd${adminConstants.VLD_PRD_10}" value="${adminConstants.VLD_PRD_10}" ${couponBase.editable ? '' : 'disabled="true"'}> 
								<span class="w50"><frame:codeName grpCd="${adminConstants.VLD_PRD}" dtlCd="${adminConstants.VLD_PRD_10}" /></span>
							</label>
                            <input type="text" class="w50 validate[min[0]] ${couponBase.vldPrdCd ne adminConstants.VLD_PRD_10 ? 'readonly' : 'validate[required,custom[number]]'}" maxlength="5"  name="vldPrdDay" id="vldPrdDay" title="<spring:message code="column.vld_prd_day"/>" value="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_10 ? couponBase.vldPrdDay : ''}" /> 일
						</div>
						<div class="mg5 mt10">
							<!-- 일자 지정-->
							<label class="fRadio">
								<input type="radio" class="" ${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? 'checked="checked"' : ''} name="vldPrdCd" id="vldPrdCd${adminConstants.VLD_PRD_20}" value="${adminConstants.VLD_PRD_20}" }>
								<span class="w50"><frame:codeName grpCd="${adminConstants.VLD_PRD}" dtlCd="${adminConstants.VLD_PRD_20}"/></span>
							</label>
	<c:if test="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20}">							
							<frame:datepicker startDate="vldPrdStrtDtm"
										 	  startValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdStrtDtm, 'yyyy-MM-dd') : ''}"
											  endDate="vldPrdEndDtm"
											  endValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdEndDtm, 'yyyy-MM-dd') : ''}"
											  />
	</c:if>
	<c:if test="${couponBase.vldPrdCd ne adminConstants.VLD_PRD_20}">	
							<frame:datepicker startDate="vldPrdStrtDtm"
										 	  startValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdStrtDtm, 'yyyy-MM-dd') : ''}"
											  endDate="vldPrdEndDtm"
											  endValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdEndDtm, 'yyyy-MM-dd') : ''}"
											  readonly="Y"
											  />		
	</c:if>								  
                                            
						</div>
</c:if>
<c:if test="${!couponBase.editable }">
						<div class="mg5">
							<!-- 발급일-->
	<c:if test="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_10}">                                            
							<label class="fRadio">
								<input type="radio" class="validate[required]" ${couponBase.vldPrdCd eq adminConstants.VLD_PRD_10 ? 'checked="checked"' : ''} name="vldPrdCd" id="vldPrdCd${adminConstants.VLD_PRD_10}" value="${adminConstants.VLD_PRD_10}" }> 
								<span class="w50"><frame:codeName grpCd="${adminConstants.VLD_PRD}" dtlCd="${adminConstants.VLD_PRD_10}" /></span>
							</label>
							<input type="text" class="w50 validate[min[0]] ${couponBase.vldPrdCd ne adminConstants.VLD_PRD_10 ? 'readonly' : 'validate[required,custom[number]]'}" maxlength="5" name="vldPrdDay" id="vldPrdDay" title="<spring:message code="column.vld_prd_day"/>" value="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_10 ? couponBase.vldPrdDay : ''}" /> 일
    </c:if>
						</div>
						<div class="mg5 mt10">
							<!-- 일자 지정-->
    <c:if test="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20}">
							<label class="fRadio">
								<input type="radio" class="validate[required]" ${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? 'checked="checked"' : ''} name="vldPrdCd" id="vldPrdCd${adminConstants.VLD_PRD_20}" value="${adminConstants.VLD_PRD_20}" }>
								<span class="w50"><frame:codeName grpCd="${adminConstants.VLD_PRD}" dtlCd="${adminConstants.VLD_PRD_20}"/></span>
							</label>
							<frame:datepicker startDate="vldPrdStrtDtm"
										 	  startValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdStrtDtm, 'yyyy-MM-dd') : ''}"
											  endDate="vldPrdEndDtm"
											  endValue="${couponBase.vldPrdCd eq adminConstants.VLD_PRD_20 ? frame:getFormatDate(couponBase.vldPrdEndDtm, 'yyyy-MM-dd') : ''}"
											  readonly="Y"
											  />
    </c:if>
						</div>
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.cp_kind_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 종류 -->
<c:if test="${couponBase.editable }">
						<frame:radio name="cpKindCd" grpCd="${adminConstants.CP_KIND}" selectKey="${couponBase.cpKindCd}"/>
</c:if>
<c:if test="${!couponBase.editable }">
						<frame:radio name="cpKindCd" grpCd="${adminConstants.CP_KIND}" selectKey="${couponBase.cpKindCd}" selectKeyOnly="true" required="true" />
</c:if>
						<div id="cpKindCd30Info" ${couponBase.cpKindCd eq adminConstants.CP_KIND_30 ? '' : 'style="display: none"' }>
							<br/>
							* 배송비 쿠폰은 자사 상품에만 적용합니다.
						</div>
					</td>
					<th><spring:message code="column.cp_isu_mth_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 지급 방식 코드-->
<c:if test="${couponBase.editable }">
						<frame:radio name="cpPvdMthCd" grpCd="${adminConstants.CP_PVD_MTH}" selectKey="${couponBase.cpPvdMthCd}" required="true" />
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="cpPvdMthCd" grpCd="${adminConstants.CP_PVD_MTH}" selectKey="${couponBase.cpPvdMthCd}" selectKeyOnly="true" required="true" />
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.cp_tg_cd"/><strong class="red">*</strong></th>
					<td>
						<div >
						<!-- 쿠폰 대상 코드-->
<c:if test="${couponBase.editable }">
							<frame:radio name="cpTgCd" grpCd="${adminConstants.CP_TG}" selectKey="${couponBase.cpTgCd}" required="true" useYn="Y"/>
</c:if>
<c:if test="${!couponBase.editable }">
							<frame:radio name="cpTgCd" grpCd="${adminConstants.CP_TG}" selectKey="${couponBase.cpTgCd}" selectKeyOnly="true" required="true" useYn="Y"/>
</c:if>
						</div>
						<button id="showCpnCategoryBtn" style="float: left;margin-top:5px; ${adminConstants.CP_TG_30 eq couponBase.cpTgCd ? '' : 'display: none;'}" type="button" onclick="showCpnCategory();" class="btn btn-add" >쿠폰 적용 전시 카테고리</button>
					</td>
					<th><spring:message code="column.cp_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 코드-->
<c:if test="${couponBase.editable or couponBase.cpPvdMthCd eq adminConstants.CP_PVD_MTH_50}">
						<input type="text" class="ml5 readonly validate[min[1]]" maxlength="20" name="cpCd" id="cpCd" title="<spring:message code="column.cp_cd"/>" value="${couponBase.cpPvdMthCd eq adminConstants.CP_PVD_MTH_50 ? couponBase.cpCd : ''}" />
</c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.dc_gb_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 적용 코드-->
<c:if test="${couponBase.editable }">
						<frame:radio name="cpAplCd" grpCd="${adminConstants.CP_APL}" selectKey="${couponBase.cpAplCd}" required="true" />
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="cpAplCd" grpCd="${adminConstants.CP_APL}" selectKey="${couponBase.cpAplCd}" selectKeyOnly="true" required="true" />
</c:if>
					</td>
					<th><spring:message code="column.all_isu_qty"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 발급 코드-->
<c:if test="${couponBase.editable }">
						<frame:radio name="cpIsuCd" grpCd="${adminConstants.CP_ISU}" selectKey="${couponBase.cpIsuCd}" required="true" />
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="cpIsuCd" grpCd="${adminConstants.CP_ISU}" selectKey="${couponBase.cpIsuCd}" selectKeyOnly="true" required="true" />
</c:if>
						<!-- 쿠폰 발급 수량-->
<c:if test="${couponBase.editable or couponBase.cpIsuCd eq adminConstants.CP_ISU_20}">
						<input type="text" class="ml5 readonly validate[min[1]] ${couponBase.cpIsuCd ne adminConstants.CP_ISU_20 ? '' : 'validate[required,custom[number]]'}" maxlength="20" name="cpIsuQty" id="cpIsuQty" title="<spring:message code="column.cp_isu_qty"/>" value="${couponBase.cpIsuCd eq adminConstants.CP_ISU_20 ? couponBase.cpIsuQty : ''}"/>
</c:if>
<div id="cpPvdMtdCd40Msg" style="display:none;">
	<strong class="red">입력 1 : 1개의 난수로 N명 사용 가능 </strong><br/>
	<strong class="red">입력 1 이상 : 입력된 숫자만큼 난수발행, 난수1개에 쿠폰 1개 발행 </strong>
</div>
					</td>
				</tr>
				<tr>
					<th rowspan="3">할인 금액<strong class="red">*</strong></th>
					<td rowspan="3">
						<table class="table_sub" style="width:450px">
							<caption>쿠폰 프로모션 등록</caption>
							<colgroup>
								<col style="width:120px;" />
								<col />
							</colgroup>
							<tbody>
								<input type="hidden" name="splCompDvdRate" id="splCompDvdRate" class="right comma validate[custom[number],min[0]]" maxlength="3" title="<spring:message code="column.spl_comp_dvd_rate"/>" value="100" }/>
								<%-- <tr>
									<th><spring:message code="column.spl_comp_dvd_rate"/><strong class="red">*</strong></th>
									<td>
										<!-- 공급 업체 분담 율-->
										<input type="text" name="splCompDvdRate" id="splCompDvdRate" class="right comma validate[custom[number],min[0]]" maxlength="3" title="<spring:message code="column.spl_comp_dvd_rate"/>" value="${couponBase.splCompDvdRate}" }/>
										<span id="splCompDvdRateUnit"> %</span>
									</td>
								</tr> --%>
								<tr>
									<th><spring:message code="column.apl_val"/><strong class="red">*</strong></th>
									<td>
										<!-- 적용 값-->
										<input type="text" class="right comma validate[custom[number],min[1]]" name="aplVal" id="aplVal" title="<spring:message code="column.apl_val"/>" value="${couponBase.aplVal}"/>
										<span id="spanCpAplCd10"> %</span>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.min_buy_amt"/><strong class="red">*</strong></th>
									<td>
										<!-- 최소 구매 금액-->
										<input type="text" class="right comma validate[custom[number],min[0]]" name="minBuyAmt" id="minBuyAmt" title="<spring:message code="column.min_buy_amt"/>"  maxlength="10" value="${couponBase.minBuyAmt}"/>
										<span id="minBuyAmtUnit"> 원</span>
									</td>
								</tr>
								<tr class="maxDcAmtView">
									<th><spring:message code="column.max_dc_amt"/><strong class="red">*</strong></th>
									<td>
										<!-- 최대 할인 금액-->
										<input type="text" class="right comma validate[custom[number],min[1]]" name="maxDcAmt" id="maxDcAmt" title="<spring:message code="column.max_dc_amt"/>" maxlength="10" value="${couponBase.maxDcAmt}" }/>
										<span id="maxBuyAmtUnit"> 원</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th style="height: 52px;"><spring:message code="column.isu_mth_cd"/><strong class="red">*</strong></th>
					<td>
<c:if test="${couponBase.editable }">
						<frame:radio name="isuTgCd" grpCd="${adminConstants.ISU_TG}" selectKey="${couponBase.isuTgCd}" required="true" />
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="isuTgCd" grpCd="${adminConstants.ISU_TG}" selectKey="${couponBase.isuTgCd}" selectKeyOnly="true" required="true" />
</c:if>
				</tr>
				<%-- <tr>
					<th><spring:message code="column.isu_host_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 발급 주체 코드-->
						<select name="isuHostCd" id="isuHostCd" class="validate[required] ${couponBase.editable ? '' : ' readonly'}" title="<spring:message code="column.isu_host_cd"/>" ${couponBase.editable ? '' : ' disabled="disabled"'}>
							<frame:select grpCd="${adminConstants.ISU_HOST}" selectKey="${couponBase.isuHostCd}" defaultName="선택"/>
						</select>
					</td>
				</tr> --%>
				<tr>
					<th style="height: 52px;"><spring:message code="column.isu_mbr_grd_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 발급  회원 등급 -->
						<frame:checkbox name="arrMbrGrdCd" useYn="${adminConstants.COMM_YN_Y}" grpCd="${adminConstants.MBR_GRD_CD}" defaultName="전체" defaultId="arrMbrGrdCd_default" checkedArray="${couponBase.mbrGrdCd }" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.cp_show_yn"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰존 전시 여부 수정가능-->
<%-- <c:if test="${couponBase.editable }">
						<frame:radio name="cpShowYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.cpShowYn}" required="true"/>
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="cpShowYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.cpShowYn}" selectKeyOnly="true" required="true"/>
</c:if> --%>
						<frame:radio name="cpShowYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.cpShowYn}"  required="true"/>						
					</td>
					<th style="height: 52px;"><spring:message code="column.web_mobile_gb_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 쿠폰 웹 모바일 구분 수정가능-->
<%-- <c:if test="${couponBase.editable }">
						<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB}" selectKey="${couponBase.webMobileGbCd}" required="true" />
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB}" selectKey="${couponBase.webMobileGbCd}" selectKeyOnly="true" required="true" />
</c:if> --%>
						<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB}" selectKey="${couponBase.webMobileGbCd}"  required="true" excludeOption="${adminConstants.WEB_MOBILE_GB_30}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.msg_send_yn"/><strong class="red">*</strong></th>
					<td>
						<!-- 발급 메시지 발송-->
						<frame:radio name="msgSndYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.msgSndYn}" required="true"/>
					</td>
					<th><spring:message code="column.expire_itdc_yn"/><strong class="red">*</strong></th>
					<td>
						<!-- D-3 만료 메시지 발송 -->
						<frame:radio name="exprItdcYn" grpCd="${adminConstants.COMM_YN}" selectKey="${couponBase.exprItdcYn}" required="true" />
					</td>
				</tr>
				<%-- <tr>
					<th>이미지<strong class="red">*</strong></th>
					<td colspan="3">
						<!-- 쿠폰 이미지 파일명-->
						<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="cpImgFlnm" id="cpImgFlnm" title="<spring:message code="column.cp_img_flnm"/>" value="${couponBase.cpImgFlnm}" />
						<!-- 쿠폰 이미지 경로명-->
						<input type="hidden" name="cpImgPathnm" id="cpImgPathnm" title="<spring:message code="column.cp_img_pathnm"/>" value="${couponBase.cpImgPathnm}" />
						<button type="button" onclick="${couponBase.editable ? 'fileUpload.image(resultCouponImage);' : ''}" class="btn">파일찾기</button>
						<br/>* 등록이미지 : 5MB 이하 / gif, png, jpg(jpeg)
					</td> --%>
<%-- 					<th><spring:message code="column.multi_apl_yn"/></th>
					<td>
<c:if test="${couponBase.editable }">
						<frame:radio name="multiAplYn" grpCd="${adminConstants.MULTI_APL_YN}" selectKey="${couponBase.multiAplYn}" required="true"/>
</c:if>
<c:if test="${! couponBase.editable }">
						<frame:radio name="multiAplYn" grpCd="${adminConstants.MULTI_APL_YN}" selectKey="${couponBase.multiAplYn}" selectKeyOnly="true" required="true"/>
</c:if>
					</td> --%>
				<!-- </tr> -->
				<tr>
					<th><spring:message code="column.coupon.notice"/></th>
					<td colspan="3">
						<!-- 유의사항 -->
						<textarea cols="30" rows="10" style="width:100%;" id="notice" name="notice" class="validate[maxSize[1000]]">${couponBase.notice}</textarea>
					</td>
				</tr>	
			</tbody>
		</table>
		</form>
						
		<div id="displayView" style="display:none;">
			<div class="window-mask" style="display:block;z-index:9003;position:fixed;"></div>
			<div class="layer-display">
				<div class="mTitle">
					<h2>쿠폰 적용 전시카테고리<strong class="red">*</strong></h2>
					<div class="buttonArea">
						<button type="button" onclick="hideCpnCategory();" class="btn btn-cancel">닫기</button>
					</div>
				</div>
				<div class="tree-menu">
					<div style="height: 530px;" class="gridTree" id="displayTree"></div>
				</div>
			</div>
		</div>

		<div id="goodsView" ${adminConstants.CP_TG_20 eq couponBase.cpTgCd ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>쿠폰 적용 상품<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<%-- <button type="button" onclick='${couponBase.editable ? 'couponGoodsLayer("couponGoodsList");' : ''}' class="btn btn-add">추가</button>
					<button type="button" onclick='${couponBase.editable ? 'couponGoodsDelete("couponGoodsList");' : ''}' class="btn btn-add">삭제</button> --%>
					<button type="button" onclick='couponGoodsLayer("couponGoodsList");' class="btn btn-add">추가</button>
					<button type="button" onclick='couponGoodsDelete("couponGoodsList");' class="btn btn-add">삭제</button>
				</div>
			</div>
			<div class="mModule no_m">
				<table id="couponGoodsList" ></table>
			</div>
		</div>

		<div id="displayView40" ${ adminConstants.CP_TG_40 eq couponBase.cpTgCd ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>쿠폰 적용 기획전<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<%-- <button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'exhbtListAddPop();'  : ''} >추가</button>
					<button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'exhbtListDelDisp();' : ''} >삭제</button> --%>
					<button type="button" class="btn btn-add" onclick='exhbtListAddPop();' >추가</button>
					<button type="button" class="btn btn-add" onclick='exhbtListDelDisp();' >삭제</button>
				</div>
			</div>
			<div class="mModule no_m">
				<table id="couponExhbtList" ></table>
			</div>
		</div>

		<div id="displayView50" ${adminConstants.CP_TG_50 eq couponBase.cpTgCd   ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>쿠폰 적용 업체<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'fnCompanyAddPop();'  : ''} >추가</button>
					<button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'fnCompanyDel();' : ''} >삭제</button>
				</div>
			</div>
			<div class="mModule no_m">
				<table id="couponTargetCompNoList" ></table>
			</div>
		</div>
		
		<div id="displayView60" ${adminConstants.CP_TG_60 eq couponBase.cpTgCd   ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>쿠폰 적용 브랜드<strong class="red">*</strong></h2>
				<div class="buttonArea">
					<%-- <button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'fnBrandAddPop();'  : ''} >추가</button>
					<button type="button" class="btn btn-add" onclick=${couponBase.editable ? 'fnBrandDel();' : ''} >삭제</button> --%>
					<button type="button" class="btn btn-add" onclick='fnBrandAddPop();'>추가</button>
					<button type="button" class="btn btn-add" onclick='fnBrandDel();'>삭제</button>
					
				</div>
			</div>
			<div class="mModule no_m">
				<table id="couponTargetBndNoList" ></table>
			</div>
		</div>
		
		<div id="goodsExView" ${adminConstants.CP_TG_30 eq couponBase.cpTgCd
		                      or adminConstants.CP_TG_40 eq couponBase.cpTgCd
		                      or adminConstants.CP_TG_50 eq couponBase.cpTgCd
		                      or adminConstants.CP_TG_60 eq couponBase.cpTgCd ? '' : 'style="display: none;"'}>
			<div class="mTitle mt30">
				<h2>쿠폰 적용 제외 상품</h2>
				<div class="buttonArea">
					<%-- <button type="button" onclick='${couponBase.editable ? 'couponGoodsExListExcelUploadLayer();' : ''}' class="btn btn-add">엑셀 일괄추가</button>
					<button type="button" onclick='${couponBase.editable ? 'couponGoodsLayer("couponGoodsExList");' : ''}' class="btn btn-add">추가</button>
					<button type="button" onclick='${couponBase.editable ? 'couponGoodsDelete("couponGoodsExList");' : ''}' class="btn btn-add">삭제</button> --%>
					<button type="button" onclick='couponGoodsExListExcelUploadLayer();' class="btn btn-add">엑셀 일괄추가</button>
					<button type="button" onclick='couponGoodsLayer("couponGoodsExList");' class="btn btn-add">추가</button>
					<button type="button" onclick='couponGoodsDelete("couponGoodsExList");' class="btn btn-add">삭제</button>
					
				</div>
			</div>
			<div class="mModule no_m">
				<table id="couponGoodsExList" ></table>
			</div>
		</div>
<c:if test="${not empty couponBase.cpNo }">
		<div class="buttonArea mt30" align="right" >
		
			<jsp:useBean id="nowDate" class="java.util.Date" />
			<fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" var="nowDt" />
			<fmt:formatDate value="${couponBase.aplEndDtm}" pattern="yyyyMMdd" var="aplEndDt" />
			<c:if test="${ (couponBase.cpPvdMthCd eq adminConstants.CP_PVD_MTH_40) and (couponBase.cpStatCd eq adminConstants.CP_STAT_20) and (nowDt <= aplEndDt) }">
				<button type="button" onclick="couponIssuePopup('01');" class="btn btn-add">쿠폰 발급</button>
				<button type="button" onclick="couponIssuePopup('02');" class="btn btn-add">쿠폰 일괄 발급</button>
				<button type="button" onclick="couponIssueDelete();" class="btn btn-add">삭제</button>
			</c:if>
			
			<button type="button" onclick="fnCouponIssueListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
		</div>
		<div class="mTitle mt10">
			<h2>쿠폰 발급 정보</h2>
		</div>
		<div class="mModule no_m">
			<table id="couponIssueList" ></table>
			<div id="couponIssueListPage"></div>
		</div>
</c:if>

		<div class="btn_area_center">
			<c:choose>
				<c:when test="${empty couponBase.cpNo }">
					<button type="button" onclick="saveCoupon();" class="btn btn-ok">등록</button>
				</c:when>
				<c:otherwise>
					<!-- 종료가 아닐때만 수정버튼이 보여짐 -->
					<c:if test="${adminConstants.CP_STAT_40 ne couponBase.cpStatCd}">
					<button type="button" onclick="saveCoupon();" class="btn btn-ok">수정</button>
					</c:if>
				</c:otherwise>
			</c:choose>
			
<c:if test="${adminConstants.CP_STAT_10 eq couponBase.cpStatCd}">
			<button type="button" onclick="deleteCoupon();" class="btn btn-add">삭제</button>
</c:if>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>