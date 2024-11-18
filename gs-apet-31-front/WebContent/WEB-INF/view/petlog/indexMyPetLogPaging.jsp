<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){
	if("${so.page}" == 1){
		$("#myPetLogListInfo").show()
	}
})
</script>
<c:forEach items="${myPetLogList }" var="petLogBase" varStatus="status">								
						<li name="myPetLogli" data-page="${so.page }" data-encYn = "${petLogBase.encCpltYn }">
							<a href="javascript:goPetLogListM('${petLogBase.mbrNo }' , '${status.index }' , '${so.page }')" class="logPicBox">
	<c:choose>
		<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
							<span class="logIcon_pic i01" style="z-index:1;"></span><!-- 동영상일 경우 -->
							<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" style="height:100%" uid="${petLogBase.mbrNo}|${session.mbrNo}"></div>		
		</c:when>
		<c:otherwise>
			<c:if test="${petLogBase.imgPath2 ne null and petLogBase.imgPath2 ne ''}">
							<span class="logIcon_pic i02"></span><!-- 이미지가 여러개 일 경우 -->
			</c:if>
<%-- 									<img src="${petLogBase.imgPath1}" alt=""> --%>
			<c:choose>					
				<c:when test="${petLogBase.imgPath1 ne null and petLogBase.imgPath1 ne ''}">										
					<c:set var="optImage"
							value="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_500)}" />
					<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
						<c:set var="optImage"
							value="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_490)}" />
					</c:if>
<%-- 					<c:if test="${fn:indexOf(petLogBase.imgPath1, '.gif') > -1 }"> --%>
<%-- 					<c:set var="optImage" --%>
<%-- 						value="${frame:imagePath(petLogBase.imgPath1)}" /> --%>
<%-- 					</c:if> --%>
					<img src="${optImage}" alt="">
				</c:when>
				<c:otherwise>
								<img src="../../_images/_temp/temp_logimg003.jpg" alt="">
				</c:otherwise>
			</c:choose>
		</c:otherwise>	
	</c:choose>							
							</a>
						</li>
</c:forEach>


