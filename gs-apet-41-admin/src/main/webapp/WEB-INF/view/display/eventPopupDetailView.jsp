<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			th.ui-th-column div { white-space:normal !important; height:auto !important; }
		</style>
		<script type="text/javascript">		
		var isGridExists = false;		
		$(document).ready(function() {			
			//게시기간 10분 단위 설정				
			$('#dispStrtMn option').each(function(){ 
				if (parseInt(this.value) % 10 != 0) {
					$(this).css("display","none");
				} 
			});
			$('#dispEndMn option').each(function(){ 
				if (parseInt(this.value) % 10 != 0) {
					$(this).css("display","none");
				} 
			});
			
			$(document).on("click", "#imageUpload", function(){					
				var limitObj = {
					width : 750,
					height : 872
				}				
				fileUpload.imageCheck(resultImage,  "bnrImgPath" ,limitObj);
			})
		});
				
		// 이미지 업로드 결과
		function resultImage(file, id) {
			var flNm = file.fileName.toLowerCase();
			if(flNm.indexOf("gif") < 0 && flNm.indexOf("jpg") < 0 && flNm.indexOf("png") < 0){
				messager.alert( "파일 확장자는 gif, jpg, png만 가능합니다." ,"Info","info");
			}else{
				$("#orgFileNm").val(file.fileName);// 원 파일 명
				$("#phyPath").val(file.filePath);// 물리 경로
				$("#flSz").val(file.fileSize);	// 파일 크기
				$("#imgPreView").show();
				$("#imgPreView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
				$("#flNo").val("");
				$("#evtpopImgPath").val("");
			}
		}
		
		//팝업 배너 수정
		function updateEvtpop(){
			if(inquiryValidate.evtPop()){	
				messager.confirm("<spring:message code='column.common.confirm.save' />",function(r){
					if(r){						
						$("#displayStrtDtm").val(getDateStr ("dispStrt"));
						$("#displayEndDtm").val(getDateStr ("dispEnd"));
						
						var options = {
								url : "<spring:url value='/display/eventPopupUpdate.do' />",
								data : $("#evtPopDetailForm").serialize(),
								callBack : function(data ) {	
									if(Number(data.updateCnt) > 0){
										var msg = "<spring:message code='column.display_view.message.save' />";							
										messager.alert(msg, "Info", "info", function(){
											updateTab('/display/eventPopupListView.do','팝업 배너 조회');
										});
									}else{
										messager.alert( "등록 실패 했습니다." ,"Info","info");
									}
									
								}
						};				
						ajax.call(options);
					}
				});				
			}			
		}
		
		var inquiryValidate = {
			evtPop : function(){
				var msg = "";	
				//게시구분
				if($("#evtpopGbCd option:selected").val() == "" || $("#evtpopGbCd option:selected").val() == null){
					msg = $('#evtpopGbCd').attr('title')+"을";
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopGbCd").focus();
					return;
				}
				//게시위치
				/* if($("#evtpopLocCd option:selected").val() == "" || $("#evtpopLocCd option:selected").val() == null){
					msg = $('#evtpopLocCd').attr('title')+"를";
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopLocCd").focus();
					return;
				} */
				//제목
				if($("#evtpopTtl").val() == "" || $("#evtpopTtl").val() == null){
					msg = $('#evtpopTtl').attr('title')+"을";
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopTtl").focus();
					return;
				}
				//image
				if($("#orgFileNm").val() == "" || $("#orgFileNm").val() == null){
					msg = "이미지를";
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopTtl").focus();
					return;
				}
				//게시기간
				if ($("#dispStrtDt").val() == "") {
					messager.alert("<spring:message code='admin.web.view.msg.exhibition.term' />","Info","info",function(){
						$("#dispStrtDt").focus();
					});
	                return false;
				} else if ($("#dispEndDt").val() == "") {
					messager.alert("<spring:message code='admin.web.view.msg.exhibition.term' />","Info","info",function(){
						$("#dispEndDt").focus();
					});
	                return false;
				} else if ($("#dispStrtDt").val() > $("#dispEndDt").val()){
					messager.alert("기간 시작일은 종료일과 같거나 이전이여야 합니다","Info","info",function(){
						$("#dispStrtDt").focus();
					});
					 return false;
				}
				
				var regExp = /[0-9]/;
				//노출순서					
				if($("#evtpopSortSeq").val() == "" || $("#evtpopSortSeq").val() == null){
					msg = $('#evtpopSortSeq').attr('title')+"을";
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopSortSeq").focus();
					return;
				}
				//사용여부
				if($(":input:radio[name=evtpopStatCd]:checked").val() == "" || $(":input:radio[name=evtpopStatCd]:checked").val() == null){
					msg = '<spring:message code="column.stat"/>를';
					messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
					$("#evtpopStatCd").focus();
					return;
				}
				
				return true;
			}				
		};
		//이미지 삭제
		function delImage(){
			$("#orgFileNm").val("");// 원 파일 명
			$("#phyPath").val("");// 물리 경로
			$("#flSz").val("");	// 파일 크기			
			$("#imgPreView").attr('src', '/images/noimage.png' );
			$("#flNo").val("");
			$("#evtpopImgPath").val("");
		}
		//팝업배너삭제
		function deleteEvtpop(){
			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var options = {
							url : "<spring:url value='/display/eventPopupDelete.do' />",
							data : $("#evtPopDetailForm").serialize(),
							callBack : function(data ) {	
								if(Number(data.updateCnt) > 0){
									var msg = "<spring:message code='column.display_view.message.delete' />";							
									messager.alert(msg, "Info", "info", function(){
										updateTab('/display/eventPopupListView.do','팝업 배너 조회');
									});
								}else{
									messager.alert( "삭제 실패 했습니다." ,"Info","info");
								}								
							}
					};			
					ajax.call(options);
				}
			});
		}
		

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>팝업 배너 등록</h2>
		</div>
		<form id="evtPopDetailForm" name="evtPopDetailForm" method="post">	
			<input type = "hidden" name = "phyPath"			id = "phyPath"/>		
			<input type = "hidden" name = "flSz" 			id = "flSz" 	/>
			<input type = "hidden" name = "flModYn" 		id = "flModYn" />
			<input type = "hidden" name = "displayStrtDtm"  id = "displayStrtDtm" value="" />
			<input type = "hidden" name = "displayEndDtm"   id = "displayEndDtm" value="" />
			<input type = "hidden" name = "flNo" 			id = "flNo"  value="${evtpop.flNo }"/>
			<input type = "hidden" name = "evtpopNo"		id = "evtpopNo"  value="${evtpop.evtpopNo }"/>
			<input type = "hidden" name = "evtpopImgPath"	id = "evtpopImgPath"  value="${evtpop.evtpopImgPath }"/>

			<table class="table_type1">
				<caption>팝업 배너 등록</caption>
				<colgroup>
					<col style="width:20%;">							
					<col style="width:27%;">
					<col style="width:23%;">
					<col style="width:30%;">					
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">게시구분<strong class="red">*</strong></th>
						<!-- 게시구분 -->
						<td colspan = "3">
							<select name="evtpopGbCd" id="evtpopGbCd" title="게시구분" >                                
                                <frame:select grpCd="${adminConstants.EVTPOP_GB}" showValue="false" selectKey="${evtpop.evtpopGbCd}" />
                            </select>							
						</td>
						<!-- 게시위치. 미노출로 변경20210804  -->
						<%-- <th scope="row">게시위치<strong class="red">*</strong></th>
						<td>
							<select name="evtpopLocCd" id="evtpopLocCd" title="게시위치" >                            	
                                <frame:select grpCd="${adminConstants.EVTPOP_LOC}" showValue="false" selectKey="${evtpop.evtpopLocCd}" />
                            </select>							
						</td> --%>								
					</tr>					
					<tr>
						<th scope="row"><spring:message code="column.ttl"/><strong class="red">*</strong></th>
						<!-- 제목 -->
						<td colspan = "3">
							<input type="text"  class = "w800" name="evtpopTtl" id="evtpopTtl" title="<spring:message code="column.ttl"/>" value="${evtpop.evtpopTtl}" >				
						</td>								
					</tr>					
					
					<tr style ="height:100px">
						<th scope="row">이미지<strong class="red">*</strong></th>	
						<!-- 이미지 -->		
						<td>					
							<div>								
								<input type="text"  class="w300" name="orgFileNm" id="orgFileNm" title="파일명" readonly value="${evtpop.orgFileNm}">								
							</div>	
							<div>
							<c:set var="imgPath" value="${frame:optImagePath(evtpop.evtpopImgPath,adminConstants.IMG_OPT_QRY_400)}" />
							<c:if test="${fn:indexOf(evtpop.evtpopImgPath, 'cdn.ntruss.com') > -1 }" >
								<c:set var="imgPath" value="${evtpop.evtpopImgPath}" />
							</c:if>
							<img id="imgPreView" name="imgPreView" src="${imgPath}" onError="this.src='/images/noimage.png';"  class="thumb" alt="" style = "float:left"/>
							</div>						
						</td>
						<td colspan = "2" style="vertical-align: top;">					
							<div>
								<button type="button" class="btn" id="imageUpload" >
									찾아보기
								</button> <!-- 추가 -->
								<span class="red-desc">(파일 확장자는 gif, jpg, png만 가능합니다, 사이즈 750 x 872)</span>
							</div>	
							<div>
								<button type="button" class="btn" onclick="delImage();" style="margin-top: 10px;">
									삭제
								</button> 
							</div>						
						</td>
					</tr>
					<tr>
						<th scope="row">연결화면 URL</th>
						<!-- 연결화면 URL -->
						<td colspan = "3">									
							<input type="text" class = "noHash w800" name="evtpopLinkUrl" id="evtpopLinkUrl" title="연결화면 URL" value="${evtpop.evtpopLinkUrl}" />
						</td>												
					</tr>
					<tr>
						<th scope="row">게시 기간<strong class="red">*</strong></th>
						<!-- 게시 기간 -->
						<td colspan = "3">							
							<frame:datepicker startDate="dispStrtDt" startHour="dispStrtHr" startMin="dispStrtMn" startSec="dispStrtSec" startValue="${evtpop.displayStrtDtm}"
											  endDate="dispEndDt" endHour="dispEndHr" endMin="dispEndMn" endSec="dispEndSec" endValue="${evtpop.displayEndDtm}" />
						</td>												
					</tr>
					<tr>
						<th scope="row">노출 순서<strong class="red">*</strong></th>
						<!-- 노출 순서 -->
						<td colspan = "4">	
							<input type="text" class = "w300" name="evtpopSortSeq" id="evtpopSortSeq" title="노출 순서"  value="${evtpop.evtpopSortSeq}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
						</td>								
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.stat"/><strong class="red">*</strong></th>
						<!-- 상태 -->
						<td>
                            <frame:radio name="evtpopStatCd" grpCd="${adminConstants.EVTPOP_STAT}" selectKey="${evtpop.evtpopStatCd}" />
						</td>										
					</tr>
										
				</tbody>
			</table>					
		</form>
		
		<div class="btn_area_center">
			<button type="button" onclick="updateEvtpop();" class="btn" style = "background-color: #0066CC;">저장</button>
			<button type="button" onclick="deleteEvtpop();" class="btn">삭제</button>
			<button type="button" onclick="closeTab();" class="btn">목록</button>
		</div>						
	</t:putAttribute>
</t:insertDefinition>