<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
	<script>
	
	$(function(){
		
		$(document).on("click" , "#fileDownload" , function(){
			fileDownload("${notice.filePath}" , "${notice.fileName}");
		})
	});
	
	//파일 다운로드
	 function fileDownload(filePath, fileName){
		var deviceGb = "${view.deviceGb}";
		if(deviceGb != "${frontConstants.DEVICE_GB_10}"){
			ui.alert("<spring:message code='front.web.view.customer.filedownload.mobile.msg.check.warning' />");
		}else{
			var inputs = "<input type=\"hidden\" name=\"filePath\" value=\""+filePath+"\"/><input type=\"hidden\" name=\"fileName\" value=\""+fileName+"\"/>";
		 	jQuery("<form action=\"/common/fileDownloadResult\" method=\"post\">"+inputs+"</form>").appendTo('body').submit();					
		}
		
	 }

	</script>
	<article class="popLayer a popInqry" id="popInqry">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">${notice.ttl}</h1>
					<button type="button" class="btnPopClose" onclick="ui.popLayer.close('popInqry')">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<div class="inqryBox">
						<div class="inqry_Contbox">
							<div class="txt_date">
								<span class="date"><frame:date date="${notice.stringRegDtm }" type="C" /></span>
							</div>
							<div class="attach_file">
								<p class="atchFile" id="fileDownload" title="[제휴종류] 입점 및 제휴 제안서 업체명.xlsx">[제휴종류] 입점 및 제휴 제안서 업체명.xlsx</p>
							</div>
						</div>
						<div class="inqry_Contbox">
							<div class="inqry_textBox">
								<div class="notiTxt">
									<p>입점 및 제휴 문의는 온라인 접수를 통해서만 가능합니다.</p>
									<p>입점, 마케팅 등 파트너십 관련 문의는 아래 메일을 통해 연락주세요.</p>
								</div>
								<div>
									<p class="tit"><strong>1. 제휴 신청서 접수</strong></p>
									<p>입점 및 제휴 제안서를 작성하신 후 아래 메일로 보내주세요.</p>
									<p>(신청서 제출 : <strong>md@petsbe.com</strong>)</p>
									<br>
									<p>메일 제목은 아래와 같이 통일해주세요.</p>
									<p>(예시 : <strong>[제휴종류]입점 및 제휴 제안서_업체명</strong>)</p>
								</div>
								<div>
									<p class="tit"><strong>2. 제휴 신청서 검토</strong></p>
									<p>담당자가 접수된 신청서를 검토하고 연락드립니다.</p>
								</div>
								<div>
									<p class="tit"><strong>3. 계약 체결 및 판매</strong></p>
									<p>상품 진행이 확정되면 계약을 체결하고 상품 판매가 가능합니다.</p>
								</div>
							</div>
						</div>						
						<!-- 
						<div class="inqry_Contbox">
							${notice.content}
						</div>
						 -->
					</div>
				</main>
			</div>
		</div>
	</article>

	<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>