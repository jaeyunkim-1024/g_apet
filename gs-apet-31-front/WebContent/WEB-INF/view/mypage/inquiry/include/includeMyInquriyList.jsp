<script type="text/javascript">
inquiry.totalCount = ${fn:length(counselList)}
</script>
<c:forEach var="counselList" items="${counselList}">
	<li name="inquiryNm" data-pst-agr-yn="${counselList.pstAgrYn }" data-cus-no="${counselList.cusNo}" data-cus-ctg1-cd="${counselList.cusCtg1Cd}" data-cus-delFlno="${counselList.flNo}">
		<div class="hBox">
			<div class="tit" name="inquiryTit" data-content="${counselList.content}">[${counselList.dtlNm}] ${counselList.content}</div>
			<div class="info">
				<div class="dds">
					<em class="dd date"><fmt:formatDate value="${counselList.cusAcptDtm}" pattern="yyyy.MM.dd" /></em> <em class="dd rep   com">${counselList.statCdNm}</em>
				</div>
				<div class="stat">
					<nav class="uidropmu dmenu">
						<button type="button" class="bt st gb">메뉴열기</button>
						<div class="list">
							<ul class="menu">
								<c:if test="${counselList.cusStatCd eq '10'}">
									<li><button type="button" class="bt" onclick="inquiryViewPop('update', this);">수정</button></li>
								</c:if>
								<li><button type="button" class="bt" onclick="deleteInquiry('${counselList.cusNo}', this)">삭제</button></li>
							</ul>
						</div>
					</nav>
				</div>
			</div>
			<button type="button" class="btnTog">버튼</button>
		</div>
		<div class="cBox" style="display: none;">
			<c:choose>
				<c:when test="${empty counselList.rplContent && empty counselList.fileList}"></c:when>
				<c:otherwise>
						<div class="addpic">
							<ul class="pics" name="inquiryPics">
								<c:if test="${not empty counselList.fileList }">
									<c:forEach var="filePath" items="${counselList.fileList }">
										<li>
											<a href="javascript:void(0);" class="pic"><img onclick="detailInquiryImgPop(this)" src="${frame:optImagePath(filePath.phyPath, frontConstants.IMG_OPT_QRY_794)}" data-img-seq="${filePath.seq }" alt="이미지" class="img"></a></li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
						<c:if test="${counselList.rplContent ne null and counselList.rplContent ne ''}">
							<div class="reply">
								<div class="msg" style="white-space:pre-line;"><c:out value="${counselList.rplContent}" escapeXml="false"/></div>
								<div class="info">
									<div class="dds">
										<em class="dd ids">판매자</em> / <em class="dd date"><fmt:formatDate value="${counselList.cusPrcsDtm}" pattern="yyyy.MM.dd" /></em> 
									</div>
								</div>
							</div>
						</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</li>
</c:forEach>