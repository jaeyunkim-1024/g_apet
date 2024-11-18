<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			// idCheck 여부
			var idCheck = false;

			$(document).ready(function(){
				$("#bbsId").validationEngine();
				changeBbsTpCd ();
			});
			
			// 사이트 검색
			function searchSt () {
				var options = {
					multiselect : false
					, callBack : searchStCallback
				}
				layerStList.create (options );
			}
			function searchStCallback (stList ) {
				if(stList.length > 0 ) {
					$("#stId").val (stList[0].stId );
					$("#stNm").val (stList[0].stNm );
				}
			}
			<c:if test="${empty board}">
			
				//사용안하는 구분자 숨기기
				$(document).on("click", "input[name=gbUseYn]", function(e){
					if($(this).val() == "Y") {
						$("#gbUseView").show();
					} else {
						$("#gbUseView").hide();
					}
				});
	
				//사용안하는 파일 숨기기
				$(document).on("click", "input[name=flUseYn]", function(e){
					console.log( $(this) );
					if($(this).val() == "Y") {
						$("#flUseView").show();
					} else {
						$("#flUseView").hide();
					}
				});
			
				// ID 체크로직
				$(document).on("blur", "#bbsId", function(e){
					if(!validate.check("bbsId")) {
						var options = {
							url : "<spring:url value='/system/bbsIdCheck.do' />"
							, data : $("#boardForm").serializeJson()
							, callBack : function(result){
								if(result.checkCount > 0){
									idCheck = false;
									$('#bbsId').validationEngine('showPrompt', result.message, 'error', true);
								} else {
									idCheck = true;
									$('#bbsId').validationEngine('showPrompt', "사용가능한 게시판 아이디 입니다.", 'pass', true);
								}
							}
						};
						ajax.call(options);
					} else {
						idCheck = false;
					}
				});
			</c:if>

		//게시글 등록
			function boardInsert(){
				if(!idCheck) {
					$('#bbsId').validationEngine('showPrompt', "게시판 아이디를 확인해 주세요", 'error', true);
					return;
				}

				if(validate.check("boardForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var data = $("#boardForm").serializeJson();

							//구분자 리스트 담기
							if($("input[name=gbUseYn]:checked").val() == "${adminConstants.GB_USE_YN_Y}") {
								var gbArr = new Array();
								$(".bbsGbAddView").each(function(e) {  // 추가된 구분자를 배열로 담는다.
									gbArr.push($(this).serializeJson());
								});
								data.bbsInGbStr = JSON.stringify(gbArr); //배열을 다시 string형태로 바꿈
							}

							var options = {
								url : "<spring:url value='/system/boardInsert.do' />"
								, data : data
								, callBack : function(result){
									updateTab('/system/boardView.do?bbsId=' + $("#bbsId").val(), '게시판 정보 상세');
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			//게시판 수정
			function boardUpdate(){
				if(validate.check("boardForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var data = $("#boardForm").serializeJson();

							//파일관련 초기화
							$('#uploadExt').val('');
							$('#atchFlCnt').find('option:first').attr('selected', 'selected');

							//구분자 리스트 담기
							if($("input[name=gbUseYn]:checked").val() == "${adminConstants.GB_USE_YN_Y}") {
								var gbArr = new Array();
								$(".bbsGbAddView").each(function(e) {  // 추가된 구분자를 배열로 담는다.
									gbArr.push($(this).serializeJson());
								});
								data.bbsInGbStr = JSON.stringify(gbArr); //배열을 다시 string형태로 바꿈
							}

							var options = {

								url : "<spring:url value='/system/boardUpdate.do' />"
								, data : data
								, callBack : function(result){
									updateTab();
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			//게시판 삭제
			function boardDelete() {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var sendData ={
							bbsId : $("#bbsId").val()
						}
						var options = {
							url : "<spring:url value='/system/boardDelete.do' />"
							, data : $("#boardForm").serializeJson()
							, callBack : function(result) {
								messager.alert('<spring:message code="column.display_view.message.delete" />', "Info", "info", function(){
									closeGoTab('게시판 정보 목록', '/system/boardListView.do');	
								});
							}
						};
						ajax.call(options);
					}
				})
			}

			//구분자 추가
			function addGb() {
				var html = new Array();
				html.push('<div class="bbsGbAddView mb5">');
				html.push('	<input type="hidden" name="bbsGbNo" title="" value="" />');
				html.push('	<input type="text" class="validate[required]" name="bbsGbNm" title="" value="" />');
				html.push('	<button type="button" class="btn" onclick="deleteGb(this);" ><spring:message code="column.common.delete" /></button>');
				html.push('</td>');
				$("#gbView").append(html.join(""));
			}

			//구분자 삭제
			function deleteGb(obj) {
				var cnt = $("#gbView .bbsGbView").length + $("#gbView .bbsGbAddView").length;

				if(cnt > 1) {//구분자에 글이 있을 경우
					if(validation.isNull($(obj).siblings("input[name=bbsGbNo]").val())) {	// 게시글이 존재하지 않을 경우
						$(obj).parent().remove();
					} else {
						//게시글이 존재 할 경우
						messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
							if(r){
								var sendData = {
									  bbsId : $("#bbsId").val()
									, bbsGbNo : $(obj).siblings("input[name=bbsGbNo]").val()
								}
								 var options = {
									url : "<spring:url value='/system/boardGbDelete.do' />"
									, data : sendData
									, callBack : function(result){
										$(obj).parent().remove();
									}
								};
								ajax.call(options);
							}
						})
					}
				} else {
					messager.alert('<spring:message code="admin.web.view.msg.board.deleteGb" />', "Info", "info");
					return;
				}
			}
			
			// callback : 업체 검색
			function searchCompany(){
				var options = {
					  multiselect : false
					, callBack : function(compList){
						if(compList.length > 0){
							$("#compNo").val (compList[0].compNo);
							$("#compNm").val (compList[0].compNm);
						}
					}
				}
				layerCompanyList.create (options);
			}
			
			// 게시판 유형 코드 구분에 따른 처리
			function changeBbsTpCd () {
				var BbsTpCd = $("#bbsTpCd").children("option:selected").val();
				console.log( "BbsTpCd : " + BbsTpCd + " ${adminConstants.BBS_TP_11 } : " + ${adminConstants.BBS_TP_11 } );
				if (BbsTpCd == "${adminConstants.BBS_TP_11 }" ) {
					$("#strongRed").show();
					objClass.add ($("#compNm"), "validate[required]" );
				} else {
					$("#strongRed").hide();
					objClass.remove ($("#compNm"), "validate[required]" );
				}
			
			}
			
			// 이미지 업로드 결과
			function resultBbsImage(result) {
				$("#imgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
				$("#bbsImgPath").val(result.filePath);
			}
			
			function deleteImage() {
				$("#bbsImgPath").val("");
				$("#imgPathView").attr('src', '/images/noimage.png' );
			}
			
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<!-- 코드 넣는곳 -->
			<div class="mTitle">
				<h2>게시판 등록</h2> 
			</div>
				
			<form name="boardForm" id="boardForm" method="post">
			<input type="hidden" id="stId" name="stId" value="1" />
			<table class="table_type1">
				<caption>게시판  등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.bbs_id"/><strong class="red">*</strong></th>
						<td>
							<!-- 게시판 ID-->
							<c:if test="${empty board}">
								<input type="text" class="validate[required]" name="bbsId" id="bbsId" title="<spring:message code="column.bbs_id"/>" value="${board.bbsId}" maxlength="10"/>
							</c:if>
							<c:if test="${not empty board}">
								<input type="text" class="readonly validate[required]" name="bbsId" id="bbsId" title="<spring:message code="column.bbs_id"/>" value="${board.bbsId}" readonly="readonly"/>
							</c:if>
						</td>
						<th><spring:message code="column.bbs_nm"/><strong class="red">*</strong></th>
						<td>
							<!-- 게시판 명-->
							<input type="text" class="validate[required, maxSize[100]]" name="bbsNm" id="bbsNm" title="<spring:message code="column.bbs_nm"/>" value="${board.bbsNm}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.bbs_tp_cd"/><strong class="red">*</strong></th>
						<td>
							<!-- 게시판 유형 코드-->
							<!--frame:radio name="bbsTpCd" grpCd="${adminConstants.BBS_TP}" selectKey="${board.bbsTpCd}"/-->
							<select id="bbsTpCd" name="bbsTpCd" onchange="changeBbsTpCd();">
								<frame:select grpCd="${adminConstants.BBS_TP }" defaultName="선택" showValue="false" selectKey="${board.bbsTpCd}"/>
							</select>
						</td>
						<th><spring:message code="column.scr_use_yn"/><strong class="red">*</strong></th>
						<td>
							<!-- 비밀 사용 여부-->
							<frame:radio name="scrUseYn" grpCd="${adminConstants.SCR_USE_YN}" selectKey="${board.scrUseYn}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.fl_use_yn"/><strong class="red">*</strong></th>
						<td>
							<!-- 파일 사용 여부 -->
							<frame:radio name="flUseYn" grpCd="${adminConstants.FL_USE_YN}" selectKey="${board.flUseYn}" disabled="${not empty board.flUseYn ? true : false }"/>
						</td>
						<%-- <th><spring:message code="column.st_id" /><strong class="red">*</strong></th>
						<td>						
							<!-- 사이트 ID-->
							<frame:stId funcNm="searchSt()" requireYn="Y" defaultStNm="${board.stNm }" defaultStId="${board.stId }" />
						</td> --%>
					</tr>
					<tr id="flUseView" ${board.flUseYn eq adminConstants.FL_USE_YN_Y or empty board.flUseYn ? '' : 'style="display:none;"'} >
						<th><spring:message code="column.atch_fl_cnt"/><strong class="red">*</strong></th>
						<td>
							<!-- 첨부 파일 갯수-->
							<select class="validate[required]" name="atchFlCnt" id="atchFlCnt" title="<spring:message code="column.atch_fl_cnt" />">
								<frame:select grpCd="${adminConstants.ATCH_FL_CNT}" selectKey="${board.atchFlCnt}" defaultName="선택하세요"/>
							</select>
						</td>
						<th><spring:message code="column.upload_ext"/><strong class="red">*</strong></th>
						<td>
							<!-- 업로드 확장자 -->
							<input type="text" class="validate[required, maxSize[20]]" name="uploadExt" id="uploadExt" title="<spring:message code="column.upload_ext"/>" value="${board.uploadExt}" />
							<div class="mt5 red-desc">( 분류와 분류 사이는 | 로 구분하세요. )</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.gb_use_yn"/></th>
						<td>
							<!-- 구분 사용여부 -->
							<frame:radio name="gbUseYn" grpCd="${adminConstants.GB_USE_YN}" selectKey="${board.gbUseYn}" disabled="${not empty board.gbUseYn ? true : false }"/>
						</td>
						<th><spring:message code="column.goods.comp_no" /><span id="strongRed" style="display: none;"><strong class="red">*</strong></span></th>	<!-- 업체 번호-->
						<td>
							<frame:compNo funcNm="searchCompany"  defaultCompNo="${board.compNo}" defaultCompNm="${board.compNm}" /><!--  editGoodsYn="N" -->
						</td>
					</tr>
					<tr>
						<!-- 이미지 경로 -->
						<th><spring:message code="column.img_path"/></th>
						<td colspan="3">
							<div class="inner">
							<input type="hidden" id="bbsImgPath" name="bbsImgPath"  value="${board.bbsImgPath}" />
							<c:if test="${empty board.bbsImgPath}">
								<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="">
							</c:if>
							<c:if test="${not empty board.bbsImgPath}">
								<img id="imgPathView" name="imgPathView" src="<frame:imgUrl/>${board.bbsImgPath}" class="thumb" alt="">
							</c:if>
							</div>
							<div class="inner ml10" style="vertical-align:bottom">
								<button type="button" onclick="fileUpload.image(resultBbsImage);" class="btn"><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" onclick="deleteImage();" class="btn"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.dscrt" /></th>	<!-- 설명 업체공지사항으로 만들어야함-->
						<td colspan="3">
							<textarea class="validate[maxSize[500]]" name="bbsDscrt" id="bbsDscrt" cols="150" rows="3" >${board.bbsDscrt }</textarea>
						</td>
					</tr>
				</tbody>
			</table>

			<div id="gbUseView" ${board.gbUseYn eq adminConstants.GB_USE_YN_Y or empty board.gbUseYn ? '' : 'style="display: none;"'}>
				<div class="mTitle mt15">
					<h2>구분자 등록 [ ※ 등록할 게시판의 키워드별 게시판을 구분하고 싶을 때 추가하세요. ]</h2> 
					<div class="buttonArea">
						<button type="button" onclick="addGb();" class="btn btn-add">추가</button>
					</div>
				</div>

				<table class="table_type1">
					<caption>구분자 등록</caption>
					<tbody>
						<tr>
							<th>구분자<strong class="red">*</strong></th>
							<td id="gbView">
								<!-- 구분자 등록 -->
								<c:if test="${empty board}">
									<div class="bbsGbAddView mg5">
										<input type="hidden" name="bbsGbNo" />
										<input type="text" class="validate[required]" name="bbsGbNm" value="" />
										<button type="button" class="btn" onclick="deleteGb(this);" ><spring:message code="column.common.delete" /></button>
									</div>
								</c:if>
								<!-- 구분자 수정 -->
								<c:if test="${not empty board}">
								<c:forEach items="${listBoardGb}" var="item">
									<div class="bbsGbView mg5">
										<input type="hidden" name="bbsGbNo" value="${item.bbsGbNo}" />
										<input type="text" class="readonly validate[required]" readonly="readonly" name="bbsGbNm" title="" value="${item.bbsGbNm}" />
										<button type="button" class="btn" onclick="deleteGb(this);" ><spring:message code="column.common.delete" /></button>
									</div>
								</c:forEach>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>

			<div class="btn_area_center">
				<c:if test="${empty board}">
					<button type="button" onclick="boardInsert();" class="btn btn-ok">등록</button>
					<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
				</c:if>
				<c:if test="${not empty board}">
					<button type="button" onclick="boardUpdate();" class="btn btn-ok">수정</button>
					<button type="button" onclick="boardDelete(); return false" class="btn btn-add">삭제</button>
					<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
				</c:if>
			</div>
	</t:putAttribute>
</t:insertDefinition>