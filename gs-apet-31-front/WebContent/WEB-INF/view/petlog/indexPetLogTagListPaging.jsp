<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<div>
<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
<c:forEach items="${tagPetLogList}" var="petLogBase" varStatus="idx">								
								<li>								
										<a href="javascript:goPetLogListT('${idx.index }' ,'${so.page }')" class="logPicBox">
					<c:choose>
						<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath != ''}">
										<span class="logIcon_pic i01" style="z-index:1;"></span>
										<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" style="height:100%" uid="${petLogBase.mbrNo}|${session.mbrNo}"></div>
						</c:when>	
						<c:otherwise>
							<c:if test="${petLogBase.imgCnt > 1}">
										<span class="logIcon_pic i02"></span>
							</c:if>										
							<c:choose>
								<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
										<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_490)}" alt="">
								</c:when>
								<c:otherwise>
										<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_510)}" alt="">
								</c:otherwise>
							</c:choose>
<!--  										<img src="../../_images/_temp/temp_logimg001.jpg" alt=""> -->
						</c:otherwise>
					</c:choose>
										</a>
								</li>
</c:forEach>
</div>

