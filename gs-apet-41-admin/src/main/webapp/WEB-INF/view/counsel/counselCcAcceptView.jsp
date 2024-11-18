<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<jsp:include page="/WEB-INF/view/claim/include/incOrderDetailCsList.jsp" />

		<script type="text/javascript">
			
			$(document).ready(function(){
				
			    counselInfoSearch.view();
			    counselInfoMember.clear();			    
				counselInfoOrder.create();
				counselInfoClaim.create();
				counselInfoCs.create();
				
				// CTI로부터 호출되는 경우 파라미터에 대한 고객정보 조회
				if("<c:out value="${inCallNum}" />" != "" ){
					ctiConnect.setCtiInfo("<c:out value="${stId}" />", "<c:out value="${stNm}" />", "<c:out value="${inCallType}" />", "<c:out value="${inCallNum}" />", "<c:out value="${cusTp}" />");
				}
			});
			
			$(function() {
				
				$(".mem_search").keydown(function() {
					if ( window.event.keyCode == 13 ) {
						counselInfoSearch.search();
						return false;
					}
				});	

				$(".nomem_search").keydown(function() {
					if ( window.event.keyCode == 13 ) {
						counselInfoSearch.search();
						return false;
					}
				});	

				$(".counselOrderInfo").keydown(function() {
					if ( window.event.keyCode == 13 ) {
						counselInfoOrder.reload();
						return false;
					}
				});	

				$(".counselClaimInfo").keydown(function() {
					if ( window.event.keyCode == 13 ) {
						counselInfoClaim.reload();
						return false;
					}
				});	
				
				$(".counselCsInfo").keydown(function() {
					if ( window.event.keyCode == 13 ) {
						counselInfoCs.reload();
						return false;
					}
				});	
				
				// CS등록 카테고리 1 선택
				$("#counselAcceptCusCtg1Cd").bind ("change", function () {
					var selectVal = $(this).children("option:selected").val();

					if ( selectVal == "" ) {
						$("#counselAcceptCusCtg2Cd").html ('');
						$("#counselAcceptCusCtg3Cd").html ('');
						return;
					}

					// 분류
					config = {
						grpCd : '${adminConstants.CUS_CTG2 }'
						, usrDfn1Val : selectVal
						, defaultName : '선택'
						, showValue : false
						, callBack : function(html) {
							$("#counselAcceptCusCtg2Cd").html ('');
							$("#counselAcceptCusCtg2Cd").append (html);
							$("#counselAcceptCusCtg3Cd").html ('');

							if($("#counselAcceptCusCtg2Cd option").size() > 1 ) {
								objClass.add ($("#counselAcceptCusCtg2Cd"), "validate[required]" );
							} else {
								objClass.remove ($("#counselAcceptCusCtg2Cd"), "validate[required]" );
							}
						}
					};
					codeAjax.select(config);

				});

				// CS 카테고리 2 선택
				$("#counselAcceptCusCtg2Cd").bind ("change", function () {
					var selectVal = $(this).children("option:selected").val();

// 					alert(selectVal);
					if ( selectVal == "" ) {
						$("#counselAcceptCusCtg3Cd").html ('');
						return;
					}

					// 분류
					config = {
						grpCd : '${adminConstants.CUS_CTG3 }'
						, usrDfn1Val : selectVal
						, defaultName : '선택'
						, showValue : false
						, callBack : function(html) {
							$("#counselAcceptCusCtg3Cd").html ('');
							$("#counselAcceptCusCtg3Cd").append (html);

							if($("#counselAcceptCusCtg3Cd option").size() > 1 ) {
								objClass.add ($("#counselAcceptCusCtg3Cd"), "validate[required]" );
							} else {
								objClass.remove ($("#counselAcceptCusCtg3Cd"), "validate[required]" );
							}
						}
					};
					codeAjax.select(config);

				});
	
				//정보검색 결과 Tab 클릭 이벤트
				$("#counselAcceptInfoTab > ul > li").click(function(){
					grid.resize();
				});
				
				
				// 회원 구분-라디오 버튼 클릭
				$("#counselInfoSearchMemberYn").change(function(){
					counselInfoSearch.view();
				});

				// 머리말/맺음말 유형 변경
				$(document).on("change", "#counselAcceptReplType", function(e) {
					// 머리말/맺음말 유형
					<c:forEach var="item" items="${frame:listCode(adminConstants.REPLY_TYPE_TP)}">
					if('${item.dtlCd}' == $("#counselAcceptReplType").val()) {
						$("#counselAcceptRplHdContent").val('${item.usrDfn1Val}');
						$("#counselAcceptRplFtContent").val('${item.usrDfn2Val}');
					}
					</c:forEach>
					if('' == $("#counselAcceptReplType").val()) {
						$("#counselAcceptRplHdContent").val('');
						$("#counselAcceptRplFtContent").val('');
					}
				});
				
				// 고객 회신 여부 선택 이벤트
				$("#counsel_accept_process_rpl_yn").click(function(){
					counselAccept.changeRpl();
				});
				
			});
			
			/*
			 * CTI 연동
			 */
			var ctiConnect = {
				// CTI로 부터 넘겨받은 정보 설정
				setCtiInfo : function(stId, stNm, inCallType, inCallNum, cusTp){

					var tel = "";
					var mobile = "";
					
					if("M" == inCallType){
						mobile = inCallNum;
					}else if("T" == inCallType){
						tel = inCallNum;
					}
					
					// 전체 초기화
					this.clear();
					
					// 검색영역 초기값 설정
					counselInfoSearch.init(stId, stNm, tel, mobile);
					// 상담내역에 설정
					counselAccept.setEqrrInfo(stId, stNm, "", "", tel, mobile, "" );
					
					// 상담 유형
					$("#counselAcceptCusTpCd").val(cusTp);
				}
				// 전화걸기					
				, call : function(siteId, telNo){
					telNo = telNo.split("-").join("");
					top.tckArea.tck.setCall(siteId, telNo);
				}
				// 기존 정보 초기화				
				, clear : function(){
					
					// 요약정보 초기화
					counselInfoStatus.clear();
					
					// 회원 정보 초기화
				    counselInfoMember.clear();		
				    
				    // 주문 목록 초기화
				    $("#counselOrderInfoNoSearch").val("Y");
					counselInfoOrder.reload();
				    
					// 클레임 목록 초기화
					$("#counselClaimInfoNoSearch").val("Y");
					counselInfoClaim.reload();
				    
					// 상담목록 초기화
					$("#counselCsInfoNoSearch").val("Y");
					counselInfoCs.reload();
					
					// 상담 등록 초기화
					counselAccept.clear();
				}
			};
			
			/*
			 * 정보 검색 영역
			 */
			var counselInfoSearch = {
				// 검색 초기값 설정
				init : function(stId, stNm, tel, mobile){
					$("#counselInfoSearchMemberYn").val("Y");
					
					// 검색영역 초기화
					this.clear();
					// 검색화면 전환
					this.view();
					
					$("#counselInfoMemStId").val(stId);
					$("#counselInfoMemStNm").val(stNm);
					$("#counselInfoMemTel").val(tel);
					$("#counselInfoMemMobile").val(mobile);
					
					this.search();
				}
				// 검색 버튼
				, search : function(){
					var memberYn = $("#counselInfoSearchMemberYn").val();

					if(memberYn == "Y"){
						this.getMemberCheck();
					}else{
						this.loadNoMember();
					}

				}
				// 검색 영역 초기화
				,clear : function(){
					var memberYn = $("#counselInfoSearchMemberYn").val();
					if(memberYn == "Y"){
						resetForm("counselInfoMemForm");
					}else{
						resetForm("counselInfoNoMemForm");
					}
				},
				// 회원여부 체크
				getMemberCheck : function(){
					var options = {
						url : "<spring:url value='/counsel/cc/getMemberCheck.do' />"
						, wait : false
						, data : $("#counselInfoMemForm").serializeJson()
						, callBack : function(result){
							if(result.mbrNo  == -1){
								//1건이상 조회
								counselInfoSearch.memberLayer();
							}else if(result.mbrNo == -2){
								//조회정보 존재하지 않음
								//비회원에서 조회
								messager.confirm("<spring:message code='admin.web.view.msg.counsel.accept.memberinfo' />",function(r){
									if(r){
										$("#counselInfoSearchMemberYn").val("N");
										// 비회원 검색화면 활성화
										counselInfoSearch.view();
										// 회원의 검색정보 비회원 검색에 설정
										counselInfoSearch.copySearchInfo();
										// 비회원 검색
										counselInfoSearch.search();		
									}else{
										counselInfoSearch.clear();
									}
								});
							}else{
								//1건조회
								counselInfoSearch.loadMember(result.mbrNo);
							}
						}
					};
					ajax.call(options);
					
				}
				// 회원 겁색 Layer
				, memberLayer : function(){
					var options = {
							multiselect : true
							, callBack : counselInfoSearch.cbMember
							, param : {petRegYn : 'Y'}
					}
					layerMemberList.create(options);
				}
				// 회원 검색 결과
				, cbMember : function(mbrList){
					counselInfoSearch.loadMember(mbrList[0].mbrNo );
				}
				// 회원에 대한 정보 검색
				, loadMember : function(mbrNo){

					// 요약정보
					counselInfoStatus.setMember(mbrNo);

					//고객정보 조회
					counselInfoMember.get(mbrNo);
					
					// 주문정보 조회
					counselInfoOrder.setMember(mbrNo);
					
					// 클레임정보 조회
					counselInfoClaim.setMember(mbrNo);

					// CS정보 조회
					counselInfoCs.setMember(mbrNo);
					
					changeCsTab(0);
					grid.resize();
				}
				// 비회원일 경우 설정
				, loadNoMember : function(){
					
					if(
						$("#counselInfoNoMemName").val() == ""
							&& $("#counselInfoNoMemTel").val() == ""
								&& $("#counselInfoNoMemMobile").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.needinfo' />","Info","info");
						return;
					}					

					// 요약정보
					counselInfoStatus.setNoMember();
					
					// 고객정보 View 숨김
					counselInfoMember.clear();
					$("#counselMemberInfoMbrNm").html("비회원");
					
					// 주문정보 조회
					counselInfoOrder.setNoMember();
					
					// 클레임정보 조회
					counselInfoClaim.setNoMember();

					// CS정보 조회
					counselInfoCs.setNoMember();

					changeCsTab(1);
					grid.resize();
				}
				// 검색 정보 복사
				, copySearchInfo : function(){
					this.clear();
					
					$("#counselInfoNoMemStId").val($("#counselInfoMemStId").val());
					$("#counselInfoNoMemStNm").val($("#counselInfoMemStNm").val());
					$("#counselInfoNoMemName").val($("#counselInfoMemMbrNm").val());
					$("#counselInfoNoMemTel").val($("#counselInfoMemTel").val());
					$("#counselInfoNoMemMobile").val($("#counselInfoMemMobile").val());
				}
				,view : function(){
					var memberYn = $("#counselInfoSearchMemberYn").val();
					if(memberYn == "Y"){
						$('#memberView').show();
						$('#nonMemberView').hide();
					}else{
						$('#memberView').hide();
						$('#nonMemberView').show();
					}					
				}

			}

			/*
			 * 상담 요약 정보
			 */
			var counselInfoStatus = {
				// 상태 조회					
				get : function(data){
					
					var options = {
							url : "<spring:url value='/counsel/cc/getCounselStatus.do' />"
							, wait : false
							, data : data
							, callBack : function(result){
								var result = result.status;
								
								$("#counselInfoStatusMem").html(result.mbrGb);
								$("#counselInfoStatusOrder").html(result.orderCnt + "건");
								$("#counselInfoStatusClaim").html(result.claimCnt + "건");
								$("#counselInfoStatusRefund").html(validation.num(result.refundAmt) + "원 (" +result.refundCnt+"건)");
								$("#counselInfoStatusCusCc").html(result.cusCcCnt + "건");
								$("#counselInfoStatusCusWeb").html(result.cusWebCnt + "건");
								$("#counselInfoStatusGoodsCmt").html(result.goodsCmtCnt + "건");
								$("#counselInfoStatusGoodsIqr").html(result.goodsIqrCnt + "건");
							}
						};
						ajax.call(options);
				}
				// 회원
				, setMember : function(mbrNo){
					var data =  {mbrNo : mbrNo};
					this.get(data);
				}
				// 비회원
				, setNoMember : function(){
					var data =  $("#counselInfoNoMemForm").serialize();
					this.get(data);
				}
				// 초기화
				, clear : function(){
					$(".counselInfoStatus").html("");
				}
			};
			
			
			/*
			 * 정보검색 > 고객정보 컨트롤
			 */
			var counselInfoMember = {
				get : function(mbrNo){
					var options = {
							url : "<spring:url value='/counsel/cc/getMemberInfo.do' />"
							, wait : false
							, data : {mbrNo : mbrNo}
							, callBack : function(result){
								var member = result.memberBase;
								
								counselInfoMember.clear();
								
								$("#counselMemberInfoMbrNo").html(member.mbrNo);
								$("#counselMemberInfoMbrNm").html(member.mbrNm);
								$("#counselMemberInfoStNm").html(member.stNm);
								$("#counselMemberInfoJoinDtm").html(validation.timestamp(member.joinDtm));
								$("#counselMemberInfoBirth").html(validation.birth(member.birth));
								$("#counselMemberInfoEmail").html(member.email);
								$("#counselMemberInfoMobile").html(validation.mobile(member.mobile));
								$("#counselMemberInfoTel").html(validation.tel(member.tel));
								
								$("#counselMemberInfoMbrGrdCd").val(member.mbrGrdCd);
								$("#counselMemberInfoMbrStatCd").val(member.mbrStatCd);
								$("#counselMemberInfoGdGbCd").val(member.gdGbCd);
								$("#counselMemberInfoNtnGbCd").val(member.ntnGbCd);
								$("#counselMemberInfoJonPathCd").val(member.joinPathCd);
								
								$("#counselMemberInfoEmailRcvYn").val(member.emailRcvYn);
								$("#counselMemberInfoSmsRcvYn").val(member.smsRcvYn);
								$("#counselMemberInfoSvmnRmnAmt").html(validation.num(member.svmnRmnAmt) + "원");
								
								$("#counselMemberInfoDetailView").show();
								
								// 문의자 정보 설정
								counselAccept.setEqrrInfo(member.stId, member.stNm, member.mbrNo, member.mbrNm, member.tel, member.mobile, member.email );
							}
						};
						ajax.call(options);
				}
				, clear : function(){
					$(".counselMemberInfo").html("");
					$(".counselMemberInfoVal").val("");
					
					$("#counselMemberInfoDetailView").hide();
				}
				, detailView : function(mbrNo){
					addTab('회원 상세', '/cs/memberView.do?mbrNo=' + $("#counselMemberInfoMbrNo").html() + '&viewGb=' + '${adminConstants.VIEW_GB_POP}');
				}
			};
			
			/*
			 * 정보검색 > 주문정보 컨트롤
			 */
			var counselInfoOrder = {
				// 주문 목록 생성
				create : function(){
					var options = {
						url : "<spring:url value='/counsel/cc/orderListGrid.do' />"
						, height : 400
						, searchParam : $("#counselOrderInfoForm").serializeJson()
						, colModels : [
				             // 주문번호
				             {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center", sortable:false}
				 			// 연관정보설정
				 			, {name:"button", label:'<b><u><tt>연관정보</tt></u></b>', width:"80", align:"center", sortable:false, classes:'pointer fontbold', formatter: function(rowId, val, rawObject, cm) {
				 				var str = '<button type="button" onclick="counselAccept.setReferOrder(\'' + rawObject.ordNo + '\', \''+rawObject.ordDtlSeq+'\')" class="btn_h25_type1">연관정보</button>';
				 				return str;
				 			}}
                            // 주문상세일련번호
                            , {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"70", align:"center", sortable:false}				             
				 			// 사이트 ID
				 			, {name:"stId", label:"<spring:message code='column.st_id' />", width:"70", align:"center", hidden:true}
				 			// 사이트 명
				 			, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"80", align:"center", sortable:false}
				             // 주문매체
				            , {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"60", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}			
				             // 주문접수일자
				            , {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}			
				             // 주문완료일자
				            , {name:"ordCpltDtm", label:'<spring:message code="column.ord_cplt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}			
				 			// 회원번호
				 			, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"70", align:"center", sortable:false, hidden:true}
				 			// 주문자ID
				 			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false}	
				 			// 주문자명
				 			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"70", align:"center", sortable:false}
				 			// 주문자 전화
				 			, {name:"ordrTel", label:'<spring:message code="column.ordrTel" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false, hidden:true}
				 			// 주문자 휴대폰
				 			, {name:"ordrMobile", label:'<spring:message code="column.ordrMobile" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
				 			// 주문자 이메일
				 			, {name:"ordrEmail", label:'<spring:message code="column.ordrEmail" />', width:"120", align:"center", sortable:false}
						 	// 상품명
						 	, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"250", align:"left", sortable:false}
                            // 주문내역상태코드
                            , {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}, hidden:true}
                            // 주문내역상태코드 이름
                            , {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_stat_cd" />', width:"80", align:"center", sortable:false}
                            // 클레임상태
                            , {name:"clmIngYn", label:'<spring:message code="column.clm_stat_cd" />', width:"70", align:"center", sortable:false, hidden:true}						 	
						 	// 주문수량
						 	, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer'}
						 	// 취소수량
						 	, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer'}
				 			// 잔여주문수량
				 			, {name:"rmnOrdQty", label:'<spring:message code="column.rmn_ord_qty" />', width:"70", align:"center", formatter:'integer', sortable:false, hidden:true}
						 	// 반품수량
						 	, {name:"rtnQty", label:'<spring:message code="column.rtn_qty" />', width:"60", align:"center",  formatter:'integer', hidden:true}
				 			// 반품완료수량
				 			, {name:"rtnCpltQty", label:'<spring:message code="column.rtn_cplt_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 반품진행수량
				 			, {name:"rtnIngQty", label:'<spring:message code="column.rtn_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 교환진행수량
				 			, {name:"clmExcIngQty", label:'<spring:message code="column.clm_exc_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
						    // 건별결제금액
						    , {name:"paySumAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 수령인 명
				 			, {name:"adrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"70", align:"center", sortable:false}
				 			// 수령인 휴대폰
				 			, {name:"mobile", label:'<spring:message code="column.ord.mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber, sortable:false}
				 			// 수령인 주소 1
				 			, {name:"roadAddr", label:'<spring:message code="column.ord.roadAddr" />', width:"200", align:"center", sortable:false}
				 			// 수령인 주소 2
				 			, {name:"roadDtlAddr", label:'<spring:message code="column.ord.roadDtlAddr" />', width:"150", align:"center", sortable:false}
						]
						, onSelectRow : function(ids) {	// row click

							var rowdata = $("#counselOrderInfoList").getRowData(ids);

							// 비회원에 건에 대한 문의자 정보 설정
							if(rowdata.mbrNo == "<c:out value="${adminConstants.NO_MEMBER_NO}"/>"){
								counselAccept.setEqrrInfo(rowdata.stId, rowdata.stNm, rowdata.mbrNo, rowdata.ordNm, rowdata.ordrTel, rowdata.ordrMobile, rowdata.ordrEmail );
							}
							
						}
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	var ids = $('#counselOrderInfoList').jqGrid('getDataIDs');
			            
			                // 그리드 데이터 가져오기
			                var gridData = $("#counselOrderInfoList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].rmnOrdQty == '0') {
				                	   
				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#counselOrderInfoList tr[id=' + ids[i] + ']').css('color', 'red');
				                   }
				                }			     
			            	}
			            	
			            }							
						, grouping: true
						, groupField: ["ordNo"]
						, groupText: ["<b>주문번호</b><button class=\"btn_type6 ml5 mt2 mb2\" onclick=\"counselInfoOrder.detailView('{0}');\">주문상세</button>" ]
						, groupOrder : ["asc"]
						, groupColumnShow : [false]			
					};

					grid.create( "counselOrderInfoList", options) ;
				}
			 	// 주문 목록 재조회
				, reload : function(){

					var options = {
						searchParam : $("#counselOrderInfoForm").serializeJson()
					};

					grid.reload("counselOrderInfoList", options);			
				}
			 	, detailView : function(ordNo){
					addTab('주문 상세', '/cs/orderDetailView.do?ordNo=' + ordNo + '&viewGb=' + '${adminConstants.VIEW_GB_POP}');
			 	}
				// 회원조회
				, setMember : function(mbrNo){
					this.clearForm();
					$("#counselOrderInfoMbrNo").val(mbrNo);
					this.reload();
				}
				// 비회원 조회
				, setNoMember : function(){
					this.clearForm();
					$("#counselOrderInfoMbrNo").val("<c:out value="${adminConstants.NO_MEMBER_NO}"/>");
					$("#counselOrderInfoStId").val($("#counselInfoNoMemStId").val()); 
					$("#counselOrderInfoOrdAcptDtmStart").val($("#acptDtmStart").val());
					$("#counselOrderInfoOrdAcptDtmEnd").val($("#acptDtmEnd").val());
					$("#counselOrderInfoOrdNm").val($("#counselInfoNoMemName").val());
					$("#counselOrderInfoOrdrTel").val($("#counselInfoNoMemTel").val());
					$("#counselOrderInfoOrdrMobile").val($("#counselInfoNoMemMobile").val());
					this.reload();

				}
				// 검색 영역 초기화
				, clearForm : function(){
					resetForm("counselOrderInfoForm");
				}
			};

			 /*
			  * 정보검색 > 클레임정보 컨트롤
			  */
			var counselInfoClaim = {
				// 클레임 목록 생성
				create : function(){
					var options = {
						url : "<spring:url value='/counsel/cc/claimListGrid.do' />"
						, height : 400
						,colModels : [
				 			// 클레임 번호
				 			  {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"120", align:"center"}
				 			// 연관정보설정
				 			, {name:"button", label:'<b><u><tt>연관정보</tt></u></b>', width:"80", align:"center", sortable:false, classes:'pointer fontbold', formatter: function(rowId, val, rawObject, cm) {
				 				var str = '<button type="button" onclick="counselAccept.setReferOrder(\'' + rawObject.ordNo + '\', \''+rawObject.ordDtlSeq+'\')" class="btn_h25_type1">연관정보</button>';
				 				return str;
				 			}}
				 			/* 사이트명 */
				 			, {name:"stNm", label:'<spring:message code='column.st_nm' />', width:"80", align:"center" }
				 			/* 사이트 ID */
				 			, {name:"stId", label:'<spring:message code='column.st_id' />', width:"100", align:"center", hidden: true} 
				 			// 주문 번호
				 			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"115", align:"center"}
				 			// 클레임 유형 코드
				 			, {name:"clmTpCd", label:'<spring:message code="column.clm_tp_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}}	
				 			// 클레임 상태 코드
				 			, {name:"clmStatCd", label:'<spring:message code="column.clm_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_STAT}" />"}}
				 			// 클레임 접수 일시
				 			, {name:"acptDtm", label:'<spring:message code="column.clm_acpt_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm" }
				 			// 클레임 완료 일시
				 			, {name:"cpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm" }
				 			// 클레임 취소 일시
				 			, {name:"cncDtm", label:'<spring:message code="column.clm_cnc_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm" }
				 			// 클레임 상세 순번
				 			, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"80", align:"center" }
				 			// 주문 상세 순번
				 			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"80", align:"center", hidden:true}
				 			// 클레임 유형 코드
				 			, {name:"clmDtlTpCd", label:'<spring:message code="column.clm_dtl_tp_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_TP}" />"}}	
				 			// 클레임 상세 상태 코드
				 			, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}" />"}}
				 			// 클레임 사유 코드
				 			, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}
				 			// 상품아이디
				 			, {name:"goodsId", label:'<spring:message code='column.goods_id' />', width:"100", align:"center", hidden: true} 
				 			// 상품명
				 			, {name:"goodsNm", label:'<spring:message code='column.goods_nm' />', width:"200", align:"center" }
				 			// 단품번호
				 			, {name:"itemNo", label:'<spring:message code='column.item_no' />', width:"100", align:"center", hidden: true} 
				 			// 단품명
				 			, {name:"itemNm", label:'<spring:message code='column.item_nm' />', width:"100", align:"center" }
				 			// 클레임 수량
				 			, {name:"clmQty", label:'<spring:message code="column.clm_qty" />', width:"80", align:"center", formatter:'integer'}
				 			// 클레임 완료 일시
				 			, {name:"clmCpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm"}
			 
				 		]
						, searchParam : $("#counselClaimInfoForm").serializeJson()
						, gridComplete: function() {  /** 데이터 로딩시 함수 **/

							var ids = $('#counselClaimInfoList').jqGrid('getDataIDs');
						    
							// 그리드 데이터 가져오기
							var gridData = $("#counselClaimInfoList").jqGrid('getRowData');

							if(gridData.length > 0){
								// 데이터 확인후 색상 변경
								for (var i = 0; i < gridData.length; i++) {

									// 데이터의 is_test 확인
									if (gridData[i].clmStatCd == '40') {
									   
										// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
										$('#counselClaimInfoList tr[id=' + ids[i] + ']').css('color', 'red');
								   }
								}			     
							}
							
					    }
						, onSelectRow : function(ids) {	// row click

							var rowdata = $("#counselClaimInfoList").getRowData(ids);

							// 문의자 정보 설정
							if(rowdata.mbrNo == "<c:out value="${adminConstants.NO_MEMBER_NO}"/>"){
								counselAccept.setEqrrInfo(rowdata.stId, rowdata.stNm, rowdata.mbrNo, rowdata.ordNm, rowdata.ordrTel, rowdata.ordrMobile, rowdata.ordrEmail );
							}

						}						
						, grouping: true
						, groupField: ["clmNo"]
						, groupText: ["<b>클레임번호</b><button class=\"btn_type6 ml5 mb2 mt2\" onclick=\"counselInfoClaim.detailView('{0}');\">클레임상세</button>"]
						, groupOrder : ["desc"]
						, groupCollapse: false
						, groupColumnShow : [false]

					};

					grid.create( "counselClaimInfoList", options) ;
				}
			  	// 클레임 목록 재조회
				,reload : function(){
					var options = {
						searchParam : $("#counselClaimInfoForm").serializeJson()
					};

					grid.reload("counselClaimInfoList", options);			

				}
			 	, detailView : function(clmNo){
					addTab('클레임 상세', '/cs/claimDetailView.do?clmNo=' + clmNo + '&viewGb=' + '${adminConstants.VIEW_GB_POP}');
			 	}			  	
				// 회원 조회
				, setMember : function(mbrNo){
					this.clearForm();
					$("#counselClaimInfoMbrNo").val(mbrNo);
					this.reload();
				}
				// 비회원 조회
				, setNoMember : function(){
					this.clearForm();
					$("#counselClaimInfoMbrNo").val("<c:out value="${adminConstants.NO_MEMBER_NO}"/>");
					
					$("#counselClaimInfoStId").val($("#counselInfoNoMemStId").val()); 
					$("#counselClaimInfoClmAcptDtmStart").val($("#acptDtmStart").val());
					$("#counselClaimInfoClmAcptDtmEnd").val($("#acptDtmEnd").val());
					$("#counselClaimInfoOrdNm").val($("#counselInfoNoMemName").val());
					$("#counselClaimInfoOrdrTel").val($("#counselInfoNoMemTel").val());
					$("#counselClaimInfoOrdrMobile").val($("#counselInfoNoMemMobile").val());

					this.reload();
					
				}
				// 검색 영역 초기화
				, clearForm : function(){
					resetForm("counselClaimInfoForm");
				}

			  };

			  /*
			   * 정보검색 > CS정보 컨트롤
			   */
			var counselInfoCs = {
				// CS 목록 생성
				create : function(){
					var options = {
						url : "<spring:url value='/counsel/cc/counselListGrid.do' />"
						, height : 200
						, searchParam : $("#counselCsInfoForm").serializeJson()
						, colModels : [
				  			//상담 번호
							{name:"cusNo", label:'<spring:message code="column.cus_no" />', hidden:true}
							//사이트 ID
							, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true}
							//  사이트 명
							, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"80", align:"center", sortable:false }
							//상담 경로 코드
							, {name:"cusPathCd", label:'<spring:message code="column.cus_path_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
							// 상담 상태 코드
							, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}
							// 주문 번호
							, {name:"ordNo", label:'<b><u><tt><spring:message code="column.ord_no" /></tt></u></b>', width:"110", align:"center" , classes:'pointer fontbold'}
							// 문의자 회원번호
							, {name:"eqrrMbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center", hidden:true}
							// 문의자 명
							, {name:"eqrrNm", label:'<b><u><tt><spring:message code="column.eqrr_nm" /></tt></u></b>', width:"60", align:"center", classes:'pointer fontbold'}
							// 문의자 전화
							, {name:"eqrrTel", label:'<spring:message code="column.eqrr_tel" />', width:"90", align:"center", formatter:gridFormat.phonenumber}
							// 문의자 휴대폰
							, {name:"eqrrMobile", label:'<spring:message code="column.eqrr_mobile" />', width:"90", align:"center", formatter:gridFormat.phonenumber}
							// 문의자 이메일
							, {name:"eqrrEmail", label:'<spring:message code="column.eqrr_email" />', width:"120", align:"center"}
							// 제목
							, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}
							// 상담 카테고리1 코드
							, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
							// 상담 카테고리2 코드
							, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}
							// 상담 카테고리3 코드
							, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}
							// 상담 접수 일시
							, {name:"cusAcptDtm", label:'<spring:message code="column.cus_acpt_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
							// 상담 취소 일시
							, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
							// 상담 완료 일시
							, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"110", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
							//상담 담당자 번호
							, {name:"cusChrgNo", label:'<spring:message code="column.cus_chrg_no" />', hidden:true}
							//상담 담당자명
							, {name:"cusChrgNm", label:'<spring:message code="column.cus_chrg_nm" />', width:"80", align:"center"}
							//상담 접수자
							, {name:"cusAcptrNm", label:'<spring:message code="column.cus_acptr_nm" />', width:"80", align:"center"}
							//상담 취소자
							, {name:"cusCncrNm", label:'<spring:message code="column.cus_cncr_nm" />', width:"80", align:"center"}
							//상담 완료자
							, {name:"cusCpltrNm", label:'<spring:message code="column.cus_cpltr_nm" />', width:"80", align:"center"}
						]
						, onSelectRow : function(ids) {	// row click
	
							var rowdata = $("#counselCsInfoList").getRowData(ids);
	
							// 문의자 정보 설정
							if(rowdata.eqrrMbrNo == "<c:out value="${adminConstants.NO_MEMBER_NO}"/>"){
								counselAccept.setEqrrInfo(rowdata.stId, rowdata.stNm, rowdata.eqrrMbrNo, rowdata.eqrrNm, rowdata.eqrrTel, rowdata.eqrrMobile, rowdata.eqrrEmail );
							}
							
							counselInfoCs.detailView(rowdata.cusNo, rowdata.cusPathCd);
							
						}						
					};

					grid.create( "counselCsInfoList", options) ;
				}
			   // CS 목록 재조회
				,reload : function(){
					var options = {
						searchParam : $("#counselCsInfoForm").serializeJson()
					};

					grid.reload("counselCsInfoList", options);			

				}
			   // 상세 조회
			   , detailView : function(cusNo, cusPathCd){
				   var url = "";
				   if(cusPathCd == "<c:out value="${adminConstants.CUS_PATH_10}" />"){
					   url = "<spring:url value='/counsel/web/counselWebView.do' />";					   
// 						createTargetFormSubmit({
// 							  id : "counselWebView"
// 							, url : "<spring:url value='/counsel/web/counselWebView.do' />"
// 							, target : '_blank'
// 							, data : {
// 								cusNo : cusNo
// 								,viewGb : '${adminConstants.VIEW_GB_POP}'
// 							}
// 						});
				   }else{
					   url = "<spring:url value='/counsel/cc/counselCcView.do' />";		
// 						createTargetFormSubmit({
// 							  id : "counselCcView"
// 							, url : "<spring:url value='/counsel/cc/counselCcView.do' />"
// 							, target : '_blank'
// 							, data : {
// 								cusNo : cusNo
// 								,viewGb : '${adminConstants.VIEW_GB_POP}'
// 							}
// 						});
				   }
				   
				   $("#counselCsDetailCusNo").val(cusNo);
				   $("#counselCsDetailForm").attr("target", "counselAcceptCsDetail");
				   $("#counselCsDetailForm").attr("action", url);
				   $("#counselCsDetailForm").submit();
				   
			   }
				// 회원 조회
				, setMember : function(mbrNo){
					this.clearForm();
					$("#counselCsInfoMbrNo").val(mbrNo);
					this.reload();
				}
				// 비회원 조회
				, setNoMember : function(){
					this.clearForm();
					$("#counselCsInfoMbrNo").val("<c:out value="${adminConstants.NO_MEMBER_NO}"/>");

					$("#counselCsInfoStId").val($("#counselInfoNoMemStId").val()); 
					$("#counselCsInfoCusAcptDtmStart").val($("#acptDtmStart").val());
					$("#counselCsInfoCusAcptDtmEnd").val($("#acptDtmEnd").val());
					$("#counselCsInfoEqrrNm").val($("#counselInfoNoMemName").val());
					$("#counselCsInfoEqrrTel").val($("#counselInfoNoMemTel").val());
					$("#counselCsInfoEqrrMobile").val($("#counselInfoNoMemMobile").val());

					this.reload();
					
				}
				// 검색 영역 초기화
				, clearForm : function(){
					resetForm("counselCsInfoForm");
					
					//TODO snw 상세영역 초기화
// 					$("#counselAcceptCsDetail").html("");
				}

		   };
			   
			/*
			 * CS 접수 컨트롤
			 */
			var counselAccept = {
				// 문의자 정보 설정
				setEqrrInfo : function(stId, stNm, mbrNo, mbrNm, tel, mobile, email){
					if(stId != "" && stId != null){
						$("#counselAcceptStId").val(stId);
					}
					if(stNm != "" && stNm != null){
						$("#counselAcceptStNm").val(stNm);
					}
					if(mbrNo != "" && mbrNo != null){
						$("#counselAcceptEqrrMbrNo").val(mbrNo);
					}
					if(mbrNm != "" && mbrNm != null){
						$("#counselAcceptEqrrNm").val(mbrNm);
					}
					if($("#counselAcceptEqrrTel").val() == ""){
						$("#counselAcceptEqrrTel").val(validation.tel(tel));
					}
					if($("#counselAcceptEqrrMobile").val() == ""){
						$("#counselAcceptEqrrMobile").val(validation.mobile(mobile));
					}
					if(email != "" && email != null){
						$("#counselAcceptEqrrEmail").val(email);
					}
				}
				// CS 등록
				, insert : function(){
	                if ( validate.check("counselCcAcceptForm") ) {
	                	if(this.valid()){
	                		messager.confirm('<spring:message code="column.order_common.confirm.claim_cs_accept" />',function(r){
	                			if(r){
	                				var options = {
	    		                            url : "<spring:url value='/counsel/cc/insertCounsel.do' />"
	    		                            , data : $("#counselCcAcceptForm").serializeJson()
	    		                            , callBack : function(data){
	    		                            	messager.alert('<spring:message code="column.common.accept.final_msg" />',"Info","info",function(){
	    		                            		counselAccept.clear();
	    		                            	});	    		                                
	    		                            }
	    		                        };
	    	
	    		                        ajax.call(options);				
	                			}
	                		});
	                	}
	                }
					
				}
				, valid : function (){
					
					if( $("#counselAcceptEqrrTel").val() == "" && $("#counselAcceptEqrrMobile").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.phonenumber' />","Info","info");
						return false;
					}
				
					if($("#counsel_accept_process_rpl_yn").prop( "checked")){
						var cusRplCd = $("input[name=cusRplCd]:checked").val();
						if(cusRplCd == "<c:out value="${adminConstants.CUS_RPL_10}" />" && $("#counselAcceptEqrrMobile").val() == "") {
							messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.sms' />","Info","info");
							return false;
						}
						if(cusRplCd == "<c:out value="${adminConstants.CUS_RPL_20}" />" && $("#counselAcceptEqrrEmail").val() == "") {
							messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.email' />","Info","info");
							return false;
						}
					}
					
					return true;
				}
				// 참조정보 설정(주문)
				, setReferOrder : function(ordNo, ordDtlSeq){
					
					if(ordNo != $("#counselAcceptOrdNo").val()){
						this.clearRefer();	
					}
					
					$("#counselAcceptOrdNo").val(ordNo);
					
					var orgDtlSeqs = $("input[name=ordDtlSeqs]");

					var addYn = true;
					
					if(orgDtlSeqs.length > 0){
						for(var i=0; i <orgDtlSeqs.length; i++ ){
							if($(orgDtlSeqs[i]).val() == ordDtlSeq){
								addYn = false;
							}
						}
					}
				
					if(addYn){
						var addHtml = "<dd>";
						addHtml += "<input type=\"hidden\" id=\"counselAcceptOrdNo\" name=\"ordDtlSeqs\" value=\""+ordDtlSeq+"\" />" + ordDtlSeq;
						addHtml += "<button class=\"btn_type4 ordDtlSeqInfo ml2\" style=\"min-width:25px;\" onclick=\"counselAccept.removeRefer(this);\">삭제</button>";
						addHtml += "</dd>";
	
						$("#counselAcceptRefer").append(addHtml);
					}
				}
				// 연관정보 삭제
				, removeRefer : function(obj){
					$(obj).parent("dd").remove();
					if($(".seqlist dd").length == 0){
						$("#counselAcceptOrdNo").val("");
					}
				}
				// 참조정보 초기화
				, clearRefer : function(){
					$(".counsel_accept_refer").val("");
					$("#counselAcceptRefer dd").remove();
				}
				// 접수영역 초기화
				, clear : function(){
					resetForm("counselCcAcceptForm");
					this.clearRefer();
					$("#counselAcceptEqrrMbrNo").val("<c:out value="${adminConstants.NO_MEMBER_NO}"/>");
				}
				// 회신 여부 변경
				,changeRpl :function(){
					if($("#counsel_accept_process_rpl_yn").prop( "checked")){
						$(".process_rpl").show();
					}else{
						$(".process_rpl").hide();
						$("#counselAcceptRplHdContent").val('');
						$("#counselAcceptRplContent").val('');
						$("#counselAcceptRplFtContent").val('');
					}
				}
				// 유형 변경 이벤트
				, call : function(gb){
					var callNum = "";

					if($("#counselAcceptStId").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />","Info","info",function(){
							$("#counselAcceptStId").focus();
						});						
						return;
					}
					
					if($("#counselAcceptCusTpCd").val() != ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.call' />","Info","info");
						return;
					}
					
					if(gb == "T"){
						if($("#counselAcceptEqrrTel").val() == ""){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.phone' />","Info","info");
							return;
						}else{
							callNum = $("#counselAcceptEqrrTel").val();
						}
					}else{
						if($("#counselAcceptEqrrMobile").val() == ""){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.accept.phone' />","Info","info");
							return;
						}else{
							callNum = $("#counselAcceptEqrrMobile").val();
						}
					}
					// 상담 유형 OutBound 처리
					$("#counselAcceptCusTpCd").val("${adminConstants.CUS_TP_20}");
					
					ctiConnect.call($("#counselAcceptStId").val(), callNum);
				}
				
			};
			
			function goCsBoard() {
				addTab('CS게시판', '/csnotice/bbsLetterListView.do');
			}
			
			function changeCsTab(index) {
				var cur_tab = $('#counselAcceptInfoTab').find('.active').attr('data-target');
				var chg_li = $('#counselAcceptInfoTab').find('li:nth-child(' + (index+1) + ')');
				var chg_tab = chg_li.attr('data-target');
				
				$('#' + cur_tab).hide();
				$('#' + chg_tab).show();
				
				$('#counselAcceptInfoTab li').removeClass('active');
				$(chg_li).addClass('active');
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

	<div class="row">
		<!-- ==================================================================== -->
		<!-- 정보검색 -->
		<!-- ==================================================================== -->
		<div class="col-md-9">
			<div class="mTitle">
				<h2><spring:message code="column.counsel.accept.search" /></h2>
				<div class="buttonArea">
					<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd or adminConstants.USR_GB_1031 eq adminSession.usrGbCd}" >
					<button type="button" onclick="goCsBoard();" class="btn" style="margin-right:20px;">CS게시판 바로가기</button>
					</c:if>
					<select id="counselInfoSearchMemberYn">
						<option value="Y">회원</option>
						<option value="N">비회원</option>
					</select>
					<button type="button" onclick="counselInfoSearch.search();" class="btn btn-add">검색</button>
					<button type="button" onclick="counselInfoSearch.clear();" class="btn btn-add">초기화</button>
				</div>
			</div>
			
			<div id="memberView">
				<form name="counselInfoMemForm" id="counselInfoMemForm">
					<table class="table_type1">
						<caption>회원 검색</caption>
						<colgroup>
							<col style="width:125px;">
							<col />
							<col style="width:125px;">
							<col />
							<col style="width:125px;">
							<col style="width:300px;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td colspan="3">
									<select id="counselInfoMemStId" name="stId" title="사이트">
										<option value="">--선택--</option>
										<c:forEach items="${stList}" var="stInfo">
											<option value="${stInfo.stId}">${stInfo.stNm}</option>
										</c:forEach>
									</select>
								</td>
								<th><spring:message code="column.login_id"/></th>
								<td>
									<!-- 로그인 아이디-->
									<input type="text" class="mem_search" name="loginId" id="counselInfoMemLoginId" title="<spring:message code="column.login_id"/>" value="" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.mbr_nm"/></th>
								<td>
									<!-- 회원 명-->
									<input type="text" class="w100 mem_search" name="mbrNm" id="counselInfoMemMbrNm" title="<spring:message code="column.mbr_nm"/>" value="" />
								</td>
								<th><spring:message code="column.tel"/></th>
								<td>
									<!-- 전화-->
									<input type="text" class="w100 phoneNumber mem_search" name="tel" id="counselInfoMemTel" title="<spring:message code="column.tel"/>" value="" />
								</td>
								<th><spring:message code="column.mobile"/></th>
								<td>
									<!-- 휴대폰-->
									<input type="text" class="phoneNumber mem_search" name="mobile" id="counselInfoMemMobile" title="<spring:message code="column.mobile"/>" value="" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			
			<div id="nonMemberView">
				<form name="counselInfoNoMemForm" id="counselInfoNoMemForm">
					<table class="table_type1">
						<caption>비회원 검색</caption>
						<colgroup>
							<col style="width:125px;">
							<col />
							<col style="width:125px;">
							<col />
							<col style="width:125px;">
							<col style="width:300px;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st" /></th> <!-- 사이트 ID -->
								<td colspan="3">
									<select id="counselInfoNoMemStId" name="stId" title="사이트">
										<option value="">--선택--</option>
										<c:forEach items="${stList}" var="stInfo">
											<option value="${stInfo.stId}">${stInfo.stNm}</option>
										</c:forEach>
									</select>
								</td>
								<th><spring:message code="column.acptDtm" /></th>
								<td>
									<frame:datepicker startDate="acptDtmStart" endDate="acptDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.name" /></th>
								<td>
									<input type="text" class="w100 nomem_search" name="name" id="counselInfoNoMemName" title="<spring:message code="column.name"/>" value="" />
								</td>
								<th><spring:message code="column.tel"/></th>
								<td>
									<input type="text" class="w100 phoneNumber nomem_search" name="tel" id="counselInfoNoMemTel" title="<spring:message code="column.tel"/>" value="" />
								</td>
								<th><spring:message code="column.mobile"/></th>
								<td>
									<input type="text" class="phoneNumber nomem_search" name="mobile" id="counselInfoNoMemMobile" title="<spring:message code="column.mobile"/>" value="" />
								</td>
							</tr>
						</tbody>										
					</table>
				</form>
			</div>
			
			<div class="mTitle mt30">
				<h2><spring:message code="column.counsel.accept.search.result" /></h2>
			</div>
			
			<div class="box box border-t">
				<table class="table_info">
					<tbody>
						<tr>
							<th class="title"><spring:message code="column.counsel.status" /></th>
							<th><spring:message code="column.counsel.member_gb" /></th>
							<td><span id="counselInfoStatusMem" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.order_cnt" /></th>
							<td><span id="counselInfoStatusOrder" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.claim_ing_cnt" /></th>
							<td><span id="counselInfoStatusClaim" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.refund_" /></th>
							<td><span id="counselInfoStatusRefund" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.cs_cc_ing_cnt" /></th>
							<td><span id="counselInfoStatusCusCc" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.cs_web_ing_cnt" /></th>
							<td><span id="counselInfoStatusCusWeb" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.goods_cmt_cnt" /></th>
							<td><span id="counselInfoStatusGoodsCmt" class="counselInfoStatus"></span></td>
							<th><spring:message code="column.counsel.goods_inquiry_cnt" /></th>
							<td><span id="counselInfoStatusGoodsIqr" class="counselInfoStatus"></span></td>
						</tr>
					</tbody>
				</table>
			
				<div id="counselAcceptInfoTab" class="cs_tabs mt20">
					<ul>
						<li data-target="counselAcceptMemberInfo" class="active"><a href="#" onclick="javascript:changeCsTab(0);">고객 정보</a></li>
						<li data-target="counselAcceptOrderInfo"><a href="#" onclick="javascript:changeCsTab(1);">주문 정보</a></li>
						<li data-target="counselAcceptClaimInfo"><a href="#" onclick="javascript:changeCsTab(2);">클레임 정보</a></li>
						<li data-target="counselAcceptCsInfo"><a href="#" onclick="javascript:changeCsTab(3);">CS 정보</a></li>
					</ul>
				</div>
				<div class="box" style="border-top:none;">
					<!-- 고객정보 -->
					<div id="counselAcceptMemberInfo">
					<jsp:include page="/WEB-INF/view/counsel/include/incCounselAcceptMemberInfo.jsp" />
					</div>
					
					<!-- 주문 정보 -->
					<div id="counselAcceptOrderInfo" style="display:none;">
					<jsp:include page="/WEB-INF/view/counsel/include/incCounselAcceptOrderInfo.jsp" />
					</div>
					
					<!-- 클레임 정보 -->
					<div id="counselAcceptClaimInfo" style="display:none;">
					<jsp:include page="/WEB-INF/view/counsel/include/incCounselAcceptClaimInfo.jsp" />
					</div>
					
					<!-- CS 정보 -->
					<div id="counselAcceptCsInfo" style="display:none;">
					<jsp:include page="/WEB-INF/view/counsel/include/incCounselAcceptCsInfo.jsp" />
					</div>
				</div>	
			</div>
			<!-- ==================================================================== -->
			<!-- // 정보검색 -->
			<!-- ==================================================================== -->
		</div>
		<div class="col-md-3">
		<!-- ==================================================================== -->
		<!-- CS 등록 -->
		<!-- ==================================================================== -->
			<div class="mTitle gTitle">
				<h2><spring:message code="column.counsel.accept.regist" /></h2>
				<!-- 버튼 : 주문정보 수정 -->
				<div class="buttonArea">
		            <button type="button" class="btn btn-add" onclick="counselAccept.insert();">등록</button>
				</div>
			</div>
	
            <form id="counselCcAcceptForm" name="counselCcAcceptForm" method="post" >

                <table class="table_type1">
                    <caption>글 정보보기</caption>
                    <colgroup>
                        <col width="120px" />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="column.st" /><strong class="red">*</strong></th> 
                            <td>
								<select id="counselAcceptStId" name="stId" class="w100 validate[required]" title="사이트">
									<option value="">선택</option>
									<c:forEach items="${stList}" var="stInfo">
										<option value="${stInfo.stId}">${stInfo.stNm}</option>
									</c:forEach>
								</select>
                            </td>
						</tr>
                        <tr>
                            <th><spring:message code="column.cus_tp_cd" /><strong class="red">*</strong>
                            <td>
                                <select id="counselAcceptCusTpCd" name="cusTpCd" class="w100 validate[required]" title="<spring:message code="column.cus_tp_cd" />"  >
                                    <frame:select grpCd="${adminConstants.CUS_TP}" defaultName="선택" />
                                </select>
                            </td>
						</tr>
                        <tr>
                            <th><spring:message code="column.resp_gb_cd" /><strong class="red">*</strong>
                            <td>
                                <select id="counselAcceptRespGbCd" name="respGbCd" class="w100 validate[required]" title="<spring:message code="column.resp_gb_cd" />" >
                                    <frame:select grpCd="${adminConstants.RESP_GB }" defaultName="선택" />
                                </select>
                            </td>
						</tr>
						<tr>
                            <th scope="row"><spring:message code="column.cus_ctg" /><strong class="red">*</strong></th>
                            <td>
                            	<dl class="rowlist">
                            		<dt>
                            			대분류
                            		</dt>
                            		<dd>
		                                <select name="cusCtg1Cd" id="counselAcceptCusCtg1Cd" class="w100 validate[required]" title="<spring:message code="column.cus_ctg1_cd" />" >
		                                    <frame:select grpCd="${adminConstants.CUS_CTG1 }" defaultName="선택" />
		                                </select>
                            		</dd>
                            	</dl>
                            	<dl class="rowlist">
                            		<dt>
                            			중분류
                            		</dt>
                            		<dd>
		                                <select name="cusCtg2Cd" id="counselAcceptCusCtg2Cd" class="w100 validate[required]" title="<spring:message code="column.cus_ctg2_cd" />" >
		                                </select>
                            		</dd>
                            	</dl>
                            	<dl class="rowlist">
                            		<dt>
                            			소분류
                            		</dt>
                            		<dd>
		                                <select name="cusCtg3Cd" id="counselAcceptCusCtg3Cd" class="w100 validate[required]" title="<spring:message code="column.cus_ctg3_cd" />" >
		                                </select>
                            		</dd>
                            	</dl>
                            </td>
                        </tr>                    
                        <tr>
                            <th scope="row"><spring:message code="column.eqrr_info" /><strong class="red">*</strong></th>
                            <td>
                            	<dl class="rowlist">
                            		<dt><spring:message code="column.eqrr_nm" /></dt>
                                	<dd>
                                		<input type="hidden" id="counselAcceptEqrrMbrNo" name="eqrrMbrNo" value="" />
                                		<input type="text" class="w86 input_text validate[required, maxSize[50]]" id="counselAcceptEqrrNm" name="eqrrNm" title="<spring:message code="column.eqrr_nm" />" value="" />
                                		
                                	</dd>
								</dl>
                            	<dl class="rowlist">
                            		<dt><spring:message code="column.call_gb_cd" /></dt>
                                	<dd>
		                                <select id="counselAcceptCallGbCd" name="callGbCd" class="w100 validate[required]" title="<spring:message code="column.call_gb_cd" />" >
		                                    <frame:select grpCd="${adminConstants.CALL_GB }" defaultName="선택" />
		                                </select>
                                	</dd>
								</dl>
								
                            	<dl class="rowlist">
                            		<dt><spring:message code="column.tel" /></dt>
                                	<dd>
                                		<input type="text" class="w86 phoneNumber validate[maxSize[20], custom[tel]]" id="counselAcceptEqrrTel" name="eqrrTel" title="<spring:message code="column.eqrr_tel" />" value="" />
                                		<!-- 2017.9.29, CTI 연동 중단 처리  -->
                                		<%--c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_1030 or adminSession.usrGbCd eq adminConstants.USR_GB_1031}">
                                		<button class="btn_type4" onclick="counselAccept.call('T'); return false;">전화걸기</button>
                                		</c:if --%>
                                	</dd>
								</dl>
                                <dl class="rowlist">
                                	<dt><spring:message code="column.mobile" /></dt>
                                	<dd>
                                		<input type="text" class="w86 phoneNumber validate[maxSize[20], custom[mobile]]" id="counselAcceptEqrrMobile" name="eqrrMobile" title="<spring:message code="column.eqrr_mobile" />" value="" />
                                		<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_1030 or adminSession.usrGbCd eq adminConstants.USR_GB_1031}">
                                		<button class="btn_type4" onclick="counselAccept.call('M'); return false;">전화걸기</button>
                                		</c:if>
                                	</dd>
								</dl>
                                <dl class="rowlist">
                                	<dt><spring:message code="column.email" /></dt>
	                                <dd><input type="text" class="validate[maxSize[100], custom[email]]" id="counselAcceptEqrrEmail" name="eqrrEmail" title="<spring:message code="column.eqrr_email" />" value="" /></dd>
								</dl>
                            </td>
						</tr>
						<tr>
                            <th scope="row"><spring:message code="column.order_common.cs_ttl" /><strong class="red">*</strong></th>
                            <td>
                                <input type="text" class="validate[required, maxSize[30]]" id="counselAcceptTtl" name="ttl" title="<spring:message code="column.order_common.cs_ttl" />" value="">
                            </td>
                        </tr>
						<tr>
                            <th scope="row"><spring:message code="column.order_common.cs_content" /><strong class="red">*</strong></th>
                            <td>
                                <textarea rows="3" id="counselAcceptContent" name="content" maxlength="1500" class="validate[required, maxSize[1500]]" style="width:92%"></textarea>
                            </td>
                        </tr>
						<tr>
                            <th scope="row"><spring:message code="column.prcs_content" /><strong class="red">*</strong></th>
                            <td>
                                <textarea rows="3" id="counselAcceptPrcsContent" name="prcsContent" maxlength="1500" class="validate[required, maxSize[1500]]" style="width:92%"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><spring:message code="column.counsel.accept.refer" /></th>
                            <td>
                            	<dl class="rowlist">
                            		<dt><spring:message code="column.ord_no" /></dt>
                                	<dd><input type="text" class="validate[maxSize[15]] counsel_accept_refer" id="counselAcceptOrdNo" name="ordNo" title="<spring:message code="column.ord_no" />" value="" /></dd>
								</dl>
                            	<dl class="seqlist" id="counselAcceptRefer">
                            		<dt><spring:message code="column.ord_dtl_seq" /></dt>
								</dl>                            
							</td>
						</tr>
						<tr>
							<th scope="row">최종완료<strong class="red">*</strong></th>
							<td>
								<label class="fRadio"><input type="radio" name="lastRplYn" class="validate[required]" value="Y" /><span>예</span></label>
								<label class="fRadio"><input type="radio" name="lastRplYn" class="validate[required]" value="N" /><span>아니오</span></label>
								<p>
								* 최종 완료처리 하고자 하는경우 '예'를 선택하시기 바랍니다.
								</p>
							</td>
						</tr>						
						<tr>
							<th scope="row">고객회신</th>
							<td> 
								<label class="fCheck"><input type="checkbox" id="counsel_accept_process_rpl_yn" value="Y" /><span>예</span></label>
							</td>
						</tr>
						<tr class="process_rpl" style="display:none;">
							<th scope="row" rowspan="5"><spring:message code='column.rpl_content' /></th>
							<td>
								<select name="replType" id="counselAcceptReplType" title="<spring:message code="column.disp_yn"/>" >
									<frame:select grpCd="${adminConstants.REPLY_TYPE_TP}" defaultName="머리말/맺음말 유형"/>
								</select>
							</td>
						</tr>
						<tr class="process_rpl" style="display:none;">
							<td style="border-bottom:none;" >
								<input type="text" class="readonly" name="rplHdContent" id="counselAcceptRplHdContent" title="<spring:message code="column.rpl_hd_content"/>" value="" />
							</td>
						</tr>
						<tr class="process_rpl" style="display:none;">
							<td style="border-bottom:none;" >
								<textarea rows="3" class="mt5 validate[required]" id="counselAcceptRplContent" name="rplContent" style="width:92%"></textarea>
							</td>
						</tr>
						<tr class="process_rpl" style="display:none;">
							<td>
								<input type="text" class="readonly mt5" name="rplFtContent" id="counselAcceptRplFtContent" title="<spring:message code="column.rpl_ft_content"/>" value="" />
							</td>						
						</tr>
						<tr class="process_rpl" style="display:none;">
							<td>
								<frame:radio name="cusRplCd" grpCd="${adminConstants.CUS_RPL}" />
							</td>						
						</tr>                        
                    </tbody>
                </table>
            </form>
	           
		<!-- ==================================================================== -->
		<!-- // CS 등록 -->
		<!-- ==================================================================== -->
		</div>
	</div>


	</t:putAttribute>
</t:insertDefinition>