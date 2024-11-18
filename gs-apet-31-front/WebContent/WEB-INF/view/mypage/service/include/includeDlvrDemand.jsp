<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		dlvrDemand.form.find("#deliReqAddBtn").click(function(){
			// 이모지 포함 확인
			var imojiRegex = /[^a-zA-Z가-힣0-9ㄱ-ㅎㅏ-ㅣ\s]+/g;
			var imojiRegexPswd = /[^a-zA-Z가-힣0-9ㄱ-ㅎㅏ-ㅣ\s`~!@#$%^&*()-_=+\|\[\]{};:'",.<>/?]+/g;
			var goodsRcvPstEtcTxt = $("#goodsRcvPstEtcPop").val();
			var pblGatePswdTxt = $("#pblGatePswdPop").val();
			var dlvrDemandTxt = $("#dlvrDemandPop").val();
			var imojiArray = new Array();
			if(imojiRegex.test(goodsRcvPstEtcTxt)){
				var imojiArray0 = goodsRcvPstEtcTxt.match(imojiRegex);
				if(imojiArray0.length > 0){
					imojiArray.push(imojiArray0);
				}
			}
			if(imojiRegexPswd.test(pblGatePswdTxt)){
				var imojiArray1 = pblGatePswdTxt.match(imojiRegexPswd);
				if(imojiArray1.length > 0){
					imojiArray.push(imojiArray1);
				}
			}
			if(imojiRegex.test(dlvrDemandTxt)){
				var imojiArray2 = dlvrDemandTxt.match(imojiRegex);
				if(imojiArray2.length > 0){
					imojiArray.push(imojiArray2);
				}
			}
			if(imojiArray.length > 0){
				ui.alert('배송요청사항에 입력 불가능한 문자('+imojiArray.join("")+')가 포함되어있습니다.');
				return;
			}
			
			var isPblGate = dlvrDemand.changePblGate();
			var isGoodsRcvPstd = dlvrDemand.changeGoodsRcvPst();
			
			//상품수령위치
			if(!isGoodsRcvPstd){
				$("#goodsRcvValid").show();
				ui.alert('상품 수령위치를 입력해주세요');
				return
			}
			//공동현관비밀번호
			if(!isPblGate){
				$("#pblGateValid").show();
				ui.alert('공동현관 비밀번호를 입력해주세요');
				return;
			}
			//택배배송 요청사항
			/* if(!isdlvrDemand){
				ui.alert("배송 요청사항을 입력해주세요");
				return;
			} */
			
			if(isPblGate && isGoodsRcvPstd){
				dlvrDemand.save();
			}
			/* else{
				//ui.alert('배송 요청사항을 입력해주세요');
				if(!isdlvrDemand){
					ui.alert("배송 요청사항을 입력해주세요");	
				}
			} */
		})
		
		dlvrDemand.form.find("#deliCancelBtn").click(function(){
			dlvrDemand.close();
		})

		//저장버튼 활성화/비활성화
		$(document).on("propertychange keyup input change paste click", "input[name=goodsRcvPstCd], input[name=pblGateEntMtdCd], input[name=pblGatePswd], input[name=goodsRcvPstEtc]", function(){			
			var isPblGate = false;
			var isGoodsRcvPstd = false;
			if($("input[name=goodsRcvPstCd]:checked").val() != '${frontConstants.GOODS_RCV_PST_40}'
					|| $("#delist input[name=goodsRcvPstEtc]").val().trim() != ''){
				isGoodsRcvPstd = true;
			}
			if($("input[name=pblGateEntMtdCd]:checked").val() != '${frontConstants.PBL_GATE_ENT_MTD_10}'
					|| $("#delist input[name=pblGatePswd]").val().trim() != ''){
				isPblGate = true;
			}
			 
			if(isPblGate && isGoodsRcvPstd){
				dlvrDemand.form.find("#deliReqAddBtn").removeClass("disabled");
			}else{
				dlvrDemand.form.find("#deliReqAddBtn").addClass("disabled");
			}
		});
		
		$(document).on("focus", "input[name=goodsRcvPstEtc]", function(){
			if (btnDelChk) {
				$("#deliReqAddBtn").addClass("disabled");					
			}
			if($("input[name=goodsRcvPstEtc]").val() == ""){
				isGoodsRcvPstd = false;
			}
			btnDelChk = false;
		});
		
		$(document).on("focus", "input[name=pblGatePswd]", function(){
			if (btnDelChk) {
				$("#deliReqAddBtn").addClass("disabled");					
			}
			if($("input[name=goodsRcvPstEtc]").val() == ""){
				isPblGate = false;
			}
			btnDelChk = false;
		});
		
		dlvrDemand.form.find("input[name=goodsRcvPstCd]").change(function(){
			if($(this).val() == '${frontConstants.GOODS_RCV_PST_40}'){
				dlvrDemand.form.find("#rdo_dereq_msg_box_my").show();
				dlvrDemand.form.find("#goodsRcvValid").hide();
				dlvrDemand.form.find("#deliReqAddBtn").addClass("disabled");
			}else{
				dlvrDemand.form.find("input[name=goodsRcvPstEtc]").val('');
				dlvrDemand.form.find("#rdo_dereq_msg_box_my").hide();
			}
		});
		
		dlvrDemand.form.find("input[name=pblGateEntMtdCd]").change(function(){
			if($(this).val() == '${frontConstants.PBL_GATE_ENT_MTD_10}'){
				dlvrDemand.form.find("#rdo_dereq_pwd_box_my").show();
				dlvrDemand.form.find("#pblGateValid").hide();
				dlvrDemand.form.find("#deliReqAddBtn").addClass("disabled");
			}else{
				dlvrDemand.form.find("input[name=pblGatePswd]").val('');
				dlvrDemand.form.find("#rdo_dereq_pwd_box_my").hide();
			}
		});
		
		//100글자 이상 입력 시 제한 토스트 문구
		$('textarea[name=dlvrDemand]').on('propertychange keyup input change paste ', function(){
			if($(this).val().length >= 100){
				$(this).val($(this).val().substring(0,100));
				ui.toast("배송 요청사항은 100자까지 입력할 수 있어요");
			}
		});
		
		//IOS에서 한영키 눌러도 작동되서 keyup 삭제
		$("input[name=pblGatePswd]").on('propertychange input change paste ', function(){
			/* if($(this).val()){
				$("#pblGateValid").hide();
			}else{
				$("#pblGateValid").show();
			} */
			$("#pblGateValid").hide();
		})
		
		//IOS에서 한영키 눌러도 작동되서 keyup 삭제
		$("input[name=goodsRcvPstEtc]").on('propertychange input change paste ', function(){
			/* if($(this).val()){
				$("#goodsRcvValid").hide();
			}else{
				$("#goodsRcvValid").show();
			} */
			$("#goodsRcvValid").hide();
		})
		
		//IOS에서 한글->수자로 바꾸는 버트는 눌렀을때도 작동한다 change이벤트로 변경
		$("input[name=pblGatePswd]").on('chnage', function(){			
			$("#pblGateValid").hide();
		})
				
		$("input[name=goodsRcvPstEtc]").on('change', function(){
			//$("#goodsRcvValid").hide();
		})
		
		
		<c:if test="${empty address.goodsRcvPstCd}">
			dlvrDemand.form.find("input[name=goodsRcvPstCd]").eq(0).prop("checked", true);
		</c:if>
		
		<c:if test="${empty address.pblGateEntMtdCd}">
		dlvrDemand.form.find("input[name=pblGateEntMtdCd]").eq(0).prop("checked", true);
	</c:if>
		
		dlvrDemand.form.find("input[name=goodsRcvPstCd]:checked").trigger('change');
		dlvrDemand.form.find("input[name=pblGateEntMtdCd]:checked").trigger('change');
	});
	
	var dlvrDemand = {
		form : $("#"+"${param.popId}").find("#dlvrDemandForm")
		, save : function(){
			/* var dlvrDemandTxt =$("textarea[name=dlvrDemand]").val();
			console.log(dlvrDemandTxt)
			if(dlvrDemandTxt !="" && dlvrDemandTxt.length > 0 && dlvrDemandTxt.length < 5){
				ui.alert('요청사항은 5자이상입력해주세요.',{
					ycb:function(){
					},
					ybt:'확인'
				});
				return;
			} */
			var data = this.form.serializeJson();
			$.extend(data, {
				goodsRcvPstNm : dlvrDemand.form.find("input[name=goodsRcvPstCd]:checked").data("nm")
				,pblGateEntMtdNm : dlvrDemand.form.find("input[name=pblGateEntMtdCd]:checked").data("nm")
			});
			
			<c:out value="${param.callBackFnc}" />(data);
			ui.popLayer.close("<c:out value="${param.popId}" />");
		}
		, close : function(){
			ui.popLayer.close("<c:out value="${param.popId}" />");
		}
		, changePblGate : function(){
			var pblGateEntMtdCd = dlvrDemand.form.find("input[name=pblGateEntMtdCd]:checked").val();
			var inputValue = dlvrDemand.form.find("input[name=pblGatePswd]").val(); 
			if(pblGateEntMtdCd == '${frontConstants.PBL_GATE_ENT_MTD_10}' && inputValue.trim() == ''){
				dlvrDemand.form.find("#pblGateValid").show();
				return false;
			}else{
				dlvrDemand.form.find("#pblGateValid").hide();
				return true;
			}
		}
		, changeGoodsRcvPst : function(){
			var goodsRcvPstCd = dlvrDemand.form.find("input[name=goodsRcvPstCd]:checked").val();
			var inputValue = dlvrDemand.form.find("input[name=goodsRcvPstEtc]").val(); 
			if(goodsRcvPstCd == '${frontConstants.GOODS_RCV_PST_40}' && inputValue.trim() == ''){
				dlvrDemand.form.find("#goodsRcvValid").show();
				return false;
			}else{
				dlvrDemand.form.find("#goodsRcvValid").hide();
				return true;
			}
		}
	}
</script>
<c:choose>
	<c:when test ="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">배송 요청사항</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<form id="dlvrDemandForm">
					<input type ="hidden" name = "mbrDlvraNo" value = "${address.mbrDlvraNo }">
					<div class="uiDeliReq">
						<ul class="delist" id="delist">
							<li>
								<div class="hdt">상품 수령위치</div>
								<div class="cdt">
									<ul class="rlist">
									<c:forEach var="goodsRcvPstCd" items="${goodsRcvPstCdList }">
										<li>
											<label class="radio"><input type="radio" name="goodsRcvPstCd" value = "${goodsRcvPstCd.dtlCd }" data-nm="${goodsRcvPstCd.dtlNm }" ${address.goodsRcvPstCd eq goodsRcvPstCd.dtlCd ? ' checked' : ''}><span class="txt"><em class="tt">${goodsRcvPstCd.dtlNm }</em></span></label>
										</li>
									</c:forEach>
									</ul>
									<div class="etmsg" id="rdo_dereq_msg_box_my">
										<span class="input"><input type="text" placeholder="메시지를 입력해주세요" title="기타메시지" maxlength = "15" name="goodsRcvPstEtc" id="goodsRcvPstEtcPop" value = "${address.escapedGoodsRcvPstEtc}"></span>
										<div class="validation-check" id ="goodsRcvValid" style="display:none;">상품 수령위치를 입력해주세요.</div>
									</div>
								</div>
							</li>
							<li>
								<div class="hdt">공동현관 출입방법</div>
								<div class="cdt">
									<ul class="rlist">
									<c:forEach var="pblGateEntMtdCd" items="${pblGateEntMtdCdList }">
										<li>
											<label class="radio"><input type="radio" name="pblGateEntMtdCd" value = "${pblGateEntMtdCd.dtlCd}" data-nm="${pblGateEntMtdCd.dtlNm }"  ${address.pblGateEntMtdCd eq pblGateEntMtdCd.dtlCd ? ' checked' : ''}>
											<span class="txt"><em class="tt">${pblGateEntMtdCd.dtlNm}</em></span></label>
										</li>
									</c:forEach>
									</ul>
									<div class="etmsg" id="rdo_dereq_pwd_box_my">
										<span class="input"><input type="text" placeholder="예) #1234" title="공동현관 비밀번호" maxlength = "15" name="pblGatePswd" id="pblGatePswdPop" value ="${address.escapedPblGatePswd }"></span>
										<div class="validation-check" id="pblGateValid" style="display:none;">공동현관 비밀번호를 입력해주세요.</div>
									</div>
								</div>
							</li>
							<li>
								<div class="hdt">택배배송 요청사항</div>
								<div class="cdt">
									<div class="textarea msgreq">
										<textarea cols="30" maxlength="100"rows="3" placeholder="택배기사님께 요청사항을 입력해주세요. (100자 제한)" name ="dlvrDemand" id="dlvrDemandPop" >${address.escapedDlvrDemand }</textarea>
									</div>
								</div>
							</li>
						</ul>
						<div class="btnSet bot">
							<button type="button" class="btn lg c" id="deliCancelBtn">취소</button>
							<button type="button" class="btn lg a" id="deliReqAddBtn">저장</button>
						</div>
					</div>
					</form>
				</main>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">배송 요청사항</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<form id="dlvrDemandForm">
						<input type ="hidden" name = "mbrDlvraNo" value = "${address.mbrDlvraNo }">
					<div class="uiDeliReq">
						<ul class="delist" id="delist">
							<li>
								<div class="hdt">상품 수령위치</div>
								<div class="cdt">
									<ul class="rlist">
										<c:forEach var="goodsRcvPstCd" items="${goodsRcvPstCdList }">
											<li>
												<label class="radio"><input type="radio" name="goodsRcvPstCd" value = "${goodsRcvPstCd.dtlCd }" data-nm="${goodsRcvPstCd.dtlNm }" ${address.goodsRcvPstCd eq goodsRcvPstCd.dtlCd ? ' checked' : ''}><span class="txt"><em class="tt">${goodsRcvPstCd.dtlNm }</em></span></label>
											</li>
										</c:forEach>
									</ul>
									<div class="etmsg" id="rdo_dereq_msg_box_my" >
										<span class="input"><input type="text" placeholder="메시지를 입력해주세요" title="기타메시지" maxlength = "15" name="goodsRcvPstEtc" id="goodsRcvPstEtcPop" value = "<c:out value="${address.escapedGoodsRcvPstEtc}" escapeXml="false"/>"></span>
										<div class="validation-check" id ="goodsRcvValid" style="display:none;">상품 수령위치를 입력해주세요.</div>
									</div>
								</div>
							</li>
							<li>
								<div class="hdt">공동현관 출입방법</div>
								<div class="cdt">
									<ul class="rlist">
										<c:forEach var="pblGateEntMtdCd" items="${pblGateEntMtdCdList }" varStatus="stat">
											<li>
												<label class="radio"><input type="radio" name="pblGateEntMtdCd" value = "${pblGateEntMtdCd.dtlCd}" data-nm="${pblGateEntMtdCd.dtlNm }"  ${address.pblGateEntMtdCd eq pblGateEntMtdCd.dtlCd ? ' checked' : ''}>
												<span class="txt"><em class="tt">${pblGateEntMtdCd.dtlNm}</em></span></label>
												<c:if test = "${stat.index eq 0 }">
												<div class="etmsg" id="rdo_dereq_pwd_box_my">
													<span class="input"><input type="text" placeholder="예) #1234" title="공동현관 비밀번호" maxlength = "15" name="pblGatePswd" id="pblGatePswdPop" value ="<c:out value="${address.escapedPblGatePswd }" escapeXml="false"/>"></span>
													<div class="validation-check" id="pblGateValid" style="display:none;">공동현관 비밀번호를 입력해주세요.</div>
												</div>
												</c:if>
											</li>
										</c:forEach>
									</ul>
								</div>
							</li>
							<li>
								<div class="hdt">택배배송 요청사항</div>
								<div class="cdt">
									<div class="textarea msgreq">
										<textarea cols="30" maxlength="100"rows="3" placeholder="택배기사님께 요청사항을 입력해주세요. (100자 제한)" name="dlvrDemand" id="dlvrDemandPop"><c:out value="${address.escapedDlvrDemand }" escapeXml="false"/></textarea>
									</div>
								</div>
							</li>
						</ul>
						<div class="btnSet bot">
							<button type="button" id="deliCancelBtn" class="btn lg d" data-content ="" data-url="">취소</button>
							<button type="button" id="deliReqAddBtn" class="btn lg a" data-content ="" data-url="">저장</button>
						</div>
					</div>
				</main>
			</div>
		</div>
	</c:otherwise>
</c:choose>
	