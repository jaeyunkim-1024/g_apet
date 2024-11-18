<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=4, user-scalable=yes">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>Layout</title>
		<meta name="format-detection" content="telephone=no">
		<meta name="theme-color" content="#ffffff">
		<link href="/_images/common/favicon.ico" rel="shrtcut icon">
		<link href="/_images/common/favicon.png" rel="apple-touch-icon-precomposed">
		<link rel="stylesheet" href="<spring:eval expression="@bizConfig['cdn.domain']" />/_css/style.pc.css">

		<script src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-3.3.1.min.js"></script>
		<script src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-ui.min.js"></script>
		<script src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/swiper.min.js"></script>
		<script src="/_script/ui.js"></script>
		<script src="/_script/ui.mo.js"></script>
		<script src="/_html/guide/html.js"></script><!-- 개발페이지에서는 html.js 임포트 하지말아주세요. -->
	</head>
	<body class="body">
		<article class="popLayer win a popDeliReq" id="popDeliReq">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<h1 class="tit">배송 요청사항</h1>
						<button type="button" class="btnPopClose" onclick="window.close();">닫기</button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<div class="uiDeliReq">
							<ul class="delist">
								<li>
									<div class="hdt">상품 수령위치</div>
									<div class="cdt">
										<ul class="rlist">
											<c:forEach items="${goodsRcvPstList}" var="goodsRcvPst" varStatus="grpIdx">
												<li>
													<label class="radio"><input type="radio" id="goodsRcvPst-${goodsRcvPst.dtlCd }" name="goodsRcvPstCd" value="${goodsRcvPst.dtlCd }"<c:if test="${address.goodsRcvPstCd == goodsRcvPst.dtlCd }"> checked="checked" </c:if>><span class="txt"><em class="tt"><frame:codeValue items="${goodsRcvPstList}" dtlCd="${goodsRcvPst.dtlCd}" type="S"/></em></span></label>
												</li>
											</c:forEach>
										</ul>
										<div class="etmsg" id="rdo_dereq_msg_box">
											<span class="input"><input type="text" placeholder="메시지를 입력해 주세요." title="기타메시지"></span>
										</div>
									</div>
								</li>
								<li>
									<div class="hdt">공동현관 출입방법</div>
									<div class="cdt">
										<ul class="rlist">
											<c:forEach items="${pblGateEntMtdList}" var="pblGateEntMtd" varStatus="grpIdx">
												<li>
													<label class="radio"><input type="radio" id="pblGateEntMtd-${pblGateEntMtd.dtlCd }" name="pblGateEntMtdCd" value="${pblGateEntMtd.dtlCd }"<c:if test="${address.pblGateEntMtdCd == pblGateEntMtd.dtlCd }"> checked="checked" </c:if>><span class="txt"><em class="tt"><frame:codeValue items="${pblGateEntMtdList}" dtlCd="${pblGateEntMtd.dtlCd}" type="S"/></em></span></label>
												</li>
											</c:forEach>
										</ul>
										<div class="etmsg" id="rdo_dereq_pwd_box">
											<c:choose>
												<c:when test="${empty address.pblGatePswd}">
													<span class="input"><input type="text" id="pblGatePswd" name="pblGatePswd" placeholder="예) 1234 호출번호" title="공동현관 비밀번호"></span>
												</c:when>
												<c:otherwise>
													<span class="input"><input type="password" id="pblGatePswd" name="pblGatePswd" placeholder="예) 1234 호출번호" title="공동현관 비밀번호" value="${address.pblGatePswd}"></span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</li>
								<li>
									<div class="hdt">택배배송 요청사항</div>
									<div class="cdt">
										<div class="textarea msgreq">
											<textarea cols="30" rows="3" id="dlvrDemand" name="dlvrDemand" placeholder="택배기사님께 요청하실 사항이 있으실 경우 작성해 주세요.(최소 5자이상 ~ 최대 100자 이내 입력)">${address.dlvrDemand}</textarea>
										</div>
									</div>
								</li>
							</ul>
							<div class="btnSet bot">
								<button type="button" class="btn lg d" onclick = "ui.popLayer.close('popDeliReq1');" data-content ="" data-url="ui.popLayer.close('popDeliReq1');">취소</button>
								<button type="button" class="btn lg a" onclick="confirmDlvrDemand();">저장</button>
							</div>
						</div>
					</main>
				</div>

			</div>
		</article>

		<script>

			$(document).ready(function(){
				if( $("#pblGateEntMtd-10").prop("checked") ) {
					$("#rdo_dereq_pwd_box").show();
				}else{
					$("#rdo_dereq_pwd_box").hide();
				}
				
				//100글자 이상 입력 시 제한 토스트 문구
				$('textarea[name=dlvrDemand]').on('propertychange keyup input change paste ', function(){
					if($(this).val().length >= 100){
						$(this).val($(this).val().substring(0,100));
						ui.toast("배송 요청사항은 100자까지 입력할 수 있어요");
					}
				});
				
				
			}); // End Ready

			function confirmDlvrDemand(){

			}


			$(document).on("change", "[name='goodsRcvPstCd']", function(e){
				if( $("#goodsRcvPst-40").prop("checked") ) {
					$("#rdo_dereq_msg_box").show();
				}else{
					$("#rdo_dereq_msg_box").hide();
				}
			});
			$(document).on("change", "[name='pblGateEntMtdCd']", function(e){
				if( $("#pblGateEntMtd-10").prop("checked") ) {
					$("#rdo_dereq_pwd_box").show();
				}else{
					$("#rdo_dereq_pwd_box").hide();
					$("#pblGatePswd").val("");
				}
			});

		</script>
	</body>
</html>