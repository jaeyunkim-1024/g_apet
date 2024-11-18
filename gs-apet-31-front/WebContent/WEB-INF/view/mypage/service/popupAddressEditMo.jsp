<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<%--
  Class Name  : popupAddressEdit.jsp 
  Description : 회원 주소록 등록 및 수정
  Author      : 신남원
  Since       : 2016.03.02
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.03.02    신남원            최초 작성
--%>
<script type="text/javascript" 	src="/_script/memberAddress/memberAddress.js"></script>
<script>
	$(document).ready(function(){
		$(".mode0").remove()
		$("#footer").remove();
		setInput();
		
		// 상세 주소 유효성[]
		$(document).on("change input paste" , "input[name=roadDtlAddr]" , function(){
			var value = $(this).val()
			if(value.length > 30){
				if("${view.deviceGb}" == "PC"){
					ui.alert("상세 주소는 30자까지 입력 가능합니다.");
				}else{
					ui.toast("상세 주소는 30자까지 입력 가능합니다.");
				}
				$(this).val(value.substr(0 , 30));
			}
		});
		
		$("#adrOff, #adrOn").on("click", function(){
			//$(this).find('a')[0].click();
			//주소가 등록된 상태에서도 주소검색팝업
			openPostPop('cbPostPop');
		});
		
		$(document).on("mousedown","#addressul .btnDel,#delist .btnDel",function(e){
			btnDelChk = true;
		});
	})
	
	//배송지 정보 insert
	function insertAddress(){
		if (!dlvrImojiChk()) {
			return;
		}
		if(checkValidateAdd()){
			var popYn = '${popYn}';
			var formData = $("#memberAddressForm").serializeArray();
			var obj = formArrParseJson(formData);
			var options = {
					url : "<spring:url value='/mypage/service/insertAddress' />"
					, data : obj
					, done : function(result){
						ui.popLayer.close("addressAddPop");
						if (result > 0) {
							if(popYn){
								orderDlvra.addressListPop();
							}else{
								history.go(-1);
								window.setTimeout(function(){ location.reload(true); }, 200);
							}
						} else {
							if(popYn){
								orderDlvra.addressListPop();
							}else{
								history.go(-1);
								window.setTimeout(function(){ location.reload(true); }, 200);
							}
							ui.toast("배송지는 5개까지 등록할 수 있어요");
						}
					}
			}
			ajax.call(options);
		}
	}
	
	//배송지 정보 update
	function updateAddress(){
		if (!dlvrImojiChk()) {
			return;
		}
		if(checkValidateAdd()){
			var popYn = '${popYn}';
			var formData = $("#memberAddressForm").serializeArray();
			var obj = formArrParseJson(formData);
			var options = {
					url : "<spring:url value='/mypage/service/updateAddress' />"
					, data : obj
					, done : function(result){
						if(result > 0){
							ui.popLayer.close("addressAddPop");
							if(popYn){
								orderDlvra.addressListPop();
							}else{
								location.reload(true);	
							}	
						}
					}
			}
				ajax.call(options);
		}
	}
	
	// 팝업창 input setting
	function setInput(){
		if('${not empty address.mbrDlvraNo}' == 'true'){
			// 배송지 입력 팝업
			$("[data-selected='false']").show();
			$("#adrOff").hide();
			$("#addressul input").change();
			if('${address.dlvrDemandYn}' == 'Y'){
				$("#insertDeliReq").hide();
				$("#aftDeliReq").show();
			}else{
				$("#insertDeliReq").show();
				$("#aftDeliReq").hide();
			}
			
			if('${address.dftYn}' == 'Y'){
				$("input[name=dftYn]").prop("checked" , "true");
				$("input[name=dftYn]").val("Y");	
			}else{
				$("input[name=dftYn]").val("N");
			}
			// 배송 요청 사항 팝업
			$('input:radio[name="goodsRcvPstCdInput"][value="${address.goodsRcvPstCd}"]').prop("checked" , true);
			$('input:radio[name="pblGateEntMtdCdInput"][value="${address.pblGateEntMtdCd}"]').prop("checked" , true);
			$("#delist input").change();
			
			if('${address.goodsRcvPstCd}' == 40){
				$("#rdo_dereq_msg_box_my").show();
			}
			if('${address.pblGateEntMtdCd}' == 10){
				$("#pblGatePswdInput").show();
			}
		}else{
			// 배송지 입력 팝업
			$("[data-selected='false']").hide();
			$("#aftDeliReq").hide();
			$("input[name=dftYn]").val("N");
// 			$("#addBtn").prop("disabled" , true);
			// 배송 요청 사항 팝업
			$("input[name=goodsRcvPstCdInput]:eq(0)").prop("checked" , true);
			$("input[name=pblGateEntMtdCdInput]:eq(0)").prop("checked" , true);
			$("#rdo_dereq_pwd_box_my").show();
			$("input[name=pblGatePswdInput]").change();
			$("input[name=goodsRcvPstcInput]").change();
		}

		$("#addressul input").change();
	}

	function checkValidateAdd(){
		var result = false;
		var isGbNm = $("#addressul input[name=gbNm]").val().trim();
		var isAdrsNm = $("#addressul input[name=adrsNm]").val().trim();
		var isMob = $("#addressul #mobileValidate").css('display');
		var isAdrOn = $("#addressul #adrOn").text().trim();
		var isDtlAdr = $("#addressul input[name=roadDtlAddr]").val().trim();
		var isMobNo = $("#addressul input[name=mobile]").val().trim();
		var isDeleReq = $("#insertDeliReq").css('display');
		
		if(isGbNm != '' && isAdrsNm != '' && isMob == 'none' && isAdrOn != '' && isMobNo != '' && isDeleReq == 'none' && isDtlAdr != ''){
			result = true;
			$("#memberAddressForm [name='prclDtlAddr']").val($("#memberAddressForm [name='roadDtlAddr']").val());
		} else {
			if (isGbNm != '' && isAdrsNm != '' && isAdrOn != '' && isMobNo != '' && isDtlAdr != '' && isDeleReq != 'none') {
				ui.alert('배송 요청사항을 입력해주세요');	
			} else {
				ui.alert('배송지 정보를 모두 입력해 주세요');
			}
		}
		
		return result;
	}
	
	function dlvrImojiChk() {
		let result = true;
		// 배송지 입력 팝업 특수문자,이모지 유효성 체크 (배송지 명칭, 받는 사람, 휴대폰번호, 상세주소)
		var imojiRegex = /[^a-zA-Z가-힣0-9ㄱ-ㅎㅏ-ㅣ\s`~!@#$%^&*()-_=+\|\[\]{};:'",.<>/?]+/g;
		var dlvrGbNmTxt = $("#addressul input[name=gbNm]").val();
		var dlvrAdrsNmTxt = $("#addressul input[name=adrsNm]").val();
		var dlvrMobileTxt = $("#addressul input[name=mobile]").val();
		var dlvrDtlAddrTxt = $("#addressul input[name=roadDtlAddr]").val();
		var imojiArray = new Array();
		if(imojiRegex.test(dlvrGbNmTxt)){
			var imojiArray0 = dlvrGbNmTxt.match(imojiRegex);
			if(imojiArray0.length > 0){
				imojiArray.push(imojiArray0);
			}
		}
		if(imojiRegex.test(dlvrAdrsNmTxt)){
			var imojiArray1 = dlvrAdrsNmTxt.match(imojiRegex);
			if(imojiArray1.length > 0){
				imojiArray.push(imojiArray1);
			}
		}
		if(imojiRegex.test(dlvrMobileTxt)){
			var imojiArray2 = dlvrMobileTxt.match(imojiRegex);
			if(imojiArray2.length > 0){
				imojiArray.push(imojiArray2);
			}
		}
		if(imojiRegex.test(dlvrDtlAddrTxt)){
			var imojiArray3 = dlvrDtlAddrTxt.match(imojiRegex);
			if(imojiArray3.length > 0){
				imojiArray.push(imojiArray3);
			}
		}
		if(imojiArray.length > 0){
			ui.alert('배송지 정보에 입력 불가능한 문자('+imojiArray.join("")+')가 포함되어있습니다.');
			result = false
		}
		return result;
	}
</script>
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">배송지 입력</h1>
					<button type="button" class="btnPopClose" onclick="window.self.close();">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
				<form id="memberAddressForm">
					<input type ="hidden" name = "mbrNo" value = "${address.mbrNo }">
					<input type ="hidden" name = "mbrDlvraNo" value = "${address.mbrDlvraNo }">
					<input type ="hidden" name = "goodsRcvPstCd" value = "${address.goodsRcvPstCd }">
					<input type ="hidden" name = "goodsRcvPstEtc" value = "${address.goodsRcvPstEtc }">
					<input type ="hidden" name = "pblGateEntMtdCd" value = "${address.pblGateEntMtdCd }">
					<input type ="hidden" name = "pblGatePswd" value = "${address.pblGatePswd }">
					<input type ="hidden" name = "dlvrDemand" value = "${address.dlvrDemand }">
					<input type ="hidden" name = "dlvrDemandYn" value ="${address.dlvrDemandYn eq null ? N : address.dlvrDemandYn}">
					<div class="uidelivsets">
						<ul class="list" id="addressul">
							<li class="name">
								<div class="hdt">배송지 명칭</div>
								<div class="cdt">
									<div class="input del">
										<input type="text" name ="gbNm" placeholder="배송지 명칭을 입력해주세요" title="배송지" value = "<c:out value="${address.escapedGbNm }" escapeXml="false"/>">
									</div>
								</div>
							</li>
							<li class="user">
								<div class="hdt">받는 사람</div>
								<div class="cdt">
									<div class="input del">
										<input type="text" name ="adrsNm" placeholder="이름을 입력해주세요" title="배송지" value = "<c:out value="${address.escapedAdrsNm }" escapeXml="false"/>">
									</div>
								</div>
							</li>
							<li class="phone">
								<div class="hdt">휴대폰번호</div>
								<div class="cdt">
									<div class="input del">
										<input type="text" name="mobile" placeholder="-없이 번호만 입력해주세요" title="배송지" value = "${address.mobile }">
									</div>
									<span id ="mobileValidate" style ="color:red;display:none">휴대폰번호를 정확히 입력해주세요.</span>
								</div>
							</li>
							<li class="adrs">
								<div class="hdt">주소</div>
								<div class="cdt">
									<div class="uiadrset">
										<%-- <div class="input del t2" id="adrOff" data-txt="주소검색">
											<input type="text" placeholder="텍스트 입력">
											<div class="inputInfoTxt btAdr">주소검색</div>
										</div>
										<div class="input del t2" data-txt="주소검색" data-selected ="false">
											<input type="text" id="adrOn" placeholder="텍스트 입력" value="${address.roadAddr }">
											<div class="inputInfoTxt btAdr" >주소검색</div>
										</div>
										<div class="adrbox a2" data-selected ="false">
											<input type ="hidden" name ="roadAddr" value="${address.roadAddr }">
											<input type ="hidden" name ="prclAddr" value ="${address.prclAddr }">
											<input type ="hidden" name ="postNoNew" value="${address.postNoNew }">
											<span class="input"><input type="text" name ="roadDtlAddr" placeholder="상세주소를 입력하세요." value = "${address.roadDtlAddr }"></span>
										</div> --%>
										
										<div class="adrbox a1" id="adrOff">
											<div class="adr">주소를 검색해주세요.</div>
											<a href="javascript:;" class="btAdr" data-content="" data-url="/post/popupMoisPost?callBackFnc=defaultCbPostOption.callBack">주소검색</a>
										</div>
										<div class="adrbox a1" data-selected ="false">
											<div class="adr on" id="adrOn">${address.roadAddr }</div>
											<a href="javascript:;" class="btAdr" data-content="" data-url="/post/popupMoisPost?callBackFnc=defaultCbPostOption.callBack">주소검색</a>
										</div>
										<div class="adrbox a2" data-selected ="false">
											<input type ="hidden" name ="roadAddr" value="${address.roadAddr }">
											<input type ="hidden" name ="prclAddr" value ="${address.prclAddr }">
											<input type ="hidden" name ="postNoNew" value="${address.postNoNew }">
											<input type ="hidden" name ="prclDtlAddr" value="${address.prclDtlAddr }">
											<span class="input"><input type="text" name ="roadDtlAddr" placeholder="상세주소를 입력하세요." value = "<c:out value="${address.escapedRoadDtlAddr }" escapeXml="false"/>"></span>
										</div>
									</div>
								</div>
							</li>
							<li class="dreq" data-selected ="false">
								<div class="hdt">배송 요청사항</div>
								<div class="cdt">
									<div class="uiadrreq">
										<div class="pwf" id="aftDeliReq">
											<em class="t" id="goodsRcvPst">
												<c:choose>
										  			<c:when test="${address.goodsRcvPstCd eq frontConstants.GOODS_RCV_PST_40}">
										  				<c:out value="${address.escapedGoodsRcvPstEtc}" escapeXml="false"/>
										  			</c:when>
										  			<c:otherwise>
										  				<frame:codeValue items = "${goodsRcvPstList}" dtlCd="${address.goodsRcvPstCd }"/>
										  			</c:otherwise>
										  		</c:choose>
											</em>
										  	<em class="p" id="pblGateEntMtd"><frame:codeValue items = "${pblGateEntMtdList}" dtlCd="${address.pblGateEntMtdCd }"/>&nbsp; 
										  		<if test="${address.pblGateEntMtdCd eq frontConstants.PBL_GATE_ENT_MTD_10}">
									  				<c:out value="${ address.escapedPblGatePswd}" escapeXml="false"/>
									  			</if>
									  		</em>
											<div class="txt" id ="dlvrDemand"><c:out value="${address.escapedDlvrDemand }" escapeXml="false" /></div>
											<div class="btt"><a href="#" onclick="memberAddress.dlvrDemandPop();" class="btn sm btMod" data-content="layerAlert" data-url="">변경</a></div>
										</div>
										<div class="pss" id ="insertDeliReq">
											<a href="#" onclick="memberAddress.dlvrDemandPop();" class="btn btPdPl" data-content="layerAlert" data-url="">상품 수령 장소를 선택해주세요.</a>
										</div>
									</div>
									<div class="saves">
										<div class="pp"><label class="checkbox"><input type="checkbox" name ="dftYn" ${addressCnt eq 1 and not empty address.mbrDlvraNo ? ' disabled' : '' }><span class="txt"><em class="tt">기본 배송지로 등록</em></span></label></div>
									</div>
								</div>
							</li>
						</ul>
					</div>
					</form>
					<div class="btnSet bot" >
					<c:if test ="${address.mbrDlvraNo ne null}">
						<button type="button" id ="addBtn" onclick ="updateAddress();" class="btn lg a" data-dlvra-no = "${address.mbrDlvraNo }" data-content ="" data-url="updateAddress();" style ="min-width: 164px;">저장</button>
					</c:if>
					<c:if test ="${address.mbrDlvraNo eq null }">
						<button type="button" id ="addBtn" onclick ="insertAddress();" class="btn lg a save" data-content ="" data-url="insertAddress();" style ="min-width: 164px; maring-left:4px;">저장</button>
					</c:if>
				</div>
				</main>
			</div>
		</div>
		<article class="popLayer a popDeliReq noClickClose" id="popDeliReq">
		</article>
	
	
