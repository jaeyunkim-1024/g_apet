<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<jsp:include page="/WEB-INF/tiles/include/js/gsr.jsp" />
		<jsp:include page="/WEB-INF/tiles/include/js/common_mo.jsp"/>
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
	
			var orgMemberTags = [];
			var memberTags = [];
			var isMobile = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
			var isNative = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}";
			var scrollTop = 0;
			var timer = null;
			var imageResult = null;
			var mobileWeb = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";

			//이미지 업로드
			var img = {
					upload : function(){
						if(isNative){
							img.mobile();
						}else if(mobileWeb){
							img.mweb();
						}else{
							img.web();
						}
					}
			
				,	mweb : function(){
						fileUpload.profileMwebimage(function(result){
							$("[name='prflImg']").val(result.filePath);
							$("[name='prflNm']").val("");
							$("#prflImg").attr("src","/common/imageView?filePath="+result.filePath);
						});
				}	
				,	web : function(){
						fileUpload.profileimage(function(result){
							$("[name='prflImg']").val(result.filePath);
							$("[name='prflNm']").val("");
							$("#prflImg").attr("src","/common/imageView?filePath="+result.filePath);
						});
				}
				,	mobile : function(){
						// 데이터 세팅
						toNativeData.func = "onOpenGallery";
						toNativeData.useCamera = "P";
						toNativeData.galleryType = "P";
						toNativeData.usePhotoEdit = "Y";
						toNativeData.editType = "S";
						let fileIds = new Array();
						if(imageResult != null) {
							fileIds[0] = imageResult.fileId;
							toNativeData.fileIds = fileIds;
						}
						toNativeData.maxCount = 1;
						toNativeData.callbackDelete = "img.deleteCallBack";
						toNativeData.callback = "img.mobileCalBack";
						toNativeData.title = "";
						toNative(toNativeData);
				}
				,	mobileCalBack : function(result){
						imageResult = JSON.parse(result);
						$("[name='prflImg']").val("fkljaslkfjasdlkrufjsalcfnsdlkfjds");
						$("#prflImg").attr("src", imageResult.imageToBase64);
						
				}
				,	deleteCallBack : function(){
						var originalSrc = $("#prflImg").attr("data-original");
						$("#prflImg").attr("src", originalSrc);
						$("[name='prflImg']").val($("[name='orgPrflImg']").val());
				}
			};
			
			function onFileUploadCallBack(result) {
				var data = JSON.parse(result);
				/*
				{"images":[{"fileSize":3792029,"fileName":"001.jpg","fileType":"image/jpeg","fileExe":"jpg","filePath":"/member/2/2Q==/c92a1528-b4f9-48dc-8bb7-885e97610678.jpg"}],"vidose":[]}
				 */
				var fileData = data.images[0];
				var prflImg = fileData.filePath;
				var fileExe = fileData.fileExe;

				var option ={
						url : "/mypage/info/onFileUploadCallBack"
					,	data : {prflImg : prflImg , fileExe : fileExe}
					,	done : function(result){
							var resultMsg = result;
							if(resultMsg != "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
								ui.toast(resultMsg);
							}
							var config ={
								url : "/mypage/info/indexManageDetail"
								,	targetUrl : "/mypage/info/updateMemberInfo"
								,	callback : function(){
										window.location.href = "/mypage/indexMyPage";
								}
							};
							fncTagInfoLogApi(config);
					}

				};
				ajax.call(option);
			}

			//휴대폰 번호 변경(점유 인증 or KCB )
			var mobileCert = {
				open : function(){
					$("#mobile-format-error").remove();
					var config = {
						txt : "본인인증 진행 후에<br> 휴대폰번호를 변경해주세요."
						,	ycb : function(){
							setOkCeretCallBack(function(data){
								if(data['RSLT_MSG'] == "본인인증 완료"){
									var options = {
										url :"/mypage/info/ci-check"
										,	data : {ciCtfVal : data['CI'] , mbrNm : data['RSLT_NAME'] }
										,	done : function(result){
											//기존에 인증한 값이 있는지 확인
											if(result.resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
												$("#mobile , [name='mobile']").val(data.TEL_NO);
												var ntnGbCd = "${frontConstants.NTN_GB_10}";
												if(data.RSLT_NTV_FRNR_CD == "F"){
													ntnGbCd = "${frontConstants.NTN_GB_20}";
												}
												$("[name='ntnGbCd']").val(ntnGbCd);
												$("[name='mobileCd']").val(data.TEL_COM_CD);
												$("[name='ciCtfVal']").val(data.CI);
												$("[name='diCtfVal']").val(data.DI);
												
												
											}else{
												var txt = result.resultMsg;
												var config = {
													txt : txt
													,	ybt : "확인"
												};
												if(result.resultCode == "${exceptionConstants.ERROR_IS_ALREADY_INTEGRATE_MSG}"){
													config.ycb = function(){
														window.location.href = "/logout?returnUrl=/indexLogin";
													};
												}
												messager.alert(config);
											}
										}
									};
									ajax.call(options);
								}
							});
							okCertPopup("02","${session.mbrNo}");
						}
						, ybt : "본인인증하기"
						, nbt : "취소"
					};
					messager.confirm(config);
				}
				,	send : function(){
						var options = {
								url : "/common/generate"
							,	data : {mobile : $("#tm").val() }
							,	done : function(result){
									clearInterval(timer);
									$("#sb").text("재전송");

									$("#ctfKey").attr("placeholder","").focus();
									var isClick = $("#sb").attr("data-is-click");

									var limit = parseInt(result);
									$("#expire").val(limit);

									var s = (limit%60)+"";
									if(s.length == 1){
										s = "0"+s;
									}
									$("#expire").text(Math.floor(limit/60) + ":"+s).val(limit).show();

									timer = setInterval(function(){
										limit = parseInt($("#expire").val());
										var m = Math.floor(limit/60);
										s = (limit%60)+"";
										if(s.length == 1){
											s = "0"+s;
										}

										if(limit <= 0){
											$("#expire").text("0:00").val(limit);
											clearInterval(timer);
										}
										limit -= 1;
										if(limit < 0) limit = 0;
										$("#expire").text(m+":"+s).val(limit);
									},1000);
							}
						};
						ajax.call(options);
				}
				,	verify : function(ctfKey){
						$("#certification-format-error").remove();
						var options = {
								url : "/common/verify"
							,	data : {ctfKey : ctfKey}
							,	done : function(result){
									if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
										var newMobile = $("#tm").val();
										$("#mobile").val(newMobile);
										$("[name='mobile']").val(newMobile);

										ui.toast("인증되었습니다.");
										mobileCert.cancel();
									}else{
										validateMsg.defaultErrorMsg(".certification",result);
									}
							}
						};
						ajax.call(options);
				}
				,	cancel : function(){
						$("#expire").val(0);
						$(".certification").find(".validation-check").remove();
						$("#mobile-li-cert").empty();
						$("#mobile-li-default").show();
				}
			};

			// 태그 컨트롤 객체
			var tag = {
				init : function(){
					//회원 태그
					var jsonStr = "${memberTags}";
					if(jsonStr != ""){
						memberTags = jsonStr.split(",");
						orgMemberTags = jsonStr.split(",");
					}
					tag.setTagOnView(memberTags);
				}
				// 내 정보 관리 - 보여지고 있는 태그 리스트 가져오기
				,	getSelectedTag : function(){
					var arr = [];
					$("#tag-li span").not($("#tag-li span").not(":visible")).each(function(idx){
						arr.push(this.id);
					});
					return arr;
				}
				//관심 태그 변경 팝업 초기화
				,	initLayerPop : function(){
					var arr = tag.getSelectedTag();
					$("#int-tag-list button").each(function(idx){
						if(arr.indexOf($("#int-tag-list button").eq(idx).data("id")) > -1){
							$("#int-tag-list button").eq(idx).addClass("active");
						}else{
							$("#int-tag-list button").eq(idx).removeClass("active");
						}
					});
				}
				//관심 태그 변경 팝업 open
				,	openLayer : function(){
					scrollTop = $("html").scrollTop();
					tag.initLayerPop();
					ui.popLayer.open("interestTagPop");
				}
				// 관심 태그 변경 팝업 - 태그 선택 이벤트
				//2021.04.01 기준 - 모바일일 때,웹일 때 관심 태그 변경 선택자는 동일, but -> toggle 퍼포먼스 소스 다름. 담당 퍼블리셔- 김 도 선
				,	onClick : function(btn){
					var cls = "active";
					if(isMobile){
						var r = $(btn).hasClass(cls);
						$("#int-tag-list .active").length > 1 && r ? $(btn).removeClass(cls) : $(btn).addClass(cls);
					}else{
						if($("#int-tag-list .active").length == 1 && $(btn).hasClass(cls)){
							$(btn).removeClass(cls);
						}
					}
					var tagId = $(btn).data("id");

					//클릭 시, 리스트에 담을 지 뺄지
					var isPush = $(btn).hasClass(cls);
					if(!isMobile) isPush = !isPush;

					if(isPush){
						if(memberTags.indexOf(tagId) == -1){
							memberTags.push(tagId);
						}
					}else{
						memberTags.splice(memberTags.indexOf(tagId),1);
					}
				}
				,	setTagOnView :  function(tagList,callback){
					if(tagList == [] || tagList == ""){
						$("#tag-li .tag").hide();
					}else{
						var selector = tagList.join(", #");
						var $show = $("#"+selector);
						$("#tag-li .tag").not($show).hide();
						$($show).show();
					}

					if(callback){
						callback();
					}
				}
			};

			//소셜 로그인 연동
			var sns = {
					connect : function(snsLnkCd){
						var snsData = {
								snsLnkCd : snsLnkCd
							, 	checkCode : "${checkCode}"
						};
						var options = {
							url : "<spring:url value='/snsLogin' />",
							data : snsData ,
							done : function(data){
								if(isNative &&  !(snsLnkCd == 40 && '${view.os}' == '10') ){
									toNativeData.func = "onSnsLogin";
									if(snsLnkCd == "${frontConstants.SNS_LNK_CD_10}") toNativeData.loginType ="N"; //N : 네이버, K : 카카오톡 , G: 구글
									if(snsLnkCd == "${frontConstants.SNS_LNK_CD_20}") toNativeData.loginType ="K";
									if(snsLnkCd == "${frontConstants.SNS_LNK_CD_30}") toNativeData.loginType ="G";
									if(snsLnkCd == "${frontConstants.SNS_LNK_CD_40}") toNativeData.loginType ="A";
									toNative(toNativeData);
								}else{
									window.location.href = data.goUrl;
								}
							}
						};
						ajax.call(options);
				}
				,	disconnect : function(snsUuid,snsLnkCd){
						var snsNm = "네이버";
						if(snsLnkCd =="${frontConstants.SNS_LNK_CD_10}"){
							snsNm = "네이버";
						}
						if(snsLnkCd =="${frontConstants.SNS_LNK_CD_20}"){
							snsNm = "카카오";
						}
						if(snsLnkCd =="${frontConstants.SNS_LNK_CD_30}"){
							snsNm = "구글";
						}
						if(snsLnkCd =="${frontConstants.SNS_LNK_CD_40}"){
							snsNm = "애플";
						}

						var config = {
								txt : snsNm +" 로그인 설정을 해제하시겠습니까?"
							,	ycb : function(){
									var options = {
										url : "/mypage/info/disconnect"
										,	data : { snsUuid : snsUuid ,snsLnkCd : snsLnkCd }
										,	done : function(result){
											var currentLoginLnkCd = "${session.loginPathCd}";

											if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
												messager.alert({
													txt : "SNS 연결이 해제 되었습니다."
													,	ycb : function(){
														if(currentLoginLnkCd == snsLnkCd) window.location.href="/logout";
														sns.reload();
													}
												});
											}else{
												messager.alert({
													txt:"잠시 후, 다시 시도해주세요."
													,	ycb : function(){
														sns.reload();
													}
												});
											}
										}
									};
									ajax.call(options);
							}
						};
						messager.confirm(config);
				}
				,	reload : function(){
						var options = {
								url : "/mypage/info/sns-connect"
							,	type : "GET"
							,	dataType : "HTML"
							,	done : function(html){
									$("#sns-connect-list").empty().append(html);
							}
						};
						ajax.call(options);
				}
			}

			//유효성 메세지
			//닉네임
			var validateMsg = {
				duplicateNickNm : function(result){
					$("#nickNm-format-error").remove();
					var html ="<p class='validation-check' id='nickNm-format-error'>이미 사용 중인 닉네임이에요.</p>";
					if((result!=0)&& ($("#nickNm-format-error").length == -0)){
						$("#nickNm").parent().after(html);	
					}
					
				},
				emptyNickNm : function(){
					var html ="<p class='validation-check' id='nickNm-format-error'>닉네임을 입력해주세요.</p>";
					$("#nickNm-format-error").remove();
					if($("#nickNm-format-error").length == -0){
						$("#nickNm").parent().after(html)
					}
				},
				banWordNickNm : function(){
					var html ="<p class='validation-check' id='nickNm-format-error'>금지어가 포함된 내용은 입력할 수 없어요.</p>";
					$("#nickNm-format-error").remove();
					if($("#nickNm-format-error").length == -0){
						$("#nickNm").parent().after(html)
					}
				},
				duplicateEmail : function(result){
					$("#email-format-error").remove();
					var msg = "이미 사용 중인 메일 주소에요.";
					var html ="<p class='validation-check' id='email-format-error'>"+msg + "</p>";
					if(result != 0){
						$("#email").parent().after(html)
					}
				},
				//이메일
				emptyEmail : function(){
					$("#email-format-error").remove();
					var msg = "메일 주소를 입력해주세요.";
					var html ="<p class='validation-check' id='email-format-error'>"+ msg + "</p>";
					$("#email").parent().after(html)
				},
				notEmailFormat : function(){
					$("#email-format-error").remove();
					var msg = "<spring:message code='front.web.view.join.email.input.validate.check2' />";
					var html ="<p class='validation-check' id='email-format-error'>"+ msg + "</p>";
						$("#email").parent().after(html)
				},
				defaultErrorMsg : function(selector,msg){
					var id = $(selector).prop("id") == null || $(selector).prop("id") == "" ? selector.replace(/name/g,'').replace(/[^a-zA-Z]/g,'') : $(selector).prop("id");
					var errorMsgId = id + "-format-error";
					var html ="<p class='validation-check' id='"+errorMsgId+"'>"+ msg + "</p>";
					if($("#"+errorMsgId).length == 0){
						$(selector).parent().after(html)
					}
					$('.btnDel').click(function(){
						$('#'+errorMsgId).html("");
					});
				},
				tagMentionNickNm : function(){
					var html ="<p class='validation-check' id='nickNm-format-error'>닉네임에 @, #, <, > 는 입력할 수 없어요.</p>";
					$("#nickNm-format-error").remove();
					if($("#nickNm-format-error").length == -0){
						$("#nickNm").parent().after(html)
					}
				}
			}
			
			//2021.06.21 김준형 추가
			//다시 입력 시 validation Msg 제거
			$(document).on("keydown input paste",".valChkRequired", function(){
				$(this).parent().next().remove();
			})

			//GSR 포인트 인증
			function fnGetGsrPoint(){
				if($("#tm").is(":visible")){
					mobileCert.cancel();
				}

				var ciCtfVal = $("[name='ciCtfVal']").val();
				var config = {
					//ci 값 있을 때
					callBack : function(){
							var option = {
									url :  "/gsr/getGsrMemberPoint"
								,	done : function(result){
										var separateNotiMsg = result.separateNotiMsg;
										//분리보관 해제 시
										if(separateNotiMsg && separateNotiMsg != ''){
											//분리보관 해제 noti
											ui.alert("<div id='alertContentDiv'>"+separateNotiMsg+"</div>",{
												ycb:function(){
													var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
													gsrPoint = fnComma(gsrPoint);
													$del = $("#gs-btn-div , #gs-cert-noti");
													$del.remove();
													$("#gs-point").text(gsrPoint);
													$("#gs-point-notice").css("color","#669aff").show();
													$(".popAlert").remove();
												}
												,   ybt:"확인"
											});
										}else{
											var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
											gsrPoint = fnComma(gsrPoint);
											$del = $("#gs-btn-div , #gs-cert-noti");
											$del.remove();
											$("#gs-point").text(gsrPoint);
											$("#gs-point-notice").css("color","#669aff").show();
										}
								}
							};
							ajax.call(option);
					}
					//ci값 없을 때
					,	okCertCallBack : function(data){
							var option = {
									url :  "/gsr/getGsrMemberPoint"
								,	data : data
								,	done : function(result){
										var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
										gsrPoint = fnComma(gsrPoint);
										$del = $("#gs-btn-div , #gs-cert-noti");
										$del.remove();
										$("#gs-point").text(gsrPoint);
										$("#gs-point-notice").css("color","#669aff").show();

									//	fnActiveSaveBtn();
								}
							};
							ajax.call(option);
					}
				};
				gk.open(config);
			}
			
			//AOS에서 scrollDown -> nickNm 인풋 안 보일 시 blur 처리하여 키패드 내리고 자동스크롤 방지	
			var lastScroll = 0;
			var blurFlag = true;
			$(window).scroll(function(event){
				var strtScroll = $(this).scrollTop();
				if (strtScroll > lastScroll){
					if($(window).scrollTop()>600 && blurFlag){
						$("#nickNm").trigger("blur")
						blurFlag = false;
						}
					else if($(window).scrollTop()<600){
						blurFlag = true;
					}
				}
				
				lastScroll = strtScroll;
			});

			//회원 정보 수정
			function updateMember(){
				var validFlag = true
				//저장 누를 시, 1번 더 검증 ---
				var data = $("#memberForm").serializeJson();

				//닉네임 빈 값 유효성
				//var originNickNm = "<c:out value = '${vo.nickNm}'/>";
				var originNickNm = $("#decodeNickNm").val();
			 	if(data.nickNm == ""){
					validateMsg.emptyNickNm();
					validFlag=false
			 	}else{
			 		//2021-08-19 추가 김명섭
			 		if(data.nickNm.indexOf("#") > -1 
			 				|| data.nickNm.indexOf("@") > -1
			 				|| data.nickNm.indexOf("<") > -1
			 				|| data.nickNm.indexOf(">") > -1){
						validateMsg.tagMentionNickNm();
						validFlag=false
			 		}else{
						validWhenBlur.banWord({nickNm : data.nickNm}, function(returnCode){
							if(returnCode == "banWord"){
								validateMsg.banWordNickNm();
								validFlag=false
							}else{
								$.ajax({
			                        url : "/common/check-nickNm"
			                        ,   type : "POST"
			                        ,   data : {nickNm : data.nickNm}
			                        ,   dataType : "JSON"
			                   	}).done(function(result){
			                    	if(data.nickNm != originNickNm){
			                    		validateMsg.duplicateNickNm(result);
			                    	}
			                    	
			                    	if(result>0){
			                    		validFlag=false;
			                    	}
			                   	})
							}
						})
			 		}
			 	}
			 	
				//이메일 유효성
				var originEmail = "<c:out value = '${vo.email}'/>";
				if(data.email == ""){
					validateMsg.emptyEmail();
					validFlag=false;
				}else if(!valid.ko.test(data.email)){
					validateMsg.notEmailFormat();
					validFlag=false;
				}else {
					validWhenBlur.email(data.email,function(result){
						if(data.email!= originEmail){
							validateMsg.duplicateEmail(result);
							if(result>0){
	                    		validFlag=false;
	                    	}
						}
					});
				}
		
			 	setTimeout(function(){
					$(".validation-check").each(function(){
						$t =$(this).siblings("div").find("input")
						if(($(this).html())!=""){
							$t.focus();
							var location = $t.offset();
							window.scroll(0,(location.top-210))
							return false;
						}
					})
		 		},400);
		
		 		//저장 버튼 데이터 저장부분
				setTimeout(function(){
				 	if(validFlag){
						//닉네임 저장시 공백 제거 (APETQA-4573)-2021.05.25 by dslee
						var chkNickNm = data.nickNm.replace(/ /gi, "");
						data.nickNm = chkNickNm;
						data.memberTags = memberTags;
						
	 					var option = {
							url : "/mypage/info/updateMemberInfo"
							,	data : data
							,	done : function(result){
									//var resultMsg = result.resultMsg;
									var uploadImgPath = result.uploadImgPath;
									/*if(resultMsg != "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
										var exCode = result.resultCode;
										if(exCode == "${exceptionConstants.ERROR_MEMBER_DUPLICATION_EMAIL}"){
											validateMsg.defaultErrorMsg(document.getElementById("email"),resultMsg);
											$(document.getElementById("email")).focus();
										}
										if(exCode == "${exceptionConstants.ERROR_MEMBER_DUPLICATION_MOBILE}"){
											validateMsg.defaultErrorMsg(document.getElementById("mobile"),resultMsg);
											$(document.getElementById("mobile")).focus();
										}
										if(exCode == "${exceptionConstants.ERROR_MEMBER_DUPLICATION_NICK_NM}"){
											validateMsg.defaultErrorMsg(document.getElementById("nickNm"),resultMsg);
											$(document.getElementById("nickNm")).focus();
										}
										if(exCode == "${exceptionConstants.ERROR_MEMBER_IN_VALID_PRFL_IMG}"){
											ui.toast(resultMsg);
										} 
									}else{*/
										if(isNative && uploadImgPath != "" && uploadImgPath != null){
											waiting.stop();
											// 데이터 세팅
											toNativeData.func = "onFileUpload";
											toNativeData.prefixPath = uploadImgPath;
											toNativeData.callback = "onFileUploadCallBack";
											// 호출
											toNative(toNativeData);
										}else{
											var config ={
													url : "/mypage/info/indexManageDetail"
												,	targetUrl : "/mypage/info/updateMemberInfo"
												,	callback : function(){
														window.location.href = "/mypage/indexMyPage";
												}
											};
											
											fncTagInfoLogApi(config);
										}
									//}
							}
						};
						ajax.call(option);
				 	}
				},700)
			}
			
			//화면 초기화
			function fnLoadDocument(){
				//모바일일 경우, 푸터 숨기기
				if(isMobile){
					$(".menubar").hide();
					$(".footer").hide();
					$(".filter-item .tag button").off();
				}

				//태그 초기화
				tag.init();

				//버튼 활성화
				//fnActiveSaveBtn();

				//가이드 문구
				if($("#email").val() == ""){
					$("#email").css("-webkit-text-fill-color","#9a9a9a");
				}
				if($("#nickNm").val() == ""){
					$("#nickNm").css("-webkit-text-fill-color","#9a9a9a");
				}

				//sns 연동 시
				if("${connectSnsLnkCd}" != ""){
					$("html").scrollTop(1293.6000289916992);
					var config = {
							txt : "SNS 연결이 설정 되었습니다."
						,	ycb : function(){
								sns.reload();
						}
					};
					messager.alert(config);
				}
			}

			//클립 보드 복사 하기
			function copyToClipboard(val) {
				var t = document.createElement("textarea");
				document.body.appendChild(t);
				t.value = val;
				t.select();
				document.execCommand('copy');
				document.body.removeChild(t);

				messager.toast({txt:"추천코드가 복사되었어요."});
			}

			//회원 탈퇴
			function fnLeaveMember(){
				var form = document.createElement("form");
				form.setAttribute("action","/mypage/info/indexLeaveGuide");
				form.setAttribute("method","POST");

				var input = document.createElement("input");
				input.setAttribute("name","checkCode");
				input.setAttribute("value","${checkCode}");
				input.setAttribute("type","text");
				form.appendChild(input);

				document.body.appendChild(form);
				form.submit();
			}
					
			//이메일 한글입력 모바일
			$(document).ready(function(){
				validateTxtLength(this, 40);
				 $("input:text[onlyEng]").on("input paste keydown change", function() {
			   		 $(this).val($(this).val().replace(/[ㄱ-힣]/gi,""));
					});
			});
			
			//복사하기
			$(document).on("click","#copyBtn",function(){
				var rcomCd = $("[name='rcomCd']").val();
				copyToClipboard(rcomCd);
			});

			//닉네임 입력 제한
			//입력 안했을 경우 에러 메시지
			//공백입력막기
			 $(document).on("input paste keydown change","[name='nickNm']",function(){
				validateTxtLength(this, 20);
				 var nickNmNoSpace=$(this).val().replace(/ /gi, "");
				$(this).val(nickNmNoSpace);
			});
				
				
			$(document).ready(function(){
				$('#nickNm').on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
					if(timer!=null){
						clearTimeout(timer);
					}
					
					setTimeout(function(){
						var nn =  $('#nickNm').val()
						//var originNickNm = "<c:out value = '${vo.nickNm}'/>";
						var originNickNm = $("#decodeNickNm").val();
						if(nn == ""){
							validateMsg.emptyNickNm();
						}else{
							if(nn.indexOf("#") > -1 
					 				|| nn.indexOf("@") > -1
					 				|| nn.indexOf("<") > -1
					 				|| nn.indexOf(">") > -1){
								validateMsg.tagMentionNickNm();
							}else{
								validWhenBlur.banWord({nickNm : nn}, function(returnCode){
									if(returnCode == "banWord"){
										validateMsg.banWordNickNm();
									}else{
										validWhenBlur.nickNm(nn,function(result){
											if(nn != originNickNm){
												validateMsg.duplicateNickNm(result);
											}
										});
									}
								})
							}
						}
					},150)
				});
				
				$('#email').on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
					setTimeout(function(){
						var e = $("#email").val();
						var originEmail = "<c:out value = '${vo.email}'/>";
						if(e == ""){
							validateMsg.emptyEmail();
						}else if(!valid.ko.test(e)){
							validateMsg.notEmailFormat();
						}else {
							validWhenBlur.email(e,function(result){
							if(e != originEmail){
								validateMsg.duplicateEmail(result);
								}
							});
						}
					},150)
				});
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$(".mo-heade-tit").text("회원정보 수정");
					$("#header_pc").addClass('logHeaderAc');
				};
				
				fnLoadDocument();
			})
	
			//가이드 문구 dim 처리 일괄
			$(document).on("focus input paste change ","#email , #nickNm",function(){
				$(this).css("-webkit-text-fill-color",$(this).val() == "" ? "#9a9a9a" : "black");
				$(this).attr("placeholder","");
			}).on("blur","#email , #nickNm", function(){
				$(this).css("-webkit-text-fill-color",$(this).val() == "" ? "#9a9a9a" : "black");
				 if(this.id=="nickNm"){
					$(this).attr("placeholder","닉네임을 입력해주세요.");
				}
				if(this.id=="email"){
					$(this).attr("placeholder","이메일을 입력해주세요.");
				}
			})
			/*.on("input change paste","#nickNm",function(){
				validateTxtLength(document.getElementById("nickNm"), 20);
			});*/

			//모바일 - 관심 태그 변경 뒤로가기, 닫기 버튼
			$(document).on("click","#interestTagPopBackBtn , #interestTagPopCloseBtn",function(){
				tag.setTagOnView(tag.getSelectedTag(),function(){
					$("#contents").show();
					ui.popLayer.close("interestTagPop");
					$("html").scrollTop(scrollTop);
				});
			});
			
			//모바일 - 태그 저장 버튼 클릭 시
			$(document).on("click","#tagSaveBtn",function(){
				tag.setTagOnView(memberTags,function(){
					orgMemberTags = tag.getSelectedTag();
					$("#contents").show();
					ui.popLayer.close("interestTagPop");
					$("html").scrollTop(scrollTop);
				});
			});
						
			function goBack() {
				history.replaceState("","",'/mypage/indexMyPage/');
				location.href='/mypage/indexMyPage/';
			}
		</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<input type="hidden" id="decodeNickNm" value="${vo.nickNm}"/>
		
		<style>
			.expire{
				font-size: 13rem;
				color: #ff7777;
				margin-top: 7px;
				padding: 0 5px 0;
				position:absolute;
				left:53%;
				top:20%;
			}
		</style>
		<form id="memberForm">
			<div id="hiiden-field">
				<input type="hidden" id="adapter" onchange="fnSnsStatSave();"/>
				<input type="hidden" name="prflNm" value="${prflNm}" />
				<input type="hidden" name="prflImg" value="${vo.prflImg}" />
				<input type="hidden" name="orgPrflImg" value="${vo.prflImg}" />
				<input type="hidden" name="mobile" value="${vo.mobile}" />
				<input type="hidden" name="orgMobile" value="${vo.mobile}" />
				<input type="hidden" name="mobileCd" value="${vo.mobileCd}" />
				<input type="hidden" name="ciCtfVal" value="${vo.ciCtfVal}" />
				<input type="hidden" name="diCtfVal" value="${vo.diCtfVal}" />
				<%-- <input type="hidden" name="mbrDlvraNo" value="${addr.mbrDlvraNo}"/>
				<input type="hidden" name="dftYn" value="${addr.dftYn}"/>
				<input type="hidden" name="postNoNew" value="${addr.postNoNew}"/>
				<input type="hidden" name="postNoOld" value="${addr.postNoOld}"/>
				<input type="hidden" name="roadAddr" value="${addr.roadAddr}"/>
				<input type="hidden" name="roadDtlAddr" value="${addr.roadDtlAddr}"/>
				<input type="hidden" name="prclAddr" value="${addr.prclAddr}"/>
				<input type="hidden" name="prclDtlAddr" value="${addr.prclDtlAddr}"/> --%>
				<input type="hidden" name="rcomUrl" value="${vo.rcomUrl}"/>
				<input type="hidden" name="rcomCd" value="${vo.rcomCd}"/>
				<input type="hidden" name="ntnGbCd" value="${vo.ntnGbCd}" />
			</div>
			<main class="container page login srch" id="container">
