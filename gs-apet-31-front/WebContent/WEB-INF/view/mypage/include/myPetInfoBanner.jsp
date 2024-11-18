<div class="sect line">
	<dl class="my">
		<dt>
			<span><spring:message code='front.web.view.common.mypet.info.banner.management' /></span>
			<c:if test="${petList ne '[]'}">
				<a href="#" onclick="fncGoPetList(); return false;" class="next" data-content="${session.mbrNo }" data-url="/my/pet/myPetListView"></a>
			</c:if>
		</dt>
		<dd>
			<c:choose>
				<c:when test="${petList ne '[]'}">
					<ul  class="img-set">
						<c:choose>
						<c:when test="${view.deviceGb  eq 'PC'}">	
							<c:forEach items="${petList}" var="item" >
								<c:if test=""></c:if>
								<li>
									<img src="${frame:imagePath(item.imgPath) }" onclick="fncGoPetView('${item.petNo}');" style="cursor: pointer;height: 100%;width: 100%;" data-url="/my/pet/myPetView?petNo='+${item.petNo}" data-content="${session.mbrNo }">
								</li>
								
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${petList}" var="item" varStatus="status"  begin="0" end="2">
								<li>
									<img src="${frame:imagePath(item.imgPath) }" onclick="fncGoPetView('${item.petNo}');" style="cursor: pointer;height: 100%;width: 100%;" data-url="/my/pet/myPetView?petNo='+${item.petNo}" data-content="${session.mbrNo }">
									<c:if test="${status.index == 2}">
										<span><img src="${frame:imagePath(item.imgPath) }"  style="cursor: pointer;height: 100%;width: 100%;"></span>
										<em onclick="fncGoPetList();" data-url="/my/pet/myPetListView" data-content="${session.mbrNo }" >+${fn:length(petList) - 2}</em>
									</c:if>
								</li>
								
							</c:forEach>
						</c:otherwise>
						</c:choose>
						
					</ul>
					<button class="btn re" onclick="fncGoPetList();" data-url="/my/pet/myPetListView" data-content="${session.mbrNo }"><spring:message code='front.web.view.common.msg.setting' /></button>
				</c:when>
				<c:otherwise>
					<div class="pet">
						<p class="ex"><spring:message code='front.web.view.common.mypet.info.banner.pet.regist' />&nbsp;<span><spring:message code='front.web.view.common.mypet.info.banner.manage.vaccination.list' /></span></p>
						<button class="btn add" onClick="fncGoPetInsert();" data-content="${session.mbrNo }" data-url="/my/pet/petInsertView"><spring:message code='front.web.view.join.mypet_enroll.result.button.title' /></button>
					</div>
				</c:otherwise>
			</c:choose>
		</dd>
	</dl> 
</div>