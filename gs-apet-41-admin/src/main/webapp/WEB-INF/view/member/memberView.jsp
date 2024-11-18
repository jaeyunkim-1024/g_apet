<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var bigo = 1;
			$(document).ready(function(){
				//createMemberSavedMoneyGrid();
				//createMemberAddressGrid();

				csMemberSavedMoneyHist();
				csMemberCouponPossibleListGrid();
				csMemberCouponCompletionListGrid();

				//회원이력정보
				fnMemberBaseHistoryListGrid();
				
				fnAddDate(12);
			});

			function createMemberSavedMoneyGrid(){
				var options = {
					url : "<spring:url value='/member/memberSavedMoneyListGrid.do' />"
					, height : 300
					, searchParam : { mbrNo : '${member.mbrNo }' }
					, colModels : [
						//적립금 순번
						{name:"svmnSeq", label:'<spring:message code="column.svmn_seq" />', width:"90", align:"center", key: true}
						//적립금 사유 코드
						, {name:"svmnRsnCd", label:'<spring:message code="column.svmn_rsn_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_RSN}" />"}}
						//기타 사유
						, {name:"etcRsn", label:'<spring:message code="column.etc_rsn" />', width:"250", align:"center"}
						//적립 금액
						, {name:"saveAmt", label:'<spring:message code="column.save_amt" />', width:"150", align:"center", formatter:'integer'}
						//잔여 금액
						, {name:"rmnAmt", label:'<spring:message code="column.rmn_amt" />', width:"150", align:"center", formatter:'integer'}
						//유효 일시
						, {name:"vldDtm", label:'<spring:message code="column.vld_dtm" />', width:"170", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//주문 번호
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"150", align:"center"}
						//상품 평가 번호
						, {name:"goodsEstmNo", label:'<spring:message code="column.goods_estm_no" />', width:"150", align:"center"}
						, {name:"detailCnt", hidden:true }
					]
					, subGridRowExpanded : createMemberSavedMoneyDetailGrid
					, isHasSubGrid : function(rowid) {
						var rowdata = $("#memberSavedMoneyList").getRowData(rowid);
						if(rowdata.detailCnt > 0) {
							return true;
						} else {
							return false;
						}
					}
				};
				subGrid.create("memberSavedMoneyList", options);
			}

			function createMemberSavedMoneyDetailGrid(parentRowID, parentRowKey ) {
				var childGridID = parentRowID + "Sub";
				var childGridPagerID = childGridID + "Page";
				$('#' + parentRowID).append('<table id="' + childGridID + '"></table><div id="' + childGridPagerID + '"></div>');

				var options = {
					url : "<spring:url value='/member/memberSavedMoneyDetailListGrid.do' />"
					, paging : false
					, height : 150
					, searchParam : {
						svmnSeq : parentRowKey
						, mbrNo : '${member.mbrNo }'
					}
					, colModels : [
						// 적립금 순번
						{name:"svmnSeq", label:'<spring:message code="column.svmn_seq" />', width:"150", align:"center"}
						// 이력 순번
						, {name:"histSeq", label:'<spring:message code="column.hist_seq" />', width:"150", align:"center"}
						// 적립금 처리 코드
						, {name:"svmnPrcsCd", label:'<spring:message code="column.svmn_prcs_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_PRCS}" />"}}
						// 처리 일시
						, {name:"prcsDtm", label:'<spring:message code="column.prcs_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 처리 금액
						, {name:"prcsAmt", label:'<spring:message code="column.prcs_amt" />', width:"150", align:"center", formatter:'integer'}
						// 적립금 처리 사유 코드
						, {name:"svmnPrcsRsnCd", label:'<spring:message code="column.svmn_prcs_rsn_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_PRCS_RSN}" />"}}
						// 주문 번호
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"150", align:"center"}
						// 주문 상세 번호
						, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"150", align:"center"}
					]
				};
				grid.create(childGridID, options);
			}

			function createMemberAddressGrid(){
				var options = {
					url : "<spring:url value='/member/memberAddressListGrid.do' />"
					, height : 300
					, searchParam : { mbrNo : '${member.mbrNo }'}
					, paging : false
					, colModels : [

						//회원 번호
						{name:"mbrNo", label:'<spring:message code="column.mbr_no" />', hidden:true}

						//회원 배송지 번호
						, {name:"mbrDlvraNo", label:'<spring:message code="column.mbr_dlvra_no" />', width:"100", align:"center"}

						//기본 배송지
						, {name:"dftYn", label:'<spring:message code="column.dft_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DFT_YN}" />"}}

						//구분 명
						, {name:"gbNm", label:'<spring:message code="column.gb_nm" />', width:"100", align:"center"}

						//수취인 명
						, {name:"adrsNm", label:'<spring:message code="column.adrs_nm" />', width:"100", align:"center"}

						//우편 번호 구
						, {name:"postNoOld", label:'<spring:message code="column.post_no_old" />', width:"100", align:"center"}

						//지번 주소
						, {name:"prclAddr", label:'<spring:message code="column.prcl_addr" />', width:"250", align:"center"}

						//지번 상세 주소
						, {name:"prclDtlAddr", label:'<spring:message code="column.prcl_dtl_addr" />', width:"200", align:"center"}

						//우편 번호 신
						, {name:"postNoNew", label:'<spring:message code="column.post_no_new" />', width:"100", align:"center"}

						//도로 주소
						, {name:"roadAddr", label:'<spring:message code="column.road_addr" />', width:"250", align:"center"}

						//도로 상세 주소
						, {name:"roadDtlAddr", label:'<spring:message code="column.road_dtl_addr" />', width:"200", align:"center"}

						//전화
						, {name:"tel", label:'<spring:message code="column.tel" />', width:"100", align:"center"}

						//휴대폰
						, {name:"mobile", label:'<spring:message code="column.mobile" />', width:"100", align:"center"}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#memberAddressList").getRowData(ids);

						memberAddressViewPop(rowdata.mbrDlvraNo);
					}
				};
				grid.create("memberAddressList", options);
			}

			function reloadMemberAddressGrid(){
				var options = {
					searchParam : { mbrNo : '${member.mbrNo }'}
				};

				grid.reload("memberAddressList", options);
			}

			function memberUpdate() {
				if(validate.check("memberForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/member/memberUpdate.do' />"
								, data : $("#memberForm").serialize()
								, callBack : function(result){
									updateTab();
								}
							};

							ajax.call(options);
		                }
	            	});
				}
			}

			function memberAddressViewPop(mbrDlvraNo){
				var options = {
					url : '/member/memberAddressViewPop.do'
					, data : {
						mbrNo : '${member.mbrNo }',
						mbrDlvraNo : mbrDlvraNo
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "memberAddressView"
							, width : 700
							, height : 600
							, top : 200
							, title : "회원 주소"
							, body : data
							, button : "<button type=\"button\" onclick=\"memberAddressSave();\" class=\"btn btn-ok\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function couponListViewPop(){
                var options = {
              		url : '/promotion/couponListViewPop.do'
              		, data : {
              			 mbrNo : '${member.mbrNo }',
                         stId : '${member.stId }',
                         stNm : '${member.stNm }'
              		}
              		, dataType : "html"
              		, callBack : function (data ) {
              			var config = {
              				id : "couponListView"
              				, width : 1000
              				, height : 800
              				, top : 200
              				, title : "쿠폰 검색"
              				, body : data
              				, button : "<button type=\"button\" onclick=\"memberIssueCoupon();\" class=\"btn btn-ok\">쿠폰 발급</button>"
              			}
              			layer.create(config);
              		}
              	}
              	ajax.call(options );
            }

			function memberSavedMoneyInsert(){
                // 정상회원만 적립금을 지급할 수 있음(휴면/탈퇴 회원은 제외)
                var mbrStatCd = '${member.mbrStatCd}';
                if (mbrStatCd != '${adminConstants.MBR_STAT_10}') {
                	messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney_add.member_status_invalid' arguments='${member.mbrNo}'/>", "Info", "info");
                    return;
                }

				if(validate.check("memberSavedMoneyForm")) {
					 
					//유효 일시 
					var vldDtm = $("#vldDtm").val().replace(/-/gi, "");
					if (vldDtm ==''){
						messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney.date_required' />", "Info", "info", function(){
							$("#vldDtm").focus();
						});
						return;
					} 
					var currentTime =shiftDate(getCurrentTime(), 0,0,0,"");
					if(vldDtm < currentTime){
						messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney.date_invalid' />", "Info", "info");
						return;
					}
					
					var svmnRsnCd = $("select[name=svmnRsnCd]").val();
					if (svmnRsnCd == null || svmnRsnCd == '') {
						messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney.select_invalid' />", "Info", "info", function(){
						   	$("#svmnRsnCd").focus();
						});
					   	return;
					}

					messager.confirm('<spring:message code="column.member_view.svmn_rmn_amt.insert" />', function(r){
		                if (r){
		                	var data = $("#memberSavedMoneyForm").serializeObject();
							data.mbrNo = '${member.mbrNo }';

							var options = {
								url : "<spring:url value='/member/memberSavedMoneyInsert.do' />"
								, data : data
								, callBack : function(result){
									updateTab();
								}
							};

							ajax.call(options);
		                }
	            	});
				}
			}

			function memberSavedMoneyRemove(){ // 적립금 차감 hjko
                // 정상회원만 적립금을 차감할 수 있음(휴면/탈퇴 회원은 제외)
                var mbrStatCd = '${member.mbrStatCd}';
                if (mbrStatCd != '${adminConstants.MBR_STAT_10}') {
                	messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney_minus.member_status_invalid' arguments='${member.mbrNo}'/>", "Info", "info");
                    return;
                }

				if(validate.check("memberSavedMoneyForm")) {
					messager.confirm('<spring:message code="column.member_view.svmn_rmn_amt.remove" />', function(r){
		                if (r){
		                	var data = $("#memberSavedMoneyForm").serializeObject();
							data.mbrNo = '${member.mbrNo }';

							var options = {
								url : "<spring:url value='/member/memberSavedMoneyRemove.do' />"
								, data : data
								, callBack : function(result){
									updateTab();
								}
							};

							ajax.call(options);
		                }
	            	});
				}
			}

			function csMemberSavedMoneyHist(){

				var options = {
					url : "<spring:url value='/member/memberSavedMoneyHist.do' />"
					, height : 265
					, searchParam : { mbrNo : '${member.mbrNo }'
						             ,prcsDtmStart :'1111-11-11'
						            }
					, colModels : [
						  {name:"svmnPrcsCd", label:'<spring:message code="column.svmn_prcs_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_PRCS}" />"}}
						, {name:"svmnRsnCd", label:'<spring:message code="column.svmn_rsn_cd" />', width:"130", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_RSN}" />"}}
						, {name:"svmnPrcsRsnCd", label:'<spring:message code="column.svmn_prcs_rsn_cd" />', width:"130", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVMN_PRCS_RSN}" />"}}
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}
						, {name:"saveAmt", label:'<spring:message code="column.save_amt" />', width:"120", align:"right"
							, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.svmnPrcsCd != "${adminConstants.SVMN_PRCS_10}") {
									return ('-' + rowObject.saveAmt + ' 원').toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
								} else {
									return (rowObject.saveAmt+ ' 원').toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
								}
							}
						}
						, {name:"etcRsn", label:'<spring:message code="column.etc_rsn" />', width:"250", align:"center"}
						, {name:"svmnSeq", label:'<spring:message code="column.svmn_seq" />', width:"150", align:"center", formatter:'integer' , hidden:true}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"170", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

					]

				};

				grid.create("memberSavedMoneyList", options);
			}
			//회원의 사용가능한 쿠폰
			function csMemberCouponPossibleListGrid(){
				var options = {
					url : "<spring:url value='/member/memberCouponPossibleListGrid.do' />"
					, height : 265
					, searchParam : { mbrNo : '${member.mbrNo }' }
					, colModels : [
						  {name:"cpNo", label:'<spring:message code="column.cp_no" />', width:"80", align:"center", formatter:'integer'}
						, {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"200", align:"center"}
						, {name:"cpDscrt", label:'<spring:message code="column.cp_dscrt" />', width:"300", align:"center" }
						, {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"90", align:"center"}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
						, {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
						, {name:"cpAplCd", label:'<spring:message code="column.cp_apl_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
						, {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}

					]
                    , grouping: true
                    , groupField: ["cpNo"]
                    , groupText: ["쿠폰번호"]
                    , groupOrder : ["desc"]
                    , groupCollapse: false
                    , groupColumnShow : [false]
				};

				grid.create("memberCouponPossibleList", options);
			}

	        function reloadCsMemberCouponPossibleListGrid(){
	            var options = {
	                searchParam : { mbrNo : '${member.mbrNo }'}
	            };
	            grid.reload("memberCouponPossibleList", options);
	        }

			//회원의 사용한 쿠폰
			function csMemberCouponCompletionListGrid(){
				var options = {
					url : "<spring:url value='/member/memberCouponCompletionListGrid.do' />"
					, height : 265
					, searchParam : { mbrNo : '${member.mbrNo }' }
					, colModels : [
						  {name:"cpNo", label:'<spring:message code="column.cp_no" />', width:"80", align:"center", formatter:'integer'}
						, {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"200", align:"center"}
						, {name:"cpDscrt", label:'<spring:message code="column.cp_dscrt" />', width:"300", align:"center" }
						, {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"90", align:"center"}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"useDtm", label:'<spring:message code="column.use_dtm" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}
						, {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
						, {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
						, {name:"cpAplCd", label:'<spring:message code="column.cp_apl_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
						, {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}

					]
                    , grouping: true
                    , groupField: ["cpNo"]
                    , groupText: ["쿠폰번호"]
                    , groupOrder : ["desc"]
                    , groupCollapse: false
                    , groupColumnShow : [false]
				};

				grid.create("memberCouponCompletionList", options);
			}

			function smsLayerView() {
				var data = new Array();
					data.push({
						receiveName : '${member.mbrNm }'
						, receivePhone : '${member.mobile }'
					});
				var options = {
					url : "<spring:url value='/member/smsLayerView.do' />"
					, data : {
						arrSmsStr : JSON.stringify(data)
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "smsLayer"
							, width : 500
							, height : 450
							, top : 200
							, title : "SMS 발송"
							, body : data
							, button : "<button type=\"button\" onclick=\"smsSend();\" class=\"btn btn-ok\">발송</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );

		}

		$(document).on("keyup", "#msg", function(e) {

			//byteCheck("msg", "msgByte");
			var conts = document.getElementById("msg");
			var bytes = document.getElementById("msgByte");
			var i = 0;
			var cnt = 0;
			var exceed = 0;
			var ch = '';
			for (i=0; i<conts.value.length; i++) {
				ch = conts.value.charAt(i);
				if (escape(ch).length > 4) {
					cnt += 2;
				} else {
					cnt += 1;
				}
			}
			bytes.innerHTML = cnt;

			if (cnt > 80 && bigo  == 1 ) {
				$("#msgByteHtml").hide();
				$("#mmsHtml").show();
				bigo = bigo+1;
				messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.size_valid' arguments='80' />", "Info", "info");
			}

			if(cnt > 80  &&  bigo > 1){
				$("#msgByteHtml").hide();
				$("#mmsHtml").show();
			}else if(cnt <= 80  &&  bigo > 1){
				$("#msgByteHtml").show();
				$("#mmsHtml").hide();
			}
		});

		$(document).on("click", ".smsDtlBtn", function(e) {
			if($("#smsLayerForm .mListBox li").length > 1) {
				$(this).parents("li").remove();
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.sms_delete_fail' />", "Info", "info");
			}
		});

		function smsSend() {
			if($("#smsLayerForm .mListBox li").length > 0) {
				if(validate.check("smsLayerForm")) {
					messager.confirm('<spring:message code="column.common.confirm.send" />', function(r){
		                if (r){
		                	var receiveName = new Array();
							var receivePhone = new Array();

							$("#smsLayerForm .mListBox li").each(function(e) {
								receiveName.push($(this).find("input[name=receiveName]").val());
								receivePhone.push($(this).find("input[name=receivePhone]").val());
							});

							 var options = {
								url : "<spring:url value='/member/smsListSend.do' />"
								, data : {
									sendPhone : $("#smsLayerForm #sndNo").val()
									, msg : $("#smsLayerForm #msg").val()
									, receiveName : receiveName.join(",")
									, receivePhone : receivePhone.join(",")
								}
								, callBack : function(result){
									messager.alert(result.resultMessage, "Info", "info", function(){
										if(result.resultCode == 0) {
											layer.close("smsLayer");
										}
									});
								}
							};
							ajax.call(options);
		                }
	            	});
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.sms_send_fail' />", "Info", "info");
			}
		}
		   function emailLayerView() {

				var data = new Array();
				data.push({
				    receiverNm : '${member.mbrNm }'
				    , receiverEmail : '${member.email}'
				    , mbrNo : '${member.mbrNo }'
					, stId :'${member.stId }'
				});
				var options = {
					url : "<spring:url value='/member/emailLayerView.do' />"
					, data : {
						arrEmailStr : JSON.stringify(data)
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "emailLayer"
							, width : 900
							, height : 800
							, top : 100
							, title : "Email 발송"
							, body : data
							, button : "<button type=\"button\" onclick=\"emailSend();\" class=\"btn btn-ok\">발송</button>"
						}
						layer.create(config);

						EditorCommon.setSEditor('emailContent', '${adminConstants.EMAIL_PATH}');
					}
				}
				ajax.call(options );

		}

		$(document).on("click", ".emailDtlBtn", function(e) {
			if($("#emailLayerForm .mListBox li").length > 1) {
				$(this).parents("li").remove();
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.email_delete_fail' />", "Info", "info");
			}
		});

		function emailSend() {
			 
			if($("#emailLayerForm .mListBox li").length > 0) {
				if(validate.check("emailLayerForm")) {
					oEditors.getById["emailContent"].exec("UPDATE_CONTENTS_FIELD", []);
					if( !editorRequired( 'emailContent' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.send" />', function(r){
		                if (r){
		                	var arrEmailStr = new Array();

							$("#emailLayerForm .mListBox li").each(function(e) {
								arrEmailStr.push({
									receiverNm : $(this).find("input[name=nm]").val()
									, receiverEmail : $(this).find("input[name=email]").val()
									, mbrNo  : $(this).find("input[name=mbrNo]").val()
									, stId   : $(this).find("input[name=stId]").val()
								})
							});

							 var options = {
								url : "<spring:url value='/member/emailListSend.do' />"
								, data : {
									emailTitle : $("#emailLayerForm #emailTitle").val()
									, emailContent : $("#emailLayerForm #emailContent").val()
									, arrEmailStr : JSON.stringify(arrEmailStr)
								}
								, callBack : function(result){
									messager.alert(result.resultMessage, "Info", "info", function(){
										layer.close("emailLayer");
									});
								}
							};
							ajax.call(options);
		                }
	            	});
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.email_send_fail' />", "Info", "info");
			}
			 
		}


		//회원 이력 정보
		function fnMemberBaseHistoryListGrid(){

			var options = {
				url : "<spring:url value='/member/memberBaseHistoryListGrid.do' />"
				, height : 265
				, searchParam : { mbrNo : '${member.mbrNo }' }
				, colModels : [
						  {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center", hidden:true}
						, {name:"histStrtDtm", label:'<spring:message code="column.hist_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true}// 사이트 아이디
						, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"100", align:"center", sortable:false }// 사이트 명
						, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center"}
						, {name:"mbrStatCd", label:'<spring:message code="column.mbr_stat_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT}" />"}}
						, {name:"mbrGrdCd", label:'<spring:message code="column.mbr_grd_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GRD}" />"}}
						, {name:"loginId", label:'<spring:message code="column.login_id" />', width:"100", align:"center"}
						, {name:"tel", label:'<spring:message code="column.tel" />', width:"100", align:"center"}
						, {name:"mobile", label:'<spring:message code="column.mobile" />', width:"100", align:"center"}
						, {name:"email", label:'<spring:message code="column.email" />', width:"150", align:"center"}
						, {name:"birth", label:'<spring:message code="column.birth" />', width:"100", align:"center"}
						, {name:"emailRcvYn", label:'<spring:message code="column.email_rcv_yn" />', width:"100", align:"center"}
						, {name:"smsRcvYn", label:'<spring:message code="column.sms_rcv_yn" />', width:"100", align:"center"}
						, {name:"svmnRmnAmt", label:'<spring:message code="column.svmn_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"blcRmnAmt", label:'<spring:message code="column.blc_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"gdGbCd", label:'<spring:message code="column.gd_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GD_GB}" />"}}
						, {name:"ntnGbCd", label:'<spring:message code="column.ntn_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.NTN_GB}" />"}}
						, {name:"joinPathCd", label:'<spring:message code="column.join_path_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.JOIN_PATH}" />"}}
						, {name:"joinDtm", label:'<spring:message code="column.join_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"updrIp", label:'<spring:message code="column.updr_ip" />', width:"120", align:"center"}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				]
			};
			grid.create("memberBaseHistoryList", options);
		}

        //날짜 더하기
        function fnAddDate(dos){
	      	//$("#vldDtm").val( shiftDate(getCurrentTime(), 0, +dos, 0, "-")   );
	      	var date = toDateObject(getCurrentTime());
				date.setMonth(date.getMonth() + dos);			 
				date.setDate(date.getDate() -1);			 
				$("#vldDtm").val( toDateString(date, "-")   );
        }
        
        function memberPasswordReset(){
        	messager.confirm('<spring:message code="column.member_view.confirm.password" />', function(r){
                if (r){
                	var options = {
       					url : "<spring:url value='/member/memberPasswordUpdate.do' />"
       					, data : {
       						mbrNo : '${member.mbrNo}'
       					}
       					, callBack : function(result){
       						messager.alert("<spring:message code='admin.web.view.msg.member.password_update.success' />", "Info", "info");
       					}
       				};

       				ajax.call(options);
                }
        	});

		}
        
        function fnReset(dos){
        	if(dos =="mobile"){
        		$("#mobile").val('${adminConstants.COMMON_RESET_MOBILE}');
        	}else if (dos =="email"){
        		$("#email").val('${adminConstants.COMMON_RESET_EMAIL}');
        	}
        }
        
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle">
			<h2>회원 기본 정보</h2>
		</div>

		<form name="memberForm" id="memberForm" method="post">
		<table class="table_type1">
			<caption>회원 기본 정보</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.login_id"/></th><!-- 회원 번호-->
					<td>${member.loginId} (${member.mbrNo }) <input type="hidden" name="mbrNo" id="mbrNo" value="${member.mbrNo }"> &nbsp;&nbsp; <button type="button" onclick="memberPasswordReset();" class="btn">비밀번호 초기화</button>
					</td>
					<th><spring:message code="column.mbr_nm"/></th>
					<td>
						<!-- 회원 명-->
						${member.mbrNm }
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.st_id" /></th>
					<td>
						<!-- 사이트 ID -->
						${member.stNm }
					</td>
					<th><spring:message code="column.mbr_grd_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 회원 등급 코드-->
						<select class="validate[required]" name="mbrGrdCd" id="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>">
							<frame:select grpCd="${adminConstants.MBR_GRD_CD}" selectKey="${member.mbrGrdCd}" />
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.mbr_stat_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 회원 상태 코드-->
						<select class="validate[required]" name="mbrStatCd" id="mbrStatCd" title="<spring:message code="column.mbr_stat_cd"/>">
							<frame:select grpCd="${adminConstants.MBR_STAT_CD}" selectKey="${member.mbrStatCd}" selectKeyOnly="true"/>
						</select>
					</td>
					<th><spring:message code="column.join_dtm"/></th>
					<td>
						<!-- 가입 일시-->
						<fmt:formatDate value="${member.joinDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>

					<th><spring:message code="column.ntn_gb_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 국적 -->
						<select class="validate[required]" name="ntnGbCd" id="ntnGbCd" title="<spring:message code="column.ntn_gb_cd"/>">
							<frame:select grpCd="${adminConstants.NTN_GB}" selectKey="${member.ntnGbCd }" />
						</select>
					</td>
					<th><spring:message code="column.gd_gb_cd"/></th>
					<td>
						<!-- 성별 구분 코드-->
						<frame:codeName grpCd="${adminConstants.GD_GB}" dtlCd="${member.gdGbCd}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.join_path_cd"/></th>
					<td>
						<!-- 가입 경로 코드-->
						<frame:codeName grpCd="${adminConstants.JOIN_PATH}" dtlCd="${member.joinPathCd}"/>
					</td>
					<th><spring:message code="column.birth"/></th>
					<td>
						<!-- 생일-->
						${frame:getFormatDate(member.birth, 'yyyy-MM-dd')}
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.email"/><strong class="red">*</strong></th>
					<td>
						<!-- 이메일-->
						<input type="text" class="w200 validate[required, custom[email]]" name="email" id="email" title="<spring:message code="column.email"/>" value="${member.email}" maxlength="100"/>
						<button type="button" onclick="fnReset('email');" class="btn">초기화</button>
					</td>
					<th><spring:message code="column.email_rcv_yn"/><strong class="red">*</strong></th>
					<td>
						<!-- 이메일 수신 여부-->
						<frame:radio name="emailRcvYn" grpCd="${adminConstants.EMAIL_RCV_YN }" selectKey="${member.emailRcvYn}"/>
						&nbsp;&nbsp;
						<button type="button" onclick="emailLayerView();" class="btn">Email 발송</button>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.mobile"/><strong class="red">*</strong></th>
					<td>
						<!-- 휴대폰-->
						<input type="text" class="validate[required, custom[mobile]]" name="mobile" id="mobile" title="<spring:message code="column.mobile"/>" value="${member.mobile}" />
						<button type="button" onclick="fnReset('mobile');" class="btn">초기화</button>
					</td>
					<th><spring:message code="column.sms_rcv_yn"/><strong class="red">*</strong></th>
					<td>
						<!-- SMS 수신 여부-->
						<frame:radio name="smsRcvYn" grpCd="${adminConstants.SMS_RCV_YN }" selectKey="${member.smsRcvYn}"/>
						&nbsp;&nbsp;
						<button type="button" onclick="smsLayerView();" class="btn">SMS 발송</button>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.tel"/></th>
					<td>
						<!-- 전화-->
						<input type="text" class="phoneNumber validate[custom[tel]]" name="tel" id="tel" title="<spring:message code="column.tel"/>" value="${member.tel }" maxlength="20"/>
					</td>
					<th><spring:message code="column.member_view.svmn_rmn_amt"/></th>
					<td>
						<!-- 적립금 -->
						<fmt:formatNumber value="${member.svmnRmnAmt}" type="number" pattern="#,###,###"/> 원
					</td>
				</tr>
                <tr>
                    <th><spring:message code="column.mbr_dft_dlvra"/></th>
                    <td>
                        <!-- 기본 배송지 -->
                        <p>${member.mbrDftDlvrPrclAddress}</p>
                        <p>${member.mbrDftDlvrRoadAddress}</p>
                    </td>
                    <th><spring:message code="column.last_login_dtm"/></th>
                    <td>
                        <fmt:formatDate value="${member.lastLoginDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
                
                <tr>
					<th><spring:message code="column.rcom_login_id"/></th>
                    <td>
                        ${member.rcomLoginId}
                    </td>
                    <th><spring:message code="column.dormant_apl_dtm"/></th>
                    <td>
						<fmt:formatDate value="${member.dormantAplDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						<%-- <frame:datepicker startDate="mbrLevDtm" startValue="${member.mbrLevDtm}"/> --%>
					</td>

				</tr>
				<tr>
				    <th><spring:message code="column.mbr_lev_dtm"/></th>
					<td>
						<fmt:formatDate value="${member.mbrLevDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						<%-- <frame:datepicker startDate="mbrLevDtm" startValue="${member.mbrLevDtm}"/> --%>
					</td>
					<th><spring:message code="column.re_join_psb_dt"/></th>
					<td>
						${frame:getFormatDate(member.reJoinPsbDt, 'yyyy-MM-dd')}
						<%-- <frame:datepicker startDate="reJoinPsbDt" startValue="${member.reJoinPsbDt}"/> --%>
					</td>					
                </tr>
			</tbody>
		</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="memberUpdate();" class="btn btn-ok">수정</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>
		
		<!-- 여기부터삭제 예정 Str -->
		<div class="mTitle mt30">
			<h2>회원 적립금 정보</h2>
		</div>

		<div class="mModule no_m">
			<table id="memberSavedMoneyList" ></table>
			<div id="memberSavedMoneyListPage" ></div>
		</div>
		<!-- 여기삭제 예정 End -->
		
		
		<div class="mTitle mt30">
			<h2>회원 적립금 지급/차감</h2>
		</div>

		<div class="mModule no_m">
			<table id="memberSavedMoneyList" ></table>
			<div id="memberSavedMoneyListPage" ></div>
		</div>


		<form name="memberSavedMoneyForm" id="memberSavedMoneyForm" method="post">
		<table class="table_type1" style="margin-top:-10px"> 
			<caption>적립금 지급/차감</caption>
			<colgroup>
                <col style="width:100px;" />
                <col style="width:150px;" />
                <col style="width:100px;" />
                <col style="width:150px;" />
                <col style="width:100px;" />
                <col style="width:300px;" />
                <col style="width:100px;" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="column.save_amt"/><strong class="red">*</strong></th>
					<td>
						<input type="text" class="w100 comma validate[required, custom[number]]" name="saveAmt" id="saveAmt" title="<spring:message code="column.save_amt"/>" value="" maxlength="10"/>
					</td>
					<th><spring:message code="column.svmn_rsn_cd"/></th>
					<td>
						<!-- 적립금 사유 -->
                        <select name="svmnRsnCd" id="svmnRsnCd" class="w100" title="<spring:message code="column.svmn_rsn_cd"/>">
                            <frame:select grpCd="${adminConstants.SVMN_RSN}" defaultName="선택하세요" excludeOption="${adminConstants.SVMN_RSN_210}"/>
                        </select>
					</td>
                    <th><spring:message code="column.etc_rsn"/></th>
                    <td>
                        <input type="text" class="w250" name="etcRsn" id="etcRsn" title="<spring:message code="column.etc_rsn"/>" value="" maxlength="500"/>
                    </td>
                    <th><spring:message code="column.vld_dtm"/></th>
                    <td>
                        <frame:datepicker startDate="vldDtm" /><!-- class="validate[required]" -->
                        <label class="fRadio ml20"><input type="radio" id="addDate" name="addDate" title="기간" value="3"  onclick="fnAddDate(3);"><span>3개월</span></label>
                        <label class="fRadio"><input type="radio" id="addDate" name="addDate" title="기간" value="6"  onclick="fnAddDate(6);"><span>6개월</span></label>
                        <label class="fRadio"><input type="radio" id="addDate" name="addDate" title="기간" value="12" checked="checked" onclick="fnAddDate(12);"><span>1년</span></label>
                    </td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btn_area_center">
			<button type="button" onclick="memberSavedMoneyInsert();" class="btn btn-ok">적립금 부여</button>
			<button type="button" onclick="resetForm('memberSavedMoneyForm');fnAddDate(12);" class="btn btn-cancel">초기화</button>
			<button type="button" onclick="memberSavedMoneyRemove();" class="btn btn-add">적립금 차감</button>
		</div>


		<div class="mTitle mt30">
		    <h2>회원 사용가능 쿠폰</h2>
		    <div class="buttonArea">
                   <button type="button" onclick="couponListViewPop();" class="btn btn-add">쿠폰 발급</button>
               </div>
		</div>

		<div class="mModule no_m">
			<table id="memberCouponPossibleList" ></table>
			<div id="memberCouponPossibleListPage" ></div>
		</div>

		<div class="mTitle mt30">
		<h2>회원 사용완료 쿠폰</h2>
		</div>

		<div class="mModule no_m">
			<table id="memberCouponCompletionList" ></table>
			<div id="memberCouponCompletionListPage" ></div>
		</div>


		<!-- <div class="mTitle gTitle">
			<h2>회원 배송지 정보</h2>
			<div class="buttonArea">
				<button type="button" onclick="memberAddressViewPop('');" class="btn_type1">배송지 등록</button>
			</div>
		</div>

		<div class="mModule">
			<table id="memberAddressList" ></table>
		</div> -->


		<div class="mTitle mt30">
			<h2>회원 정보 변경 이력</h2>
		</div>

		<div class="mModule no_m">
			<table id="memberBaseHistoryList" ></table>
		</div>

	</t:putAttribute>
</t:insertDefinition>
