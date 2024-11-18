<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<jsp:include page="/WEB-INF/tiles/include/js/common_mo.jsp"/> <!-- MO scalable 스크립트 적용 -->
<script type="text/javascript">
	let dataMoreGb = false;
	let replyVdId = "";
	let replyAplySeq = 0;
	let sessionPrflImg = "";
	let pageMov = false;
	let resetPrflImg = true;
	let gb = "";
	let selectTagGb = false;
	let abortController;
	let firstChar;
	let whileFetching = false;
	let resJsonArr = new Array();
	
	// 댓글 리스트 조회
	function selectTvDetailReplyList(clear, vdId) {
		// 자동재생으로 페이지 이동 시
		if (replyVdId != vdId) {
			pageMov = true;
			
			fncReplyRptpPopClose("Y");
			
			$(".tv.detail .petTvReplyConfirm .btnCancel").trigger("click");
			if ($("#petTvReplyModifyAlert").css("display") == "block") {
				fncReplyModifyReset();
			}
			
			fncTagMentionAreaHide();
		}
		
		// 영상 ID 변경
		replyVdId = vdId;
		
		// 영상 상세 정보
		$("#indexTvDetailForm #vdId").val(replyVdId);
		$("#indexTvDetailForm #mbrNo").val("${session.mbrNo}");
		
		if (clear == 'N') {
	    	let page = $("#page").val()*1 + 1;
	    	$("#page").val(page);
		} else {
			$("#page").val(1);
			dataMoreGb = false;
		}
    	
    	let data = {
			vdId : replyVdId
    		, page : $("#page").val()
    	}
    	$.ajax({
			url : "<spring:url value='/tv/reply/selectTvDetailReplyList' />"
			, type : "POST"
			, dataType : "json"
			, data : data
			, success : function(data) {
				fncReplyLoad(data, clear);
			}, error : function(request, status, error) {
				ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
			}
		});
	}
	
	// 댓글 목록 호출
	function fncReplyLoad(data, clear) {
		// 댓글 입력 영역 프로필 이미지 수정
		if (resetPrflImg) {
			if ("${session.mbrNo }" != "${frontConstants.NO_MEMBER_NO }") {
				if (data.mbvo.prflImg == null || data.mbvo.prflImg == "") {
					sessionPrflImg = "";
					$("#aplyContsSpan").css("background-image", "");
				} else {
					sessionPrflImg = '${frame:optImagePath("'+ data.mbvo.prflImg +'", frontConstants.IMG_OPT_QRY_490)}';
					$("#aplyContsSpan").css("background-image", "url("+sessionPrflImg+")");
				}
			} else {
				sessionPrflImg = "";
				$("#aplyContsSpan").css("background-image", "");
			}
		}
		resetPrflImg = true;
		
		let so = data.so;
		let paging = data.paging;
		let rplCnt = paging.totalRecord;
		$("#replyTotCnt").html("댓글 " + rplCnt + "개");
		$("#video_reply").html(rplCnt);
		fncReplyList(data, clear);
		
		if (data.paging.totalRecord > data.paging.rows) {
			dataMoreGb = true;
		}
		
		if(paging.page >= paging.totalRecord/paging.rows){
			dataMoreGb = false;
		}
		
		$("#page").val(data.page);
		
		$("a, button, textarea, input").attr("tabindex", "-1");
	}
	
	// 댓글 리스트 생성
	function fncReplyList(data, clear) {
		let replyList = data.replyList;
		let html = '';
		let tvDetailRplList = [];
		let dateStr = "";
		let aplyStr = "";
		let dateStrRpl = "";
		
		if (replyList.length == 0) {
			html += '<li class="nodata"><p class="txt">첫 번째 댓글을 작성해 보세요.</p></li>';
			$("#replyTotCnt").html("댓글 0개");
			$("#video_reply").html(fnComma(replyList.length));
		} else {
			for(let i=0; i<replyList.length; i++) {
				dateStr = elapsedTime(replyList[i].sysRegDtm);
				
				aplyStr = $("#decodeStr").html(replyList[i].aply).text();
				aplyStr = aplyStr.replace(/#[^#\s\<\>\@\&\\']+|@[^@\s]+/gim, function (tag){
					//return (tag.indexOf('#') == 0) ? '<a href="javascript:fncGetPetTvReplyTagNo(\'' + tag.replace('#','') + '\');" style="color:#669aff;">' + tag + '</a>' : '<span style="font-weight:bold;">' + tag + '</span>';
					/*
					 * 어바웃펫회원은 탈퇴한 회원이다-[댓글 멘션 회원정보] 테이블 생성전에는 탈퇴한 회원 또는 존재하지 않는 닉네임을 멘션했을시 탈퇴회원으로 보고 '어바웃펫 회원'으로 표시함.
					 * 멘션의 닉네임이 실재로 존재하는 회원은 볼드처리
					 */
					if(tag.indexOf("@") !== -1){
						if(tag.indexOf("@어바웃펫회원") !== -1){
							return "@어바웃펫 회원";
						}else{
							var tempTag = tag.split("|");
							if(tempTag.length > 1){
								return '<span style="font-weight:bold;">' + tempTag[0] + '</span>';
							}else{
								return tempTag[0];
							}
						}
					}else{
						return '<span style="font-weight:bold;">' + tag + '</span>';
					}
				});
				
				html += '<li id="aply-' + replyList[i].aplySeq + '">';
				html += 	'<div class="pic">';
				html += 		'<img src="' + '${frame:optImagePath("'+ replyList[i].prflImg +'", frontConstants.IMG_OPT_QRY_490)}' + '" onerror="this.src=\'../../_images/common/img-default-profile@2x.png\'" />';
				html += 	'</div>';
				html += 	'<div class="con">';
				html += 		'<div class="tit">' + replyList[i].nickNm + '</div>'; 
				html += 		'<div class="txt">' + aplyStr + '</div>';
				html += 		'<div id="modifyReplyData' + replyList[i].aplySeq + '" style="display:none;">' + replyList[i].aply.replace(/[\|]/gm, "") + '</div>';
				html += 		'<div class="date">' + dateStr + '</div><div class="date" name="modifyDate" style="display:none;">수정 중···</div>';
				html +=		'</div>';
				html += 	'<div class="menu dopMenuIcon" onClick="ui.popSel.open(this)">';
				html += 		'<div class="popSelect">';
				html += 			'<input type="text" class="popSelInput"/>';
				html += 			'<div class="popSelInnerWrap">';
				html +=					'<ul>';
				
				if (replyList[i].mbrNo == "${session.mbrNo}") {
					html += 				'<li><a class="bt" style="color: #000000;" href="javascript:fncUpdateReply(' + replyList[i].aplySeq + ');" data-url="/tv/reply/saveTvDetailReply" data-content=""><b class="t">수정</b></a></li>';
					html += 				'<li><a class="bt" style="color: #000000;" href="javascript:fncRemoveReply(' + replyList[i].aplySeq + ');" data-url="/tv/reply/deleteTvDetailReply" data-content=""><b class="t">삭제</b></a></li>';
				} else if (replyList[i].mbrNo != "${session.mbrNo}") {
					html += 				'<li><a class="bt" style="color: #000000;" href="javascript:fncReplyRptpPopOpen(' + replyList[i].aplySeq + ');" data-url="" data-content=""><b class="t">신고</b></a></li>';
				}
				
				html += 				'</ul>';
				html +=				'</div>';
				html +=			'</div>';
				html +=		'</div>';
				html +=	'</li>';
				
				tvDetailRplList = replyList[i].tvDetailRplList;
				if (tvDetailRplList.length != 0) {
					dateStrRpl = elapsedTime(tvDetailRplList[0].rplRegDtm);
					html += '<li class="depth2">';
					html += 	'<div class="pic">';
					html +=			'<img src="../../_images/tv/admin_prfl_img.png" onerror="this.src=\'../../_images/common/icon-img-profile-default-b@2x.png\'" />';
					html +=		'</div>';
					html += 	'<div class="con">';
					html += 		'<div class="tit">운영자</div>';
					html += 		'<div class="txt">' + tvDetailRplList[0].rpl + '</div>';
					html += 		'<div class="date">' + dateStrRpl + '</div>';
					html +=		'</div>';
					html +=	'</li>';
				}
			}
		}
		
		if (clear == "Y") {
			$("#replyListArea").empty();
		}
		
		$("#replyListArea").append(html);
		
		pageMov = false;
	}
	
	// 댓글 태그 클릭 시 태그 번호 조회
	/*function fncGetPetTvReplyTagNo(tagNm) {
		$.ajax({
			url : "/tv/reply/getPetTvReplyTagNo",
			data : {
				tagNm : tagNm
			},
			success : function(data) {
				location.href="/tv/collectTags?tagNo="+data.tagNo;
				//storageHist.goBack("/tv/collectTags?tagNo="+data.tagNo);
			}
		});
	}*/
	
	// 댓글 멘션 클릭 이벤트
	/* function fncReplyMentionClick(nickNm) {
		$.ajax({
			url : "/common/getMentionInfo",
			data : {
				nickNm : nickNm
			},
			success : function(data) {
				let msg = "";
				if (data.info == null) {
					msg = "존재하지 않는 회원입니다.";
					fncPetTvReplyToastAlert(msg);
				} else {
					if (data.info.mbrStatCd == "${frontConstants.MBR_STAT_50}") {
						msg = "탈퇴한 회원입니다.";
						fncPetTvReplyToastAlert(msg);
					} else if (data.info.petLogUrl == null || data.info.petLogUrl == "") {
						msg = "반려동물을 등록하지 않은 회원입니다.";
						fncPetTvReplyToastAlert(msg);
					} else if (data.info.petLogUrl != null && data.info.petLogUrl != "") {
						location.href = "/log/indexMyPetLog/" + data.info.petLogUrl + "?mbrNo=" + data.info.mbrNo;
					}
				}
			}
		});
	} */
	
	// 토스트 알림
	function fncPetTvReplyToastAlert(msg) {
		ui.toast(msg, {
			bot:74
			, sec:2000
		});
	}
	
	// 영상 상세 댓글 등록/수정
	function fncSaveReply() {
		if (pageMov) {
			return;
		}
		
		let sendData = $("#indexTvDetailForm").serializeJson();
		let aplySaveContent = $("#aplyContent").val();
		let tagNmArr = [];
		let nickNmArr = [];
		
		aplySaveContent.replace(/#[^#\s\<\>\@\&\\']+|@[^@\s]+/gim, function (tag){
			if (tag.indexOf('#') == 0) {
				tagNmArr.push(tag.replace('#', ''));
			}
			if (tag.indexOf('@') == 0) {
				nickNmArr.push(tag.replace('@', ''));
			}
		});
		
		if (!aplySaveContent) {
			ui.alert('댓글을 입력해 주세요');
			return;
		}
		
		$.extend(sendData, {
			aply : aplySaveContent
			, nickNm : $("#decodeNickNm").val()
			, tagNmArr : tagNmArr
			, nickNmArr : nickNmArr
			, landingUrl : "${view.stDomain}" + "${requestScope['javax.servlet.forward.request_uri']}" + "?vdId=" + replyVdId + "&sortCd="+ sortCd +"&listGb="+ listGb
		});
		
		$.ajaxSettings.traditional = true;
		$.ajax({
			url : "<spring:url value='/tv/reply/saveTvDetailReply' />"
			, type : "POST"
			, dataType : "json"
			, data : sendData
			, success : function(result) {
				if (result.replyGb == "U") {
					// 댓글 수정
					ui.toast('댓글이 수정되었어요', {
						bot:74
						, sec:2000
					});
					// 수정된 댓글
					let updateReply = result.po.aply;
					// 댓글 수정 (새로고침 X)
					$("#aply-" + sendData.aplySeq)[0].scrollIntoView({behavior:'smooth', block:'center'});
					$("#aply-" + sendData.aplySeq).find("#modifyReplyData" + sendData.aplySeq).html(updateReply.replace(/[\|]/gm, ""));
					
					updateReply = updateReply.replace(/#[^#\s\<\>\@\&\\']+|@[^@\s]+/gim, function (tag){
						//return (tag.indexOf('#')== 0) ? '<a href="javascript:fncGetPetTvReplyTagNo(\'' + tag.replace('#','') + '\');" style="color:#669aff;">' + tag + '</a>' : '<span style="font-weight:bold;">' + tag + '</span>';
						/*
						 * 어바웃펫회원은 탈퇴한 회원이다-[댓글 멘션 회원정보] 테이블 생성전에는 탈퇴한 회원 또는 존재하지 않는 닉네임을 멘션했을시 탈퇴회원으로 보고 '어바웃펫 회원'으로 표시함.
						 * 멘션의 닉네임이 실재로 존재하는 회원은 볼드처리
						 */
						if(tag.indexOf("@") !== -1){
							if(tag.indexOf("@어바웃펫회원") !== -1){
								return "@어바웃펫 회원";
							}else{
								var tempTag = tag.split("|");
								if(tempTag.length > 1){
									return '<span style="font-weight:bold;">' + tempTag[0] + '</span>';
								}else{
									return tempTag[0];
								}
							}
						}else{
							return '<span style="font-weight:bold;">' + tag + '</span>';
						}
					});
					
					$("#aply-" + sendData.aplySeq).find(".txt").html(updateReply);
					$("#aply-" + sendData.aplySeq).find(".date").show();
					$("#aply-" + sendData.aplySeq).find("div[name=modifyDate]").hide();
					fncReplyModifyReset();
					
					userActionLog(sendData.vdId, "etc"); //클릭 이벤트-댓글수정(기타 모든 클릭)
				} else if (result.replyGb == "I") {
					// 댓글 등록
					ui.toast('댓글이 등록되었어요', {
						bot:74
						, sec:2000
					});
					$("#mobileAppScrollArea").scrollTop(0);
					$("#aplyContent").val("");
					$("#aplyContent").blur();
					fncBtnDispGb("N");
					// 댓글 영역 새로고침
					dataMoreGb = false;
					resetPrflImg = false;
					selectTvDetailReplyList('Y', replyVdId);
					
					// 댓글 영역으로 스크롤 이동
					$("#aplyContent")[0].scrollIntoView({block:'center'});
					
					userActionLog(sendData.vdId, "reply"); //클릭 이벤트-댓글입력
				}
				
				fncTagMentionAreaHide();
			}, error : function(request, status, error) {
				ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
			}
		});
	}
	
	// 댓글 수정 후/댓글 수정 중 자동재생으로 페이지 이동 시
	function fncReplyModifyReset() {
		$("#petTvReplyModifyAlert").hide();
		$("#aplyContent").val("");
		$("#aplyContent").blur();
		fncBtnDispGb("N");
		$("#indexTvDetailForm #aplySeq").val("");
		replyAplySeq = 0;
	}
	
	// 영상 상세 댓글 수정 textarea 댓글내용 update
	function fncUpdateReply(aplySeq) {
		// 이전 수정 댓글 - 수정 중 해제
		if (replyAplySeq != 0) {
			fncUpdateDivHide();
		}
		
		// 수정 중인 댓글 번호
		$("#indexTvDetailForm #aplySeq").val(aplySeq);
		replyAplySeq = aplySeq;
		
		// 현재 수정 중인 댓글 - 수정 중 노출
		$("#petTvReplyModifyAlert").show();
		$("#aply-" + aplySeq).find(".date").hide();
		$("#aply-" + aplySeq).find("div[name=modifyDate]").show();
		
		let updateReplyContent = $("#aply-" + aplySeq).find("#modifyReplyData" + aplySeq).text();
		updateReplyContent = updateReplyContent.replace(/@어바웃펫회원\s*/gm, "");
		
		$("#aplyContent").val(updateReplyContent);
		fncBtnDispGb("Y");
		$("#aplyContent").blur();
		$("#aplyContent").focus();
		$("#aplyContent")[0].scrollIntoView({block:'center'});
		
		fncTagMentionAreaHide();
	}
	
	function fncUpdateDivHide() {
		$("#aply-" + replyAplySeq).find(".date").show();
		$("#aply-" + replyAplySeq).find("div[name=modifyDate]").hide();
	}
	
	// 영상 상세 댓글 삭제
	function fncRemoveReply(aplySeq) {
		ui.confirm('댓글을 삭제할까요?',{
		    ycb:function(){ // 확인 버튼 클릭
		    	if (pageMov) {
					return;
				}
		    	let sendData = $("#indexTvDetailForm").serializeJson();
				sendData.aplySeq = aplySeq;
				
				if (replyAplySeq != 0) {
					fncUpdateDivHide();
					$("#aplyContent").val("");
					fncBtnDispGb("N");
					$("#petTvReplyModifyAlert").hide();
					$("#indexTvDetailForm #aplySeq").val("");
				}
				
				$.ajax({
					url : "<spring:url value='/tv/reply/deleteTvDetailReply' />"
					, type : "POST"
					, dataType : "json"
					, data : sendData
					, success : function(result) {
						resetPrflImg = false;
						ui.toast('댓글이 삭제되었어요', {
							bot:74
							, sec:2000
						});
						$("#mobileAppScrollArea").scrollTop(0);
						// 댓글 영역 새로고침
						selectTvDetailReplyList('Y', replyVdId);
						
						// 댓글 영역으로 스크롤 이동
						$("#aplyContent")[0].scrollIntoView({block:'center'});
						
						userActionLog(sendData.vdId, "etc"); //클릭 이벤트-댓글삭제(기타 모든 클릭)
					}, error : function(request, status, error) {
						ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
					}
				});
		    },
		    ncb:function(){ // 취소 버튼 클릭
		    	
		    },
		    ybt:'예',
		    nbt:'아니오',
		    cls:'petTvReplyConfirm'
		});
	}
	
	// 영상 상세 댓글 신고 팝업 열기
	function fncReplyRptpPopOpen(aplySeq) {
		if ("${session.mbrNo }" == "${frontConstants.NO_MEMBER_NO }") {
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
			    ycb:function(){ // 확인 버튼 클릭
			        // 로그인 페이지로 이동 (로그인 후 returnUrl로 이동);
					//location.href = "/indexLogin?returnUrl=${requestScope['javax.servlet.forward.request_uri']}" + "?vdId=" + replyVdId + "&sortCd="+ sortCd +"&listGb="+ listGb;
					
					var url = "${requestScope['javax.servlet.forward.request_uri']}" + encodeURIComponent("?vdId=" + replyVdId + "&sortCd=" + sortCd + "&listGb=" + listGb);
			    	if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
			    		fncAppCloseMoveLogin(url);
			    	}else{
			    		location.href = "/indexLogin?returnUrl="+url;
			    		//storageHist.goBack("/indexLogin?returnUrl="+url);
			    	}
			    },
			    ncb:function(){ // 취소 버튼 클릭
			    	
			    },
			    ybt:'로그인',
			    nbt:'취소',
			    cls:'petTvReplyConfirm'
			});
		} else {
			$.ajax({
				url : "<spring:url value='/tv/reply/tvDetailReplyRptpDupChk' />"
				, type : "POST"
				, dataType : "json"
				, data : {
					aplySeq : aplySeq
					, vdId : replyVdId
					, mbrNo : "${session.mbrNo}"
				}
				, success : function(result) {
					if (result.dupChkCnt > 0) {
						ui.toast('이미 신고한 댓글이에요', {
							bot:74
							, sec:2000
						});
					} else {
						$("#tvDetailReplyRptpForm").trigger("reset");
						$("#tvDetailReplyRptpForm .tit, #tvDetailReplyRptpForm .txt").css("color", "#000000;");
						$("#petTvReplyRptpBtn").addClass("disabled");
						$("#indexTvDetailForm #aplySeq").val(aplySeq);
						ui.popLayer.open("popReportPetTvReply");
						$("#popReportPetTvReply .pct.h_auto_p").scrollTop(0);
						
						if (!isUserPauseClick) {
							SGRPLAYER.pause(); // 신고 팝업 열리면 영상 재생 멈춤
						}
					}
				}, error : function(request, status, error) {
					ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
				}
			});
		}
	}
	
	// 영상 상세 댓글 신고 팝업 닫기
	function fncReplyRptpPopClose(gbData) {
		ui.popLayer.close("popReportPetTvReply");
		$("#indexTvDetailForm #aplySeq").val("");
		
		if (gbData != "Y") {
			if (!isUserPauseClick) {
				SGRPLAYER.play(); // 신고 팝업 닫히면 영상 다시 재생
			}
		}
	}
	
	// 영상 상세 댓글 신고
	function fncTvDetailReplyRptp() {
		if (pageMov) {
			return;
		}
		
		let sendData = $("#indexTvDetailForm").serializeJson();
		$.extend(sendData, {
			rptpRsnCd : $("#popReportPetTvReply input[name=rptpRsnCd]:checked").val()
			, rptpContent : $("#popReportPetTvReply #rptpContent").val()
		});
		
		if (!sendData.rptpRsnCd) {
			ui.toast('신고 사유를 선택해 주세요');
			return;
		}
		
		$.ajax({
			url : "<spring:url value='/tv/reply/insertTvDetailReplyRptp' />"
			, type : "POST"
			, dataType : "json"
			, data : sendData
			, success : function(result) {
				fncReplyRptpPopClose();
				ui.toast('신고가 완료되었어요', {
					bot:74
					, sec:2000
				});
				
				if (result.rptpCnt == 5) {
					// 새로고침 X
					$("#aply-" + sendData.aplySeq).remove();
				}
				
				if (!isUserPauseClick) {
					SGRPLAYER.play(); // 신고 팝업 닫히면 영상 다시 재생
				}
			}, error : function(request, status, error) {
				ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
			}
		});
	}
	
	// 영상 상세 댓글 등록 로그인 체크
	function fncReplyRegLoginChk(regYn) {
		if ("${session.mbrNo }" == "${frontConstants.NO_MEMBER_NO }") {
			$("#aplyContent").blur();
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
			    ycb:function(){ // 확인 버튼 클릭
			        // 로그인 페이지로 이동 (로그인 후 returnUrl로 이동);
					//location.href = "/indexLogin?returnUrl=${requestScope['javax.servlet.forward.request_uri']}" + "?vdId=" + replyVdId + "&sortCd="+ sortCd +"&listGb="+ listGb;
					
			    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + encodeURIComponent("?vdId=" + replyVdId + "&sortCd=" + sortCd + "&listGb=" + listGb);
			    	if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
			    		fncAppCloseMoveLogin(url);
			    	}else{
			    		location.href = "/indexLogin?returnUrl="+url;
			    		//storageHist.goBack("/indexLogin?returnUrl="+url);
			    	}
			    },
			    ncb:function(){ // 취소 버튼 클릭
			    	
			    },
			    ybt:'로그인',
			    nbt:'취소',
			    cls:'petTvReplyConfirm'
			});
		} else {
			if (regYn == "Y") {
				fncSaveReply();
			}
		}
	}
	
	// 댓글 수정 중 alert 닫기 버튼 클릭 시
	function fncCloseModifyAlert() {
		ui.confirm('댓글 수정을 취소할까요?',{
		    ycb:function(){ // '네' 버튼 클릭
		    	$("#petTvReplyModifyAlert").hide();
				fncUpdateDivHide();
				$("#aplyContent").val("");
				fncBtnDispGb("N");
				$("#indexTvDetailForm #aplySeq").val("");
				replyAplySeq = 0;
				$("#aplyContent").blur();
				
				fncTagMentionAreaHide();
		    },
		    ncb:function(){ // '아니오' 버튼 클릭
		    	$("#aplyContent").focus();
		    },
		    ybt:'예',
		    nbt:'아니오',
		    cls:'petTvReplyConfirm'
		});
	}
	
	// 버튼 show/hide function
	function fncBtnDispGb(dispGb) {
		if (dispGb == "Y") {
			//$("#aplyContentRegBtn").show();
			$("#aplyContentRegBtn").siblings("button.del").css('visibility','hidden');
		} else {
			//$("#aplyContentRegBtn").hide();
			$("#aplyContentRegBtn").siblings("button.del").hide();
		}
	}
	
	// MO WEB/APP 댓글 레이어 닫기
	function fncReplyLayerPopClose(closeThis) {
		// MO WEB/APP 댓글 수정중에 댓글 레이어 닫을 때 댓글 수정 초기화
		if ($("#petTvReplyModifyAlert").css("display") == "block") {
			fncReplyModifyReset();
			fncTagMentionAreaHide();
		}
		
		ui.commentBox.close(closeThis);
		ui.lock.using(false); //댓글 레이어 close 시 body 스크롤 unlock
		ui.dim.close();
	}
	
	// 태그,멘션 검색 후 li 태그 클릭 시 이벤트
	function selectTag(index){
		let element = document.getElementById('aplyContent');
		let strOriginal = element.value; // textarea에 입력한 값
		let iStartPos = element.selectionStart; // 현재커서의 위치
		let iEndPos = element.selectionEnd;
		$("#aplyContent").blur();
		$("#aplyContent").focus();
		
		var searchStr = strOriginal.substring(0,iStartPos);
		var selTagChar =0;
		var b4firstCharStr='';
		for(var i =0; i<searchStr.length; i++){
			if(searchStr[i] == firstChar){
				selTagChar = i;
			}
		}
		
		if(selTagChar > 0){
			b4firstCharStr = strOriginal.substring(0, selTagChar);
		}
		
		var fromFirstChar =  strOriginal.substring(selTagChar, strOriginal.length);
		var selTagFind = new RegExp(/^[@#][^\s@#]*/, 'g');
		var selTagReplLength = fromFirstChar.match(selTagFind)[0].length;
		var selTagRepl = $("#decodeSelTag").html(resJsonArr[index].firstChar + resJsonArr[index].selTag).text();
		var afterSelTagStr = fromFirstChar.substring(selTagReplLength, fromFirstChar.length);
		var space = afterSelTagStr.substring(0, 1) == ' ' ? '' : ' ';
		
		/*console.log("strOriginal === "+strOriginal);
		console.log("iStartPos === "+iStartPos);
		console.log("iEndPos === "+iEndPos);
		console.log("searchStr === "+searchStr);
		console.log("selTagChar === "+selTagChar);
		console.log("b4firstCharStr === "+b4firstCharStr);
		console.log("fromFirstChar === "+fromFirstChar);
		console.log("selTagReplLength === "+selTagReplLength);
		console.log("selTagRepl === "+selTagRepl);
		console.log("afterSelTagStr ==="+afterSelTagStr);
		console.log("space==="+space+"===");*/
		
		element.value = b4firstCharStr + selTagRepl + space + afterSelTagStr;
		
		fncTagMentionAreaHide();
	}
	
	function autoCompleteSuccess(resBody , separator){
		resJsonArr = [];
		whileFetching = false;
		$("#tagListArea").empty();
		$("#mentionListArea").empty();
		if(resBody.STATUS.CODE == "200"){
			let html = '';
			
			if( resBody.DATA.ITEMS.length > 0) {
				let item = resBody.DATA.ITEMS;
				for(var i=0;i<resBody.DATA.ITEMS.length;i++){
					//',",`와 같은 특수문자가 닉네임에 포함 될 시 스크립트 깨지는 현상때문에 json형태로 수정 
					var resJson = new Object;
					resJson.selTag = item[i].KEYWORD;
					resJson.firstChar = firstChar;
					resJsonArr.push(resJson);
					if(separator == "mention"){
						let pic = '${frame:optImagePath("'+ item[i].PRFL_IMG +'", frontConstants.IMG_OPT_QRY_786)}';
						if (!item[i].PRFL_IMG) {
							pic = '../../_images/common/icon-img-profile-default-m@2x.png';
						}
						html += '<li style="cursor:pointer;" onclick="selectTag('+i+');"><a style="color:#333333;font-weight:400;"><span class="pic"><img src="'+ pic + '"></span>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span style="color:#669aff;">').replace(/\¶HE¶/gi, '</span>') + '</a></li>';
						
						$("#mentionListArea").html(html);
						$("#petTvReplyMentionArea").css("display", "block");
					}else{
						html += '<li style="cursor:pointer;" onclick="javascript:selectTag('+i+');"><a href="javascript:void(0);" style="color:#333333;">#' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span class ="txt" style="color:#669aff;">').replace(/\¶HE¶/gi, '</span>') + '</a></li>';
						
						$("#tagListArea").html(html);
						$("#petTvReplyTagArea").css("display", "block");
					}
				}
			}
		}
	}
	
	//멘션 또는 테그 검색 영역 숨기기
	function fncTagMentionAreaHide(){
		/*if ($("#petTvReplyTagArea").css("display") == "block") {
			$("#petTvReplyTagArea").hide();
			$("#tagListArea").html("");
		}

		if ($("#petTvReplyMentionArea").css("display") == "block") {
			$("#petTvReplyMentionArea").hide();
			$("#mentionListArea").html("");
		}*/

		$("#petTvReplyTagArea").css("display", "none");
		$("#tagListArea").html("");
		$("#petTvReplyMentionArea").css("display", "none");
		$("#mentionListArea").html("");
	}
	
	$(document).ready(function(){
		if ("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true") {
			$(window).scroll(function(){
				let scrollT = $(this).scrollTop(); //스크롤바의 상단위치
				let scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
				let contentH = $(document).height(); //문서 전체 내용을 갖는 div의 높이
				
		        if(Math.ceil(scrollT + scrollH) >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
		        	if (dataMoreGb) {
		        		dataMoreGb = false;
		        		selectTvDetailReplyList('N', replyVdId);
		        	}
	        	}
		    });
		} else {
			$("#mobileAppScrollArea").scroll(function(){
				let scrollT = $(this).scrollTop(); //스크롤바의 상단위치
				let scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
				let contentH = $(this).prop('scrollHeight'); //문서 전체 내용을 갖는 div의 높이
				
		        if(Math.ceil(scrollT + scrollH) >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
		        	if (dataMoreGb) {
		        		dataMoreGb = false;
		        		selectTvDetailReplyList('N', replyVdId);
		        	}
	        	}
		    });
		}
		
		$(document).on("input", "#aplyContent", function(){
			let textLength = $(this)[0].textLength;
			if (textLength == 0) {
				fncBtnDispGb("N");
			} else {
				fncBtnDispGb("Y");
			}
		});
		
		$(document).on("click", "#replyTextarea .del", function(){
			$("#aplyContentRegBtn").hide();
			$("#aplyContent").focus();
			fncTagMentionAreaHide();
			gb = '';
		});
		
		$(document).on("change", "input[name=rptpRsnCd]", function() {
			if ($("input[name=rptpRsnCd]:checked").val() != undefined) {
				$("#petTvReplyRptpBtn").removeClass("disabled");
			} else {
				$("#petTvReplyRptpBtn").addClass("disabled");
			}
		});
		
		/*$(document).on("blur", "textarea[name=aplyContent]", function(){
 			$("#petTvReplyTagArea").hide();
 			$("#petTvReplyMentionArea").hide();
 			$("#tagListArea").html("");
 			$("#mentionListArea").html("");
 			if (selectTagGb) {
 				$("#aplyContent").focus();
 				selectTagGb = false;
 			}
 		});*/
		
		// 댓글 입력 시 해시태그, 멘션 스크립트
		$(document).on("input keyup click", "textarea[name=aplyContent]", function(e) {
			var formData = new FormData();
			let element = document.getElementById('aplyContent');
			let strOriginal = element.value;
			strOriginal = strOriginal.substring(0, element.selectionStart);
			let inTag = strOriginal.indexOf('#');
			let inMention = strOriginal.indexOf('@');
			
			if(inTag > -1){
				$("#petTvReplyTagArea").css("display", "block"); 
			}else{
				$("#petTvReplyTagArea").css("display", "none");
			}
			
			if(inMention > -1){
				$("#petTvReplyMentionArea").css("display", "block");
			}else{
				$("#petTvReplyMentionArea").css("display", "none");
			}
			
			let index = strOriginal.lastIndexOf('\#');
			if (index < strOriginal.lastIndexOf('\@') && element.selectionStart > strOriginal.lastIndexOf('\@')) {
				index = strOriginal.lastIndexOf('\@');
			}
			
			let txt = strOriginal.substring(index, element.selectionStart);
			txt = txt.substring(0, 1);
			
			gb = txt;
			// hashtag
			if (gb.indexOf('\#') > -1) {
				$("#petTvReplyMentionArea").hide();
				firstChar = "\#";
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length){
							return false;
						}
						
						return this.indexOf(str) == 0;
					}

					strFront = strOriginal.substring(0,iStartPos);
					
					var hashTagChar =0;
					for(var i =0; i<strFront.length; i++){
						if(strFront[i] == firstChar){
							//#은 추천리스트에 노출되지 않게 하기 위해
							hashTagChar = i+1;
						}
					}
					
					var fromHashTag = strOriginal.substring(hashTagChar, strOriginal.length);
					var hashTagFind = new RegExp(/[^#\s\<\>\@\&\\']*/, 'g');
					var hashTagReplLength = fromHashTag.match(hashTagFind)[0].length;
					var searchTagTxt =  strOriginal.substring(hashTagChar, hashTagChar+hashTagReplLength);
					
					//태그가 끝나는 지점에서 공백이나 개행문자가 있을 시 추천리스트 노출하지 않음.
					if(strFront.lastIndexOf('#') < strFront.lastIndexOf(' ') || strFront.lastIndexOf('#') < strFront.lastIndexOf('\n')){
						searchTagTxt = "";
					}
					
					if( searchTagTxt != ''){
						//중복 호출시 기존 request 취소를 위해 fetch로 변경
						if(whileFetching){
							abortController.abort();
						}
						
						abortController = new AbortController;
						whileFetching = true;
						
						formData.append('searchText' , searchTagTxt);
						formData.append('label' , 'pet_log_autocomplete');
						formData.append('size' , 30);
						
			            fetch("/log/getAutocomplete" , {
			            	method : "POST"
			            	, body : formData
			            	, signal : abortController.signal
			            })
			            .then(res => res.json())
			            .then(res => {autoCompleteSuccess(JSON.parse(res) , "tag")})
			            .catch(err => console.log(err))			
					} else{ 
						 $("#tagListArea").html("");
					}
				} else {
					return;
				}
			}
			
			// mention
			if (gb.indexOf('\@') > -1) {
				$("#petTvReplyTagArea").hide();
				firstChar = "\@";
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length){
							return false;
						}
						
						return this.indexOf(str) == 0;
					}
					
					strFront = strOriginal.substring(0, iStartPos);
					
					var mentionChar =0;
					for(var i =0; i<strFront.length; i++){
						if(strFront[i] == firstChar){
							mentionChar = i+1;
						}
					}
					
					var fromMention =  strOriginal.substring(mentionChar, strOriginal.length);
					var mentionFind = new RegExp(/[^s\@]*/, 'g');
					var mentionReplLength = fromMention.match(mentionFind)[0].length;
					searchMentionTxt =  strOriginal.substring(mentionChar, mentionChar+mentionReplLength);
					
					//태그가 끝나는 지점에서 공백이나 개행문자가 있을 시 추천리스트 노출하지 않음.
					if(strFront.lastIndexOf('@') < strFront.lastIndexOf(' ') || strFront.lastIndexOf('@') < strFront.lastIndexOf('\n')){
						searchMentionTxt = "";
					}
					
					if( searchMentionTxt != '' && searchMentionTxt.substring(0, 1).search(/['><]/gi) == -1 ){
						//중복 호출시 기존 request 취소를 위해 fetch로 변경
						if(whileFetching) {
							abortController.abort();
						}
						
						abortController = new AbortController;
						whileFetching = true;
						
						formData.append('searchText' , searchMentionTxt);
						formData.append('label' , 'log_member_nick_name');
						formData.append('size' , 30);
			            fetch("/log/getAutocomplete" , {
			            	method : "POST"
			            	, body : formData
			            	, signal : abortController.signal
			            })
			            .then(res => res.json())
			            .then(res => autoCompleteSuccess(JSON.parse(res) , "mention"))
			            .catch(err => console.log(err))
					} else{
						$("#mentionListArea").html("");
					}
					// xhr 통신 추가 end
					//////////////////////////////////////////////////
				} else {
					return;
				}
			}
		});
		
		//댓글 레이어 .head 스크롤로 close 시 body 스크롤 unlock
		$(".commentBoxAp.tvcommentBox").bind("popCloseEvent",function(){
			ui.lock.using(false);
			ui.dim.close();
        });
		
		//댓글 300자 초과 입력 시 토스트 알림 노출
		$(document).on("input", "#aplyContent", function(){
			if ($(this).val().length > 300) {
				$(this).val($(this).val().substring(0,300));
				ui.toast('300자 까지 입력 가능합니다.', {
					bot:74
					, sec:2000
				});
			}
		});
		
		//댓글 신고 사유 200자 초과 입력 시 토스트 알림 노출
		$(document).on("input", "#rptpContent", function(){
			if ($(this).val().length > 200) {
				$(this).val($(this).val().substring(0,200));
				ui.toast('200자 까지 입력 가능합니다.', {
					bot:74
					, sec:2000
				});
			}
		});
		
		//댓글 옵션 영역 외의 영역 클릭 시 댓글 옵션 영역 hide 처리
		$(document).on("click", ".tv.detail .commentBoxAp.tvcommentBox .menu.dopMenuIcon", function(e) {
			$(".tv.detail .commentBoxAp.tvcommentBox .head,body").one("click", function(e){
				if (!$(e.target).hasClass("popSelect") && !$(e.target).hasClass("dopMenuIcon")) {
					$(".tv.detail").find(".popSelInnerWrap").css({height:0});
				}
			});
		});
	});
