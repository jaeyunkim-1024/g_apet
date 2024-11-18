<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var acctGridRowId = null;
			
			$(document).ready(function(){
				//PO 로그인시 보이지 말아야 할 항목 처리 
				if('${adminSession.usrGrpCd}'!='10'){

				
				}
				
				$("input:text[numberOnly]").on("keyup", function() {
				    $(this).val($(this).val().replace(/[^0-9]/gi,""));
				});				
				// 사업자 번호 마스킹 처리
				$("#bizNo").mask("000-00-00000");
				
// 				console.log("${companyBase}")

				createCompanyDeliveryGrid();

				createBrandList ();

				<c:if test="${companyBase.mdUsrNo ne '' and adminConstants.USR_GRP_10 eq adminSession.usrGrpCd }">
							$("#userDeleteBtn").show();
				</c:if>
				
				$("#compNm").bind("change", function(){ compNmDupCheck(); });
				
				createStStdInfoSelect();
				
				createChrgList();
				
				createAcctList();
				
				compTpCdShow("${companyBase.compTpCd}");
				
				$("#compStatCd").bind("change", function() {
					var val = this.value;
					if(val == "${adminConstants.COMP_STAT_30}" || val == "${adminConstants.COMP_STAT_40}") {
						messager.alert("업체 상태가 변경되어도 상품이 판매중지 또는 판매종료로 자동 변경되지 않습니다.<br><br> 상태 변경 전 판매중 상품의 상태 확인 및 수동 변경 처리를 해주세요.", "Info", "info");
						return;
					}
				})
 			});

			$(document).on("input paset change", "#dlgtEmail", function(){
			   var inputVal = $(this).val().replace(/[ㄱ-힣]/g,'');
			   $("#dlgtEmail").val(inputVal);
			})
			
			// 업체명 중복확인
			function compNmDupCheck() {
				var options = {
					url : "<spring:url value='/company/compNmDupCheck.do' />"
					, data : { compNm : $("#compNm").val() }
					, callBack : function(result) {
						if(result > 0) {
							if("${companyBase.compNm}" != $("#compNm").val()) {
								messager.alert("기 등록되어 있는 업체명은 사용하실 수 없습니다.", "Info", "info");
								$("#compNm").val("").change();	
							}
						}
					}
				};

				ajax.call(options);
			}
			
			function compGbCdShow(val) {
               if (val == "${adminConstants.COMP_GB_10}" ) {	// 업체 구분이 '자사'일 경우
            	   // 업체 유형 '위탁', '매입' disabled
                   $("#compTpCd${adminConstants.COMP_TP_20}").attr("disabled", "disabled");
                   $("#compTpCd${adminConstants.COMP_TP_30}").attr("disabled", "disabled");

                   // 업체 유형 '자사' remove disabled
                   $("#compTpCd${adminConstants.COMP_TP_10}").removeAttr("disabled");
                   
                   // 업체 유형 '자사' checked
                   $("input[name='compTpCd']:radio[value='${adminConstants.COMP_TP_10}']").prop("checked", true);
                   
                   // 업체 유형 change 이벤트
                   compTpCdShow('${adminConstants.COMP_TP_10}');
                } else if (val == "${adminConstants.COMP_GB_20}" ) {	// 업체 구분이 '외부업체'일 경우
               		// 업체 유형 '자사' disbled  
                   $("#compTpCd${adminConstants.COMP_TP_10}").attr("disabled", "disabled");
                   
                	// 업체 유형 '위탁', '매입' disabled
                   $("#compTpCd${adminConstants.COMP_TP_20}").removeAttr("disabled");
                   $("#compTpCd${adminConstants.COMP_TP_30}").removeAttr("disabled");
                   
                   // 업체 유형 '위탁' checked
                   $("input[name='compTpCd']:radio[value='${adminConstants.COMP_TP_20}']").prop("checked", true);
                   
                   // 업체 유형 change 이벤트
                   compTpCdShow('${adminConstants.COMP_TP_20}');
                }
			}
			
			function compTpCdShow(val) {
				if(val == '${adminConstants.COMP_TP_30}') {	// 업체 유형이 '매입'일 경우
					// 정산 주기 숨김
					$("#cclTermCdTh").hide();
					$("#cclTermCdTd").hide();
					$("#cclTermCd").val("");
					
					// 비고 colspan 부여
					$("#bigoTd").attr("colspan", "3");
					
					// 브랜드 숨김
					$("#companyBrandArea").hide();	
					
					// 전시 카테고리 숨김
					$("#companyDispCtgArea").hide();
					
					// 수수료율 숨김 
					//$("#companyCclViewArea").hide();
					
					// 배송정잭부분 숨김 
					$("#companyDeliveryViewArea").hide();
					
					// 계좌 숨김
					$("#compAccountArea").hide();
					
					// 담당자 숨김
					$("#compChrgArea").hide();
				} else {
					// 정산 주기 노출
					$("#cclTermCdTh").show();
					$("#cclTermCdTd").show();
					
					// 비고 colspan 삭제
					$("#bigoTd").removeAttr("colspan");
					
					// 브랜드 노출
					$("#companyBrandArea").show();	
					
					// 전시 카테고리 노출
					$("#companyDispCtgArea").show();
					
					// 배송정책부분 노출
                    $("#companyDeliveryViewArea").show();
					
					// 계좌 노출
					$("#compAccountArea").show();
					
					// 담당자 노출
					$("#compChrgArea").show();
					
					// 업체 유형이 '자사'인경우 수수료율 0으로 고정
                    /* if(val == '${adminConstants.COMP_TP_10}') {
    					// 수수료율 숨김
                        $("#companyCclViewArea").hide();
    					
                    	$("#cmsRate").val(0).attr("readonly", "readonly");
                    } else {
    					// 수수료율 노출
                        $("#companyCclViewArea").show();
    					
                    	$("#cmsRate").val('').removeAttr("readonly");
                    } */
				}
			}
			
			// 사이트 select 생성
			function createStStdInfoSelect() {
				// hjko 추가
				var siteids = new Array();
				
				var options = {
					url : "<spring:url value='/st/stList.do' />"
					, data : { compNo : "${companyBase.compNo}" }
					, callBack : function(result) {
						var compStIds = new Array();
						var rows = result.rows;
						var selectStId = "<option value=''>사이트선택</option>";
						
						<c:forEach items="${compStIds}" var="compStId">
							compStIds.push("${compStId.stId}");
						</c:forEach>
						
						jQuery(rows).each(function(i){
							
							var selected = false;
							if($.inArray(rows[i].stId.toString(), compStIds) > -1){ 
								selected = true;
							}
							
							if(compStIds.length > 0){
								selectStId += "<option value= '" + rows[i].stId + "'"; 
								if(selected){
									selectStId += "selected";
								}
								selectStId += ">" + rows[i].stNm + "</option>";
							}
	                    });

						jQuery("#stId").append(selectStId);
					}
				};

				ajax.call(options);
			}

			// 공급 업체 기본 주소 등록
			function comapnyPost(result){
				$("#postNoOld").val(result.postcode);
				$("#prclAddr").val(result.jibunAddress);
				$("#postNoNew").val(result.zonecode);
				$("#roadAddr").val(result.roadAddress);
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

			function companyUpdate(){
				if(validate.check("companyViewForm")) {
					if (!checkGridDataExists()) {
						return;
					}
					
	                if($("#stId").val() == null || $("#stId").val() == ""){
	                	messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
	                    return false;
	                }
		            //주문내역 알림 시간 추가. 20210909
					var ordCletCharAlmArr = new Array();					
					$('input:checkbox[name="ordCletCharAlms"]:checked').each( function() {
						ordCletCharAlmArr.push($(this).val());
					});
					$("#ordCletCharAlmCd").val(ordCletCharAlmArr.toString());
	              
	                messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
		                if (r){
		                	var sendData = $("#companyViewForm").serializeJson();
							var brandList = grid.jsonData("brandList");
							var acctList = grid.jsonData("acctList");
							var chrgList = grid.jsonData("chrgList");
							var radioValList = changeRadioCheck();
					
							for(var  ind = 0; ind<chrgList.length; ind++){
								if(radioValList[ind]){
									chrgList[ind].picAlmRcvYn="Y"
								}else{
									chrgList[ind].picAlmRcvYn="N"
								}
							}
					
							$.extend(sendData, {
								companyBrandPO : JSON.stringify(brandList)
								, compAcctPO : JSON.stringify(acctList)
								, companyChrgPO : JSON.stringify(chrgList)
							});
							
							//console.log(sendData);
							
							var options = {
								url : "<spring:url value='/company/companyUpdate.do' />"
								, data : sendData
								, callBack : function(result){
									messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info", function(){
										updateTab();
									});
								}
							};

							ajax.call(options);
		                }
	            	});
				}
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

					// 배송 조건
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
					//$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("disabled", false);
					//$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("checked", true);
					//dlvrcCdtStdCdView('${adminConstants.DLVRC_CDT_STD_50}');
				} else {
					$("input[name=dlvrcCdtStdCd]").prop("disabled", false);
					$("input[name=dlvrcCdtStdCd]").prop("checked", false);
					//$("input[name=dlvrcCdtStdCd]:input[value=${adminConstants.DLVRC_CDT_STD_50}]").prop("disabled", true);
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

			// 업체 배송정책 목록
			function createCompanyDeliveryGrid(){
				var options = {
					url : "<spring:url value='/company/companyDeliveryListGrid.do' />"
					, height : 300
					, searchParam : { compNo : '${companyBase.compNo}' }
					, colModels : [
						{name:"compNo", label:'<spring:message code="column.comp_no" />', hidden:true }
						, {name:"dlvrcPlcNo", label:'<spring:message code="column.dlvrc_plc_no" />', width:"100", align:"center", formatter:'integer', classes:'pointer fontbold', sortable:false}
						, {name:"plcNm", label:'<b><u><tt><spring:message code="column.plc_nm" /></tt></u></b>', width:"200", align:"center", classes:'pointer fontbold', sortable:false}
                        // 배송비 정책번호 일괄 변경
                        /* , {name:"button", label:'배송정책변경', width:"90", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
                            var str = '<button type="button" onclick="fnDlvrcPlcNoChg(\'' + rawObject.compNo + '\',\'' + rawObject.dlvrcPlcNo + '\')" class="btn_h25_type1">일괄 변경</button>';
                            if (rawObject.delYn =='N'){
                                return str; 
                            }else{
                                return '';
                            }
                        }} */
						, {name:"dftHdcCd", label:'<spring:message code="column.dft_hdc_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.HDC}"/>"}, sortable:false , hidden:'${adminSession.usrGrpCd}'!='10'? true:false}
						, {name:"rtnaPostNoNew", label:'<spring:message code="column.rtna_post_no_new" />', width:"120", align:"center", sortable:false}
						, {name:"rtnaRoadAddr", label:'<spring:message code="column.rtna_road_addr" />', width:"300", align:"center", sortable:false}
						, {name:"rtnaRoadDtlAddr", label:'<spring:message code="column.rtna_road_dtl_addr" />', width:"200", align:"center", sortable:false}
						, {name:"rlsaPostNoNew", label:'<spring:message code="column.rlsa_post_no_new" />', width:"120", align:"center", sortable:false}
						, {name:"rlsaRoadAddr", label:'<spring:message code="column.rlsa_road_addr" />', width:"300", align:"center", sortable:false}
						, {name:"rlsaRoadDtlAddr", label:'<spring:message code="column.rlsa_road_dtl_addr" />', width:"200", align:"center", sortable:false}
						, {name:"rtnExcMan", label:'<spring:message code="column.rtn_exc_man" />', width:"200", align:"center", sortable:false}
						, {name:"rtnExcTel", label:'<spring:message code="column.rtn_exc_tel" />', width:"200", align:"center", sortable:false}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"150", align:"center", sortable:false}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"150", align:"center", sortable:false}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					]
					, paging : false
					, onCellSelect : function (id, cellidx, cellvalue) {
						var rowdata = $("#companyDeliveryList").getRowData(id);

						if(cellidx != 3) {
							//코드관리_그룹 상세 조회
	                        companyDeliveryView(rowdata.dlvrcPlcNo);
                        }
					}
				};

				grid.create("companyDeliveryList", options);
			}
			
			function fnDlvrcPlcNoChg(compNo, dlvrcPlcNo){
				messager.confirm('<spring:message code="column.common.confirm.batch_update" />', function(r){
	                if (r){
	                	var options = {
 			               url : "<spring:url value='/goods/updateGoodsDlvrcPlcNoBatch.do' />"
 			               , data : { compNo : compNo ,dlvrcPlcNo : dlvrcPlcNo }
 			               , callBack : function(result) {
 			                   if (result.rtn >   0 ) {
 			                	   messager.alert("<spring:message code='admin.web.view.msg.company.grid.process.success' arguments='"+result.rtn+"'/>", "Info", "info");
 			                   }else{
 			                	   messager.alert("<spring:message code='admin.web.view.msg.company.grid.process.fail'/>", "Info", "info");
 			                   }
 			               }
	 			        };
	 			        ajax.call(options);
	                }
            	});
			}   

			function reloadCompanyDeliveryGrid(){
				var options = {
					searchParam : { compNo : '${companyBase.compNo}' }
				};

				grid.reload("companyDeliveryList", options);
			}

			// 업체 배송정책 상세 보기
			function companyDeliveryView(dlvrcPlcNo) {
				var options = {
					url : "<spring:url value='/company/companyDeliveryViewPop.do' />"
					, data : {
						compNo: '${companyBase.compNo}',
						dlvrcPlcNo: dlvrcPlcNo,
						viewDlvrPlcyDetail: 'Y'
			         }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "companyDeliveryView"
							, width : 1400
							, height : 750
							, top : 50
							, title : "업체 배송정책 보기"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
			
            // 업체 배송정책 추가 등록
            function addCompanyDeliveryPolicy() {
                var options = {
   					url : "<spring:url value='/company/companyDeliveryViewPop.do' />"
   					, data : {
   						compNo: '${companyBase.compNo}',
                        viewDlvrPlcyDetail: 'N'
   			         }
   					, dataType : "html"
   					, callBack : function (data ) {
   						var config = {
   							id : "companyDeliveryView"
   							, width : 1400
   							, height : 750
   							, top : 50
   							, title : "업체 배송정책 등록"
   							, body : data
   							, button : "<button type=\"button\" onclick=\"insertCompanyDelivery();\" class=\"btn btn-ok\">저장</button>"
   						}
   						layer.create(config);
   					}
   				}
   				ajax.call(options );
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
            
	         // 업체 배송정책 택배일 때
            $(document).on("change", "select[name=compDlvrMtdCd]", function(e){
                if($(this).val() == '${adminConstants.COMP_DLVR_MTD_10}') {
                    $("#hdcCdSelect").show();
                } else {
                    $("#hdcCdSelect").hide();
                }
            });
	         
			function searchBrandCallback (brandList ) {
				var rowIds = null;
				var check = false;
				if(typeof brandList !== "undefined" && brandList.length > 0 ) {
					for(var i = 0; i < brandList.length; i++ ) {
						// 중복 체크
						brandList[i].bndNo = "";
						rowIds = $("#companyBrandList").jqGrid("getDataIDs");
						for(var idx = 0; idx < rowIds.length; idx++) {
							if(rowIds[idx] == brandList[i].bndNo) {
								check = true;
							}
						}
						if(!check ) {
							brandList[i].qty = 1;
							$("#bndNoList").jqGrid("addRowData", brandList[i].bndNo, brandList[i], "last", null );
							check = false;
						}
					}
				}
			}

			// 업체 등록시  => 체크박스 사이트 아이디와 셀렉트 박스 사이트 아이디 비교. hjko
			function compareStIdComboStId(id){
				// 체크 선택된 사이트배열 선언
				var sa = new Array();
				if($("input[name='stId']:checked").length == 0){
					return false;
				}else{
					$("input[name='stId']:checked").each(function(index, ob){
						sa.push($(this).val());
					});
					var t = $("#"+id+" option:selected").val();

					if($.inArray(t,sa) != -1){ // 있으면
						return true;
					}else{
						return false;
					}

				}
			}
			
			function checkGridDataExists() {
				if($("input[name=compTpCd]:checked").val() != "${adminConstants.COMP_TP_30}") {
					var dom = $("#acctList");
					var objRowModels = dom.jqGrid('getGridParam','colModel');
					var dataIDs = dom.getDataIDs();
					
					for(var intIndex = 0; intIndex < dataIDs.length; intIndex++) {
						for(var intIndex1 = 0; intIndex1 < objRowModels.length; intIndex1++) {
							var value = dom.jqGrid('getCell', dataIDs[intIndex], objRowModels[intIndex1].name);
							var label = objRowModels[intIndex1].label;
							if(objRowModels[intIndex1].required && (value == "" || value == "''")) {
								var msg = "<spring:message code='admin.web.view.msg.company.acct.column.empty' arguments='###' />";
								messager.alert(msg.replace("###", label.replace("*", "")), "Info", "info", function(){
									$("#addCompAccountBtn").focus();
								});
								return false;
							}
						}
					}
					
					if ( grid.jsonData ("acctList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.company.acct.empty' />", "Info", "info", function(){
							$("#addCompAccountBtn").focus();
						});
						return false;
					} else if ( grid.jsonData ("brandList" ).length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.company.brand.empty' />", "Info", "info", function(){
							$("#addBrandBtn").focus();
						});
						return false;
					} 
					
					return true;
				}
				return true;
			}
 
			// 브랜드 grid 생성
			function createBrandList () {
				 var compNo = '${companyBase.compNo}';

				var options = {
					url : "<spring:url value='/company/compBrandMapListGrid.do' />"
					, searchParam : {compNo : compNo }
					, paging : false
					, cellEdit : true
					, height : 150
					, colModels : [
						{name:"bndNo", label:'<spring:message code="column.bnd_no" />', width:"100", align:"center", key: true, sortable:false }
						, {name:"bndNmKo", label:'<spring:message code="column.bnd_nm_ko" />', width:"150", align:"center", sortable:false }
						, {name:"bndNmEn", label:'<spring:message code="column.bnd_nm_en" />', width:"150", align:"center", sortable:false }
						, {name:"useYn", label:'<spring:message code="column.use_yn" />', width:"100", align:"center", sortable:false }
						, {name:"dlgtBndYn", label:'<spring:message code="column.dlgt_bnd_yn" />', width:"100", align:"center", sortable:false, editable:true, edittype:'select', formatter:"select"
							, editoptions:{value:_COMM_YN
								, dataEvents:[
						               { 
						            	   type: "change", fn: function(e){			            		   
											   var row = $(e.target).closest('tr.jqgrow');
											   var attrCheck= false;
											   var rowid = row.attr('id');
											   var rowIndex = $("#brandList").getInd(rowid);
											   var comboVal = $("#"+rowIndex+"_dlgtBndYn option:selected").val();
	
											   if(comboVal == "${adminConstants.COMM_YN_Y}") {
												   // 중복체크
												   var drowids = $("#brandList").getDataIDs();
												   
												   for(var j = 0; j < drowids.length; j++) {
													   var drowdata = $("#brandList").getRowData(drowids[j]);
													   var drowIndex = $("#brandList").getInd(drowids[j]);
													   if(drowdata.dlgtBndYn == comboVal && rowIndex != drowIndex) {
														   $("#"+rowIndex+"_dlgtBndYn").val("${adminConstants.COMM_YN_N}");
															messager.alert("<spring:message code='admin.web.view.msg.company.brand.one_invalid' />", "Info", "info");
													   }
												   }
											   }
											}
									   }
									]
								}
							}
					]
					, multiselect : true
				};
				grid.create("brandList", options);
			}

			// 브랜드 추가 팝업  ( 다중 선택 )
			function brandAddPop(){

				var options = null;
						options = {
							multiselect : true
							, plugins : [ "themes" , "checkbox" ]
							<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
							, compNo : '${adminSession.compNo}'
							, compNm : '${adminSession.compNm}'
							</c:if>
							, callBack : function(newBrand){
								if(newBrand != null && newBrand.length > 0) {
									var companyBrands = $('#brandList').getDataIDs();
									var message = new Array();
									
		                            // 현재 업체의 적용사이트 추출
		                            /* var companyStIdArray = [];
		                            $("input:checkbox[name='stId']:checked").each(function () {
		                            	companyStIdArray.push($(this).val());
		                            }); */
		                            
		                            var companyStId = $("#stId").val();

									for(var nb in newBrand){
										var check = true;
										
		                                // 새로 추가할 브랜드의 사이트 아이디 추출
		                                var newBrandStIdArray = newBrand[nb].stIds.split("|");
		                                
		                                // 새로 추가할 브랜드의 사이트 아이디가 현재 업체의 적용사이트에 속하는지 확인
		                                for (var si in newBrandStIdArray) {
		                                    /* if (jQuery.inArray(newBrandStIdArray[si], companyStIdArray) < 0) {
		                                        check = false;
		                                    } else {
		                                        // 일치하는 사이트아이디가 있으면 바로 통과
		                                        check = true;
		                                        break;
		                                    }*/
		                                    if(newBrandStIdArray[si] != companyStId) {
		                                    	check = false;
		                                    } else {
		                                    	check = true; 
		                                        break;
		                                    }
		                                }
		                                
		                                // 적용사이트에 속하지 않아서 적용불가 메시지 추가
		                                if (check == false) {
		                                    message.push(newBrand[nb].bndNmKo + " 적용 사이트가 일치하지 않습니다.");
		                                }
		                                
		                                // 새로 추가할 브랜드가 현재 업체적용 브랜드와 겹치는지 확인
		                                for(var cb in companyBrands) {
		                                    if(newBrand[nb].bndNo == companyBrands[cb]) {
		                                        check = false;
		                                        message.push(newBrand[nb].bndNmKo + " 중복 브랜드입니다.");
		                                    }
		                                }

 										if(check) {
 										   var addData = {
	                                          bndNo : newBrand[nb].bndNo
	                                          , bndNmKo : newBrand[nb].bndNmKo
	                                          , bndNmEn : newBrand[nb].bndNmEn
	                                          , useYn : newBrand[nb].useYn
	                                          , dlgtBndYn : "${adminConstants.COMM_YN_N}"
 										   };
		                                     
											$("#brandList").jqGrid('addRowData', newBrand[nb].bndNo, addData, 'last', null);
										}
									}
									if(message != null && message.length > 0) {
										messager.alert(message.join("<br/>"), "Info", "info");
									}
								}
							}
						}

					layerBrandList.create (options );
			}

			// 브랜드 삭제
			function brandDel() {
				var rowids = $("#brandList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#brandList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.company.brand.select_invalid' />", "Info", "info");
				}
			}
			
			// callback : 담당 MD 검색
			function fnCallbackMDUserPop() {
				var data = {
					 multiselect : false
					, callBack : function(result) {
						$("#mdUsrNm").val( result[0].usrNm );
						$("#mdUsrNo").val( result[0].usrNo );
						$("#userDeleteBtn").show();
					}
					,param : {
						usrStatCd : '${adminConstants.USR_STAT_20}'
						, usrGbCd : '${adminConstants.USR_GB_1020}'
					}
				}
				layerUserList.create(data);

			}

			function fnUserDelete() {
				$("#mdUsrNm").val("");
				$("#mdUsrNo").val("");
				$("#userDeleteBtn").hide();
			}
			
			/** 업체계정으로 로그인 */
			function fnCompUserLogin(compNo) {
				messager.confirm('<spring:message code="column.common.confirm.compUserLogin" />', function(r){
	                if (r){
	                	var options = {
    						url : "<spring:url value='/company/compUserLogin.do' />"
    						, data : { compNo : compNo }
    						, callBack : function(data){
    							messager.alert(data.resultMsg, "Info", "info", function(){
    								if(data.resultCode == "S") {
        								window.top.location.reload();
        							}
    							});
    						}
    					};
    	
    					ajax.call(options);
	                }
            	});
			}
			
			/*******************************************************************************************************************************************/
			/***************** 업체 계좌 ******************************************************************************************************************/
			/*******************************************************************************************************************************************/
			
			
			// 업체 계좌 그리드 생성
			function createAcctList () {
				var options = {
					url : "<spring:url value='/company/compAcctListGrid.do' />"
					, searchParam : { compNo : "${companyBase.compNo}" }
					, paging : false
					, cellEdit : true
					, height : 150
					, colModels : [
						{name:"compAcctIsuNo", hidden:true}
						, {name:"bankGbCd", label:'<spring:message code="column.bank_cd" /> <span style="color:red;">*</span>', width:"200", align:"center", sortable:false, editable:true, edittype:'select', formatter:"select"
							, editoptions:{value:"'':선택;<frame:gridSelect grpCd='${adminConstants.BANK }' showValue='false' />" }, required:true}
						, {name:"acctNo", label:'<spring:message code="column.acct_no" /> <span style="color:red;">*</span>', width:"150", align:"center", key: false, sortable:false, editable:true
							, formatter:function(cellValue, options, rowObject) {
								var regExp = /^([\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?)$/;
								if(cellValue != null && cellValue != "" && cellValue != "undefined") {
									if(regExp.test(cellValue) == false) {
										messager.alert("숫자만 입력해주세요.", "info", "info");
										cellValue = "";
										return;
									} else {
										var size = $("#acctList").getDataIDs().length;
										var dup = 0;
										for(var intIndex = 0; intIndex < size; intIndex++) {
											var row = $("#acctList").getRowData(intIndex);
											if(row.acctNo == cellValue) {
												dup++;
											}
										}
										if(dup > 0) {
											messager.alert("중복된 계좌번호입니다.", "info", "info");
											cellValue = "";
											return;
										}
									}
									cellValue = cellValue.replaceAll("-", "").replace(regExp, "$1");
								} else {
									cellValue = "";
								}
								return cellValue;	
							} , required:true 
						}
						, {name:"acctOoa", label:'<spring:message code="column.acct_ooa" /> <span style="color:red;">*</span>', width:"150", align:"center", sortable:false, editable:true, required:true }
						, {name:"acctMemo", label:'<spring:message code="column.acct_memo" />', width:"150", align:"center", sortable:false, editable:true }
						, {name:"acctImgPath", label:'<spring:message code="column.acct_img_path" />', hidden:true }
						, {name:"acctImgPathTemp", label:'<spring:message code="column.acct_img_path" />', hidden:true}
						, {name:"acctImgPathView", label:'<spring:message code="column.acct_img_path" />', hidden:false, align:"center"
							, formatter : function(cellValue, options, rowObject) {
								var str = "";
								if(rowObject.acctImgPath != null && rowObject.acctImgPath != "") {
									str = '<img id="acctImgPathView' + options.rowId + '" src="${frame:imagePath("' + rowObject.acctImgPath + '") }" onerror="/images/noimage.png" style="width:40px; height:40px;" class="thumb" alt="" /> ';	
								} else {
									str = '<img id="acctImgPathView' + options.rowId + '" src="/images/noimage.png" style="width:40px; height:40px;" class="thumb" alt="" /> ';
								}
								return str;				
							}
						}
						, {name:"acctImgPathBtn", label:'<spring:message code="column.acct_img_path" />', width:"200", align:"center", sortable:false
							, formatter:function(cellValue, options, rowObject) {
								if('${adminSession.usrGrpCd}'!='10'){
									
									var str = "<button type='button' style='padding:5px 5px;' class='btn' onclick='companyImageLayerView(\"" + rowObject.acctImgPath + "\", \"acctImgPath\", \"계좌 이미지\", \"" + options.rowId + "\");'>확대</button>";
								}else{
									
									var str = '<button type="button" style="padding:5px 5px;" onclick="acctFileUpload(' + options.rowId + ');" class="btn">파일찾기</button>';
									str += "<button type='button' style='padding:5px 5px;' class='btn' onclick='companyImageLayerView(\"" + rowObject.acctImgPath + "\", \"acctImgPath\", \"계좌 이미지\", \"" + options.rowId + "\");'>확대</button>";
									str += "<button type='button' style='padding:5px 5px;' onclick='imageDelete(\"acctImg\", \"" + options.rowId + "\");' class='btn'>삭제</button>";
								}
								return str;
							}	
						}
					]
					, multiselect:'${adminSession.usrGrpCd}'!='10'? false:true
				};
				grid.create("acctList", options);
			}

			
			// 업체 계좌 그리드 로우 추가
			function compAccountAdd() {
				var rowId = $("#acctList").getGridParam("reccount") + 1;
				var arrData = { bankGbCd : "''" }
				
				$("#acctList ").jqGrid('addRowData', rowId, arrData, 'last', null);
			} 

			// 업체 계좌 그리드 로우 삭제
			function compAccountDel() {
				var rowids = $("#acctList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#acctList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("선택된 업체 계좌가 없습니다.", "Info", "info");
				}
			}
			
			function acctFileUpload(rowId) {
				acctGridRowId = rowId;
				fileUpload.image(resultAcctImage);
			}
			
			function resultAcctImage(file) {
				$("#acctList").jqGrid('setCell', acctGridRowId, 'acctImgPathTemp', file.filePath);
				$("#acctImgPathView" + acctGridRowId).attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}
			/*******************************************************************************************************************************************/
			/***************** 업체 담당자 *****************************************************************************************************************/
			/*******************************************************************************************************************************************/
		
				function changeRadioCheck(){
			 		var radioYnList =[]
					$("#chrgList").find("tr").each(function(idx){
						if(idx!=0){
							var $rdY  = $(this).find(".radioY").prop('checked');
							radioYnList.push($rdY)
						}
					})	
					return radioYnList;
				}
			
			function radio(value, options, rowObject){
				var cellHtml;
				 var y = '<span> <input type="radio" class="radioY" name="radio'+options.rowId+'" value="Y"';
				 var labelY = '   onclick="changeRadioCheck()" > 예 &nbsp';
				 var n = '<input type="radio" class="radioN" name="radio'+options.rowId+'" value="N"';
				 var labelN = '  onclick="changeRadioCheck()" > 아니오 </span>';
				 if(value=="Y"){
					cellHtml = y + 'checked=checked' + labelY + n + labelN;
					return cellHtml
				}else if(value=="N"){
					cellHtml = y + labelY + n +'checked=checked' +  labelN;
					return cellHtml
				}else{ 
					cellHtml = y + 'checked=checked' + labelY + n + labelN;
					return cellHtml;
				}	
		}
			
	
			
				
			// 업체 담당자 그리드 생성 
			function createChrgList () {
				var options = {
					url : "<spring:url value='/company/companyChrgListGrid.do' />"
					, searchParam : { compNo : "${companyBase.compNo}"}
					, paging : false
					, cellEdit : true
					, height : 100
					, colModels : [
						{name:"picTpCd", label:'<spring:message code="column.pic_tp_cd" />', width:"200", align:"center", sortable:false, editable:true, edittype:'select', formatter:"select"
							, editoptions:{value:"'':선택;<frame:gridSelect grpCd='${adminConstants.COMP_CHRG_TP }' showValue='false' />" }}
						, {name:"picDpm", label:'<spring:message code="column.pic_dpm" />', width:"150", align:"center", key: false, sortable:false, editable:true }
						, {name:"picNm", label:'<spring:message code="column.pic_nm" />', width:"150", align:"center", key: false, sortable:false, editable:true }
						, {name:"picTelno", label:'<spring:message code="column.pic_telno" />', width:"150", align:"center", sortable:false, editable:true
							, formatter:function(cellValue, options, rowObject) {
								var regExp = /^(\d{2,3})-?(\d{3,4})-?(\d{4})$/;
								return gridValueFormatter(cellValue, regExp, "전화번호", "tel");
							} 
						}
						, {name:"picMobile", label:'<spring:message code="column.pic_mobile" />', width:"150", align:"center", sortable:false, editable:true
							, formatter:function(cellValue, options, rowObject) {
								var regExp = /^(01[0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
								return gridValueFormatter(cellValue, regExp, "휴대폰", "tel");
							}	
						}
						, {name:"picEmail", label:'<spring:message code="column.pic_email" />', width:"200", align:"center", sortable:false, editable:true
							, formatter:function(cellValue, options, rowObject) {
								var regExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
								return gridValueFormatter(cellValue, regExp, "이메일", "email");
							}	 
						}
						, {name:"picMemo", label:'<spring:message code="column.pic_memo" />', width:"350", align:"center", sortable:false, editable:true }
						, {name:"picAlmRcvYn"
							, label:'주문내역수신여부' 
							, width:"250"
							, align:"center"
							, sortable: false
							,formatter:radio
							}	
					]
					,multiselect:'${adminSession.usrGrpCd}'!='10'? false:true
				}
				grid.create("chrgList", options);
			}
		
			 
			/* function test() {
				var edited = "0";
				var ind = jQuery("#chrgList").getInd(1,true);
				if(ind != false){
				    edited = $(ind).attr("editable");
				}

				if (edited === "1"){
				    alert("row is being edited");
				} else{
				    alert("row is not being edited");
				}
			} */

			// 그리드 전화번호, 휴대폰 형식체크, 이메일 형식체크
			function gridValueFormatter(cellValue, regExp, alertMsg, type) {
				if(cellValue != null && cellValue != "" && cellValue != "undefined") {
					if(regExp.test(cellValue) == false) {
						messager.alert(alertMsg + "형식이 아닙니다.", "info", "info");
						cellValue = "";
						return;
					}
					if(type == "tel") {
						cellValue = cellValue.replaceAll("-", "").replace(regExp, "$1-$2-$3");	
					}
				} else {
					cellValue = "";
				}
				return cellValue;	
			}
			
			// 업체 담당자 그리드 로우 추가
			function compChrgAdd() {
				var rowId = $("#chrgList").getGridParam("reccount") + 1;
				var arrData = { picTpCd : "''" }
				
				$("#chrgList").jqGrid('addRowData', rowId, arrData, 'last', null);
			} 

			// 업체 담당자 그리드 로우 삭제
			function compChrgDel() {
				var rowids = $("#chrgList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#chrgList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("선택된 업체 담당자가 없습니다.", "Info", "info");
				}
			}
			
			// 이미지 확대
			function companyImageLayerView(imgPath, tagId, title, rowid) {
				var originPath = "";
				var newPath = "";
				if(tagId.indexOf("biz") > -1) {
					if(imgPath == null || imgPath == "") {
						originPath = $("#bizLicImgPath").val();
						newPath = $("#bizLicImgPathTemp").val();
						
						imgPath = (newPath != null && newPath != "") ? newPath : originPath;
					}
				} else if(tagId.indexOf("acct") > -1) {
					var data = $("#acctList").getRowData(rowid);
					originPath = data.acctImgPath;
					newPath = data.acctImgPathTemp;
					
					imgPath = (newPath != null && newPath != "") ? newPath : originPath;
				}
				
				if(imgPath != "" && imgPath != null) {
					var options = {
						url : "<spring:url value='/company/companyImageLayerView.do' />"
						, data : { imgPath : imgPath }
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "companyImageLayerView"
								, width : 1000
								, height : 800
								, top : 200
								, title : title
								, body : data
							}
							layer.create(config);
						}
					}
					ajax.call(options );
				}
			}

			function resultImage(file) {
				$("#bizLicImgPathTemp").val(file.filePath);
				$("#bizLicImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}

			//이미지 삭제
			function imageDelete(strType, selectRowId){
				if(strType == "bizLicImg") {
					var imgPath = $("#bizLicImgPath").val();
					var imgTempPath = $("#bizLicImgPathTemp").val();	
				} else if(strType == "acctImg") {
					var row = $("#acctList").getRowData(selectRowId);
					var imgPath = row.acctImgPath;
					var imgTempPath = row.acctImgPathTemp;
				}
				var updateFlag = false;
				
				if(imgPath != "" && imgTempPath != "") {
					updateFlag = false;
					beforeImageDelete(strType);
					afterImageDelete(strType, updateFlag, selectRowId);
				} else if(imgPath != "") {
					updateFlag = true;
					afterImageDelete(strType, updateFlag, selectRowId);
				} else if(imgTempPath != "") {
					beforeImageDelete(strType,selectRowId);
				}
			}
			
			function beforeImageDelete(strType,selectRowId){
				if(strType == "bizLicImg") {
					var imgTempPath = $("#bizLicImgPathTemp").val();	
				} else if(strType == "acctImg") {
					var row = $("#acctList").getRowData(acctGridRowId);
					var imgTempPath = row.acctImgPathTemp;	
				}
				
				if (imgTempPath != '' && imgTempPath != null) {
					var options = {
						url : "<spring:url value='/company/beforeImageDelete.do' />"
						, data : { imgPath : imgTempPath }
						, callBack : function(data) {
							if(strType == "bizLicImg") {
								$("#bizLicImgPath").val("");
								$("#bizLicImgPathTemp").val("");
								$("#bizLicImgPathView").attr('src', "/images/noimage.png");
							} else if(strType == "acctImg") {
								$("#acctList").jqGrid('setCell', selectRowId, 'acctImgPathTemp', "");
								$("#acctImgPathView" + selectRowId).attr('src', '/images/noimage.png');
							}
						}
					}
					ajax.call(options);
				}
			}
			
			function afterImageDelete(strType, updateFlag, selectRowId) {
				if(strType == "bizLicImg") {
					var imgPath = $("#bizLicImgPath").val();
					var data = { compNo : "${companyBase.compNo}", bizLicImgPath : imgPath };
				} else if(strType == "acctImg") {
					var row = $("#acctList").getRowData(selectRowId);
					var imgPath = row.acctImgPath;
					var compAcctIsuNo = row.compAcctIsuNo;
					var data = { compAcctIsuNo : compAcctIsuNo, acctImgPath : imgPath };
				}
				
				if (imgPath != '' && imgPath != null) {
					var options = {
						url : "<spring:url value='/company/afterImageDelete.do' />"
						, data : data
						, callBack : function(data) {
							if(strType == "acctImg") {
								$("#acctList").jqGrid('setCell', acctGridRowId, 'acctImgPath', "");
							}
							if(updateFlag)	updateTab(); 
						}
					}
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<form name="companyViewForm" id="companyViewForm">
	 
		<input type="hidden" id="cisRegNo" name="cisRegNo" value="${companyBase.cisRegNo }" />
		<input type="hidden" id="upCompNo" name="upCompNo" value="${companyBase.upCompNo }"/>
		<div class="mTitle">
			<h2>업체 기본</h2>
		</div>

		<table class="table_type1">
			<caption>업체 기본</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<select id="stId" name="stId" <c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20 }">disabled</c:if>></select>
					</td>
                    <th><spring:message code="column.md_usr_no"/><strong class="red">*</strong></th> 
                    <td>
                       <input type="text" class="readonly validate[required]" name="mdUsrNm" id="mdUsrNm" value="${companyBase.mdUsrNm}" readonly="readonly" >
                       <input type="hidden" class="readonly" name="mdUsrNo" id="mdUsrNo" value="${companyBase.mdUsrNo}" readonly="readonly" >
                       <button type="button" class="btn" ${  adminConstants.USR_GRP_10 eq adminSession.usrGrpCd  ? 'onclick="fnCallbackMDUserPop();"' : 'style="display: none;"'}>담당 MD 검색</button>
                       <button type="button" class="btn" id="userDeleteBtn" style="display: none;"  ${ adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'onclick="fnUserDelete();"' : 'style="display: none;"'} >삭제</button>
                    </td>										
				</tr>
				<tr>
                    <th><spring:message code="column.comp_no"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 업체 번호-->
                        <input type="text" class="readonly" name="compNo" id="compNo" title="<spring:message code="column.comp_no"/>" value="${companyBase.compNo}" readonly="readonly" />
                        <c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20 and companyBase.compTpCd eq adminConstants.COMP_TP_20 }">
                        	<button type="button" class="btn" id="userDeleteBtn" onclick="fnCompUserLogin('${companyBase.compNo}')" >업체계정으로 로그인</button>
                        </c:if>
                    </td>				
					<th><spring:message code="column.comp_stat_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 상태 코드-->
						<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd"/>"  <c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20 }">disabled</c:if>>
							<frame:select grpCd="${adminConstants.COMP_STAT}" selectKey="${companyBase.compStatCd}"/>
						</select>
					</td>
				</tr>
                <tr>
                    <th><spring:message code="column.comp_gb_cd"/><strong class="red">*</strong></th>
                    <td id="compGbCdTd">
                        <!-- 업체 구분 코드-->                    
                        <frame:radio name="compGbCd" grpCd="${adminConstants.COMP_GB}" selectKey="${companyBase.compGbCd}" selectKeyOnly="true" required="true" />
                    </td>
                    <th id="compTpCdTh"><spring:message code="column.comp_tp_cd"/><strong class="red">*</strong></th>
                    <td id="compTpCdTd">
                        <!-- 업체 유형 코드-->
						<frame:radio name="compTpCd" grpCd="${adminConstants.COMP_TP}" selectKey="${companyBase.compTpCd}" required="true" selectKeyOnly="true"/>
                    </td>
                </tr>
				<tr>
                    <th><spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 업체 명-->
                        <input type="text" class="w200 validate[required]" name="compNm" id="compNm" title="<spring:message code="column.comp_nm"/>" value="${companyBase.compNm}" maxlength="100"/>
                    </td>				
					<th><spring:message code="column.tel"/><strong class="red">*</strong></th>
					<td>
						<!-- 전화-->
						<input type="text" class="w200 phoneNumber validate[required, custom[tel]]" name="tel" id="tel" title="<spring:message code="column.tel"/>" value="${companyBase.tel}" maxlength="20"/>
					</td>	
				</tr>
				<tr>
                    <th><spring:message code="column.ceo_nm"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 대표자 명-->
                        <input type="text" class="w200 validate[required]" name="ceoNm" id="ceoNm" title="<spring:message code="column.ceo_nm"/>" value="${companyBase.ceoNm}" maxlength="50"/>
                    </td>	
                    <th><spring:message code="column.fax"/></th>
                    <td>
                        <input type="text" class="w200 phoneNumber validate[custom[tel]]" name="fax" id="fax" title="<spring:message code="column.fax"/>" value="${companyBase.fax}" maxlength="20"/>
                    </td>		
				</tr>
				<tr>	
                    <th><spring:message code="column.biz_no"/><strong class="red">*</strong></th>
                    <td>
                        <input type="text" class="w200 validate[required, custom[bizNo]]" name="bizNo" id="bizNo" title="<spring:message code="column.biz_no"/>" value="${companyBase.bizNo}" maxlength="10"/>
                    </td>		
                    <th><spring:message code="column.biz_lic_img_path"/></th> 
                    <td>
                    	<input type="hidden" id="bizLicImgPathTemp" name="bizLicImgPathTemp" />
                    	<input type="hidden" id="bizLicImgPath" name="bizLicImgPath" value="${companyBase.bizLicImgPath }" />
                    	<c:choose>
                    		<c:when test="${not empty companyBase.bizLicImgPath }">
                    			<img id="bizLicImgPathView" name="bizLicImgPathView" src="${frame:imagePath(companyBase.bizLicImgPath) }" onerror="/images/noimage.png" class="thumb" alt="" />
                    		</c:when>
                    		<c:otherwise>
                    			<img id="bizLicImgPathView" name="bizLicImgPathView" src="/images/noimage.png" class="thumb" alt="" />
                    		</c:otherwise>
                    	</c:choose>
                    	
                    	<button type="button" class="btn" onclick="fileUpload.image(resultImage);">파일찾기</button>
                    	<button type="button" class="btn" onclick="companyImageLayerView('', 'bizLicImgPath', '사업자 등록증');">확대</button>
                    	<button type="button" class="btn" onclick="imageDelete('bizLicImg');">삭제</button>
                    </td>	
				</tr>
				<tr>
					<th><spring:message code="column.biz_cdts"/></th>
					<td>
						<input type="text" class="w200" name="bizCdts" id="bizCdts" title="<spring:message code="column.biz_cdts"/>" value="${companyBase.bizCdts}" maxlength="100"/>
					</td>
                    <th><spring:message code="column.biz_tp"/></th>
                    <td>
                        <input type="text" class="w200" name="bizTp" id="bizTp" title="<spring:message code="column.biz_tp"/>" value="${companyBase.bizTp}" maxlength="100"/>
                    </td>					
				</tr>      
                <tr>
                    <th><spring:message code="column.common.post"/><strong class="red">*</strong></th>
                    <td>
                        <input type="hidden" name="postNoOld" id="postNoOld" title="<spring:message code="column.post_no_old"/>" value="${companyBase.postNoOld}" />
                        <input type="hidden" name="prclAddr" id="prclAddr" title="<spring:message code="column.prcl_addr"/>" value="${companyBase.prclAddr}" />
                        <div class="mg5">
                            <input type="text" class="readonly validate[required]" name="postNoNew" id="postNoNew" title="<spring:message code="column.post_no_new"/>" value="${companyBase.postNoNew}" readonly="readonly" />
                            <button type="button" onclick="layer.post(comapnyPost);" class="btn"><spring:message code="column.common.post.btn"/></button>
                        </div>
                        <div class="mg5">
                            <input type="text" class="readonly w300 validate[required]" name="roadAddr" id="roadAddr" title="<spring:message code="column.road_addr"/>" value="${companyBase.roadAddr}" readonly="readonly" />
                            <input type="text" class="w200 validate[required]" name="roadDtlAddr" id="roadDtlAddr" title="<spring:message code="column.road_dtl_addr"/>" value="${companyBase.roadDtlAddr}" maxlength="100"/>
                        </div>                        
                    </td>
                    <th><spring:message code="column.dlgt_email" /><strong class="red">*</strong></th> 
                    <td>
                    	<input type="text" class="w200 validate[required, custom[email2]]" name="dlgtEmail" id="dlgtEmail" value="${companyBase.dlgtEmail}" title="<spring:message code="column.dlgt_email" />" placeholder="대표 이메일을 입력하세요" maxlength="100"/>
                    </td>                  
                </tr>
                <tr>
                	<th><spring:message code="column.bigo"/></th>
                    <td id="bigoTd">
                        <input type="text" class="w200" name="bigo" id="bigo" title="<spring:message code="column.bigo"/>" value="${companyBase.bigo}" maxlength="1000"/>
                    </td>
                    <th id="cclTermCdTh"><spring:message code="column.comp_ccl_term_cd"/><strong class="red">*</strong></th>
                    <td id="cclTermCdTd">
                    	<select id="cclTermCd" name="cclTermCd" <c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20 }">disabled</c:if>>
                        	<frame:select grpCd="${adminConstants.CCL_TERM}" selectKey="${companyBase.cclTermCd }" />
                        </select>
                    </td>
                </tr>
                <tr>
               		<c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20}" >	
	                	<th><spring:message code="column.biz.incm_read_tm"/></th>
	                	<td>
	                		<input type="text" class="w200" name="incmReadTm" id="incmReadTm" value="${companyBase.incmReadTm}" title="<spring:message code="column.biz.incm_read_tm"/>" maxlength="2" numberOnly/>	                		
	                	</td>
                	</c:if>	
                	<th><spring:message code="column.ord_alm_time"/></th>
                    <td <c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}" >colspan="3" </c:if>>
                    	<input type="hidden" id="ordCletCharAlmCd" name="ordCletCharAlmCd" />
                    	<frame:checkbox name="ordCletCharAlms" grpCd="${adminConstants.ORD_CLET_CHAR_ALM }" checkedArray="${companyBase.ordCletCharAlmCd }" />
                    </td>
                	<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}" > 
                		<input type="hidden" name="incmReadTm" id="incmReadTm" value="${companyBase.incmReadTm}" />
                	</c:if>
                </tr>
                <tr>
                	<th><spring:message code="column.cis_reg_yn"/></th>
                	<td colspan="3">
                		<frame:codeName grpCd="${adminConstants.CIS_REG_YN }" dtlCd="${companyBase.cisRegYn }" />                		
                	</td>                
                </tr>                
			</tbody>
		</table>
		
		<div id="compAccountArea">
			<div class="mTitle mt30">
				<h2>업체 계좌<strong class="red">*</strong> &nbsp;&nbsp; <span style="color: red;font-weight: normal;font-size: 12px;">*계좌입력시 숫자만 입력해 주세요</span></h2> 
				<c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20 and companyBase.compTpCd eq adminConstants.COMP_TP_20 }">
					<div class="buttonArea">
						<button type="button" id="addCompAccountBtn" onclick="compAccountAdd();" class="btn btn-add"><spring:message code="column.common.addition" /></button>
						<button type="button" onclick="compAccountDel();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
					</div>
				</c:if>
			</div>
			<div class="mModule" style="margin-top:0">
				<table id="acctList" class="grid"></table>
				<div id="acctListPage"></div>
			</div>
		</div>
		
		<div id="compChrgArea">
			<div class="mTitle mt30">
				<h2>업체 담당자</h2>
				<div class="buttonArea">
					<button type="button" id="addCompChrgBtn" onclick="compChrgAdd();" class="btn btn-add"><spring:message code="column.common.addition" /></button>
					<c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20 and companyBase.compTpCd eq adminConstants.COMP_TP_20 }">
						<button type="button" onclick="compChrgDel();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
					</c:if>
				</div>
			</div>
			<div class="mModule" style="margin-top:0">
				<table id="chrgList" class="grid"></table>
				<div id="chrgListPage"></div>
			</div>
		</div>

