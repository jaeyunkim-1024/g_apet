<%--	
 - Class Name	: /pettv/petSchoolComplete.jsp
 - Description	: 펫스쿨 상세
 - Since		: 2021.2.1
 - Author		: KWJ
--%>

<%-- 
사용 Tiles 지정
--%>
<tiles:insertDefinition name="noheader_mo" >	
	<tiles:putAttribute name="script.include" value="script.pettv"/>
	<tiles:putAttribute name="script.inline">		      		
		<script type="text/javascript">
		var histCnt = Number("${histCnt}");
		var histLoginCnt = Number("${histLoginCnt}");
		histCnt = histCnt + histLoginCnt;
		
		//IOS에서 history back로 진입한경우
		$(window).bind("pageshow", function(event) {
			if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
		    	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}">				
					toNativeData.func = "onColorChange";				
					toNativeData.color = "black";	
					toNative(toNativeData);						
				</c:if>				
		    }
		});
		
		$(document).ready(function(){
			<c:if test="${empty EduContsVO}" >
			$("body").html("");
			ui.alert("잘못된 접근 입니다.<br>펫스쿨 메인으로 이동합니다.",{ // 알럿 옵션들
			    tit:"ERROR",
			    ycb:function(){
			    	location.href="/tv/petSchool";
			    },
			    ybt:"확인" // 기본값 "확인"
			});					
			</c:if>
			
			/* 앱 화면 상,하단 색상 변경. 펫스쿨에서만 black */
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}">				
				toNativeData.func = "onColorChange";				
				toNativeData.color = "black";	
				toNative(toNativeData);						
			</c:if>
			
			<c:if test="${view.twcUserAgent eq true }">			
			toNativeData.func = "onTitleBarHidden";		
			toNativeData.hidden = "Y";
			toNative(toNativeData);
			</c:if>
			
			var mbrNo = "${session.mbrNo}";
			if (mbrNo != '0') {
				petTvViewHist('<c:out value="${EduContsVO.vdId}" />', mbrNo, 0, 0, "Y");			    
			}			
			console.log("petLogYn : ${petLogYn}");
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and petLogYn eq 'Y'}" >
				var petLogStr = "게시물이 등록되었습니다.";			
				<c:if test="${!empty session.petLogUrl}" >
					petLogStr = '<div class="link"><p class="tt">게시물이 등록되었습니다.</p><a href="javascript:;" onClick="goMyPetLog();" class="lk" data-content="" data-url="/log/indexMyPetLog/${session.petLogUrl}?mbrNo=${session.mbrNo}">바로가기</a></div>';
				</c:if>
				
				ui.toast(petLogStr, {
					bot:70
				});
				
				var renewURL = location.href;
				renewURL = renewURL.replace('&petLogYn=Y','');
				history.pushState(null, null, renewURL);
			</c:if>
		});
		
		//indexMyPetLog 이동
		function goMyPetLog(){
			changeAppTopColor();
			location.href = "/log/indexMyPetLog/${session.petLogUrl}?mbrNo=${session.mbrNo}";
			//storageHist.goBack("/log/indexMyPetLog/${session.petLogUrl}?mbrNo=${session.mbrNo}");
		}
		
		function changeAppTopColor(){
			/* 앱 화면 상,하단 색상 변경. 펫스쿨에서만 black */
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}">	
			toNativeData.func = "onColorChange";				
			toNativeData.color = "white";	
			toNative(toNativeData);
			</c:if>
		}
		
		function onThumbAPIReady() {
		  //v1.js 의 thumbApi.ready() 함수 이용하여 태그 생성.(프로그래스바 처리 떄문에...)		  
		  var _cdn_url = cdn_url;
		  var _file_cdn_url = file_cdn_url;
		  
		  var _html = "";		
		  //교육용 컨텐츠에 썸네일이 생김. 기존 SGR 썸네일 가져오는 부분 수정. 2021.03.15
		  <c:forEach items="${contsList}" var="contList"  varStatus="idx">
			  <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 or (view.deviceGb eq frontConstants.DEVICE_GB_10 and idx.index lt 6) }">
			  var _bg_url = "";			  
			  <c:if test = "${empty contList.thumPath}" >
			 	  _bg_url = file_cdn_url + "vod/<c:out value='${contList.outsideVdId }' />/video.png";		 
			  </c:if>
			  <c:if test = "${!empty contList.thumPath}" >
			  	  var thumPath = "${contList.thumPath}";		  	
				  if(thumPath.indexOf('cdn.ntruss.com') > -1){
					 _bg_url = thumPath;
				  }else{
					 _bg_url = '${frame:imagePath("' + thumPath + '")}';					
				  }
			  </c:if>			  		  
			  var _progress = "<c:out value='${contList.stepProgress }' />";
			  var _vd_id    = "<c:out value='${contList.vdId }' />";
			  _html += '<li class="swiper-slide">';		  
			  _html +=		'<a href="javascript:;" onClick = "fnNextEdu(\''+_vd_id+'\')" data-url="/tv/school/indexTvDetail?vdId=${contList.vdId }" data-content="<c:out value='${contList.vdId }' />" >';
			  _html +=  	'<div class="thumb-box">';
			  _html +=			'<div class="thumb-img" style="background-image:url(\''+_bg_url+'\');">';
			  _html +=				'<div class="progress-bar" style="width:<c:out value='${contList.stepProgress }' />%;"></div>';
			  _html +=			'</div>';
			  _html +=			'<div class="thumb-info gray">';		  
			  _html +=				'<span class="tlt" style = "white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"><c:out value='${contList.ttl }' /></span>';		  
			  _html +=				'<span class="level lv<c:out value="${fn:substring(contList.lodCd,0,1)}" />">';
			  _html +=					'<span>난이도1</span><span>난이도2</span><span>난이도3</span>';
			  _html +=				'</span>';
			  _html +=			'</div>';
			  _html +=		'</div>';	
			  _html +=		'</a>';
			  _html +=	'</li>';		
			  </c:if>
		  </c:forEach>
		  $("#nextEdu").html(_html);
		  setSwiper();
		  thumbApi.ready();
		};
		
		//찜보관
		function fncBookToast(obj){
			//var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}?vdId=<c:out value="${EduContsVO.vdId}" />";			
			var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${EduContsVO.vdId}" />&histLoginCnt=2&histCnt=${histCnt}&linkYn=${linkYn}");
			if ("${session.mbrNo}" == '0'){		
				url = "/indexLogin?"+url;
				showConfirm("로그인 후 서비스를 이용할 수 있어요.\n로그인 할까요?", url , "로그인");				
				return false;
			}
			$(obj).toggleClass('on');
			//찜리스트 추가시 바로가기 추가-21.03.19 by LDS
			var str = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="javascript:;" onClick="goMyWishList();" class="lk" data-content="" data-url="/mypage/tv/myWishList">바로가기</a></div>';
			var deleteYn = "N";		
			if($(obj).hasClass("on") === false){
				str = "찜리스트에서 삭제되었어요";
				deleteYn = "Y";
			}
			if ("${session.mbrNo}" != '0') {
			    var options = {
			        url : "<spring:url value='/tv/school/saveContsInterest' />",
			        data : {
			            vdId : '<c:out value="${EduContsVO.vdId}" />' //영상ID
			            , deleteYn : deleteYn //삭제여부			            
			        },
			        async : false,
			        done : function(data){			       
			            ui.toast(str, {
							bot:70
						});
			        }
			    };			   
			    ajax.call(options);
			    
			  	//클릭 이벤트-시청					
				if(deleteYn == "N"){						
					userActionLog('<c:out value="${EduContsVO.vdId}" />', "interest");
				}else{						
					userActionLog('<c:out value="${EduContsVO.vdId}" />', "interest_d");
				}
			}
			
						
		}
		//찜리스트로 이동
		function goMyWishList(){
			changeAppTopColor();
			location.href = "/mypage/tv/myWishList";
			//storageHist.goBack("/mypage/tv/myWishList");
		}
		//다시교육하기
		function reEdu(){						
			location.href = "/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=0&histCnt="+(histCnt+2);
			//storageHist.goBack("/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=0&histCnt="+(histCnt+2));
			//history.go(-1 + (histLoginCnt*-1));
		}
		
		//다음교육이어하기
		function fnNextEdu(vdid){			
			location.href = "/tv/school/indexTvDetail?vdId="+vdid+"&histCnt="+(histCnt+2);
			//storageHist.goBack("/tv/school/indexTvDetail?vdId="+vdid+"&histCnt="+(histCnt+2));
		}
				
		//모바일 상단 < 버튼 클릭
		function goToLastStep(){			
			<c:forEach items="${EduContsVO.detailList}" var="detail"  varStatus="idx">							
				<c:if test="${idx.last}"><c:set var ="lastStep" value =  "${detail.stepNo}" /></c:if>
			</c:forEach>			
			location.href = "/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=<c:out value="${lastStep}" />&histCnt="+(histCnt+2+"&linkYn=${linkYn}");
			//history.go(-1 + (histLoginCnt*-1));
			//storageHist.goBack("/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=<c:out value="${lastStep}" />&histCnt="+(histCnt+2)+"&linkYn=${linkYn}");
		}
		
		//회원 프로필 화면으로 이동
		function goToProfile(mbrNo, petLogUrl){
			changeAppTopColor();
			location.href = "/log/indexMyPetLog/"+ petLogUrl + "?mbrNo=" + mbrNo;
			//storageHist.goBack("/log/indexMyPetLog/"+ petLogUrl + "?mbrNo=" + mbrNo);
		}
		
		//좋아할만한 펫로그 화면으로 이동
		function goToTagList(idx){
			changeAppTopColor();
			/* var eduNm = makeEduNm();
			location.href = "/log/indexPetLogTagList?tag=펫스쿨따라잡기_"+eduNm;  */
			var petLogList = "";
			<c:forEach items="${catchList}" var="catchList"  varStatus="idx">
				<c:if test="${idx.index eq 0}" >
				petLogList += "${catchList.petLogNo}";
				</c:if>
				<c:if test="${idx.index ne 0}" >
				petLogList += ",${catchList.petLogNo}";
				</c:if>			
			</c:forEach>			
			//location.href = "/log/indexLikePetLogList?petLogNo="+idx+"&petLogList="+petLogList;
			location.href = "/log/indexPetLogList?pageType=L&petLogList="+petLogList+"&selIdx="+idx;
			//storageHist.goBack("/log/indexPetLogList?pageType=L&petLogList="+petLogList+"&selIdx="+idx);
		}

		//펫로그 영상등록
		function regPetLog(){
			//var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}?vdId=<c:out value="${EduContsVO.vdId}" />";			
			var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${EduContsVO.vdId}" />&histLoginCnt=2&histCnt=${histCnt}&linkYn=${linkYn}");			
			if ("${session.mbrNo}" == '0'){		
				url = "/indexLogin?"+url;
				showConfirm("로그인 후 서비스를 이용할 수 있어요.\n로그인 할까요??", url , "로그인");							
				return false;
			}
			if("<c:out value='${mypetYn}' />" == "N"){
				//url = "/my/pet/petInsertStep1";
				url = "/my/pet/petInsertView";
				showConfirm("마이펫 등록 후 이용할 수 있어요<br/>펫정보를 등록할까요?", url, "예", "아니오");				
				return false;
			}
			changeAppTopColor();			
			var eduNm = makeEduNm();			
			location.href = "/log/indexPetLogInsertView?tag=펫스쿨따라잡기_"+eduNm+"&petLogChnlCd=30&rltId=${EduContsVO.vdId}&rtnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${EduContsVO.vdId}" />&petLogYn=Y&histLoginCnt="+(histLoginCnt+3));
			//storageHist.goBack("/log/indexPetLogInsertView?tag=펫스쿨따라잡기_"+eduNm+"&petLogChnlCd=30&rltId=${EduContsVO.vdId}&rtnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${EduContsVO.vdId}" />&petLogYn=Y&histLoginCnt="+(histLoginCnt+3)));
			
			//toNativeData.func = "onCloseMovePage";
			//toNativeData.moveUrl = "${view.stDomain}/log/indexPetLogInsertView?tag=펫스쿨따라잡기_"+eduNm+"&petLogChnlCd=30&rltId=${EduContsVO.vdId}&rtnUrl=${requestScope['javax.servlet.forward.request_uri']}?vdId=<c:out value="${EduContsVO.vdId}" />&petLogYn=Y";			
			//toNative(toNativeData);
		}
		
		//alert
		function showConfirm(msg, url , ybtNm, nbtNm){
			var ybtText = ybtNm != null ? ybtNm : "확인"
			var nbtText = nbtNm != null ? nbtNm : "취소"
			ui.confirm(msg,{ // 컨펌 창 옵션들
			    tit:"",
			    ycb:function(){		
			    	changeAppTopColor();
			    	location.href = url;
			    	//storageHist.goBack(url);
			    },
			    ncb:function(){			        
			    },
			    
			    ybt:ybtText,
			    nbt:nbtText
			});
		}
		
		function makeEduNm(){
			var eduNm = '<c:out value="${EduContsVO.ttl }" />';			
			//괄호내용 지우기
			//eduNm = eduNm.replace((/\[(.*?)\]/g),"").replace((/\((.*?)\)/g),"").replace((/\{(.*?)\}/g),"");
			eduNm = eduNm.replace((/\((.*?)\)/g),"");
			//공백 치환
			eduNm = eduNm.replace(/ /gi, "_");			
			
			return eduNm;
		}
		</script>		
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content"> 
		<!-- content 내용 부분입니다.	-->	
		<!-- 필요에 따라 로케이션 추가 : jsp:include page="/WEB-INF/tiles/b2c/include/location.jsp" -->
		<form id="petTvCompleteForm" method="post" action="/tv/school/indexTvDetail"> 
			<input type="hidden" id="vdId" 			 name="vdId" 		   value="<c:out value="${EduContsVO.vdId}" />" />
			<input type="hidden" id="stepNo" 		 name="stepNo" 		   value="0" />			
			<input type="hidden" id="petGbCd" 		 name="petGbCd" 	   value="<c:out value="${EduContsVO.petGbCd}" />" />
			<input type="hidden" id="eudContsCtgLCd" name="eudContsCtgLCd" value="<c:out value="${EduContsVO.eudContsCtgLCd}" />" />
			<input type="hidden" id="eudContsCtgMCd" name="eudContsCtgMCd" value="<c:out value="${EduContsVO.eudContsCtgMCd}" />" />
			<input type="hidden" id="eudContsCtgSCd" name="eudContsCtgSCd" value="<c:out value="${EduContsVO.eudContsCtgSCd}" />" />						
		</form>
		<main class="container page tv schoolCom" id="container">
			<div class="inr">			
				<!-- 모바일 서브헤드 -->
				<div class="pageHead black">
					<div class="inr">
						<div class="hdt">
							<button class="back" type="button" onClick="goToLastStep();" data-content="<c:out value="${EduContsVO.vdId}" />" data-url= "/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=<c:out value="${lastStep}" />" >뒤로가기</button>
						</div>
						<div class="cent"><h2 class="subtit"><c:out value="${EduContsVO.ttl }" escapeXml="false"/></h2></div>
					</div>
				</div>
				<!-- //pc-subtit -->

				<!-- 본문 -->
				<div class="contents" id="contents">
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
					<div class="pc-subtit">
						<h2><c:out value="${EduContsVO.ttl }" escapeXml="false"/></h2>
					</div>
					</c:if>
					<section class="finish">
						<h2>교육이 완료되었습니다!</h2>
						<p>
							마이펫이 과정을 모두 완료했나요?<br> 
							반복학습이 필요하다면 찜하고 복습하세요.
						</p>
						<div class="btn-area">							
							<button type="button" id="jjim" data-content="<c:out value="${EduContsVO.vdId}" />" data-url= "/tv/school/saveContsInterest" class="btn-rnd add<c:if test="${interestVo.zzimCnt gt 0 }" > on</c:if>" onClick="fncBookToast(this);">찜 보관</button>							
							<button type="button" class="btn-rnd" data-content="<c:out value="${EduContsVO.vdId}" />" data-url= "/tv/school/indexTvDetail?vdId=<c:out value="${EduContsVO.vdId}" />&stepNo=0" onClick="reEdu();">처음부터 다시보기</button>
						</div>
					</section>

					<!-- 펫스쿨 따라잡기 인기영상 -->
					<c:if test="${catchShowYn eq 'Y'}">
						<section class="catch">
							<div class="title-area">
								<h3>#펫스쿨따라잡기 Top 영상</h3>
							</div>
							<div class="swiper-div newDn">
								<div class="swiper-container">
									<ul class="swiper-wrapper">
										<c:forEach items="${catchList}" var="catchList"  varStatus="idx">
											<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 or (view.deviceGb eq frontConstants.DEVICE_GB_10 and idx.index lt 5) }">
											<li class="swiper-slide">
												<div class="thumb-box">
													<c:set var="imgPt" value="${frame:optImagePath(catchList.imgPath1,frontConstants.IMG_OPT_QRY_460)}" />
													<c:if test="${fn:indexOf(catchList.imgPath1, 'cdn.ntruss.com') > -1 }" >
													<c:set var="imgPt" value="${catchList.imgPath1}" />
													</c:if>
													<c:choose>
														<c:when test="${!empty catchList.vdPath}">
															<a href="javascript:;" onClick="goToTagList('${idx.index}');" data-content="${catchList.mbrNo }" data-url= "/log/indexPetLogTagList" class="thumb-video" >
															<div class="vthumbs" video_id="${catchList.vdPath}" type="video_thumb" style="height:100%"></div>
															</a>
														</c:when>
														<c:otherwise>
															<a href="javascript:;" onClick="goToTagList('${idx.index}');" data-content="${catchList.mbrNo }" data-url= "/log/indexPetLogTagList" class="thumb-img" style="background-image:url(<c:out value='${imgPt }' />)"></a>
														</c:otherwise>
													</c:choose>												
													<div class="thumb-info">
														<c:set var="prImgPt" value="${frame:optImagePath(catchList.prflImg,frontConstants.IMG_OPT_QRY_60)}" />
														<c:if test="${fn:indexOf(catchList.prflImg, 'cdn.ntruss.com') > -1 }" >
														<c:set var="prImgPt" value="${catchList.prflImg}" />
														</c:if>
														<a href="javascript:;" onClick="goToProfile(<c:out value="${catchList.mbrNo }" />,'<c:out value="${catchList.petLogUrl }" />')" data-content="${catchList.mbrNo }" data-url= "" class="round-img-pf" style="background-image:url(<c:out value='${prImgPt }' />),url('../../_images/common/icon-img-profile-default-s@2x.jpg');"></a>
														<div class="info">
															<%-- <div class="tlt"><c:out value="${catchList.loginId }" /></div> --%>
															<div class="tlt"><c:out value="${catchList.nickNm }" /></div>
														</div>
													</div>
												</div>
											</li>
											</c:if>
										</c:forEach>
									</ul>
									<div class="swiper-pagination"></div>
								</div>
							</div>
							<!-- //Swiper -->
						</section>
					</c:if>
					<%-- <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 or view.envmtGbCd eq 'local' or view.envmtGbCd eq 'dev'}"> --%>
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}"> 
					<section class="add-movie">
						<c:if test="${catchShowYn eq 'Y'}">
							<p>
								<!-- 마이펫의 훈련 영상을 등록하고<br>
								다른 반려인들과 이야기 나눠보세요. -->
								마이펫의 훈련영상을 등록하고<br>다른 친구들과 이야기 나눠보세요							
							</p>
						</c:if>
						<div class="btn-area">
							<button type="button" onClick="regPetLog();" data-content="" data-url= "/log/indexPetLogInsertView"><spring:message code='front.web.view.new.menu.log'/> 영상 등록</button> <!-- APET-1250 210728 kjh02  -->
						</div>
					</section>
					</c:if>

					<!-- 다음 교육 이어하기 -->
					<section class="continue">
						<div class="title-area">
							<h3>다음 교육 시작하기</h3>
						</div>
						<div class="swiper-div newDn">
							<div class="swiper-container edu-list">
								<ul class="swiper-wrapper" id = "nextEdu">									
								</ul>
								<div class="swiper-pagination"></div>
							</div>
						</div>
						<!-- //Swiper -->
					</section>
					
				</div>

                    
				</div>
            </div>
        </main>
        
        <%--pc에서 상담톡 안보이도록 처리-2021.04.30
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="" />
	        </jsp:include>
        </c:if>
        --%>
        
         <script>
        
         
         <c:choose>
     		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	     		// Swiper catch
				var swiperPopul = new Swiper('.catch .swiper-container', {
	                slidesPerView: 'auto',
	                spaceBetween: 16,
	            });
     		</c:when>
			<c:otherwise>
			function setSwiper(){				
				// Swiper catch
				var swiper1 = new Swiper('.catch .swiper-container', {
	                slidesPerView: 'auto',
	                spaceBetween: 16,
	            });
	
				// Swiper continue
				var swiper2 = new Swiper('.continue .swiper-container', {
	                slidesPerView: 'auto',
	             // spaceBetween: 16,  // 2021.04.06 : spaceBetween 제거
	            });
			}
				
			</c:otherwise>
		</c:choose>
			
        </script>
	</tiles:putAttribute>
	
	<%-- 
	Tiles popup put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="popup">
		<!-- popup 내용 부분입니다. -->
	</tiles:putAttribute>
</tiles:insertDefinition>