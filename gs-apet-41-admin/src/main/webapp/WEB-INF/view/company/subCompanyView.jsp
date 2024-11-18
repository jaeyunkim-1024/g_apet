<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){

                //compGbCdShow("${companyBase.compGbCd}");
                $("input[name=compGbCd]").change(function() {
                    compGbCdShow($(this).val());
                });

				// 사업자 번호 마스킹 처리
				$("#bizNo").mask("000-00-00000");

				createCompanyDeliveryGrid();

				createBrandList ();

				createDispCtgList ();
				// 사이트 select 생성
				createStStdInfoSelect();
			});

			// hjko 추가
			$(function(){
				// 사이트 클릭시 전시카테고리 제어
				$("input[name=stId]").click(function(){
					
				    if($(this).is(':checked')){
				    	 var selVal = $(this).val();
				    	 $("select[name='selectStId']").find("option[value="+selVal+"]").prop("disabled", false);
				    }else{
				    	var notSelVal = $(this).val();  // 체크 되지 않은 사이트
				    	var selectStVal = $("#selectStId").val();
				    	$("select[name='selectStId']").find("option[value="+notSelVal+"]").prop("disabled", true);
				    	
				    	//선택된 사이트가 체크 해제된 경우
				    	if(notSelVal == selectStVal){
				    		$("#selectStId").val('');
				    	}
				    }
		
				});
			});

			function compGbCdShow(val) {
				if (val == "${adminConstants.COMP_GB_10}" ) {
					$("#compGbCdTd").attr('colspan', 3);
					$("#compTpCdTh").hide();
					$("#compTpCdTd").hide();
				} else {
					$("#compGbCdTd").removeAttr('colspan');
					$("#compTpCdTh").show();
					$("#compTpCdTd").show();
				}
			}

			// 사이트 select 생성
			function createStStdInfoSelect() {
				// hjko 추가
				var siteids = new Array();

				$("input[name='stId']:checked").each(function(index, ob){
					siteids.push($(this).val());
				});
				
				var options = {
					url : "<spring:url value='/st/stList.do' />"
					, callBack : function(result) {
						var rows = result.rows;
						var selectStId = "<option value=''>사이트선택</option>";
						
						jQuery(rows).each(function(i){
							var disabled = false;
							if($.inArray(rows[i].stId.toString() ,siteids) == -1){ // 없으면
								disabled = true;
							}
							
							if(siteids.length >0){
								selectStId += "<option value= '" + rows[i].stId + "'";
								if(disabled){
									selectStId += "disabled='disabled'";
								}
								selectStId += ">" + rows[i].stNm + "</option>";
							}else{
								<c:if test= '${empty companyBase.compNo }'>
								selectStId += "<option value='" + rows[i].stId + "'>" + rows[i].stNm + "</option>";
								</c:if>
							}
	                    });
						jQuery("#selectStId").append(selectStId);
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
				var chkStCnt = $("input[name='stId']:checked").length;
				if(chkStCnt ==0){
					messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
					return false;
				}
				
				if(validate.check("companyViewForm")) {
					if (!checkGridDataExists()) {
						return;
					}
					$("input[name=stId]").each(function(index,obj){
						$("input[name='stId']").removeAttr("disabled");
					});

					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
		                if (r){
		                	var sendData = $("#companyViewForm").serialize();
							var dispCtgList = grid.jsonData ("dispCtgList" );
							var brandList = grid.jsonData("brandList");
							sendData += "&displayCategoryPO=" + JSON.stringify(dispCtgList);
							sendData += "&companyBrandPO=" + JSON.stringify(brandList);

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

				$("input[name=dlvrcCdtStdCd]").prop("disabled", false);
				$("input[name=dlvrcCdtStdCd]").prop("checked", false);

				dlvrcCdtStdCdView('');
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
						, {name:"dlvrcPlcNo", label:'<spring:message code="column.dlvrc_plc_no" />', width:"100", align:"center", formatter:'integer'}
						, {name:"plcNm", label:'<b><u><tt><spring:message code="column.plc_nm" /></tt></u></b>', width:"200", align:"center", classes:'pointer fontbold'}
                        // 배송비 정책번호 일괄 변경
                        , {name:"button", label:'배송정책변경', width:"90", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
                            var str = '<button type="button" onclick="fnDlvrcPlcNoChg(\'' + rawObject.compNo + '\',\'' + rawObject.dlvrcPlcNo + '\')" class="btn_h25_type1">일괄 변경</button>';
                            if (rawObject.delYn =='N'){
                                return str; 
                            }else{
                                return '';
                            }
                        }}
						, {name:"dftHdcCd", label:'<spring:message code="column.dft_hdc_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.HDC}"/>"}}
						, {name:"rtnaPostNoNew", label:'<spring:message code="column.rtna_post_no_new" />', width:"120", align:"center"}
						, {name:"rtnaRoadAddr", label:'<spring:message code="column.rtna_road_addr" />', width:"300", align:"center"}
						, {name:"rtnaRoadDtlAddr", label:'<spring:message code="column.rtna_road_dtl_addr" />', width:"200", align:"center"}
						, {name:"rlsaPostNoNew", label:'<spring:message code="column.rlsa_post_no_new" />', width:"120", align:"center"}
						, {name:"rlsaRoadAddr", label:'<spring:message code="column.rlsa_road_addr" />', width:"300", align:"center"}
						, {name:"rlsaRoadDtlAddr", label:'<spring:message code="column.rlsa_road_dtl_addr" />', width:"200", align:"center"}
						, {name:"etcInfo", label:'<spring:message code="column.etc_info" />', width:"200", align:"center"}
						, {name:"etcInfo2", label:'<spring:message code="column.etc_info2" />', width:"200", align:"center"}
						, {name:"rtnExcMan", label:'<spring:message code="column.rtn_exc_man" />', width:"200", align:"center"}
						, {name:"rtnExcTel", label:'<spring:message code="column.rtn_exc_tel" />', width:"200", align:"center"}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"150", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"150", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
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

			// 전시 카테고리
			function createDispCtgList () {
				 var compNo = '${companyBase.compNo}'

				if (compNo == "") {
					compNo = 0;
				}

				var options = {
					url : "<spring:url value='/company/compDispMapListGrid.do' />"
					, searchParam : { compNo : compNo }
					, paging : false
					, cellEdit : true
					, height : 150
					, colModels : [
						{name:"stNm", label:"<spring:message code='column.st_nm' />", width:"200", align:"center", sortable:false } /* 사이트 명 */
						, {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", key: true, sortable:false } /* 전시분류 번호 */
						, {name:"dispClsfNm", label:'<spring:message code="column.disp_clsf_nm" />', width:"150", align:"center", sortable:false } /* 전시분류 명 */
						, {name:"ctgPath", label:'<spring:message code="column.display.disp_clsf.path" />', width:"300", align:"center", sortable:false } /* 대분류 */
						, {name:"goodsId", label:'', width:"100", align:"center", hidden:true, sortable:false } /* 전시분류 번호 */
						, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true} /* 사이트 ID */
					]
					, multiselect : true
				};
				grid.create("dispCtgList", options);
			}

			// 업체 등록시  => 체크박스 사이트 아이디와 셀렉트 박스 사이트 아이디 비교. hjko
			function compareStIdComboStId(){
				// 체크 선택된 사이트배열 선언
				var sa = new Array();
				if($("input[name='stId']:checked").length == 0){
					return false;
				}else{
					$("input[name='stId']:checked").each(function(index, ob){
						sa.push($(this).val());
					});
					var t = $("#selectStId option:selected").val();

					if($.inArray(t,sa) != -1){ // 있으면
						return true;
					}else{
						return false;
					}
				}
			}

			// 전시카테고리 추가
			function displayCategoryAddPop() {
				
				// 상위업체 번호를 선택하지 않았을 때
                if ($("#upCompNm").val() == '' || $("#upCompNo").val() == '') {
                	messager.alert("<spring:message code='admin.web.view.msg.sub_company.up_company.select_invalid'/>", "Info", "info", function(){
                		$("#upCompNm").focus();
                	});
                    return false;
                }
				
				if(!compareStIdComboStId()){
					if($("input[name='stId']:checked").length == 0){
						messager.alert("<spring:message code='admin.web.view.msg.company.display.select_invalid'/>", "Info", "info");
					}else{
						messager.alert("<spring:message code='admin.web.view.msg.company.display.compare_invalid'/>", "Info", "info", function(){
							$("#selectStId").focus();
						});
					}
					return false;
				}

				var options = {
					compNo : $("#upCompNo").val()
					//, multiselect : true
					//, filterGb : "G"
					//, stId : $("#selectStId option:selected").val()
					//, dispClsfCd : "${adminConstants.DISP_CLSF_10}"
					//, plugins : [ "themes" , "checkbox" ]
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var idx = $('#dispCtgList').getDataIDs();
							var message = new Array();
							for(var i in result){
								var addData = {
									  dispClsfNo : result[i].dispClsfNo
									, dispClsfNm : result[i].dispClsfNm
									, ctgPath : result[i].ctgPath
									, stId : result[i].stId
									, stNm : result[i].stNm
								}
								var check = true;
								for(var j in idx) {
									if(addData.dispClsfNo == idx[j]) {
										check = false;
										break;
									}
								}

								if(check) {
									$("#dispCtgList").jqGrid('addRowData', result[i].dispClsfNo, addData, 'last', null);
								} else {
									message.push(result[i].dispClsfNm + " 중복된 카테고리 입니다.");
								}
							}
							if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"), "Info", "info");
							}
						}
					}
				}

				layerCompanyCategoryList.create(options);
			}

			// 전시카테고리 삭제
			function displayCategoryDelDisp() {
				var rowids = $("#dispCtgList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#dispCtgList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.company.display.delete_invalid'/>", "Info", "info");
				}
			}

			function checkGridDataExists() {
				if ( grid.jsonData ("brandList" ).length == 0) {
					messager.alert("<spring:message code='admin.web.view.msg.company.brand.empty'/>", "Info", "info", function(){
						$("#addBrandBtn").focus();
					});
					return false;
				}else if (grid.jsonData ("dispCtgList" ).length == 0 ){
					messager.alert("<spring:message code='admin.web.view.msg.company.display.empty'/>", "Info", "info", function(){
						$("#addCategoryBtn").focus();
					});
					return false;
				}
				return true;
			}

			// 브랜드 grid 생성
			function createBrandList () {
				 var compNo = '${companyBase.compNo}'

				if (compNo == "") {
					compNo = 0;
				}

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
	                                                    	   	messager.alert("<spring:message code='admin.web.view.msg.company.brand.one_invalid'/>", "Info", "info");
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
				
				// 상위업체 번호를 선택하지 않았을 때
				if ($("#upCompNm").val() == '' || $("#upCompNo").val() == '') {
					messager.alert("<spring:message code='admin.web.view.msg.sub_company.up_company.select_invalid'/>", "Info", "info", function(){
						$("#upCompNm").focus();
					});
				    return false;
				}
				
				var options = null;
				options = {
					multiselect : true
					, plugins : [ "themes" , "checkbox" ]
					, compNo : $("#upCompNo").val()
					, compNm : $("#upCompNm").val()
					, callBack : function(result){
						if(result != null && result.length > 0) {
							var idx = $('#brandList').getDataIDs();
							var message = new Array();
							for(var i in result){
								var addData = {
									  bndNo : result[i].bndNo
									, bndNmKo : result[i].bndNmKo
									, bndNmEn : result[i].bndNmEn
									, useYn : result[i].useYn
								}

								var check = true;
								for(var j in idx) {
									if(addData.bndNo == idx[j]) {
										check = false;
									}
								}

								if(check) {
									$("#brandList").jqGrid('addRowData', result[i].bndNo, addData, 'last', null);
								} else {
									message.push(result[i].bndNmKo + " 중복된 브랜드 입니다.");
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

			/* 상위 업체 검색 */
			function searchCompany() {
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
				}

				companyMgtLayerCompanyList.create(options);
			}
			function searchCompanyCallback (compList ) {
				if(compList.length > 0 ) {
					$("#upCompNo").val (compList[0].compNo );
					$("#upCompNm").val (compList[0].compNm );
				}

				// 사이트목록 있는거 체크하기. hjko추가
				$("input[name='stId']").prop('checked',false);
				$("input[name=stId]").each(function(index,obj){
					$("input[name='stId']").prop("disabled",true);
				});
				searchCompStList($("#upCompNo").val());

			}
			// 상위 업체의 사이트 목록 조회
			function searchCompStList(upCompNo){
				var sendData = upCompNo;
					var options = {
						url : "<spring:url value='/company/getUpperCompStList.do' />"
						, data : {
							upCompNo : upCompNo
						}
						, callBack : function(data){
							console.debug(data );

							var stIdList = data.compStList;

							for(var i=0; i< stIdList.length; i++){
								$("input[name='stId'][value="+stIdList[i].stId+"]").prop("checked",true);
								$("input[name='stId'][value="+stIdList[i].stId+"]").prop("disabled",false);

							}

						}
					};

					ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

	<form name="companyViewForm" id="companyViewForm">

		<div class="mTitle">
			<h2>하위 업체 기본</h2>
		</div>

		<table class="table_type1">
			<caption>하위 업체 기본</caption>
			<tbody>
<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<frame:stIdCheckbox selectKey="${companyBase.stStdList}" compNo="${companyBase.upCompNo}" disabled="true" required="true"/>
					</td>
					<th><spring:message code="column.upComp"/><strong class="red">*</strong></th>
					<td><!-- 상위 업체 번호-->
						<input type="text" class="readonly" name="upCompNm" id="upCompNm" title="<spring:message code="column.comp_no"/>" value="${companyBase.upCompNm}" readonly="readonly" />
						(${companyBase.upCompNo})
						<input type="hidden" id="upCompNo" name="upCompNo" value="${companyBase.upCompNo}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.comp_no"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 번호-->
						<input type="text" class="readonly" name="compNo" id="compNo" title="<spring:message code="column.comp_no"/>" value="${companyBase.compNo}" readonly="readonly" />
					</td>
					<th><spring:message code="column.comp_stat_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 상태 코드-->
						<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd"/>">
							<frame:select grpCd="${adminConstants.COMP_STAT}" selectKey="${companyBase.compStatCd}"/>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.comp_gb_cd"/><strong class="red">*</strong></th>
					<td id="compGbCdTd">
						<!-- 업체 구분 코드 : 외부업체-->
						<frame:radio name="compGbCd" grpCd="${adminConstants.COMP_GB}" selectKey="${companyBase.compGbCd}" selectKeyOnly="true" required="true"/>
					</td>
					<th id="compTpCdTh"><spring:message code="column.comp_tp_cd"/><strong class="red">*</strong></th>
					<td id="compTpCdTd">
						<!-- 업체 유형 코드: 입점-->
						<frame:radio name="compTpCd" grpCd="${adminConstants.COMP_TP}" selectKey="${companyBase.compTpCd}" selectKeyOnly="true" required="true"/>
					</td>
				</tr>
</c:if>
<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}" >
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<frame:stIdCheckbox selectKey="${companyBase.stStdList}" compNo="${companyBase.upCompNo}" disabled="false"/>
					</td>
					<th><spring:message code="column.upComp_no"/><strong class="red">*</strong></th>
					<td><!-- 상위 업체 번호-->
						<input type="text" class="readonly" name="upCompNm" id="upCompNm" title="<spring:message code="column.comp_no"/>" value="${companyBase.upCompNm}" readonly="readonly" />
						<input type="hidden" id="upCompNo" name="upCompNo" value="${companyBase.upCompNo}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.comp_no"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 번호-->
						<input type="text" class="readonly" name="compNo" id="compNo" title="<spring:message code="column.comp_no"/>" value="${companyBase.compNo}" readonly="readonly" />
					</td>
					<th><spring:message code="column.comp_stat_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 상태 코드-->
						<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd"/>">
							<frame:select grpCd="${adminConstants.COMP_STAT}" selectKey="${companyBase.compStatCd}"/>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.comp_gb_cd"/><strong class="red">*</strong></th>
					<td id="compGbCdTd">
						<!-- 업체 구분 코드 : 외부업체-->
						<frame:radio name="compGbCd" grpCd="${adminConstants.COMP_GB}" selectKey="${companyBase.compGbCd}" selectKeyOnly="true" required="true"/>
					</td>
					<th id="compTpCdTh"><spring:message code="column.comp_tp_cd"/><strong class="red">*</strong></th>
					<td id="compTpCdTd">
						<!-- 업체 유형 코드: 입점-->
						<frame:radio name="compTpCd" grpCd="${adminConstants.COMP_TP}" selectKey="${companyBase.compTpCd}" selectKeyOnly="true" required="true"/>
					</td>
				</tr>
</c:if>

				<tr>
					<th><spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 명-->
						<input type="text" class="w200 validate[required]" name="compNm" id="compNm" title="<spring:message code="column.comp_nm"/>" value="${companyBase.compNm}" maxlength="100"/>
					</td>
                    <th><spring:message code="column.biz_no"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 사업자 번호 -->
                        <input type="text" class="w200 validate[custom[bizNo]]" name="bizNo" id="bizNo" title="<spring:message code="column.biz_no"/>" value="${companyBase.bizNo}" maxlength="10"/>
                    </td>   					
				</tr>
				<tr>
				    <th><spring:message code="column.ceo_nm"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 대표자 명-->
                        <input type="text" class="w200 validate[required]" name="ceoNm" id="ceoNm" title="<spring:message code="column.ceo_nm"/>" value="${companyBase.ceoNm}" maxlength="50"/>
                    </td>
					<th><spring:message code="column.tel"/><strong class="red">*</strong></th>
					<td>
						<!-- 전화-->
						<input type="text" class="w200 phoneNumber validate[required, custom[tel]]" name="tel" id="tel" title="<spring:message code="column.tel"/>" value="${companyBase.tel}" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.bank_cd"/></th>
					<td>
						<select class="w193" name="bankCd" id="bankCd" title="<spring:message code="column.bank_cd"/>">
							<frame:select grpCd="${adminConstants.BANK}" selectKey="${companyBase.bankCd}" defaultName="선택"/>
						</select>
					</td>
                    <th><spring:message code="column.fax"/></th>
                    <td>
                        <input type="text" class="w200 phoneNumber validate[custom[tel]]" name="fax" id="fax" title="<spring:message code="column.fax"/>" value="${companyBase.fax}" maxlength="20"/>
                    </td>					
				</tr>
				<tr>
					<th><spring:message code="column.acct_no"/></th>
					<td>
						<input type="text" class="w200 numeric validate[custom[number]]" name="acctNo" id="acctNo" title="<spring:message code="column.acct_no"/>" value="${companyBase.acctNo}" maxlength="50"/>
						<label class="red-desc"> * 계좌입력시 숫자만 입력해 주세요 </label>
					</td>
					<th><spring:message code="column.ooa_nm"/></th>
                    <td>
                        <input type="text" class="w200" name="ooaNm" id="ooaNm" title="<spring:message code="column.ooa_nm"/>" value="${companyBase.ooaNm}" maxlength="50"/>
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
					<th><spring:message code="column.common.post"/></th>
					<td>
						<input type="hidden" name="postNoOld" id="postNoOld" title="<spring:message code="column.post_no_old"/>" value="${companyBase.postNoOld}" />
						<input type="hidden" name="prclAddr" id="prclAddr" title="<spring:message code="column.prcl_addr"/>" value="${companyBase.prclAddr}" />
						<div class="mg5">
							<input type="text" class="readonly" name="postNoNew" id="postNoNew" title="<spring:message code="column.post_no_new"/>" value="${companyBase.postNoNew}" readonly="readonly" />
							<button type="button" onclick="layer.post(comapnyPost);" class="btn"><spring:message code="column.common.post.btn"/></button>
						</div>
						<div class="mg5">
							<input type="text" class="readonly w300" name="roadAddr" id="roadAddr" title="<spring:message code="column.road_addr"/>" value="${companyBase.roadAddr}" readonly="readonly" />
							<input type="text" class="w200" name="roadDtlAddr" id="roadDtlAddr" title="<spring:message code="column.road_dtl_addr"/>" value="${companyBase.roadDtlAddr}" maxlength="100"/>
						</div>
					</td>
                    <th><spring:message code="column.dlgt_email" /><strong class="red">*</strong></th> 
                    <td>
                    	<input type="text" class="w200 validate[required, custom[email]]" name="dlgtEmail" id="dlgtEmail" value="${companyBase.dlgtEmail}" title="<spring:message code="column.dlgt_email" />" placeholder="대표 이메일을 입력하세요" maxlength="100"/>
                    </td>					
				</tr>
				 <tr>
                    <th><spring:message code="column.comp_cs_chrg_nm"/></th> 
                    <td>
                             <input type="text" class="w200" name="csChrgNm" id="csChrgNm" value="${companyBase.csChrgNm}" placeholder="CS 담당자 이름을 입력하세요" maxlength="50"/>
                             <input type="text" class="w190 phoneNumber validate[custom[tel]]" name="csChrgTel" id="csChrgTel" value="${companyBase.csChrgTel}" placeholder="CS 담당자 연락처를 입력하세요" maxlength="20"/>
                    </td>
                    <th><spring:message code="column.comp_stl_chrg_nm"/></th> 
                    <td>
                             <input type="text" class="w200" name="stlChrgNm" id="stlChrgNm" value="${companyBase.stlChrgNm}" placeholder="정산 담당자 이름을 입력하세요" maxlength="50"/>
                             <input type="text" class="w190 phoneNumber validate[custom[tel]]" name="stlChrgTel" id="stlChrgTel" value="${companyBase.stlChrgTel}" placeholder="정산 담당자 연락처를 입력하세요" maxlength="20"/>
                    </td>
                </tr>
                <tr>
                	<th><spring:message code="column.bigo"/></th>
                    <td colspan="3">
                        <input type="text" class="w450" name="bigo" id="bigo" title="<spring:message code="column.bigo"/>" value="${companyBase.bigo}" maxlength="1000"/>
                    </td>  
                </tr>	
			</tbody>
		</table>


		<div class="mTitle mt30">
			<h2>브랜드<strong class="red">*</strong></h2>
<c:if test="${! USR_GB_2020}">
			<div class="buttonArea">
				<button type="button" onclick="brandAddPop();return false;" id="addBrandBtn" class="btn btn-add"><spring:message code="column.common.addition" /></button>
				<button type="button" onclick="brandDel();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
			</div>
</c:if>
		</div>
		<div class="mModule" style="margin-top:0">
			<table id="brandList"></table>
			<div id="brandListPage"></div>
		</div>

		<div class="mTitle mt30"> 
			<h2>전시 카테고리<strong class="red">*</strong></h2>
<c:if test="${! USR_GB_2020}">
			<div class="buttonArea">
				<c:if test="${adminConstants.USR_GB_2020 ne adminSession.usrGbCd}" >
				<select name="selectStId" id="selectStId" title="사이트 조건" >
				</select>
				</c:if>

				<button type="button" id="addCategoryBtn" onclick="displayCategoryAddPop();" class="btn btn-add" id="dispAdd"><spring:message code="column.common.addition" /></button>
				<button type="button" onclick="displayCategoryDelDisp();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
			</div>
</c:if>
		</div>
		<div class="mModule" style="margin-top:0">
			<table id="dispCtgList" class="grid"></table>
			<div id="dispCtgListPage"></div>
		</div>

		<div class="mTitle mt30">
			<h2>업체 배송정책</h2>
			<div class="buttonArea">
				<button type="button" onclick="addCompanyDeliveryPolicy();" class="btn btn-add">등록</button>
			</div>
		</div>
		<div class="mModule" style="margin-top:0">
			<table id="companyDeliveryList"></table>
		</div>

		</form>

		<div class="btn_area_center">
			<button type="button" onclick="companyUpdate();" class="btn btn-ok">수정</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>

	</t:putAttribute>
</t:insertDefinition>