<!-- 				<div class="header pageHead heightNone"> -->
<!-- 					<div class="inr"> -->
<!-- 						<div class="hdt"> -->
<!-- 							<button class="back" type="button" onclick="goBack();" data-content="" data-url="/mypage/indexMyPage">뒤로가기</button> -->
<!-- 						</div> -->
<!-- 						<div class="cent"><h2 class="subtit">회원정보 수정</h2></div> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<div class="inr">
					<!-- 본문 -->
					<div class="contents" id="contents">
						<div class="pc-tit">
							<h2>회원정보 수정</h2>
						</div>
						<div class="fake-pop">
							<div class="pct">
								<div class="poptents">
									<!-- 프로필 사진 -->
									<div class="my-picture">
										<p class="picture">
											<img id="prflImg" class="thumb" data-original="${frame:optImagePath(vo.prflImg, frontConstants.IMG_OPT_QRY_794)}" src="${frame:optImagePath(vo.prflImg, frontConstants.IMG_OPT_QRY_794)}" alt="">
										</p>
										<button type="button" class="btn edit" id="prflImgBtn" onclick="img.upload();" data-content="${vo.prflImg}"></button>
									</div>
									<!-- // 프로필 사진 -->
									<!-- 회원 정보 입력 -->
									<div class="member-input">
										<ul class="list">
											<li>
												<strong class="tit requied">아이디</strong>
												<p class="info">필수 입력 정보</p>
												<div class="input disabled">
													<input type="text" value="${vo.loginId}" readonly style="-webkit-text-fill-color:black;">
												</div>
											</li>
											<li>
												<strong class="tit">이름</strong>
												<div class="input disabled">
												<c:choose>
													<c:when test="${not empty vo.mbrNm}">
														<input type="text"  id="mbrNm" value="${vo.mbrNm}" readonly style="-webkit-text-fill-color:black;">
													</c:when>
													<c:otherwise>
														<input type="text"  id="mbrNm" value="" ${vo.mbrNm == '' ? 'placeholder="본인확인이 필요합니다."' :'' } readonly style="-webkit-text-fill-color:#9a9a9a;">
													</c:otherwise>
												</c:choose>
												</div>
											</li>
											<li id="mobile-li-default">
												<strong class="tit">휴대폰 번호</strong>
												<div class="input disabled flex">
													<c:choose>
														<c:when test="${not empty vo.mobile}">
															<input type="text" id="mobile" value="${vo.mobile}"  readonly style="-webkit-text-fill-color:black;">
														</c:when>
														<c:otherwise>
															<input type="text" id="mobile" value="" ${vo.mobile == '' ? 'placeholder="본인확인이 필요합니다."' :'' } readonly style="-webkit-text-fill-color:#9a9a9a;">
														</c:otherwise>
													</c:choose>
													<c:if test="${not empty vo.ciCtfVal}">
														<a href="javascript:;" onclick="mobileCert.open();" class="btn md" >변경</a>
													</c:if>
												</div>
											</li>
											<li id="mobile-li-cert">
											</li>
											<li>
												<strong class="tit requied">닉네임</strong>
												<div class="input del disabled">
													<input type="text" name="nickNm" class="valChkRequired" id="nickNm" value="${vo.nickNm}" maxlength ="22" placeholder="닉네임을 입력해주세요." style="-webkit-text-fill-color:black;" >
												</div>
											</li>
											<c:choose>
											<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
											<li>
												<strong class="tit requied">이메일</strong>
												<div class="input del disabled">
													<input type="text" name="email" class="valChkRequired" id="email" onlyEng value="${vo.email}" maxlength ="41" placeholder="이메일을 입력해주세요." style="-webkit-text-fill-color:black;">
												</div>
											</li>
											</c:when>
											<c:otherwise>
											<li>
												<strong class="tit requied">이메일</strong>
												<div class="input del disabled">
													<input type="text" name="email" class="valChkRequired" id="email" value="${vo.email}" placeholder="이메일을 입력해주세요."  maxlength ="42" style="-webkit-text-fill-color:black;">
												</div>
											</li>
											</c:otherwise>
											</c:choose>
											<%-- <li>
												<strong class="tit requied">생년월일</strong>
												<div class="input disabled">
													<input type="text" placeholder="2021.05.05" value="${vo.birth}" readonly>
												</div>
											</li>
											<li>
												<strong class="tit requied" id="mbr-gd-li">성별</strong>
												<div class="flex-wrap">
													<label class="radio"><input type="radio" name="radio1" disabled ${vo.gdGbCd eq frontConstants.GD_GB_1 ? ' checked' : ''}><span class="txt">남자</span></label>
													<label class="radio"><input type="radio" name="radio1" disabled ${vo.gdGbCd eq frontConstants.GD_GB_0 ? ' checked' : ''}><span class="txt">여자</span></label>
												</div>
											</li> --%>
											<%-- <li class="b-line">
												<c:set var="addressTxt" value="[ ${addr.postNoNew} ] ${addr.roadAddr}" />
												<c:if test="${empty addr.postNoNew or empty addr.roadAddr}">
													<c:set var="addressTxt" value="" />
												</c:if>
												<strong class="tit ">주소</strong>
												<div class="adrbox basic">
													<c:choose>
														<c:when test="${not empty addressTxt}">
															<div class="adr on" id="addr">${addressTxt}</div>
														</c:when>
														<c:otherwise><div class="adr on" id="addr">&nbsp;</div></c:otherwise>
													</c:choose>
													<a href="javascript:;"  id="input-addr-div" class="btAdr">주소검색</a>
												</div>
												<div class="input disabled" id="addrDetailDiv">
													<input type="text" id="addrDetail" class="text-input" placeholder="상세 주소를 입력해주세요." value="${addr.roadDtlAddr}" >
												</div>
											</li> --%>
											<li class="b-line">
												<strong class="tit">초대코드</strong>
												<div class="flex-wrap">
													<div class="txt" id="frdRcomKey">${vo.rcomCd}</div>
													<a href="javascript:;" class="btn sm" id="copyBtn">복사하기</a>
												</div>
											</li>
											<li class="b-line">
												<strong class="tit">GS&POINT</strong>
												<div class="input flex tx-r" id="gs-btn-div">
													<input type="text" value="" readonly>
													<!-- 임시 주석 -->
													<a href="javascript:;" class="btn md" onclick="fnGetGsrPoint();">포인트 조회</a>
												</div>
												<div class="ptt" id="gs-point-notice" style="display:none;"><b class="t">사용 가능한 포인트</b> <em class="prc"><b class="b" id="gs-point">25,000</b><i class="w">P</i></em></div>
												<p class="sub-txt" id="gs-cert-noti">GS&POINT사용을 위해서는 본인인증이 필요합니다.</p>
											</li>
											<li class="b-line">
												<div class="flex-wrap">
													<strong class="tit mb0">관심태그</strong>
													<a href="javascript:tag.openLayer();" class="btn sm" data-url="/mypage/info/indexInterestTagPop" data-content="${session.mbrNo}">변경</a>
												</div>
												<div class="tag-area" id="tag-li">
													<c:forEach var="tag" items="${interestTag}">
														<span class="tag" id="${tag.dtlCd}" data-tag-no="${tag.dtlCd}">${tag.dtlNm}</span>
													</c:forEach>
												</div>
											</li>
											<li id="sns-connect-list">
												<jsp:include page="./indexSnsConnectList.jsp" />
											</li>
										</ul>
									</div>
									<!-- // 회원 정보 입력 -->
								</div>
							</div>
							<div class="pbt pull">
								<div class="bts">
									<a href="javascript:;" class="btn xl a" id="saveBtn" onclick="updateMember();">저장</a>
								</div>
							</div>
							<div class="btn-area">
								<a href="javascript:fnLeaveMember();" class="text-btn" data-url="/mypage/info/indexLeaveGuide" data-content="${session.mbrNo}" >회원탈퇴하기</a>
							</div>
						</div>
					</div>
				</div>
			</main>
		</form>
		<!-- e -->

		<jsp:include page="./indexInterestTagPop.jsp" />

		 <!-- 플로팅 영역 -->
<%--         <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" > --%>
<%-- 			<jsp:include page="/WEB-INF/tiles/include/floating.jsp"> --%>
<%-- 	        	<jsp:param name="floating" value="" /> --%>
<%-- 	        </jsp:include> --%>
<%--         </c:if> --%>
	</tiles:putAttribute>
</tiles:insertDefinition>