</script>

<form name="indexTvDetailForm" id="indexTvDetailForm" method="post">
	<input type="hidden" name="mbrNo" id="mbrNo" value="${session.mbrNo }" />
	<input type="hidden" name="vdId" id="vdId" value="" />
	<input type="hidden" name="aplySeq" id="aplySeq" value="" />
</form>

<input type="hidden" id="page" name="page" value="${so.page }" />
<input type="hidden" id="decodeStr" value=""/>
<input type="hidden" id="decodeNickNm" value="${session.nickNm }"/>
<input type="hidden" id="decodeSelTag" value=""/>

<div class="commentBoxAp tvcommentBox type01">
	<div class="head">
		<div class="con">
			<div class="tit" id="replyTotCnt"></div>
			<a href="javascript:;" class="close" id="moReplyLayerCloseBtn" onClick="fncReplyLayerPopClose(this);"></a>
		</div>
	</div>
	<div class="con">
		<!-- 태그팝업 -->
		<div class="fixed_box" <%-- style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'top:-46px;' : ''} --%>">
			<div class="tagList" id="petTvReplyTagArea">
				<ul id="tagListArea"></ul>
			</div>
			<div class="userList" id="petTvReplyMentionArea">
				<ul id="mentionListArea"></ul>
			</div>
		    <div class="alert-commentBox" id="petTvReplyModifyAlert" style="display:none;">
		        <p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>
		        <button class="close" onclick="fncCloseModifyAlert();"></button>
		    </div>
		</div>
		<!-- //태그팝업 -->
		
		<!-- 댓글입력 -->
		<div class="input" id="replyTextarea">
			<span id="aplyContsSpan"></span>
			<textarea type="text" id="aplyContent" name="aplyContent" onfocus="fncReplyRegLoginChk();"
			placeholder="${session.mbrNo eq frontConstants.NO_MEMBER_NO ? '로그인 후 댓글을 입력해 주세요' : '댓글을 입력해 주세요' }"></textarea>
			<button id="aplyContentRegBtn" onClick="fncReplyRegLoginChk('Y');"  data-url="/tv/reply/saveTvDetailReply" data-content="">등록</button>
		</div>
		<!-- //댓글입력 -->
		
		<!-- 댓글리스트 -->
		<div class="box" id="mobileAppScrollArea" <%--style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'height: calc(100% - 78px); padding-top: 78px;' : ''}"--%>>
			<div class="commendListBox">
				<ul id="replyListArea"></ul>
			</div>
		</div>
		<!-- //댓글리스트 -->
	</div>
</div>