<c:if test="${companyBase.compTpCd ne adminConstants.COMP_TP_30 }">
		<div class="mTitle mt30">
			<h2>브랜드<strong class="red">*</strong></h2>
<%-- <c:if test="${USR_GRP_10}">
			<div class="buttonArea">
				<button type="button" onclick="brandAddPop();return false;" id="addBrandBtn" class="btn btn-add"><spring:message code="column.common.addition" /></button>
				<button type="button" onclick="brandDel();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
			</div>
</c:if> --%>
		</div>

		<div class="mModule" style="margin-top:0">
			<table id="brandList" class="grid"></table>
			<div id="brandListPage"></div>
		</div>
</c:if>		

<%-- 업체 유형이 '매입'이 아닌경우만 노출 --%>
<c:if test="${companyBase.compTpCd ne adminConstants.COMP_TP_30 }">
		<div class="mTitle mt30">
			<h2>업체 배송정책</h2>
			<%-- 업체 유형이 '위탁'인 경우만 노출 --%>
			<c:if test="${companyBase.compTpCd eq adminConstants.COMP_TP_20 }">
				<div class="buttonArea">
					<button type="button" onclick="addCompanyDeliveryPolicy();" class="btn btn-add">등록</button>
				</div>
			</c:if>
		</div>
		<div class="mModule" style="margin-top:0">
			<table id="companyDeliveryList" class="grid"></table>
		</div>
</c:if>		
		</form>

		<div class="btn_area_center">
		    <button type="button" onclick="companyUpdate();" class="btn btn-ok">수정</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">목록</button>
		</div>

	</t:putAttribute>
</t:insertDefinition>
