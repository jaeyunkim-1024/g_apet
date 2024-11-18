<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				
			});
			
			function petraEnc(type) {
				var options = {
					url : "<spring:url value='/sample/petraEnc.do' />"
					,data : {
						encStr : $("#" + type + "wayEnc").val(),
						type : type
					}
					,callBack : function(data) {
						$("#" + type + "wayEncTxt").val(data.result);
						$("#" + type + "wayDec").val(data.result);
						$("#" + type + "wayDecTxt").val("");
					}
				}
				if ($("#" + type + "wayEnc").val() != '') {
					ajax.call(options);
				}
			}
			
			function petraDec() {
				var options = {
					url : "<spring:url value='/sample/petraDec.do' />"
					,data : {
						decStr : $("#twowayDec").val()
					}
					,callBack : function(data) {
						$("#twowayDecTxt").val(data.result)
					}
				}
				if ($("#twowayDec").val() != '') {
					ajax.call(options);
				}
			}
			
			function twcEnc() {
				var options = {
					url : "<spring:url value='/sample/twcEnc.do' />"
					,data : {
						encStr : $("#tEnc").val(),
						key : $("#twcKey").val()
					}
					,callBack : function(data) {
						$("#twcEncTxt").val(data.result);
						$("#tDec").val(data.result);
						$("#twcDecTxt").val("");
					}
				}
				if ($("#twcEnc").val() != '') {
					ajax.call(options);
				}
			}
			
			function twcDec() {
				var options = {
					url : "<spring:url value='/sample/twcDec.do' />"
					,data : {
						decStr : $("#tDec").val(),
						key : $("#twcKey").val()
					}
					,callBack : function(data) {
						$("#twcDecTxt").val(data.result)
					}
				}
				if ($("#twcDec").val() != '') {
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
<!-- 		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%"> -->
<!-- 			<div title="내용" style="padding:10px"> -->
				
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<br/> -->

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="구글 애널리틱스 [21. 03.03]" style="padding:10px">
				<p>- 샘플 페이지 호출 url : <span style="color:red;">/sample/sampleGoogleAnalytics</span></p>
				<p>1. googleAnalytics.js의 각 업무별 데이터의 하위 항목을 입력합니다. ( 각 업무별 필요 변수는 구글 애널리틱스 가이드 기준으로 구성되었습니다.)</p>
				<p>( 업무별 데이터 변수명 : 회원가입-sign_up_data, 로그인-login_data, 장바구니-add_to_cart_data, 구매-purchase_data, 환불-refund_data, 검색-search_data )</p>
				<p>2. sendGtag(업무명) 호출합니다.</p>
				<p>( 업무명 : 회원가입-sign_up, 로그인-login, 장바구니-add_to_cart, 구매-purchase, 환불-refund, 검색-search )</p>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="애드브릭스 [21. 02. 23]" style="padding:10px">
				<p>- FO 샘플 화면 호출 URL :<span style="color:red;"> /sample/sampleAdbrix</span></p>
				<p>- js : /gs-apet-31-front/WebContent/_script/adbrix.js</p>
				<p>1. adbrix.js의 각 업무별 데이터의 하위 항목을 입력합니다.</p>
            	<p>- 업무별 데이터명 >> 회원가입:onUserRegisterData, 상품 보기:onProductViewData, 상품검색:onSearchData,  장바구니 담기:onAddToCartData, 최초결제 완료:onFirstPurchaseData, 결제완료:onPurchaseData</p>
            	<p>2. toNativeAdbrix(업무별 데이터) 호출합니다.</p>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="카카오 맵 [21. 02. 17]" style="padding:10px">
				<p>- FO 샘플 화면 호출 URL :<span style="color:red;"> /sample/sampleKakaoMap</span></p>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="APP INTERFACE [21. 02. 17]" style="padding:10px">
				<p>- FO 샘플 화면 호출 URL :<span style="color:red;"> /sample/sampleAppInterface</span></p>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="PUSH / 디바이스 토큰 [21. 02. 05]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('PUSH / 디바이스 토큰', '/sample/sampleSendPushView.do', this);">PUSH / 디바이스 토큰</a>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="KCB OkCert3 휴대폰 본인 인증 [21.01.27]" style="padding:10px">
				<p>- FO 샘플 화면 호출 URL :<span style="color:red;"> /sample/sampleOkCert</span></p>
				<p>- 호출 스크립트 : okCertPopup(rqstCausCd)</p>
				<p>- 호출 controller :CommonController.java >> okCertPop</p>
				<p> [ rqstCausCd ] 00:회원가입, 01:성인인증, 02:회원정보 수정, 03:비밀번호 찾기, 04:상품구매, 99:기타(default)</p>
				<p>- callback으로 "okCertCallback(result)"로 정의해서 사용</p>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="TILES 추가 [21.01.27]" style="padding:10px">
				<p>tiles:insertDefinition name="common" 이외에 "default" 추가하였습니다.</p>
				<p>common 에서 header, gnb, lnb, menubar, footer가 제외 되었습니다.</p>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="디바이스 구분 [21.01.25]" style="padding:10px">
				<p>- 디바이스 구분은 user-agent 에 apet이 있으면 APP 이며, 쿠키 DEVICE_GB의 값을 우선하여 PC, MO를 적용합니다. 나머지의 경우 모바일과 태블릿은 MO이고 이외의 경우는 PC입니다.<br/>&emsp;아래 샘플페이지 참고 부탁드립니다.</p>				
				<p>- FO 샘플 호출 경로  : <span style="color:red;">/sample/sampleCheckView/</span></p>
				<p> 기기구분&emsp;&emsp;&emsp;&emsp;&emsp; - $ {view.device} (PC, MO, APP)</p>
				<p> OS구분&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;- $ {view.os} (DEVICE_TYPE(PC), ANDROID:10, IOS:20)</p>
				<p> 서비스 구분&emsp;&emsp;&emsp;&emsp;- $ {view.seoSvcGbCd} (펫샵:10, 펫TV:20(default), 펫로그:30)</p>
				<p> 펫 구분&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;- $ {view.petGb} (강아지:10(default), 고양이: 20, 기타:30)</p>
			</div>
		</div>
		<br/>		
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="FO 시스템 변수 적용 제거 [21.01.25]" style="padding:10px">
				<p> - FO server 설정 Argument 추가된 “-Dsite.gb=b2c” 불필요 </p>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="검색 이벤트 전송 [21. 01. 25]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('검색 이벤트 전송', '/sample/sampleSendSearchEventView.do', this);">검색 이벤트 전송</a>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="네이버 이메일 [21. 01. 20]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('네이버 이메일', '/sample/sampleSendMailView.do', this);"> 네이버 이메일 </a>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="TILES 적용 (퍼블 적용) [21.01.18]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('TILES 안내', '/sample/sampleTilesGuideView.do', this);"> TILES 적용 안내 </a>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="마스킹 UTIL [21.1.15]" style="padding:10px">
				<p> 적용 위치 : /gs-apet-01-common/src/framework/common/util/MaskingUtil.java </p>
				<a style="color:blue;" onclick="addTabDepth1('Masking', '/sample/sampleMaskedStringView.do', this);"> 마스킹 UTIL 테스트 </a>
			</div>
		</div>
		<br/>

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="행정안전부 우편번호 안내 [21.1.8]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('행정안전부 우편번호 안내', '/sample/sampleMoisPostView.do', this);"> 행정안전부 우편번호 안내 </a>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="Naver Map 안내 [21.1.4]" style="padding:10px">
				<a style="color:blue;" onclick="javascript:addTabDepth1('Naver Map 안내', '/sample/sampleNaverMapView.do', this);"> Naver Map 안내 </a>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="암복호화 관련 가이드 [20.12.22]" style="padding:10px">
				<p> - C:\Program Files\sinsiway\petra\api 경로에 petra_cipher_api.conf 파일을 추가 </p>
				<p> - C:\Windows\System32 경로에 klib.dll, pcjapi.dll, pthreadVC2.dll 파일들을 추가 </p>
				<p> - Bastion에 터널링 추가 : 10.20.23.6:6030 / L6030</p>
				<p> - bizService 의 암복호화 method 로 암복호화 </p>
				<p> // 단방향 <br/>
					bizService.oneWayEncrypt(암호화할 str) //userId(Object) 가 없는 경우 session 의 mbrNo 또는 usrNo 로 자동 세팅합니다.<br/>
					bizService.oneWayEncrypt(암호화할 str, userId) // userId를 param 으로 넘길 경우 mbrNo 또는 usrNo , userId 를 넘기면 됩니다.<br/>
					<br/>
					// 양방향<br/>
					bizService.twoWayEncrypt(암호화할 str)<br/>
					bizService.twoWayEncrypt(암호화할 str, userId)<br/>
					bizService.twoWayDecrypt(복호화할 str)<br/>
					bizService.twoWayDecrypt(복호화할 str, userId)<br/>
					<br/>
					Ex)<br/>
					String oneWayEncryptStrNoUserId = bizService.oneWayEncrypt("apet"); <br/>
					String oneWayEncryptStr = bizService.oneWayEncrypt("apet", 0L);<br/>
					String twoWayEncryptStrNoUserId = bizService.twoWayEncrypt("petLog");<br/>
					String twoWayEncryptStr = bizService.twoWayEncrypt("petLog", "NonLoginUser");<br/>
					String twoWayDecryptStrNoUserId = bizService.twoWayDecrypt("petLog");<br/>
					String twoWayDecryptStr = bizService.twoWayDecrypt("petLog", "90000001");<br/>
				</p>
				<form id="petraForm" name="petraForm" method="post">
					<table class="table_type1">
						<caption>암복호화</caption>
						<tbody>
			                <tr>
			                    <th>양방향 암호화</th>
			                    <td>
									<input type="text" id="twowayEnc" name="twowayEnc" class="validate[required] w180">
									<button type="button" onclick="petraEnc('two');" class="btn btn-ok">암호화</button>
									<input type="text" id="twowayEncTxt" name="twowayEncTxt" class="validate[required] w300 readonly" readonly="readonly">
			                    </td>
			                    <th rowspan="2">단방향 암호화</th>
			                    <td rowspan="2">
			                    	<input type="text" id="onewayEnc" value="${onewayEnc }" name="onewayEnc">
			                    	<button type="button" onclick="petraEnc('one');" class="btn btn-ok">암호화</button>
									<input type="text" id="onewayEncTxt" name="onewayEncTxt" class="validate[required] w300 readonly" readonly="readonly">
			                    </td>
			                </tr>
			                <tr>
			                	<th>양방향 복호화</th>
			                    <td>
			                    	<input type="text" id="twowayDec" name="twowayDec" class="validate[required] w180" >
			                    	<button type="button" onclick="petraDec();" class="btn" style="background-color: #0066CC;">복호화</button>
									<input type="text" id="twowayDecTxt" name="twowayDecTxt" class="validate[required] w300 readonly" readonly="readonly">
			                	</td>
			                </tr>
			                	
			                
						</tbody>
					</table>
					</form>
					
			    </div>
			</div>
			<br/>
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="TWC, 그 외 암복호화 관련" style="padding:10px">
				<p> - key 없이 암복호화 진행시, TWC key 로 암복호화 </p>
				<form id="petraForm" name="petraForm" method="post">
					<table class="table_type1">
						<caption>암복호화</caption>
						<tbody>
			                <tr>
			                    <th>양방향 암호화</th>
			                    <td>
									<input type="text" id="tEnc" name="tEnc" class="validate[required] w180">
									<button type="button" onclick="twcEnc();" class="btn btn-ok">암호화</button>
									<input type="text" id="twcEncTxt" name="twcEncTxt" class="validate[required] w300 readonly" readonly="readonly">
			                    </td>
			                    <th rowspan="2">Key</th>
			                    <td rowspan="2">
			                    	<input type="text" id="twcKey" value="" name="twcKey" class="w500">
			                    </td>
			                </tr>
			                <tr>
			                	<th>양방향 복호화</th>
			                    <td>
			                    	<input type="text" id="tDec" name="tDec" class="validate[required] w180" >
			                    	<button type="button" onclick="twcDec();" class="btn" style="background-color: #0066CC;">복호화</button>
									<input type="text" id="twcDecTxt" name="twcDecTxt" class="validate[required] w300 readonly" readonly="readonly">
			                	</td>
			                </tr>
			                	
			                
						</tbody>
					</table>
					</form>
					
			    </div>
			</div>
		</div>
		<br/>
		
	</t:putAttribute>
</t:insertDefinition>