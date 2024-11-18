<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script src="/js/member.js"></script>
		<script type="text/javascript">
			function createMenuTree() {
				$("#twcCsTree").jstree({//tree 생성
					core : {
						multiple : false
						, data : {
							type : "POST"
							, url : function (node) {
								return "";
							}
						}
					}
					, plugins : [ "themes" ]
				})
					// event 핸들러 :: 매장 클릭시 이벤트
					.on('changed.jstree', function(e, data) {

					})
					.bind("ready.jstree", function (event, data) {
						//$("#twcCsTree").jstree("open_all");
					});
			}

			//회원 검색
			function fnGetMemberBaseInShort(inqrHistNo){
				var validate = false;
				var loginId = $("#memberSearchForm [name='loginId']").val();
				var mobile = $("#memberSearchForm [name='mobile']").val();
				var email = $("#memberSearchForm [name='email']").val();
				var mbrNo = $("#memberSearchForm [name='mbrNo']").val();

				validate = loginId != "" || mobile != "" || email != "" || mbrNo != "" ;
				if(!validate){
					messager.alert("<span class='messager-font'>조회 조건이 입력되지 않아, 고객조회가 가능하지 않습니다.</span></br>" +
							"<span class='messager-font'>1개 이상의 고객정보를 입력 하신 후, 고객조회를 하시기 바랍니다.</span>","알림");
				}else if(validate && email != "" && !/^[^\sㄱ-ㅎㅏ-ㅣ가-힣]*@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)){
					validate = false;
					messager.alert("이메일을 다시 입력해주세요.","Info");
				}

				var data = $("#memberSearchForm").serializeJson();
				if(inqrHistNo != undefined && inqrHistNo != null){
					data.cnctHistNo = $("#hidden-field [name='cnctHistNo']").val();
					data.inqrHistNo = inqrHistNo;
					data.maskingUnlock = "${adminConstants.COMM_YN_Y}";
				}else{
					data.cnctHistNo = $("#hidden-field [name='cnctHistNo']").val();
				}

				if(validate) {
					var options = {
						url: "<spring:url value='/member/getMemberBaseInShort.do' />"
						, data: data
						, type: "GET"
						, dataType: "html"
						, callBack: function (result) {
							$("#memberInfoDiv").replaceWith(result);

							if($("#memberInfoDiv [name='mbrNo']").val() == ""){
								$("#memberInfoDiv").empty();
								$("#member-tab").replaceWith('<div id="member-tab" class="mt30"></div>');
								fnInitView();
								messager.alert("<span class='messager-font red'>입력하신 조회조건으로 해당하는 결과가 없습니다.</span>" +
										"</br><span class='messager-font'>&nbsp;조회조건을 다시 확인하시어 입력해주세요.</span>","Info");
							}else if($("#memberInfoDiv [name='mbrStatCd']").val() == "${adminConstants.MBR_STAT_30}"){
								var mbrNm = $("#memberInfoDiv #mbr-nm-txt").text();
								var txt = "<span class='red' style='font-size:12px;'><" + mbrNm + "></span>" + "님의 회원상태가 현재 휴면 상태입니다.";

								var ok = {
										txt : "<button class='btn btn-ok'>휴면상태 해제</button>"
									,	callBack : function(){
											fnUpdateMbrStatCd("${adminConstants.MBR_STAT_10}");
									}
								};
								messager.confirm(txt,function(r){},"휴면상태 알림",function(){
									$(".messager-button").empty();
									var html =  "";
									html += "<div clas='btn_area_center'>";
									html += "<button class=\"btn btn-ok\" onClick=\"fnUpdateMbrStatCd(10);$('.panel-tool-close').trigger('click');\" >휴면 해제</button>"
									html += "<button class=\"btn ml10\" onClick=\"memberTab.init();twcTab.init();$('.panel-tool-close').trigger('click');\" >닫기</button>"
									html += "</div>";
									$(".messager-button").append(html);
								});
							}else{
								memberTab.init();
								twcTab.init();
							}
						}
					};
					ajax.call(options);
				}
			}

			//강성고객 지정/해제
			function fnMemberDffcMbrYn(dffcMbrYn){
				var msg = dffcMbrYn == "${adminConstants.COMM_YN_Y}" ? "강성고객 지정 하시겠습니까?" : "강성고객 해제 하시겠습니까?" ;
				messager.confirm(msg,function(r){
					if(r){
						var data = {
							dffcMbrYn : dffcMbrYn
							, mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
						};

						var options = {
							url : "<spring:url value='/member/memberUpdate.do' />"
							,	data : data
							,	callBack : function(result){
									fnGetMemberBaseInShort();
							}
						};
						ajax.call(options);
					}
				},'알림');
			}

			//개인정보 숨김/해제
			function fnUnlockPrivacyMasking(){
				messager.confirm("<spring:message code='column.member_search_view.maksing_unlock_msg' />",function(r){
					if(r){
						var data = {
								cnctHistNo : $("#hidden-field [name='cnctHistNo']").val()
							,	mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
							,	inqrHistNo : $("#hidden-field [name='inqrHistNo']").val()
						};
						var options = {
							url : "<spring:url value='/member/unlockPrivacyMasking.do' />"
							,	data : data
							,	callBack : function(result){
									$("[name='maskingUnlock']").val("${adminConstants.COMM_YN_Y}");
									fnGetMemberBaseInShort(data.inqrHistNo);
							}
						};
						ajax.call(options);
					}
				});
			}

			//회원 상태 변경 팝업
			function fnConfirmMbrStatUpdate(){
				messager.confirm("회원 상태를 변경 하시겠습니까?",function(r){
					if(r){
						var mbrStatCd = $("[name=mbrStatCd] option:selected").val();
						fnUpdateMbrStatCd(mbrStatCd);
					}
				},"회원 상태 변경");
			}

			//회원 상태 변경
			function fnUpdateMbrStatCd(mbrStatCd){
				var data = {
						mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
					, 	mbrStatCd : mbrStatCd
					,	stId : $("[name='stId']").val()
				};

				if($("[name='mbrStatCd']").data("original") == parseInt("${adminConstants.MBR_STAT_30}")){
					data.dormantRlsYn = "${adminConstants.COMM_YN_Y}";
				}

				var aplVal = $("[name=mbrStatCd]").data("original") + ";" + $("[name=mbrStatCd] option:selected").val();

				if($("#memberInfoDiv [name='maskingUnlock']").val() === "${adminConstants.COMM_YN_Y}"
						&&  parseInt($("[name=mbrStatCd]").data("original")) != parseInt($("[name=mbrStatCd] option:selected").val())){
					data.cnctHistNo = $("#hidden-field [name='cnctHistNo']").val();
					data.aplVal = aplVal;
				}

				var options = {
					url : "<spring:url value='/member/updateMemberStatCd.do' />"
					,	data : data
					,	callBack : function(result){
							fnControllMbrStatSelect(mbrStatCd);
							//회원 상태 변경하였으면 data-original 변경
							$("[name='mbrStatCd']").data("original", mbrStatCd);							
					}
				};
				ajax.call(options);
			}

			//회원 상태 셀렉트 박스 제어
			function fnControllMbrStatSelect(mbrStatCd){
				var $isShow = null;
				$("#mbrStatUpdateBtn").show();
				//블랙
				if(mbrStatCd == "${adminConstants.MBR_STAT_60}"){
					$("[name='mbrStatCd'] option").hide();
					$isShow = $("option[value='${adminConstants.MBR_STAT_10}'] , option[value='${adminConstants.MBR_STAT_60}']");
				}
				//부당 거래
				else if(mbrStatCd == "${adminConstants.MBR_STAT_80}"){
					$("[name='mbrStatCd'] option").hide();
					$isShow = $("option[value='${adminConstants.MBR_STAT_10}'] , option[value='${adminConstants.MBR_STAT_80}']");
				}
				//휴면
				else if(mbrStatCd == "${adminConstants.MBR_STAT_30}"){
					$isShow = $("option[value='${adminConstants.MBR_STAT_30}']");
					$("[name='mbrStatCd']").prop("disabled",true);
					$("#mbrStatUpdateBtn").hide();
				}
				//정상
				else if(mbrStatCd == "${adminConstants.MBR_STAT_10}"){
					$isShow = $("option[value='${adminConstants.MBR_STAT_10}'] , option[value='${adminConstants.MBR_STAT_30}'] , option[value='${adminConstants.MBR_STAT_60}'] , option[value='${adminConstants.MBR_STAT_80}']");
					$("[name='mbrStatCd']").prop("disabled",false);
				}

				if($isShow != null){
					$("[name='mbrStatCd']").find($isShow).show();
				}

				$("[name='mbrStatCd'] option").prop("selected",false);
				$("[name='mbrStatCd'] option[value='"+mbrStatCd+"']").prop("selected",true);
			}

			//휴대폰 변경 이력
			function fnMobileHistoryLayerPop(){
				var data = {
						mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
					,	maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
					,	type : "MDN"
				};
				var options = {
					url : "<spring:url value='/member/memberMobileHistoryLayerPop.do' />"
					,	data : data
					, 	dataType : "HTML"
					, 	callBack : function(result){
						$("#memberMobileHistoryLayer").remove();
						var config = {
							id : "memberMobileHistoryLayer"
							, title : "MDN 변경 history"
							, body : result
							, height : "630"
							, button : "<button type='button' onclick='layer.close(\"memberMobileHistoryLayer\");' class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
			}

			//회원 쿠폰 상세 팝업
			function fnMemberCouopnLayerPop(){
				var data = {
						mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
					,	maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
					,	type : "CP"
				};
				var options = {
					url : "<spring:url value='/member/memberCouponLayerPop.do' />"
					, data : data
					, dataType : "HTML"
					, callBack : function(result){
						$("#memberCouponLayer").remove();
						var config = {
							id : "memberCouponLayer"
							, width : 1000
							, height : 680
							, title : "쿠폰 상세 내역"
							, body : result
							, button : "<button type='button' onclick='layer.close(\"memberCouponLayer\");' class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
			}

			// '배송지 확인' 버튼
			function fnMemberAddressViewPop(){
				var data = {
						mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
					,	maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
					,	type : "ADR"
				};
				var options = {
					url : "<spring:url value='/member/memberAddressViewPop.do' />"
					, data : data
					, dataType : "HTML"
					, callBack : function(result){
						var config = {
							id : "memberAddressLayer"
							, width : 1000
							, height : 630
							, title : "배송지 정보"
							, body : result
							, button : "<button type='button' onclick='layer.close(\"memberAddressLayer\");' class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
			}

			//간편 카드 레이어 팝업
			function fnSimpleMemberCardLayerPop(){
				var data = {
					mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
					,	maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
					,	type : "CARD"
				};
				var options = {
					url : "<spring:url value='/member/memberSimpleCardListViewPop.do' />"
					, data : data
					, dataType : "HTML"
					, callBack : function(result){
						var config = {
							id : "memberCardLayer"
							, width : 1000
							, height : 630
							, title : "간편결제 상세 내역"
							, body : result
							, button : "<button type='button' onclick='layer.close(\"memberCardLayer\");' class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
			}
			
			//우주코인 레이어 팝업
			function fnSktmpLayerPop(){
				var data = {
						mbrNo : $("#memberInfoDiv  [name='mbrNo']").val()
						,	maskingUnlock : $("#hidden-field [name='maskingUnlock']").val()
						,	type : "SKTMP"
					};
					var options = {
						url : "<spring:url value='/member/memberSktmpLayerPop.do' />"
						, data : data
						, dataType : "HTML"
						, callBack : function(result){
							var config = {
								id : "memberSktmpLayer"
								, width : 1000
								, height : 630
								, title : "우주코인 상세내역"
								, body : result
							}
							layer.create(config);
						}
					};
					ajax.call(options);
			}

			//반려동물 상세 화면 뷰
			function fnMemberPetDetatilView(){
				var url = "/member/memberPetView.do?mbrNo=" + $("#hidden-field [name='mbrNo']").val();
				addTab("반려동물 조회", url);
			}

			//초기화
			function fnInitView(){
				resetForm('memberSearchForm');
				$("[name='url']").val("${url}");
				var searchFlag =  $("#memberSearchForm [name='mbrNo']").val() != "";
				var ajaxOptions = {
					url: "<spring:url value='/member/getMemberBaseInShort.do' />"
					, data : searchFlag ? $("#memberSearchForm").serializeJson() : {}
					, type: "GET"
					, dataType: "html"
					, callBack: function (result) {
						$("#memberInfoDiv").replaceWith(result);
					}
				};
				ajax.call(ajaxOptions);

				if(searchFlag){
					memberTab.init();
				}else{
					$("#member-tab").tabs();

					memberTab.createTab(memberPayTabNm,"/member/memberPayView.do",{id:'iframe-memberPayView',isSearch:false});
					memberTab.createTab(memberPetLogTabNm,"/member/memberPetLogView.do",{id:'iframe-memberPetLogView',isSearch:false});
					memberTab.createTab(memberGoodsReviewTabNm,"/member/memberGoodsReview.do",{id:'iframe-memberGoodsReview',isSearch:false});
					memberTab.createTab(memberReplyTabNm,"/member/memberReplyView.do",{id:'iframe-memberReplyView',isSearch:false});
					memberTab.createTab(memberReportTabNm,"/member/memberReportView.do",{id:'iframe-memberReportView',isSearch:false});
					memberTab.createTab(memberTagFollowTabNm,"/member/memberTagFollow.do",{id:'iframe-memberTagFollow',isSearch:false});
					//memberTab.createTab(memberRecommandTabNm,"/member/memberRecommandView.do",{id:'iframe-memberRecommandView',isSearch:false});
					memberTab.createTab(memberFollowTabNm,"/member/memberFollowView.do",{id:'iframe-memberFollowView',isSearch:false});
					memberTab.createTab(memberGoodsIoTabNm,"/member/memberGoodsIoView.do",{id:'iframe-memberGoodsIoView',isSearch:false});
					memberTab.createTab(memberCsTabNm,"/member/memberCsListView.do",{id:'iframe-memberCsListView',isSearch:false});

					$("#member-tab").tabs('select', memberPayTabNm,false);
				}

				twcTab.init();
			}
			
			// 이메일 변경
			function emailUpdateViewPop() {
				var options = {
					  url : '/member/emailUpdateViewPop.do'
					, data : {nickNm : $("#nickName").val()}
					, dataType : "html"
					, callBack : function(result) {
						var config = {
							 id : 'emailUpdateViewPopLayer'
							,width : 500
							,height: 190
							,title : '알림'
							,button : "<button type='button' onclick='emailUpdate();' class='btn btn-ok' disabled>변경</button>"
							,body : result
						}
						layer.create(config);	
						
						$("#emailUpdateViewPopLayer_dlg-buttons .btn-cancel").text("취소");
					}			
				}
				ajax.call(options);
			}
			
			function emailUpdate() {
				var options = {
						url : '/member/emailUpdate.do'
						, data : {
							mbrNo : $("#memberInfoDiv [name='mbrNo']").val()
							, email : $("#emailUpdateViewPopLayer #email").val()
						}
						, callBack : function(result) {
							if(result == "${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}") {
								messager.alert('이메일이 변경되었습니다.', "Info", "info", function(){ 
									layer.close("emailUpdateViewPopLayer");
									
									var inqrHistNo = $("#hidden-field [name='inqrHistNo']").val();
									if($("#hidden-field [name='maskingUnlock']").val() === "${adminConstants.COMM_YN_N}")	inqrHistNo = null;
									fnGetMemberBaseInShort(inqrHistNo);
								});	
							}
						}			
				}
				ajax.call(options);
			}

			$(function(){
				//회원 번호
				$(document).on("input chnage paste","[name='mbrNo']",function(){
					let inputVal = $(this).val();
					$("[name='mbrNo']").val(inputVal.replace(/[^\d]/g,""));
				});

				//모바일
				$(document).on("input chnage paste","[name='mobile']",function(){
					let inputVal = $(this).val();
					$("[name='mobile']").val(inputVal.replace(/[^\d|^-]/g,""));
				})

				$(document).on("keyup",function(e){
					if ( e.keyCode == 13 ) {
						//fnGetMemberBaseInShort();
					}
				})

				fnInitView();
			});
			
           $(document).ready(function(){
              
              $(document).on("keydown","#memberSearchForm input",function(){
      			if ( window.event.keyCode == 13 ) {
      				fnGetMemberBaseInShort();
    		  	}
              });
           });			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<style>
			.messager-font{
				font-size:11px;
			}
		</style>
		<!-- 회원 검색 폼-->

		<input type="hidden" id="adminSessionUsrNm" value="${adminSession.usrNm}" />
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="memberSearchForm" id="memberSearchForm">
					<input type="hidden" name="url" value="${url}" />
					<select id="stId" name="stId" style="display:none;"><frame:stIdStSelect /></select>
					<table class="table_type1">
						<colgroup>
							<col width="8%" />
							<col width="12%" />
							<col width="8%" />
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<%--<col width="15%" />
							<col width="8%" /> --%>
						</colgroup>
						<tbody>
						<tr>
							<th>회원ID</th>
							<td>
								<input type="text" class="w100" name="loginId" id="loginId" value="${search.loginId}"/>
							</td>

							<th>휴대폰</th>
							<td>
								<input type="text" class="phoneNumber validate[custom[mobile]] w150" name="mobile" id="mobile" value="${search.mobile}" />
							</td>

							<th>이메일</th>
							<td>
								<input type="text" class="w150" name="email" id="email" value="${search.email}" />
							</td>

							<th>User-no</th>
							<td>
								<input type="text" class="w100" name="mbrNo" id="mbrNo" value="${search.mbrNo}" />
							</td>

							<%--<th>상품권 번호</th>
							<td>
								<input type="text" name="" id="" value="" style="width:150px"/>
							</td>--%>
						</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="fnInitView();" class="btn btn-cancel">초기화</button>
					<button type="button" onclick="fnGetMemberBaseInShort();" class="btn btn-ok">조회</button>
				</div>
			</div>
		</div>

		<!-- 회원 기본 정보-->
		<jsp:include page="./memberBaseInfo.jsp"/>

		<!-- 거래 내역,펫로그,상품 리뷰내역,댓글 내역,신고된 내역,추천 내역,친구등록 내역-->
		<div id="member-tab" class="mt30" style="width:100%;"></div>

		<!--회원 상담 이력 -->
		<%--<div class="mt30">
			<div id="member-twc-tab" style="display: inline-block;height:500px;width:40%;"></div>
			<div id="member-tws-cs-list" style="display:inline-block;width:59%;height:500px;">
				<div class="col-md-3" style="display:inline-block;width:40%;padding-right:0;">
					<div class="mTitle" style="width:290px;">
						<input type="text" id="" name="" style="width:8.1em;"/>
						<div class="buttonArea ml5">
							<button type="button" onclick="" class="btn btn-add">초기화</button>
							<button type="button" onclick="" class="btn btn-add ml5">검색</button>
						</div>
					</div>
					<div class="tree-menu" style="width:40%;">
						<div class="gridTree" id="twcCsTree" style="height:449px;"></div>
					</div>
				</div>
				<div class="col-md-3" style="display:inline-block;width:57%;height:100%;padding-right:0;">
					<jsp:include page="./twcTab/indexTwcCsRegisterList.jsp"/>
				</div>
			</div>
		</div>--%>
	</t:putAttribute>
</t:insertDefinition>
<style>
.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
</style>
