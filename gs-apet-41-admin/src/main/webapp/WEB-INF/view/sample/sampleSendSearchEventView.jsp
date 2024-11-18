<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script>		
			$(document).ready(function(){		
				$("input[name='logGb']").change(function(){
					$(".action :input").val("");
					$(".search :input").val("");
					if($("input[name='logGb']:checked").val() == "SEARCH"){
						$(".search").show();						
						$(".action").hide();
					}else{
						$(".action").show();						
						$(".search").hide();
					}
				});
			})
			
			function sendClickEvent() { 
				let sendData = $("#sendClickEventForm").serializeJson();
				let options = {
					url : "<spring:url value='/sample/sampleSendSearchEventTest.do' />"
					, data : sendData
					, callBack : function(result){
						messager.alert(result, "Info", "info");
					}
				};
				ajax.call(options);
			}
	        
			function setNow() {
				var date = new Date();				
				var year = date.getFullYear();              //yyyy
			    var month = (1 + date.getMonth());          //M
			    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
			    var day = date.getDate();                   //d
			    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
			    var hour = date.getHours();
			    hour = hour >= 10 ? hour : '0' + hour;
			    var min = date.getMinutes();
			    min = min >= 10 ? min : '0' + min;
			    var sec = date.getSeconds();
			    sec = sec >= 10 ? sec : '0' + sec;
			    var now =   year + '-' + month + '-' + day + " " + hour + ":" + min + ":" + sec;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
				$("input[name='timestamp']").val(now);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="검색 이벤트 전송 안내" style="padding:10px">
				<p>- 메소드 : BizService.sendClickEventToSearchEngineServer(SearchEngineEventPO sepo)</p>
				<p>- PO : SearchEngineEventPO (아래부터 해당 필드명 기준으로 설명)</p>
				<p>- <span style="color:red;">logGb 로 검색 이벤트 와 클릭 이벤트 구분 : "SEARCH", "ACTION" </span></p>
				<p>- <span style="color:red;">검색 이벤트 필드 설명</span></p>
					<table class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="503" style="border-collapse:
					 collapse;width:377pt">
					 <colgroup><col width="96" style="mso-width-source:userset;mso-width-alt:3072;width:72pt">
					 <col width="56" style="mso-width-source:userset;mso-width-alt:1792;width:42pt">
					 <col width="63" style="mso-width-source:userset;mso-width-alt:2016;width:47pt">
					 <col width="72" span="4" style="width:54pt">
					 </colgroup><tbody><tr height="37" style="height:27.75pt">
					  <td height="37" class="xl67" width="96" style="color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; height:27.75pt;width:72pt">Name<br>
					    (depth1)</td>
					  <td class="xl67" width="56" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-left:none;width:42pt">Type</td>
					  <td class="xl67" width="63" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-left:none;width:47pt">필수여부</td>
					  <td colspan="2" class="xl68" width="144" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:1.0pt solid windowtext;
						border-right:none;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-right:1px solid black;
					  border-left:none;width:108pt">설명</td>
					  <td colspan="2" class="xl70" width="144" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:none;
						border-bottom:1.0pt solid windowtext;
						border-left:none;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">예시 / 값</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl70" width="99" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;width:74pt">logGb </td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl72" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">이벤트 구분</td>
					  <td colspan="2" class="xl73" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none; border-right:1.0pt solid black">SEARCH</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl72" width="96" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;width:72pt">mbr_no</td>
					  <td class="xl73" width="56" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; width:42pt">String</td>
					  <td class="xl73" width="63" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-left:none;width:47pt">자동입력</td>
					  <td colspan="2" class="xl74" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">회원 ID</td>
					  <td colspan="2" class="xl75" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none; border-right:1.0pt solid black">75</td>
					 </tr>
					 <tr height="40" style="mso-height-source:userset;height:30.0pt">
					  <td height="40" class="xl72" width="96" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:30.0pt;border-top:none;
					  width:72pt">section</td>
					  <td class="xl73" width="56" style="height:30.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:42pt">String</td>
					  <td class="xl73" width="63" style="height:30.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl83" width="144" style="height:30.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-right:1px solid black;
					  border-left:none;width:108pt">요청구분</td>
					  <td colspan="2" class="xl77" width="144" style="height:30.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">category<br>
					    content</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl72" width="96" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;border-top:none;
					  width:72pt">index</td>
					  <td class="xl73" width="56" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:42pt">String</td>
					  <td class="xl73" width="63" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl84" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1.0pt solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">카테고리 종류</td>
					  <td colspan="2" class="xl86" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1.0pt solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-right:1.0pt solid black;
					  border-left:none;width:108pt">TV/LOG/SHOP</td>
					 </tr>
					 <tr height="34" style="mso-height-source:userset;height:25.5pt">
					  <td height="34" class="xl72" width="96" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:25.5pt;border-top:none;
					  width:72pt">content_id</td>
					  <td class="xl73" width="56" style="height:25.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:42pt">String</td>
					  <td class="xl73" width="63" style="height:25.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl83" width="144" style="height:25.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-right:1px solid black;
					  border-left:none;width:108pt">콘텐츠/상품 번호<br>
					    (SECTION이 content 일시)</td>
					  <td colspan="2" class="xl77" width="144" style="height:25.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">PRODUCT-0001</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl72" width="96" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;border-top:none;
					  width:72pt">keyword</td>
					  <td class="xl73" width="56" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:42pt">String</td>
					  <td class="xl73" width="63" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl88" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; border-left:none;width:108pt">검색어</td>
					  <td colspan="2" class="xl77" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">강아지</td>
					 </tr>
					 <tr height="41" style="mso-height-source:userset;height:30.75pt">
					  <td height="41" class="xl79" width="96" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:30.75pt;width:72pt">timestamp</td>
					  <td class="xl73" width="56" style="height:30.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:42pt">String</td>
					  <td class="xl73" width="63" style="height:30.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">자동입력</td>
					  <td colspan="2" class="xl80" width="144" style="height:30.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:108pt">발생일시<br>
					    (was 서버기준)</td>
					  <td colspan="2" class="xl82" width="144" style="height:30.75pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">2020-12-20 12:30</td>
					 </tr></tbody></table><br><p><br></p>
				<p>- <span style="color:red">클릭(액션) 이벤트 필드 설명</span></p>
								<table class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="584" style="border-collapse:collapse;width:438pt">
					 <colgroup><col width="99" style="mso-width-source:userset;mso-width-alt:3168;width:74pt">
					 <col width="52" style="mso-width-source:userset;mso-width-alt:1664;width:39pt">
					 <col width="62" style="mso-width-source:userset;mso-width-alt:1984;width:47pt">
					 <col width="72" style="width:54pt">
					 <col width="155" style="mso-width-source:userset;mso-width-alt:4960;width:116pt">
					 <col width="72" span="2" style="width:54pt">
					 </colgroup><tbody><tr height="37" style="height:27.75pt">
					  <td height="37" class="xl65" width="99" style="color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; height:27.75pt;width:74pt">Name<br>
					    (depth1)</td>
					  <td class="xl65" width="52" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-left:none;width:39pt">Type</td>
					  <td class="xl65" width="62" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-left:none;width:47pt">필수여부</td>
					  <td colspan="2" class="xl66" width="227" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:1.0pt solid windowtext;
						border-right:none;
						border-bottom:1.0pt solid windowtext;
						border-left:1px solid windowtext;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-right:1px solid black;
					  border-left:none;width:170pt">설명</td>
					  <td colspan="2" class="xl68" width="144" style="height:27.75pt; color:windowtext;
						font-size:10.0pt;
						font-weight:700;
						text-align:center;
						border-top:none;
						border-right:none;
						border-bottom:1.0pt solid windowtext;
						border-left:none;
						background:silver;
						mso-pattern:black none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">예시 / 값</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl70" width="99" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;width:74pt">logGb</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-left:none;width:47pt">자동입력</td>
					  <td colspan="2" class="xl72" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">이벤트 구분</td>
					  <td colspan="2" class="xl73" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none; border-right:1.0pt solid black">ACTION</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl70" width="99" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;width:74pt">mbr_no</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-left:none;width:47pt">자동입력</td>
					  <td colspan="2" class="xl72" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">회원 ID</td>
					  <td colspan="2" class="xl73" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none; border-right:1.0pt solid black">75</td>
					 </tr>
					 <tr height="36" style="mso-height-source:userset;height:27.0pt">
					  <td height="36" class="xl70" width="99" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:27.0pt;border-top:none;
					  width:74pt">section</td>
					  <td class="xl71" width="52" style="height:27.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:27.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl72" style="height:27.0pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">요청구분</td>
					  <td colspan="2" class="xl75" width="144" style="height:27.0pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">shop<br>
					    log<br>
					    tv<br>
					    member (사용자)</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl70" width="99" style="color:windowtext;
						font-size:9.0pt;
						border:1px solid black;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">content_id</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl72" style="height:16.5pt; width:108pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext; border-right:1px solid black;border-left:
					  none">콘텐츠/상품 번호/회원번호/태그번호</td>
					  <td colspan="2" class="xl75" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">PRODUCT-0001</td>
					 </tr>
					 <tr height="546" style="mso-height-source:userset;height:409.5pt">
					  <td rowspan="2" height="700" class="xl80" width="99" style="color:windowtext;
						font-size:9.0pt;
						text-align:center;
						border-top:1px solid black;
						border-right:1px solid windowtext;
						border-bottom:none;
						border-left:none;
						white-space:normal; border-bottom:1px solid black;
					  height:525.0pt;border-top:none;width:74pt">action</td>
					  <td rowspan="2" class="xl82" width="52" style="height:409.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:none;
						border-left:1px solid windowtext;
						white-space:normal; border-bottom:1px solid black;
					  border-top:none;width:39pt">String</td>
					  <td rowspan="2" class="xl82" width="62" style="height:409.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:none;
						border-left:1px solid windowtext;
						white-space:normal; border-bottom:1px solid black;
					  border-top:none;width:47pt">Y</td>
					  <td colspan="2" rowspan="2" class="xl84" width="227" style="height:409.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:none;
						border-left:1px solid windowtext;
						white-space:normal; border-bottom:1px solid black;
					  width:170pt">- section이 shop 일때<br>
					    interest : 찜<br>
					    interest_d : 찜 취소 <br>
					    order : 구매<br>
					    cart : 장바구니 담기<br>
					    view : 조회<br>
					    share : 공유<br>
					    delete : 최근 본 상품 삭제<br>
					    <br>
					    - section이 log 일때<br>
					    like : 좋아요<br>
					    like_d : 좋아요 취소<br>
					    followm : 팔로우(회원) <br>
					    followm_d : 팔로우(회원) 취소<br>
					    followt : 팔로우(태그) <br>
					    followt_d : 팔로우(태그) 취소 <br>
					    share : 공유<br>
					    reply : 댓글입력<br>
					    petlog : 펫로그 작성<br>
					    view : 조회<br>
					    <br>
					    - section이 tv 일때<br>
					    share : 공유<br>
					    like : 좋아요 <br>
					    like_d : 좋아요 취소<br>
					    watch : 시청<br>
					    reply : 댓글입력<br>
					    view : 조회<br>
					    delete : 최근 본 영상 삭제<br>
					    <br>
					    - section이 user 일때<br>
					    change : 관심태그 변경<br>
					    <br>
					    - 기타<br>
					    &nbsp;etc : 기타 모든 클릭&nbsp; <br>
					    &nbsp; <br>
					    (위 액션시 담아야할 값)</td>
					  <td colspan="2" rowspan="2" class="xl85" width="144" style="height:409.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border-top:1px solid windowtext;
						border-right:none;
						border-bottom:none;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  border-bottom:1px solid black;width:108pt">view<br>
					    interest<br>
					    interest_d<br>
					    order<br>
					    cart<br>
					    like<br>
					    like_d<br>
					    followm<br>
					    followm_d<br>
					    followt<br>
					    followt_d<br>
					    share<br>
					    reply<br>
					    petlog<br>
					    watch<br>
					    change<br>
					    delete<br>
					    etc</td>
					 </tr>
					 <tr height="154" style="mso-height-source:userset;height:115.5pt">
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">url</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">현재
					  URL</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">　</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">targetUrl</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">Y</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">타겟
					  URL</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">클릭 시 이동 URL</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">litd</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">경도</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">암호화 필요</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">lttd</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">위도</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">암호화 필요</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">prclAddr</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">지번 주소</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">암호화 필요</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">roadAddr</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">도로 주소</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">암호화 필요</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">postNoNew</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">우편번호</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">암호화 필요</td>
					 </tr>
					 <tr height="22" style="height:16.5pt">
					  <td height="22" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:16.5pt;border-top:none;
					  width:74pt">agent</td>
					  <td class="xl71" width="52" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">N</td>
					  <td colspan="2" class="xl77" width="227" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">전송기기</td>
					  <td colspan="2" class="xl79" width="144" style="height:16.5pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">IOS, Android, 등등</td>
					 </tr>
					 <tr height="45" style="mso-height-source:userset;height:33.75pt">
					  <td height="45" class="xl76" width="99" style="color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border:1px solid windowtext;
						white-space:normal; height:33.75pt;border-top:none;
					  width:74pt">timestamp</td>
					  <td class="xl71" width="52" style="height:33.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:39pt">String</td>
					  <td class="xl71" width="62" style="height:33.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:center;
						border:1px solid windowtext;
						white-space:normal; border-top:none;border-left:none;width:47pt">자동입력</td>
					  <td colspan="2" class="xl77" width="227" style="height:33.75pt; color:windowtext;
						font-size:10.0pt;
						text-align:left;
						border-top:none;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:1px solid windowtext;
						white-space:normal; border-left:none;width:170pt">발생일시<br>
					    (was 서버기준)</td>
					  <td colspan="2" class="xl79" width="144" style="height:33.75pt; color:windowtext;
						font-size:10.0pt;
						mso-number-format:'General Date';
						text-align:left;
						border-top:1px solid windowtext;
						border-right:1px solid windowtext;
						border-bottom:1px solid windowtext;
						border-left:none;
						white-space:normal; border-right:1.0pt solid black;
					  width:108pt">2020-12-20 12:30</td>
					 </tr></tbody></table><p><br></p>
			</div>
		</div>
		<br/>
		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="FO 호출 예시 " style="padding:10px">
				<table class="table_type1">
					<colgroup>
						<col />
						<col />
					</colgroup>
					<tr>
						<td >
							<p>-&nbsp;<b>검색 이벤트</b></p>
							<pre>
$.ajax({
	url : "/common/sendSearchEngineEvent"
	, data : {
		"logGb" : 'SEARCH'
		, "section" : 'content'
		, "index" : 'tv'
		, "content_id" : 'PRODUCT-0001'
		, "keyword" : '강아지'
	}
});
							</pre>
						</td>
						<td>
							<p>-&nbsp;<b>클릭 이벤트</b></p>
							<pre>
 $.ajax({
	url : "/common/sendSearchEngineEvent"
	, data : {
		 "section" : 'shop'
		, "content_id" : "G12353234"
		, "action" : "interest"
		, "url" : "https://stg.aboutpet.co.kr/goods/indexGoodsDetail?goodsId=GI000000015"
	}
});
							</pre>
						</td>			
					</tr>
				</table>
			</div>
		</div>
		<br/>
		
		
	</t:putAttribute>
</t:insertDefinition>