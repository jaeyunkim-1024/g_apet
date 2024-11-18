						<c:forEach var="tagVodList" items="${tagVodList }">
                            <li>
                                <div class="thumb-box">
                                    <div class="div-img">
                                    	<c:if test="${tagVodList.newYn eq 'Y' }">
                                        	<i class="icon-n">N</i>
                                        </c:if>
										<c:if test="${tagVodList.vdGbCd eq frontConstants.VD_GB_10 }">
											<a href="#" onclick="tvDetail('${tagVodList.vdId}', 'S', '${tagVodList.tagNo}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(tagVodList.thumPath, 'cdn.ntruss.com') > -1 ? tagVodList.thumPath : frame:optImagePath(tagVodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${tagVodList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${tagVodList.vdId}">
												<div class="time-tag"><span>${tagVodList.totLnth }</span></div>
	                                        </a>
										</c:if>
										<c:if test="${tagVodList.vdGbCd eq frontConstants.VD_GB_20 }">
											<a href="#" onclick="tvDetail('${tagVodList.vdId}', 'N', '${tagVodList.tagNo}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(tagVodList.thumPath, 'cdn.ntruss.com') > -1 ? tagVodList.thumPath : frame:optImagePath(tagVodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${tagVodList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=TAG_${tagVodList.tagNo}">
												<div class="time-tag"><span>${tagVodList.totLnth }</span></div>
	                                        </a>
										</c:if>
                                    </div>
                                    <div class="thumb-info top">
                                    	<c:choose>
	                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                                    		<div class="round-img-pf" onclick="srisDetail(${tagVodList.srisNo});" style="background-image:url(${fn:indexOf(tagVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? tagVodList.srisPrflImgPath : frame:optImagePath(tagVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)}); cursor:pointer;"></div>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<div class="round-img-pf" onclick="srisDetail(${tagVodList.srisNo});" style="background-image:url(${fn:indexOf(tagVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? tagVodList.srisPrflImgPath : frame:optImagePath(tagVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}); cursor:pointer;"></div>
	                                    	</c:otherwise>
                                    	</c:choose>
                                        <div class="info">
                                            <div class="tlt k0426">
                                            	<c:if test="${tagVodList.vdGbCd eq frontConstants.VD_GB_10 }">
													<a href="#" onclick="tvDetail('${tagVodList.vdId}', 'S', '${tagVodList.tagNo}'); return false;" data-content="${tagVodList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${tagVodList.vdId}">
														${tagVodList.ttl }
			                                        </a>
												</c:if>
												<c:if test="${tagVodList.vdGbCd eq frontConstants.VD_GB_20 }">
													<a href="#" onclick="tvDetail('${tagVodList.vdId}', 'N', '${tagVodList.tagNo}'); return false" data-content="${tagVodList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=TAG_${tagVodList.tagNo}">
														${tagVodList.ttl }
			                                        </a>
												</c:if>
											</div>
                                            <div class="detail">
                                                <%-- <span class="read play">${tagVodList.hits }</span> --%>
                                                <span class="read like" data-read-like="${tagVodList.vdId}"><fmt:formatNumber type="number" value="${tagVodList.likeCnt }"/></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
						</c:forEach>