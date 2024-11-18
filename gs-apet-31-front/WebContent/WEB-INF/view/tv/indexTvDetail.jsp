<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
  Class Name  : indexTvDetail.jsp 
  Description : 펫TV 영상 상세화면
  Author      : LDS
  Since       : 2021.01.19
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2021.01.19   이동식          	최초 작성
--%>

<%-- 
사용 Tiles 지정
--%>
<tiles:insertDefinition name="header_pc">
	<%-- 
	Tiles script.include put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.include" value="script.pettv"/> <!-- 지정된 스크립트 적용 -->
	
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
		<style>
			/*
			20210416 퍼블소스 적용 테스트 주석 처리
			body, html{height:100% !important;} 
			20210416 퍼블소스 적용 테스트 주석 처리 
			*/
	        /* pip모드 테스트로 인해 주석처리-21.04.20
	        body, html{height:100%;}
	        */
	    </style>
    
		<script type="text/javascript">
			// 동영상 마우스 우클릭 방지
			$(".video-area").on("contextmenu", function(event) { event.preventDefault();});
			let nowVdId = "${so.vdId}"; 	<%--페이지 진입시 영상ID--%>
			let sortCd = "${so.sortCd}"; 	<%--영상 정렬구분값(10:최신순, 20:인기순)--%>
			let listGb = "${so.listGb}"; 	<%--진입목록 구분값--%>
			let player;						<%--영상 플레이어 생성--%>
			let tabGb = "S";				<%--현재 재생되는 영상의 탭 구분(S:시리즈 영상(default), A:추천 영상)--%>
			
			var seconds = 5;
			var myTimer;
			
			$(function(){
				//펫TV 상세는 pip모드로 인하여 viewport를 다시 셋팅함.(pip모드 해제시 화면이 확대되는 현상)
				$("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no");
				
	            $(".btn-video-layer").click(function(){
	                $(this).toggleClass("on");
	                if($(this).hasClass("on")){
	                    $(this).parents(".videoAndListWrap").addClass("infoMode");
	                }else{
	                    $(this).parents(".videoAndListWrap").removeClass("infoMode");
	                };
	                $(this).css("top","");/* 04.12 */
	            });

	            /* 가로모드 시 위치 잡아 주는 함수 */
	            /*function setTingsPosition(){
	                $(".div-right").css("bottom",window.innerHeight - $(".tabWrap > .head").offset().top - 20);
	                $(".tvVideoInfoBoth").height(window.innerHeight - $(".div-right").offset().top - 40);
	            };*/
	            
	            /* 예외처리 */
	            /*function etcsReturn(e){
	                if(e.target.getAttribute("class") == "tvVideoInfoBoth" || $(e.target).parents(".acSelect").length || $(e.target).parents(".tvSlid").length || window.matchMedia("(orientation:portrait)").matches){
	                    return true;
	                }else{
	                    return false;
	                }
	            }*/

	            /* tab width 설정 */
	            $(window).resize(reFn);
	            reFn();

	            function reFn(){
	                var $li = $(".tabWrap > .con > ul > li");
	                var check = window.matchMedia('(orientation:landscape)').matches;
	                $li.width($(document).width());
	                var w = window.innerWidth;
	                if(w >= 1024){
	                    $(".videoAndListWrap .tab-area").height($(".videoAndListWrap .video-area").height())
	                }else{
	                    $(".videoAndListWrap .tab-area").removeAttr("style");
	                };
	                /*if(check){
	                    $(".acSelect").each(function(i,n){
	                        var $this = $(n);
	                        var wh = window.innerHeight;
	                        var h = $this.innerHeight();
	                        if(h >= wh){
	                            $this.css("height",wh)
	                        }else{
	                            $this.css("max-height",wh)

	                        };
	                    });
	                };*/
	            };
	            
	            if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
		            $(".off-ly").click(function() {
		            	//console.log(".off-ly");
		            	clearTimer();
					});
		            
		            $(".tvSlid").scroll(function() {
		            	//console.log(".tvSlid");
		            	clearTimer();
		            });
	            }
	            
	            /* 320대응 스크립트-04.12 */
	            $(".page.tv.detail .tab-area").scroll(function(){
	                var $bt = $(".div-right .btn-video-layer");
	                $bt.css("top","-" + $(this).scrollTop() + "px")
	                //console.log($(this).scrollTop())
	            })
	        });
			
			//가로모드 체크
			window.addEventListener('resize', function () {
				if (window.matchMedia('(orientation: portrait)').matches) {
					//mWeb, APP시 세로모드일때 타이머 리셋
                    if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
                		//console.log("세로모드이다.");
                		clearTimer();
            		}
					
					//20210416 퍼블소스 적용 테스트 추가
                    //$("body, html").css("height","100%"); //pip모드 테스트로 인해 주석처리-21.04.20
				} else {
					//mWeb, APP시 가로모드일때 타이머 리셋
                    if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
	                    //console.log("가로모드이다");
	                    clearTimer();
                    }
					
					//20210416 퍼블소스 적용 테스트 추가
                    //$("body, html").css("height","auto"); //pip모드 테스트로 인해 주석처리-21.04.20
				}
			});
			
			//뒤로가기 이벤트 처리에 사용-sgr에서 가이드
			window.addEventListener("message", function(event){
			    if(event.data.action == 'player_reload'){
			        document.getElementById(event.data.player_ifr_id).contentWindow.location.replace(event.data.player_url);
			    }
			});
			
			$(window).on('popstate', function(event) {
				var data = event.originalEvent.state;
				if(data !== null){
					nowVdId = data.vd_id;
					
					ui.tab2($("#tab_sris")); //시리즈 영상 탭으로 이동
					
					fncAutoFlag();
				}else{
					/* APP일때 location.href 호출하면 이쪽이 실행되서 주석처리 & APP에서 onNewPage 로 띄운 화면은 뒤로가기 이벤트시 화면을 닫아줘서 주석처리
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
						// 데이터 세팅
						toNativeData.func = "onClose";
						// APP 호출
						toNative(toNativeData);
					}else{*/
						//history.go(-1);
						storageHist.goBack();
					//}
				}
			});
			
			let acTotTime = 0; 				<%--총 영상길이--%>
			let acPlayTime = 0; 			<%--현재 시청길이--%>
			let outId = ""; 				<%--외부videoId--%>
			let srisYn = "N"; 				<%--시리즈여부--%>
			let prevSrisVdId = ""; 			<%--이전 시리즈영상ID--%>
			let nextSrisVdId = ""; 			<%--다음 시리즈영상ID--%>
			let sesnYn = "N"; 				<%--시즌여부--%>
			let prevSesnVdId = ""; 			<%--이전 시즌영상ID--%>
			let nextSesnVdId = ""; 			<%--다음 시즌영상ID--%>
			let prevAdviceVdId = ""; 		<%--이전 추천 영상ID--%>
			let nextAdviceVdId = ""; 		<%--다음 추천 영상ID--%>
			let srisAdYn = "N";				<%--시리즈 광고여부--%>
			let sysRegr = "";				<%--영상 등록자번호--%>
			let autoPlayFlag = false;		<%--App 자동재생여부--%>
			let autoNextPlayFlag = false;	<%--App 다음영상자동재생여부--%>
			let firstVdoHits = true;		<%--조회수 증가 여부--%>
			let boolPipNo = true;			<%--PIP여부--%>
			
			$(document).ready(function(){
				fncAutoFlag();
				
				history.pushState({vd_id : nowVdId}, "", "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb);

				$(document).click(function (e) {
					if(!$(e.target).closest(".prd-layer .cont").length ) {
						$('.prd-layer').slideUp('300');
						e.stopPropagation();
					}
				});

				/* 04.08 : 추가 */
				$(".page.tv .prd-layer .top .inner").click(function(e){
					e.stopPropagation();
				});
				/* 04.08 : 추가 */
			}); // End Ready
			
			//자동재생여부
			function fncAutoFlag(){
				//PC는 자동재생, MW는 자동재생안함
				//APP는 설정에 따라 자동재생시행
				if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){ //PC
					autoPlayFlag = true;
					autoNextPlayFlag = true;
					
					fncPrevNextVdoListInfo();
				}else if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){ //MW
					autoPlayFlag = false;
					autoNextPlayFlag = false;
					
					fncPrevNextVdoListInfo();
				}else if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
					//자동재생여부 판단
					// 데이터 세팅
					toNativeData.func = "onIsAutoPlay";
					toNativeData.callback = "appIsAutoPlay";
					// APP 호출
					toNative(toNativeData);
					
					if("${view.twcUserAgent}" == "true"){
		            	//TWC 호출일때 상단 타이틀바 숨김
		            	// 데이터 세팅
						toNativeData.func = "onTitleBarHidden";
						toNativeData.hidden = "Y";
						// APP 호출
						toNative(toNativeData);
		            }
				}
			}
			
			//App 자동재생여부값
			function appIsAutoPlay(jsonString){
				var parseData = JSON.parse(jsonString);
				//alert("isAutoPlay : " + parseData.isAutoPlay + "  pipYn : " + parseData.pipYn + "  onCloseYn : " + parseData.onCloseYn);
				
				var autoPlay = parseData.isAutoPlay; //자동재생여부
				var pipYn = parseData.pipYn; //PIP지원가능여부
				var onCloseYn = parseData.onCloseYn; //onClose 실행여부
				
				if(autoPlay == "Y"){
					autoPlayFlag = true;
					autoNextPlayFlag = true;
				}else{
					autoPlayFlag = false;
					autoNextPlayFlag = false;
				}
				
				//OS버전에 따라 PIP기능이 안될때 X버튼 보이도록 처리
				//onNewPage로 호출된게 아닐때 X버튼 보이도록 처리
				//twc호출이 아닐때(twc호출일때는 jstl로 판단) X버튼 보이도록 치리
				//위의 기준에 Push등 바로 영상상세 화면 진입일때 X버튼 보여지면서 onCloseYn 값에 따라 Y=onClose 호출, N=펫TV 홈으로 화면이동 되도록 처리
				if(pipYn == "N" && "${view.twcUserAgent}" == "false"){
					$("#btnClose").addClass("app");
					
					if(onCloseYn == "Y"){
						$("#btnClose").attr("onclick", "fncToMove('no_pip');");
					}else{
						$("#btnClose").attr("onclick", "fncToMove('tv_home');");
					}
				}
				
				fncPrevNextVdoListInfo();
			}
			
			//영상 상세정보, 태그목록, 연관상품목록, 이전/다음 시리즈(시즌) 목록 정보, 추천 영상 목록 조회
			function fncPrevNextVdoListInfo() {
				$.ajax({
					type: 'POST',
					url: "/tv/series/selectPrevNextVdoListInfo",
					async: false,
					dataType: 'json',
					data : {
						vdId : nowVdId
						, sortCd : sortCd
						, listGb : listGb
					},
					success: function(data) {
						acTotTime = 0; 				<%--총 영상길이 초기화--%>
						acPlayTime = 0; 			<%--현재 시청길이 초기화--%>
						outId = ""; 				<%--외부videoId 초기화--%>
						srisYn = "N"; 				<%--시리즈여부 초기화--%>
						prevSrisVdId = ""; 			<%--이전 시리즈영상ID 초기화--%>
						nextSrisVdId = ""; 			<%--다음 시리즈영상ID 초기화--%>
						sesnYn = "N"; 				<%--시즌여부 초기화--%>
						prevSesnVdId = ""; 			<%--이전 시즌영상ID 초기화--%>
						nextSesnVdId = ""; 			<%--다음 시즌영상ID 초기화--%>
						prevAdviceVdId = ""; 		<%--이전 추천 영상ID 초기화--%>
						nextAdviceVdId = ""; 		<%--다음 추천 영상ID 초기화--%>
						srisAdYn = "N";				<%--시리즈 광고여부 초기화--%>
						sysRegr = "";				<%--영상 등록자번호 초기화--%>
						firstVdoHits = true;		<%--조회수 증가 여부 초기화--%>
						
						ui.tab2($("#tab_sris")); //시리즈 영상 탭으로 이동
						
						fncDetailInfo(data); 	//영상 상세정보, 태그목록, 연관상품목록
						fncDetailVdoList(data); //이전, 다음, 시리즈(시즌) 목록 정보 셋팅
						fncAdviceVdoList(data); //추천 영상 목록 정보 셋팅
						
						// PC의 경우에 영상 상세 진입할 경우 바로 댓글 조회 (MO WEB, APP의 경우 댓글 ui 버튼 클릭 시 댓글 목록 조회)
						if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
							selectTvDetailReplyList('Y', nowVdId); // 댓글 정보
						} else {
							// 영상 자동 재생 페이지 이동 시 댓글 레이어 close
							$("#aplyContent").blur();
							if(boolPipNo){
								$("#moReplyLayerCloseBtn").trigger("click");
							}
						}
						
						//영상(인기, 맞춤, 신규)목록에서 댓글, 연관상품 클릭으로 상세페이지 진입시 댓글팝업, 연관상품 팝업이 떠야함.
						if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
							if(listGb.indexOf("VDO") !== -1){
								var param = listGb.split("_");
								if(param[2] == "R"){
									//댓글팝업 실행
									//$("#video_reply").trigger("click");
									setTimeout(fncAplyLayerOpen, 500);
									listGb = param[0]+"_"+param[1]+"_N";
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}else if(param[2] == "T"){
									//연관상품팝업 실행
									//$("#videoTing").trigger("click");
									getRelatedGoodsWithTv($("#videoTing"), nowVdId, "N");
									listGb = param[0]+"_"+param[1]+"_N";
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}
							}else if(listGb.indexOf("TAG") !== -1){
								var param = listGb.split("_");
								if(param[1] == "R"){
									//댓글팝업 실행
									//$("#video_reply").trigger("click");
									setTimeout(fncAplyLayerOpen, 500);
									listGb = param[0]+"_N_"+param[2];
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}else if(param[1] == "T"){
									//연관상품팝업 실행
									//$("#videoTing").trigger("click");
									getRelatedGoodsWithTv($("#videoTing"), nowVdId, "N");
									listGb = param[0]+"_N_"+param[2];
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}
							}else if(listGb.indexOf("VT") !== -1){
								var param = listGb.split("_");
								if(param[2] == "R"){
									//댓글팝업 실행
									//$("#video_reply").trigger("click");
									setTimeout(fncAplyLayerOpen, 500);
									listGb = param[0]+"_"+param[1]+"_N";
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}else if(param[2] == "T"){
									//연관상품팝업 실행
									//$("#videoTing").trigger("click");
									getRelatedGoodsWithTv($("#videoTing"), nowVdId, "N");
									listGb = param[0]+"_"+param[1]+"_N";
									
									var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
									history.replaceState({vd_id : nowVdId}, "", replaceUrl);
									storageHist.replaceHist(replaceUrl);
								}
							}
							
							//연관상품 바텀시트 오픈 후 화면이동이면 연관상품 바텀시트 오픈시킴
							if(listGb.indexOf("goods") !== -1){
								var param = listGb.split("-");
								listGb = param[0];
								
								var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
								history.replaceState({vd_id : nowVdId}, "", replaceUrl);
								storageHist.replaceHist(replaceUrl);
								
								if(param.length > 2){
									getRelatedGoodsWithTv($("#videoTing"), nowVdId, "N|"+param[2]);
								}else{
									getRelatedGoodsWithTv($("#videoTing"), nowVdId, "N");
								}
							}else if(listGb.indexOf("cart") !== -1){
								var param = listGb.split("-");
								listGb = param[0];
								
								var replaceUrl = "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb;
								history.replaceState({vd_id : nowVdId}, "", replaceUrl);
								storageHist.replaceHist(replaceUrl);
								
								getRelatedGoodsWithTv($("#videoTing"), nowVdId, "Y");
							}
						}
					},
					error: function(request, status, error) {
						ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
					}
				});
			}
			
			//영상 상세정보, 태그목록, 연관상품목록 셋팅
			function fncDetailInfo(data){
				var tvDetailVO = data.tvDetailVO;
				var tagList = data.tagList;
				
				if(tvDetailVO !== null && tvDetailVO !== undefined) {
					userActionLog(tvDetailVO.vdId, "watch"); //클릭 이벤트-시청
					
					acTotTime = tvDetailVO.acTotTime;
					acPlayTime = tvDetailVO.acPlayTime;
					outId = tvDetailVO.acOutsideVdId;
					srisAdYn = tvDetailVO.srisAdYn;
					sysRegr = tvDetailVO.sysRegrNo;
					
					$("#video_title").html(tvDetailVO.ttl); //영상제목
					
					var srisThumBgUrl = "";
					if(tvDetailVO.srisPrflImgPath != null && tvDetailVO.srisPrflImgPath !== undefined){
						if(tvDetailVO.srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
							srisThumBgUrl = tvDetailVO.srisPrflImgPath;
						}else{
							srisThumBgUrl = "${frame:optImagePath('"+ tvDetailVO.srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_786)}";
						}
					}
					$("#sris_thum").css("background-image", "url("+ srisThumBgUrl +")"); //시리즈 썸네일
					$("#sris_thum").attr("onclick", "fncGoSrisList('"+ tvDetailVO.srisNo +"')"); //시리즈목록 이동
					
					$("#sris_name").html(tvDetailVO.srisNm); //시리즈명
					$("#sris_name").attr("onclick", "fncGoSrisList('"+ tvDetailVO.srisNo +"')"); //시리즈목록 이동
					
					<%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거--%>
					//$("#player_count").html(fnComma(tvDetailVO.hits)); //재생수(조회수)
					$("#video_list_title").html("["+ tvDetailVO.srisNm +"] "+ (tvDetailVO.sesnNm == null ? "" : tvDetailVO.sesnNm)); //시리즈 영상 목록의 시리즈명, 시즌명
					
					/*영상 상세정보*/
					var dtlHtml = "";
					dtlHtml += '<div class="cont day">등록일 : '+ tvDetailVO.sysRegDt +'</div>';
					
					<%-- 추천 영상일때만 --%>
					//if(tabGb == "A"){ //추천 영상 로직변경으로 추천 영상에서 영상 선택시 시리즈탭으로 이동 및 시리즈목록이 재생되야해서 추천 영상일때만 보여지던 하위 일치율은 50% 넘을시 구분없이 보여지는걸로 수정
						/*(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
						if(tvDetailVO.rate !== null && tvDetailVO.rate !== undefined && tvDetailVO.rate !== "null"){
							var rate = Number(tvDetailVO.rate);
							if(rate >= 50){
								dtlHtml += '<div class="cont">';
			                    dtlHtml += '사용자 관심분야와 '+ rate +'% 일치해요!<br>';
			                    dtlHtml += '</div>'; 
							}
						}*/
					//}
                    
                    if(tvDetailVO.content != "" && tvDetailVO.content != undefined){
                    	dtlHtml += '<div class="cont">'+ tvDetailVO.content.replace(/(\n|\r\n)/g, '<br>') +'</div>';
                    }
                    
                    if(tagList != null && tagList.length > 0){
                    	dtlHtml += '<div class="cont tag">';
                    		for(var i=0; i<tagList.length; i++){
                    			dtlHtml += '<span style="cursor:pointer;" onclick="fncGoTagList(\''+ tagList[i].acTagNo +'\')">#'+ tagList[i].acTagNm +'</span>';
                    		}
	                  	dtlHtml += '</div>';
                    }
                    
                    if(tvDetailVO.crit != "" && tvDetailVO.crit != undefined){
                    	dtlHtml += '<div class="cont">';
                    	dtlHtml += '	<h3>음원저작권</h3>';
                    	dtlHtml += '	<p>'+ tvDetailVO.crit.replace(/(\n|\r\n)/g, '<br>') +'</p>';
                    	dtlHtml += '</div>';
                    }
					
					$("#video_detail").html(dtlHtml);
					/*//영상 상세정보*/
					
					/*연관상품*/
					$("#videoTing").attr("data-content", nowVdId);
					$("#videoTing").attr("data-url", "getRelatedGoodsWithTv(this, '"+ nowVdId +"', 'N')");
					
					//연관상품 갯수
					if(Number(tvDetailVO.goodsCount) > 0){
						$("#goodsNum").html(tvDetailVO.goodsCount);
						
						$(".tvConnectedTing").removeAttr("style");
						$(".btn-with-wrap").removeAttr("style");
						
						//연관상품 썸네일 이미지
						var goodsImgVO = tvDetailVO.goodsImgVO;
						var goodsThumBgUrl = "";
						if(goodsImgVO !== null && goodsImgVO !== undefined){
							if(goodsImgVO.imgPath !== null && goodsImgVO.imgPath !== undefined){
								if(goodsImgVO.imgPath.indexOf('cdn.ntruss.com') != -1){
									goodsThumBgUrl = goodsImgVO.imgPath;
								}else{
									goodsThumBgUrl = "${frame:optImagePath('"+ goodsImgVO.imgPath +"', frontConstants.IMG_OPT_QRY_500)}";
								}
							}else{
								goodsThumBgUrl = "../../_images/tv/@temp01.jpg"; 
							}
						}else{
							goodsThumBgUrl = "../../_images/tv/@temp01.jpg"; 
						}
						$("#goodsThums").css("background-image", "url("+ goodsThumBgUrl +")"); //시리즈 썸네일
					}else{
						$("#goodsNum").html("0");
						
						$(".tvConnectedTing").css("display", "none");
						$(".btn-with-wrap").css("display", "none");
					}
					/*//연관상품*/
					
					/*하단바(좋아요, 댓글, 공유, 찜)*/
					if(tvDetailVO.likeYn == "Y"){
						$("#video_like").addClass("on");
					}else{
						$("#video_like").removeClass("on");
					}
					$("#video_like").html(fnComma(tvDetailVO.likeCnt));
					$("#video_reply").html(fnComma(tvDetailVO.replyCnt));
					if(tvDetailVO.dibsYn == "Y"){
						$("#video_mark").addClass("on");
					}else{
						$("#video_mark").removeClass("on");
					}
					
					$("#video_like").attr("data-content", nowVdId);
					$("#video_reply").attr("data-content", nowVdId);
					$("#vdoClipboard").attr("data-content", nowVdId);
					$("#video_mark").attr("data-content", nowVdId);
					/*//하단바(좋아요, 댓글, 공유, 찜)*/
					
					/*App 공유*/
					$("#appSubject").val(tvDetailVO.ttl.replace(/amp;/gi, "")); //app 공유에서 사용-영상제목
					
					<%--var vdoThumbUrl = "";
					if(tvDetailVO.acPrflImgPath != null && tvDetailVO.acPrflImgPath !== undefined){
						if(tvDetailVO.acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
							vdoThumbUrl = tvDetailVO.acPrflImgPath;
						}else{
							vdoThumbUrl = "${frame:optImagePath('"+ tvDetailVO.acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
						}
					}
					
					imgToBase64ByFileReader(vdoThumbUrl).then(function(val) {
						var img = val.replace("data:image/png;base64,", "");
						//console.log(img);
						$("#appImage").val(img); //app 공유에서 사용-영상썸네일 이미지
					});--%>
					/*//App 공유*/
					
					//공유 URL 셋팅
					$("#vdoClipboard").attr("data-clipboard-text", tvDetailVO.srtUrl); //PC,MO 공유에서 사용
					$("#appLink").val(tvDetailVO.srtUrl.replace(/amp;/gi, "")); //app 공유에서 사용-링크
				}else{
					ui.alert("재생할 수 없는 영상입니다.<br>펫TV 메인으로 이동합니다.",{ // 알럿 옵션들
					    tit:"ERROR",
					    ycb:function(){
					    	location.href="/tv/home/";
					    },
					    ybt:"확인" // 기본값 "확인"
					});
				}
			}
			
			
			
			
			
			<%-- ###############################################시리즈 영상 목록 영역############################################### --%>
			//이전, 다음, 시리즈(시즌) 목록 정보 셋팅
			function fncDetailVdoList(data){
				var srisList = data.srisList; //시리즈 영상 목록
				var prevSrisInfo = data.prevSrisInfo; //이전 시리즈 영상 정보
				var nextSrisInfo = data.nextSrisInfo; //다음 시리즈 영상 정보
				var sesnList = data.sesnList; //시즌 영상 목록
				var prevSesnInfo = data.prevSesnInfo; //이전 시즌 영상 정보
				var nextSesnInfo = data.nextSesnInfo; //다음 시즌 영상 정보
				
				var prevSrisNum = -1; //이전 시리즈 영상순번
				var nextSrisNum = 0; //다음 시리즈 영상순번
				var prevSesnNum = -1; //이전 시즌 영상순번
				var nextSesnNum = 0; //다음 시즌 영상순번
				
				var html = "";
				if(sesnList != null && sesnList.length > 0){
					sesnYn = "Y";
					for(var i=0; i<sesnList.length; i++){
						html += '<div class="swiper-slide">'
						html += '	<div class="channel thumb-info">';
						html += '    	<div class="profile" style="background-image:url(../../_images/tv/@temp01.jpg);"></div>';
						html += '    	<div class="info">';
						html += '        	<div class="tit">'+ sesnList[i].ttl +'</div>';
						html += '    	</div>';
						html += '	</div>';
						html += '	<div name="thumbBox_'+ sesnList[i].vdId +'" class="thumb-box">';
						
						if(sesnList[i].vdId == nowVdId){
							prevSesnNum = i-1;
							nextSesnNum = i+1;
							
							$("#vdoTopPaging").html('<strong>'+ (i+1) +'</strong><em>/</em><span>'+ sesnList.length +'</span>');
						}
						
						if(sesnList[i].newYn == "Y"){
							html += '    	<i class="icon-n">N</i>';
						}
						
						var sesnBgUrl = "";
						if(sesnList[i].acPrflImgPath != null && sesnList[i].acPrflImgPath !== undefined){
							if(sesnList[i].acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
								sesnBgUrl = sesnList[i].acPrflImgPath;
							}else{
								sesnBgUrl = "${frame:optImagePath('"+ sesnList[i].acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
							}
						}
						//console.log("sesnList[i].progressBar ::: "+sesnList[i].progressBar);
						html += '    	<a href="#" class="thumb-img" onclick="fncTvDetail(\''+ sesnList[i].vdId +'\', \'S\'); return false;" style="background-image:url('+ sesnBgUrl +');" name="thumbImg_'+ sesnList[i].vdId +'" data-content="'+ sesnList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ sesnList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html += '       	<div class="time-tag"><span>'+ sesnList[i].acTotTimeStr +'</span></div>';
						if(Number(sesnList[i].progressBar) > 9){
							html += '       <div class="progress-bar" style="width:'+ sesnList[i].progressBar +'%;"></div>';
						}
						html += '    	</a>';
						html += '    	<div class="thumb-info">';
						html += '        	<div class="info">';
						html += '            	<div class="tlt">';
						html += '    				<a href="#" onclick="fncTvDetail(\''+ sesnList[i].vdId +'\', \'S\'); return false;" data-content="'+ sesnList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ sesnList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html +=							sesnList[i].ttl;
						html += '					</a>'
						html += '				</div>';
						html += '            	<div class="detail">';
						<%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거--%>
						//html += '                	<span class="read play">'+ fnComma(sesnList[i].hits) +'</span>';
						html += '                	<span class="read like">'+ fnComma(sesnList[i].likeCnt) +'</span>';
						html += '            	</div>';
						html += '        	</div>';
						html += '    	</div>';
						html += '	</div>';
						html += '</div>';
					}
				}else{
					srisYn = "Y";
					for(var i=0; i<srisList.length; i++){
						html += '<div class="swiper-slide">'
						html += '	<div class="channel thumb-info">';
						html += '    	<div class="profile" style="background-image:url(../../_images/tv/@temp01.jpg);"></div>';
						html += '    	<div class="info">';
						html += '        	<div class="tit">'+ srisList[i].ttl +'</div>';
						html += '    	</div>';
						html += '	</div>';
						html += '	<div name="thumbBox_'+ srisList[i].vdId +'" class="thumb-box">';
						
						if(srisList[i].vdId == nowVdId){
							prevSrisNum = i-1;
							nextSrisNum = i+1;
							
							$("#vdoTopPaging").html('<strong>'+ (i+1) +'</strong><em>/</em><span>'+ srisList.length +'</span>');
						}
						
						if(srisList[i].newYn == "Y"){
							html += '    	<i class="icon-n">N</i>';
						}
						
						var srisBgUrl = "";
						if(srisList[i].acPrflImgPath != null && srisList[i].acPrflImgPath !== undefined){
							if(srisList[i].acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
								srisBgUrl = srisList[i].acPrflImgPath;
							}else{
								srisBgUrl = "${frame:optImagePath('"+ srisList[i].acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
							}
						}
						//console.log("srisList[i].progressBar ::: "+srisList[i].progressBar);
						html += '    	<a href="#" class="thumb-img" onclick="fncTvDetail(\''+ srisList[i].vdId +'\', \'S\'); return false;" style="background-image:url('+ srisBgUrl +');" name="thumbImg_'+ srisList[i].vdId +'" data-content="'+ srisList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ srisList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html += '        	<div class="time-tag"><span>'+ srisList[i].acTotTimeStr +'</span></div>';
						if(Number(srisList[i].progressBar) > 9){
							html += '        <div class="progress-bar" style="width:'+ srisList[i].progressBar +'%;"></div>';
						}
						html += '    	</a>';
						html += '    	<div class="thumb-info">';
						html += '        	<div class="info">';
						html += '            	<div class="tlt">';
						html += '    				<a href="#" onclick="fncTvDetail(\''+ srisList[i].vdId +'\', \'S\'); return false;" data-content="'+ srisList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ srisList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html +=							srisList[i].ttl;
						html += '					</a>'
						html += '				</div>';
						html += '            	<div class="detail">';
						<%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거--%>
						//html += '                	<span class="read play">'+ fnComma(srisList[i].hits) +'</span>';
						html += '                	<span class="read like">'+ fnComma(srisList[i].likeCnt) +'</span>';
						html += '            	</div>';
						html += '        	</div>';
						html += '    	</div>';
						html += '	</div>';
						html += '</div>';
					}
				}
				
				if(nextSesnInfo !== null && nextSesnInfo !== undefined) {
					html += '<div class="swiper-slide season">'
					html += '	<div class="thumb-box">';
					html += '    	<div class="div-respon">';
					
					var nextSesnBgUrl = "";
					if(nextSesnInfo.acPrflImgPath != null && nextSesnInfo.acPrflImgPath !== undefined){
						if(nextSesnInfo.acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
							nextSesnBgUrl = nextSesnInfo.acPrflImgPath;
						}else{
							nextSesnBgUrl = "${frame:optImagePath('"+ nextSesnInfo.acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
						}
					}
					html += '        	<a href="#" class="thumb-img" onclick="fncTvDetail(\''+ nextSesnInfo.vdId +'\', \'S\'); return false;" style="background-image:url('+ nextSesnBgUrl +');" data-content="'+ nextSesnInfo.vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ nextSesnInfo.vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
					html += '            	<div class="season-list">';
					html += '                	<span>'+ fnComma(nextSesnInfo.vdCnt) +'</span>';
					html += '            	</div>';
					html += '        	</a>';
					html += '        	<div class="thumb-info">';
					html += '            	<div class="info">';
					html += '            		<div class="tlt">';
					html += '        				<a href="#" onclick="fncTvDetail(\''+ nextSesnInfo.vdId +'\', \'S\'); return false;" data-content="'+ nextSesnInfo.vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ nextSesnInfo.vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
					html +=								nextSesnInfo.sesnNm;
					html += '						</a>'
					html += '					</div>';
					html += '            	</div>';
					html += '        	</div>';
					html += '    	</div>';
					html += '	</div>';
					html += '</div>'
				}else if(nextSrisInfo !== null && nextSrisInfo !== undefined){
					html += '<div class="swiper-slide season">'
					html += '	<div class="thumb-box">';
					html += '    	<div class="div-respon">';
					
					var nextSrisBgUrl = "";
					if(nextSrisInfo.acPrflImgPath != null && nextSrisInfo.acPrflImgPath !== undefined){
						if(nextSrisInfo.acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
							nextSrisBgUrl = nextSrisInfo.acPrflImgPath;
						}else{
							nextSrisBgUrl = "${frame:optImagePath('"+ nextSrisInfo.acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
						}
					}
					html += '        	<a href="#" class="thumb-img" onclick="fncTvDetail(\''+ nextSrisInfo.vdId +'\', \'S\'); return false;" style="background-image:url('+ nextSrisBgUrl +');" data-content="'+ nextSrisInfo.vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ nextSrisInfo.vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
					html += '            	<div class="season-list">';
					html += '                	<span>'+ fnComma(nextSrisInfo.vdCnt) +'</span>';
					html += '            	</div>';
					html += '        	</a>';
					html += '        	<div class="thumb-info">';
					html += '            	<div class="info">';
					html += '            		<div class="tlt">';
					html += '        				<a href="#" onclick="fncTvDetail(\''+ nextSrisInfo.vdId +'\', \'S\'); return false;" data-content="'+ nextSrisInfo.vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ nextSrisInfo.vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
					html +=								nextSrisInfo.srisNm;
					html += '						</a>'
					html += '					</div>';
					html += '            	</div>';
					html += '        	</div>';
					html += '    	</div>';
					html += '	</div>';
					html += '</div>'
				}
				
				$("#listSrisSesn").html(html);
				
				if(boolPipNo){
					scrollActive(nowVdId); //현재 재생영상 표시 및 스크롤 이동
				}
				
				if(sesnYn == "Y"){
					//시즌 이전 영상ID
					if(prevSesnNum < 0){
						if(prevSesnInfo != null){
							prevSesnVdId = prevSesnInfo.vdId;
						}					
					}else{
						prevSesnVdId = sesnList[prevSesnNum].vdId;
					}
					
					//시즌 다음 영상ID
					if(nextSesnNum >= sesnList.length){
						if(nextSesnInfo != null){
							nextSesnVdId = nextSesnInfo.vdId;
						}
					}else{
						nextSesnVdId = sesnList[nextSesnNum].vdId;
					}
					
					if(prevSesnVdId == ""){
						//이전 시즌이 없는것이므로 이전시리즈 영상ID를 넣어준다.
						if(prevSrisInfo != null){
							prevSesnVdId = prevSrisInfo.vdId;
						}
					}
					
					if(nextSesnVdId == ""){
						//다음 시즌이 없는것이므로 다음시리즈 영상ID를 넣어준다.
						if(nextSrisInfo != null){
							nextSesnVdId = nextSrisInfo.vdId;
						}
					}
				}else{
					//시리즈 이전 영상ID
					if(prevSrisNum < 0){
						if(prevSrisInfo != null){
							prevSrisVdId = prevSrisInfo.vdId;
						}
					}else{
						prevSrisVdId = srisList[prevSrisNum].vdId;
					}
					
					//시리즈 다음 영상ID
					if(nextSrisNum >= srisList.length){
						if(nextSrisInfo != null){
							nextSrisVdId = nextSrisInfo.vdId;
						}
					}else{
						nextSrisVdId = srisList[nextSrisNum].vdId;
					}
				}
				
				//console.log("prevSesnVdId ::: >>> " + prevSesnVdId);
				//console.log("nextSesnVdId ::: >>> " + nextSesnVdId);
				//console.log("prevSrisVdId ::: >>> " + prevSrisVdId);
				//console.log("nextSrisVdId ::: >>> " + nextSrisVdId);
				
				<%--if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){
					var cookieData = document.cookie;
					if(cookieData.indexOf("popMwPlay=done") < 0){
						ui.confirm("3G/LTE 등으로 영상재생시<br>데이터 사용료가 발생할 수 있습니다.",{ // 컨펌 창 띄우기
							ycb:function(){
								autoPlayFlag = true;
								fncDetailVdoApi(); //플레이어 셋팅
								
								setCookie("popMwPlay", "done" , 24 );
							},
							ncb:function(){
								autoPlayFlag = false;
								fncDetailVdoApi(); //플레이어 셋팅
								
								setCookie("popMwPlay", "done" , 24 );
							},
							ybt:'재생',
							nbt:'취소'	
						});
					}else{
						fncDetailVdoApi(); //플레이어 셋팅
					}
				}else{--%>
					//if(tabGb == "A"){
						fncDetailVdoApi(); //플레이어 셋팅
					//}
				<%--}--%>
			}
			
			<!-- 시리즈 영상 플레이어 셋팅 -->
			function fncDetailVdoApi() {
				var event = {
					playing:fncPlayingSris //재생시작시 호출
					, pause:fncPauseSris // 일시정지시 호출
					, ended:fncEndedSris //재생 종료시 호출
					, muted:fncMutedSris //음소거 변화가 발생하면 호출 , 현재 상태값 전달
					, keepPlaying:fncKeepPlayingSris //영상 재생시 , 현재 재생위치 5초마다 보고
					, activeControlbar:fncActiveControlbarSris //컨트롤바가 활성/비활성시 호출
					, fullscreen:fncFullscreenSris //풀스크린 여부
				};
				
				if(sesnYn == "Y"){
					if(nextSesnVdId != ""){
						event.nextVideo = fncNextVideoSris //다음영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}else if(nextSrisVdId != ""){
						event.nextVideo = fncNextVideoSris //다음영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}
					
					if(prevSesnVdId != ""){
						event.prevVideo = fncPrevVideoSris //이전영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}else if(prevSrisVdId != ""){
						event.prevVideo = fncPrevVideoSris //이전영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}
				}else{
					if(nextSrisVdId != ""){
						event.nextVideo = fncNextVideoSris //다음영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}
					if(prevSrisVdId != ""){
						event.prevVideo = fncPrevVideoSris //이전영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
					}
				}
				
				var totTime = Number(acTotTime);
				var playTime = Number(acPlayTime);
				var startTime = 0;
				
				if(playTime < totTime){
					startTime = playTime;
				}
				
				//console.log("totTime ::: " + totTime);
				//console.log("playTime ::: " + playTime);
				//console.log("startTime ::: " + startTime);
				
				var deviceGb = "";
				if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
					deviceGb = "pc";
				}else{
					deviceGb = "mobile";
				}
				
				var adYn = false;
				if(srisAdYn == "Y"){
					adYn = true;
				}
				//console.log("srisAdYn ::: " + srisAdYn);
				//console.log("adYn ::: " + adYn);
				
				player = SGRPLAYER;
				player.setup('player', {
					height : "100%"
					, width : "100%"
					, video_id : outId
					, vtype : "mp4"
					, ui : deviceGb //UI 분기를 위하여 추가(mobile|pc)/현재 480px를 기점으로 모바일/pc ui가 자동 변경됨, 마우스액션같은건 분기처리됨
					, autoplay : autoPlayFlag //자동재생여부
					, start_time : startTime //입력된 초부터 시작(이어보기)
					, auto_next_play_event : autoNextPlayFlag //다음영상 자동재생 실행 여부
					, is_ad : adYn // 프리롤 광고 여부
					, uploader_id : sysRegr //업로드한 유저 아이디
					, viewer_id : "${session.mbrNo}" //시청하는 유저 아이디
					, controlBar: { //생략가능
						volumePanel : true  //볼륨컨트롤
						, playToggle : true //플레이 버튼
						, progressControl : true //프로그래시바
						, fullscreenToggle : true //플스크린버튼
						, playbackRateMenuButton : true //재생속도 버튼
						, pictureInPictureToggle : true  // PIP 버튼
						, timeDisplay : true //영상 시간 표시
						, frame_cover_fit : false //영상 프레임에 꽉채울지 여부
					}
					, events : event
			    });
				
				if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
					clearTimer();
				}
			}
			<!-- //시리즈 영상 플레이어 셋팅 -->
			<!-- 시리즈 영상 플레이어 이벤트 -->
			function fncPlayingSris(){
				//console.log('fncPlayingSris', '이벤트 실행');
				//console.log("isUserPauseClick", isUserPauseClick);
			}
			function fncPauseSris(){
				//console.log('fncPauseSris', '이벤트 실행');
				//console.log("isUserPauseClick", isUserPauseClick);
			}
			function fncEndedSris(){
				//console.log('fncEndedSris', '이벤트 실행');
				
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					//시청이력 저장
				  	petTvViewHist(nowVdId, mbrNo, acTotTime, 0);
				}
			}
			function fncMutedSris(state){
				if(state==true) {
				    //console.log('fncMutedSris', '음소거됨');
			    }else{
				    //console.log('fncMutedSris', '음소거해제');
			    }
			}
			function fncActiveControlbarSris(state){
				if(state==true) {
				    //console.log('fncActiveControlbarSris', '컨트롤바 보임');
			    }else{
				    //console.log('fncActiveControlbarSris', '컨트롤바 숨김');
			    }
			}
			function fncKeepPlayingSris(sec){
				//console.log('fncKeepPlayingSris', '시청보고 5초마다 / 현재시간 : '+sec);
				
				if(firstVdoHits){
					//조회수	증가
					$.ajax({
						type: 'POST',
						url: '/tv/series/updateVdoHits',
						async: false,
						dataType: 'json',
						data : {
							vdId : nowVdId //영상ID
						},
						success: function(data) {
							//console.log(data.actGubun);
						},
						error: function(request,status,error) {
							ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
						}
					});
					
					firstVdoHits = false;
				}
				
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					//시청이력 저장
				  	petTvViewHist(nowVdId, mbrNo, Math.floor(sec), 0);
				}
			}
			function fncNextVideoSris(){
				//console.log('fncNextVideoSris', '이벤트 실행');
				
		    	if(sesnYn == "Y"){
			    	nowVdId = nextSesnVdId;
			    }else{
			    	nowVdId = nextSrisVdId;
			    }
			    
		    	fncVideoEvent();
			}
			function fncPrevVideoSris(){
				//console.log('fncPrevVideoSris', '이벤트 실행');
				
		    	if(sesnYn == "Y"){
			    	nowVdId = prevSesnVdId;
			    }else{
			    	nowVdId = prevSrisVdId;
			    }
			    
		    	fncVideoEvent();
			}
			function fncFullscreenSris(state){
				if(state==true) {
			        //console.log('fncFullscreenSris', '풀스크린');
			    }else{
			        //console.log('fncFullscreenSris', '풀스크린 해제');
			        clearTimer();
			    }
			}
			<!-- //시리즈 영상 플레이어 이벤트 -->
			<%-- //###############################################시리즈 영상 목록 영역############################################### --%>
			
			
			
			
						
			<%-- ###############################################추천 영상 목록 영역############################################### --%>
			//추천 영상 목록 정보 셋팅
			function fncAdviceVdoList(data){
				var adviceVdoList = data.adviceVdoList; //시리즈 영상 목록
				
				var prevAdviceNum = -1; //이전 영상순번
				var nextAdviceNum = 0; //다음 영상순번
				
				var html = "";
				if(adviceVdoList != null && adviceVdoList.length > 0){
					for(var i=0; i<adviceVdoList.length; i++){
						var adSrisThumBgUrl = "";
						if(adviceVdoList[i].srisPrflImgPath != null && adviceVdoList[i].srisPrflImgPath !== undefined){
							if(adviceVdoList[i].srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
								adSrisThumBgUrl = adviceVdoList[i].srisPrflImgPath;
							}else{
								adSrisThumBgUrl = "${frame:optImagePath('"+ adviceVdoList[i].srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_430)}";
							}
						}
						
						html += '<div class="swiper-slide addTit">';
						html += '    <div class="channel-info  k0420" onclick="fncGoSrisList(\''+ adviceVdoList[i].srisNo +'\');" style="cursor:pointer;"><!-- 04.20 : 수정 -->';
						html += '        <div class="round-img-pf" style="background-image:url('+ adSrisThumBgUrl +');"></div>';
						html += '        <div class="ch-name">'+ adviceVdoList[i].srisNm +'</div>';
						html += '    </div>';
						html += '    <div class="channel thumb-info">';
						html += '        <div class="profile" style="background-image:url('+ adSrisThumBgUrl +');"></div>';
						html += '        <div class="info">';
						html += '            <div class="tit">'+ adviceVdoList[i].srisNm +'</div>';
						html += '        </div>';
						html += '    </div>';
						html += '    <div name="thumbBox_'+ adviceVdoList[i].vdId +'" class="thumb-box">';
						
						if(adviceVdoList[i].vdId == nowVdId){
							prevAdviceNum = i-1;
							nextAdviceNum = i+1;
						}
						
						if(adviceVdoList[i].newYn == "Y"){
							html += '    <i class="icon-n">N</i>';	
						}
						
						var adviceBgUrl = "";
						if(adviceVdoList[i].acPrflImgPath != null && adviceVdoList[i].acPrflImgPath !== undefined){
							if(adviceVdoList[i].acPrflImgPath.indexOf('cdn.ntruss.com') != -1){
								adviceBgUrl = adviceVdoList[i].acPrflImgPath;
							}else{
								adviceBgUrl = "${frame:optImagePath('"+ adviceVdoList[i].acPrflImgPath +"', frontConstants.IMG_OPT_QRY_390)}";
							}
						}
						//console.log("adviceVdoList[i].progressBar ::: "+adviceVdoList[i].progressBar);
						html += '        <a href="#" class="thumb-img" onclick="fncTvDetail(\''+ adviceVdoList[i].vdId +'\', \'A\'); return false;" style="background-image:url('+ adviceBgUrl +');" name="thumbImg_'+ adviceVdoList[i].vdId +'" data-content="'+ adviceVdoList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ adviceVdoList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html += '        	<div class="time-tag"><span>'+ adviceVdoList[i].acTotTimeStr +'</span></div>';
						if(Number(adviceVdoList[i].progressBar) > 9){
							html += '        	<div class="progress-bar" style="width:'+ adviceVdoList[i].progressBar +'%;"></div>';
						}
						html += '        </a>';
						html += '        <div class="thumb-info k0420"><!-- 04.20 : 수정 -->';
						html += '            <div class="info">';
						//html += '                <div class="tlt"><em>'+ (adviceVdoList[i].rate == "null" ? "0" : adviceVdoList[i].rate) +'%</em>'+ adviceVdoList[i].ttl +'</div>';
						html += '				 <div class="tlt">';
						html += '        		 	 <a href="#" onclick="fncTvDetail(\''+ adviceVdoList[i].vdId +'\', \'A\'); return false;" data-content="'+ adviceVdoList[i].vdId +'" data-url="/tv/series/indexTvDetail?vdId='+ adviceVdoList[i].vdId +'&sortCd='+ sortCd +'&listGb='+ listGb +'">';
						html +=					         adviceVdoList[i].ttl;
						html += '					 </a>'
						html += '				 </div>';
						html += '				 <div class="detail type-only">';
						<%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거--%>
						//html += '    				 <span class="read play">'+ fnComma(adviceVdoList[i].hits) +'</span>';
						html += '    			 	 <span class="read like">'+ fnComma(adviceVdoList[i].likeCnt) +'</span>';
						html += '				 </div>';
						html += '            </div>';
						html += '        </div>';
						html += '    </div>';
						html += '</div>';
					}
				}
				
				$("#listAdvice").html(html);
				
				//scrollActive(nowVdId); //현재 재생영상 표시 및 스크롤 이동
				//스크롤 위치 처음으로 이동처리
				if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){ //PC
					$("#listAdvice").parent().animate({"scrollTop":"0px"}, 0);
				}else{
					$("#listAdvice").parent().animate({"scrollLeft":"0px"}, 0);
				}
				
				if(prevAdviceNum >= 0){
					prevAdviceVdId = adviceVdoList[prevAdviceNum].vdId;
				}
				
				if(nextAdviceNum < adviceVdoList.length){
					nextAdviceVdId = adviceVdoList[nextAdviceNum].vdId;
				}
				
				//console.log("prevAdviceVdId ::: >>> " + prevAdviceVdId);
				//console.log("nextAdviceVdId ::: >>> " + nextAdviceVdId);
				
				/*if(tabGb == "A"){
					fncAdviceVdoApi(); //플레이어 셋팅
				}*/
			}
			
			<!-- 추천 영상 플레이어 셋팅 -->
			<!-- 추천 영상 로직 변경으로 사용아함(추천 영상 영상 재생시 시리즈 영상 탭으로 이동 후 시리즈영상이 재생되면됨) -->
			<%--function fncAdviceVdoApi(){
				var event = {
					playing:fncPlayingAdvice //재생시작시 호출
					, pause:fncPauseAdvice // 일시정지시 호출
					, ended:fncEndedAdvice //재생 종료시 호출
					, muted:fncMutedAdvice //음소거 변화가 발생하면 호출 , 현재 상태값 전달
					, keepPlaying:fncKeepPlayingAdvice //영상 재생시 , 현재 재생위치 5초마다 보고
					, activeControlbar:fncActiveControlbarAdvice //컨트롤바가 활성/비활성시 호출
					, fullscreen:fncFullscreenAdvice //풀스크린 여부
				};
				
				if(prevAdviceVdId != ""){
					event.prevVideo = fncPrevVideoAdvice //이전영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
				}
				
				if(nextAdviceVdId != ""){
					event.nextVideo = fncNextVideoAdvice //다음영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
				}
				
				var totTime = Number(acTotTime);
				var playTime = Number(acPlayTime);
				var startTime = 0;
				
				if(playTime < totTime){
					startTime = playTime;
				}
				
				var deviceGb = "";
				if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
					deviceGb = "pc";
				}else{
					deviceGb = "mobile";
				}
				
				var adYn = false;
				if(srisAdYn == "Y"){
					adYn = true;
				}
				//console.log("srisAdYn ::: " + srisAdYn);
				//console.log("adYn ::: " + adYn);
				
				player = SGRPLAYER;
				player.setup('player', {
					height : "100%"
					, width : "100%"
					, video_id : outId
					, vtype : "mp4"
					, ui : deviceGb //UI 분기를 위하여 추가(mobile|pc)/현재 480px를 기점으로 모바일/pc ui가 자동 변경됨, 마우스액션같은건 분기처리됨
					, autoplay : autoPlayFlag //자동재생여부
					, start_time : startTime //입력된 초부터 시작(이어보기)
					, auto_next_play_event : autoNextPlayFlag //다음영상 자동재생 실행 여부
					, is_ad : adYn // 프리롤 광고 여부
					, uploader_id : sysRegr //업로드한 유저 아이디
					, viewer_id : "${session.mbrNo}" //시청하는 유저 아이디
					, controlBar: { //생략가능
						volumePanel : true  //볼륨컨트롤
						, playToggle : true //플레이 버튼
						, progressControl : true //프로그래시바
						, fullscreenToggle : true //플스크린버튼
						, playbackRateMenuButton : true //재생속도 버튼
						, pictureInPictureToggle : true  // PIP 버튼
						, timeDisplay : true //영상 시간 표시
						, frame_cover_fit : false //영상 프레임에 꽉채울지 여부
					}
					, events : event
			    });
			}
			<!-- //추천 영상 플레이어 셋팅 -->
			<!-- 추천 영상 플레이어 이벤트 -->
			function fncPlayingAdvice(){
			    //console.log('fncPlayingAdvice', '이벤트 실행');
			}
			function fncPauseAdvice(){
			    //console.log('fncPauseAdvice', '이벤트 실행');
			}
			function fncEndedAdvice(){
			    //console.log('fncEndedAdvice', '이벤트 실행');
			    
			    var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					//시청이력 저장
				  	petTvViewHist(nowVdId, mbrNo, acTotTime, 0);
				}
			}
			function fncMutedAdvice(state){
			    if(state==true) {
				    //console.log('fncMutedAdvice', '음소거됨');
			    }else{
				    //console.log('fncMutedAdvice', '음소거해제');
			    }
			}
			function fncActiveControlbarAdvice(state){
			    if(state==true) {
				    //console.log('fncActiveControlbarAdvice', '컨트롤바 보임');
			    }else{
				    //console.log('fncActiveControlbarAdvice', '컨트롤바 숨김');
			    }
			}
			function fncKeepPlayingAdvice(sec){
			    //console.log('fncKeepPlayingAdvice', '시청보고 5초마다 / 현재시간 : '+sec);
			    
			    if(firstVdoHits){
					//조회수	증가
					$.ajax({
						type: 'POST',
						url: '/tv/series/updateVdoHits',
						async: false,
						dataType: 'json',
						data : {
							vdId : nowVdId //영상ID
						},
						success: function(data) {
							//console.log(data.actGubun);
						},
						error: function(request,status,error) {
							ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
						}
					});
					
					firstVdoHits = false;
				}
				
			    var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					//시청이력 저장
				  	petTvViewHist(nowVdId, mbrNo, Math.floor(sec), 0);
				}
			}
			function fncNextVideoAdvice(){
			    //console.log('fncNextVideoAdvice',' 이벤트 들어옴 ');
			    
		    	nowVdId = nextAdviceVdId;
		    	
		    	fncVideoEvent();
			}
			function fncPrevVideoAdvice(){
			    //console.log('fncPrevVideoAdvice', ' 이벤트 들어옴 ');
			    
		    	nowVdId = prevAdviceVdId;
			    
		    	fncVideoEvent();
			}
			function fncFullscreenAdvice(state){
			    if(state==true) {
			        //console.log('fncFullscreenAdvice', '풀스크린');
			    }else{
			        //console.log('fncFullscreenAdvice', '풀스크린 해제');
			    }
			}--%>
			<!-- //추천 영상 플레이어 이벤트 -->
			<%-- //###############################################추천 영상 목록 영역############################################### --%>
			
			
			
			
			function fncVideoEvent(){
		    	history.pushState({vd_id : nowVdId}, "", "/tv/series/indexTvDetail?vdId="+ nowVdId +"&sortCd="+ sortCd +"&listGb="+ listGb);
		    	
		    	fncAutoFlag();
			}
			
			//영상 상세화면
			function fncTvDetail(vdId, gb){
				tabGb = gb; //현재 재생되는 영상의 탭 구분(S:시리즈 영상, A:추천 영상)
				
				nowVdId = vdId;
				
				fncVideoEvent();
			}
			
			//좋아요 저장/해제
			function fncLike(obj){
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					petTvLikeDibs(obj, nowVdId, mbrNo, "10"); //10:좋아요, 20:찜
					
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
						var data = {
							vdId : nowVdId,
							intrGbCd : "10"
						};
						
						// 데이터 세팅
						toNativeData.func = "onCallMainScript";
						toNativeData.callback = "appCallMainScript";
						toNativeData.data = JSON.stringify(data);
						// APP 호출
						toNative(toNativeData);
					}
				}else{
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
					    ycb:function(){ // 확인 버튼 클릭
					        // 로그인 페이지로 이동 (로그인 후 returnUrl로 이동);
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + encodeURIComponent("?vdId=" + nowVdId + "&sortCd=" + sortCd + "&listGb=" + listGb);
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
					    nbt:'취소'
					});
				}
			}
			
			//찜 저장/해제
			function fncBookmark(obj){
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
						petTvLikeDibs(obj, nowVdId, mbrNo, "20", "Y"); //10:좋아요, 20:찜
						
						var data = {
							vdId : nowVdId,
							intrGbCd : "20"
						};
						
						// 데이터 세팅
						toNativeData.func = "onCallMainScript";
						toNativeData.callback = "appCallMainScript";
						toNativeData.data = JSON.stringify(data);
						// APP 호출
						toNative(toNativeData);
					}else{
						petTvLikeDibs(obj, nowVdId, mbrNo, "20", "N"); //10:좋아요, 20:찜
					}
				}else{
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
					    ycb:function(){ // 확인 버튼 클릭
					        // 로그인 페이지로 이동 (로그인 후 returnUrl로 이동);
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + encodeURIComponent("?vdId=" + nowVdId + "&sortCd=" + sortCd + "&listGb=" + listGb);
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
					    nbt:'취소'
					});
				}
			}
			
			//App일때 '마이 찜' 화면으로 화면 닫고 이동해야해서 추가된 함수
			function fncAppCloseMoveZzim(){
				var callParam = "";
				if(sortCd != ""){
					callParam = nowVdId+"."+sortCd+"."+listGb;
				}else{
					callParam = nowVdId+"."+listGb;
				}
				
				// 데이터 세팅
				toNativeData.func = "onCloseMovePage";
				toNativeData.moveUrl = "${view.stDomain}/mypage/tv/myWishList?callParam="+callParam;
				// APP 호출
				toNative(toNativeData);
			}
			
			//App일때 로그인 화면으로 화면 닫고 이동해야해서 추가된 함수
			function fncAppCloseMoveLogin(url){
				// 데이터 세팅
				toNativeData.func = "onCloseMovePage";
				toNativeData.moveUrl = "${view.stDomain}/indexLogin?returnUrl="+url;
				// APP 호출
				toNative(toNativeData);
			}
			
			//공유하기
			function fncVdoShare(id, gb) {
				petTvShare(id, nowVdId, '30');
				
				if(gb == "app"){
					// 데이터 세팅
					toNativeData.func = "onShare";
					toNativeData.image = $("#appImage").val();
					toNativeData.subject = $("#appSubject").val();
					toNativeData.link = $("#appLink").val();
					// 호출
					toNative(toNativeData);
				}
			}
			
			//펫TV 메인, 시리즈목록, 영상목록, 최근 시청한 영상으로 이동
			function fncToMove(flag){
				//pc, mw일때 이전페이지로 이동되어야함.
				if(flag == "web"){
					storageHist.goBack();
					
					/*if(listGb.indexOf("HOME") !== -1){
						//펫TV 홈
						location.href="/tv/home/";
					}else if(listGb.indexOf("SRIS") !== -1){
						var param = listGb.split("_");
						
						//시리즈목록
						location.href="/tv/series/petTvSeriesList?srisNo="+param[1]+"&sesnNo=1";
					}else if(listGb.indexOf("VDO") !== -1){
						var dispCornNo = "";
						var param = listGb.split("_");
						if(param[1] == "F"){
							//맞춤
							dispCornNo = "569"
						}else if(param[1] == "N"){
							//신규
							dispCornNo = "567"
						}else if(param[1] == "P"){
							//인기
							dispCornNo = "568"
						}
						
						//영상목록-맞춤, 신규, 인기
						location.href="/tv/petTvList?dispCornNo="+dispCornNo;
					}else if(listGb.indexOf("RECENT") !== -1){
						//최근 시청한 영상목록
						location.href="/tv/series/indexTvRecentVideo";
					}else if(listGb.indexOf("TAG") !== -1){
						var param = listGb.split("_");
						
						//영상목록-태그
						location.href="/tv/hashTagList?tagNo="+param[2];
					}else if(listGb.indexOf("COLL") !== -1){
						var param = listGb.split("_");
						
						//태그 모아보기목록
						location.href="/tv/collectTags?tagNo="+param[1];
					}else if(listGb.indexOf("WISH") !== -1){
						//마이찜-TV목록
						location.href="/mypage/tv/myWishList";
					}else if(listGb.indexOf("GOODS") !== -1){
						var param = listGb.split("_");
						
						//상품상세
						location.href="/goods/indexGoodsDetail?goodsId="+param[1];
					}else if(listGb.indexOf("SEARCH") !== -1){
						var backToSrch = $.cookie("backToSrch");
						
						//검색
						location.href = (backToSrch == "" || backToSrch == undefined)?"/commonSearch":backToSrch;
					}else if(listGb.indexOf("LOG") !== -1){
						//펫로그 홈
						location.href="/log/home/";
					}else if(listGb.indexOf("VT") !== -1){
						var param = listGb.split("_");
						
						//영상목록-시리즈 TAG/미고정, 동영상 TAG/미고정
						location.href="/tv/tagVodList?dispCornNo="+param[1];
					}else{
						//값이 없으면 펫TV 홈으로
						location.href="/tv/home/";
					}*/
				}
				//App일때 PIP 모드 실행되야함.
				else if(flag == "app"){
					fncAppClassHide("N");
					
					// 데이터 세팅
					toNativeData.func = "onShowPIP";
					toNativeData.callback = "fncClosePIP";
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}" == "true"){
						if (window.matchMedia('(orientation: portrait)').matches) {
							var pipWidth = 190;
							var pipHeight = 106;
							var screenWidth = Math.floor(window.innerWidth*0.6);
							
							var reSizeWidth = screenWidth;
							var reSizeHeight = Math.floor(pipHeight * (screenWidth / pipWidth));
							
							toNativeData.width = reSizeWidth;
							toNativeData.height = reSizeHeight;
						}else{
							var pipWidth = 190;
							var pipHeight = 106;
							var screenWidth = Math.floor(window.innerHeight*0.6);
							
							var reSizeWidth = screenWidth;
							var reSizeHeight = Math.floor(pipHeight * (screenWidth / pipWidth));
							
							toNativeData.width = reSizeWidth;
							toNativeData.height = reSizeHeight;
						}
					}else{
						toNativeData.width = "";
						toNativeData.height = "";
					}
					// APP 호출
					toNative(toNativeData);
				}
				//APP이지만 PIP모드 실행불가일때 페이지 닫기
				//onNewPage를 통해서 연 화면만 닫을수 있음, 영상 상세는 onNewPage를 통해서 열기때문에 호출
				else if(flag == "no_pip"){
					// 데이터 세팅
					toNativeData.func = "onClose";
					// APP 호출
					toNative(toNativeData);
				}
				//APP이지만 Push 등으로 진입시 X버튼 클릭시 펫TV 홈으로 이동하도록 해야함.
				else if(flag == "tv_home"){
					location.href = "/tv/home/";
				}
			}
			
			// 하단바 댓글 버튼 클릭 시 댓글 등록 textarea focus (PC)
			function fncAplyContentFocus() {
				$("#aplyContent").focus();
			}
			
			// 하단바 댓글 버튼 클릭 시 댓글 layer open (MO, APP)
			function fncAplyLayerOpen() {
				$("#mobileAppScrollArea").scrollTop(0);
				selectTvDetailReplyList('Y', nowVdId); // 댓글 정보
				ui.commentBox.open(".tvcommentBox");
				ui.lock.using(true); //댓글 레이어 오픈 시 body 스크롤 lock
			}
			
			//App에서 PIP 해제시 호출, 미노출부분 노출처리
			function fncClosePIP(){
				fncAppClassHide("Y");
				
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					$.ajax({
						type: 'POST',
						url: '/tv/series/selectVdoMbrLikeMarkCheck',
						dataType: 'json',
						data : {
							vdId : nowVdId //영상ID
						},
						success: function(data) {
							if(data.likeMarkCheck == "A"){
								$("#video_like").addClass("on");
								$("#video_mark").addClass("on");
							}else if(data.likeMarkCheck == "L"){
								$("#video_like").addClass("on");
								$("#video_mark").removeClass("on");
							}else if(data.likeMarkCheck == "M"){
								$("#video_like").removeClass("on");
								$("#video_mark").addClass("on");
							}else if(data.likeMarkCheck == "N"){
								$("#video_like").removeClass("on");
								$("#video_mark").removeClass("on");
							}
							
							$("#video_like").html(fnComma(data.likeCnt));
						},
						error: function(request,status,error) {
							ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
						}
					});
				}
			}
			
			//App에서 PIP 호출시 영상영역을 제외한 나머지 미노출 처리
			function fncAppClassHide(flag){
				if(flag == "Y"){
					boolPipNo = true;
					
					$(".top-area").show(); //제목 영역
					$(".tab-area").show(); //탭 영역(시리즈 영상목록, 추천 영상)
					$(".tabWrap").show(); //탭 영역
					$(".div-right").show(); //영상정보 영역
					$("#video_detail").show(); //영상상세정보 영역
					$(".bottom-bar").show(); //하단바 영역
					$(".pop-relation-box").show(); //mo일때 연관상품 영역
					$(".type01").show(); //댓글 영역
					
					//App PIP 해제
					$("#wrap").removeAttr("style");
					//$(".videoAndListWrap").removeAttr("style");
					//$(".video-area").removeAttr("style");
					//$(".video-palyer").removeAttr("style");
					$("#player").removeAttr("style");
					
					$("body, html").css("overflow-y", "");
					//$(".inr").css("overflow-y", "");
					
					//console.log("fncAppClassHide");
					clearTimer();
					
					scrollActive(nowVdId);
				}else{
					boolPipNo = false;
					
					$(".top-area").hide(); //제목 영역
					$(".tab-area").hide(); //탭 영역(시리즈 영상목록, 추천 영상)
					$(".tabWrap").hide(); //탭 영역
					$(".div-right").hide(); //영상정보 영역
					$("#video_detail").hide(); //영상상세정보 영역
					$(".bottom-bar").hide(); //하단바 영역
					$(".pop-relation-box").hide(); //mo일때 연관상품 영역
					$(".type01").hide(); //댓글 영역
					
					//App PIP 실행
					$("#wrap").css("min-width", "0px");
					//$(".videoAndListWrap").css("height", "auto");
					//$(".video-area").css("height", "auto");
					//$(".video-palyer").css("padding-bottom", "0");
					$("#player").css("position", "inherit");
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}" == "true"){
						if (window.matchMedia('(orientation: portrait)').matches) {
							var pipWidth = 190;
							var pipHeight = 106;
							var screenWidth = Math.floor(window.innerWidth*0.6);
							
							var reSizeWidth = screenWidth;
							var reSizeHeight = Math.floor(pipHeight * (screenWidth / pipWidth));
						}else{
							var pipWidth = 190;
							var pipHeight = 106;
							var screenWidth = Math.floor(window.innerHeight*0.6);
							
							var reSizeWidth = screenWidth;
							var reSizeHeight = Math.floor(pipHeight * (screenWidth / pipWidth));
						}
						
						$("#player").css("width", reSizeWidth);
						$("#player").css("height", reSizeHeight);
					}else{
						$("#player").css("width", "100%");
						$("#player").css("height", "100%");
					}
					
					$("body, html").css("overflow-y", "hidden");
					//$(".inr").css("overflow-y", "hidden");
				}
			}
			
			//이미지 base64 변환
			function imgToBase64ByFileReader(url){
				var width = 130;
				var height = 73;
				
				return new Promise((resolve, reject) => {
					var image = new Image()
					image.crossOrigin="*";
					image.onload = () => {
				    	var w = image.naturalWidth > width ? width : image.naturalWidth;
				    	var h = image.naturalHeight > height ? height : image.naturalHeight;
				    	
				    	var canvas = document.createElement('canvas');
				      	canvas.width = w;
				      	canvas.height = h;
				      	canvas.getContext('2d').drawImage(image, 0, 0, w, h);
				      	
				      	var uri = canvas.toDataURL();
				      	resolve(uri);
					}
					
					image.src = url;
				});
			}
			
			//시리즈목록 이동
			function fncGoSrisList(srisNo){
				if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
					var callParam = "";
					if(sortCd != ""){
						callParam = nowVdId+"."+sortCd+"."+listGb;
					}else{
						callParam = nowVdId+"."+listGb;
					}
					
					// 데이터 세팅
					toNativeData.func = "onCloseMovePage";
					toNativeData.moveUrl = "${view.stDomain}/tv/series/petTvSeriesList?srisNo="+ srisNo +"&sesnNo=1&callParam="+callParam;
					// APP 호출
					toNative(toNativeData);
				}else{
					location.href="/tv/series/petTvSeriesList?srisNo="+ srisNo +"&sesnNo=1";
					//storageHist.goBack("/tv/series/petTvSeriesList?srisNo="+ srisNo +"&sesnNo=1");
				}
			}
			
			//태그목록 이동
			function fncGoTagList(tagNo){
				if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
					var callParam = "";
					if(sortCd != ""){
						callParam = nowVdId+"."+sortCd+"."+listGb;
					}else{
						callParam = nowVdId+"."+listGb;
					}
					
					// 데이터 세팅
					toNativeData.func = "onCloseMovePage";
					toNativeData.moveUrl = "${view.stDomain}/tv/collectTags?tagNo="+tagNo+"&callParam="+callParam;
					// APP 호출
					toNative(toNativeData);
				}else{
					location.href="/tv/collectTags?tagNo="+tagNo;
					//storageHist.goBack("/tv/collectTags?tagNo="+tagNo);
				}
			}
			
			//탭 클릭
			function fncClickTab(obj){
				ui.tab2(obj);
			}
			
			//타이머셋팅
			function setTimer(){
				if(seconds > 0){
					//console.log("seconds ::: " + seconds);
					seconds--;
					myTimer = setTimeout("setTimer()", 1000);
				}else{
					seconds = 5;
					$("#hideAfter3Sec").addClass("off");
				}
			}
			
			//타이머초기화
			function clearTimer(){
				if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
					if($("#hideAfter3Sec").hasClass("off")){
						//console.log("숨겨져있어");
						$("#hideAfter3Sec").removeClass("off");
						clearTimeout(myTimer);
						setTimer();
					}else{
						//console.log("보이고있어");
						clearTimeout(myTimer);
						seconds = 5;
						setTimer();
					}
            	}
			}
			
			//쿠기 저장
			function setCookie( name, value, expirehours ) {
				var todayDate = new Date();
				todayDate.setHours( todayDate.getHours() + expirehours );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
		</script>
		<style>
			/*App PIP 실행으로 추가*/
	        /*@media (max-width:230px)  {
		        body,html{overflow:hidden}
		        video{object-fit:cover}
	        }*/
	        
	        /*
	        @media (min-width:230px)  {
	            body,html{overflow:auto}
	        }
	        */
		</style>
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content">
		<input type="hidden" id="appImage" value=""/>
		<input type="hidden" id="appSubject" value=""/>
		<input type="hidden" id="appLink" value=""/>
		
		<!-- content 내용 부분입니다.	-->	
		<!-- 필요에 따라 로케이션 추가 : jsp:include page="/WEB-INF/tiles/b2c/include/location.jsp" -->
		
		<main class="container page tv detail" id="container">
            <div class="inr" id="hideAfter3Sec">
            	<div class="off-ly">
	            	<%--<!--App pip 테스트용-->
	            	<button type="button" onclick="fncClosePIP();">ShowShowShow</button>
	            	--%>
	                <!-- 본문 -->
					<div class="contents" id="contents">
						<!-- PC 타이틀 영역 -->
						<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
							<tiles:putAttribute name="header.title"/>
						</c:if>
						<!-- top-area -->
						<div class="top-area">
	                        <div class="div-flex">
	                            <p id="video_title"></p>
	                            <c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
										<c:if test="${view.twcUserAgent eq true}">
										<button class="btn-close app" id="btnClose" onclick="fncToMove('no_pip')"><span>닫기</span></button>
										</c:if>
										<c:if test="${view.twcUserAgent eq false}">
										<button class="btn-close" id="btnClose" onclick="fncToMove('app')"><span>닫기</span></button>
										</c:if>
									</c:when>
									<c:otherwise>
										<button class="btn-close app" id="btnClose" onclick="fncToMove('web');"><span>닫기</span></button>
									</c:otherwise>
								</c:choose>
	                        </div>
	    
	                        <div class="thumb-info">
	                            <div id="sris_thum" class="round-img-pf" style="cursor:pointer;" onclick=""></div>
	                            <div class="info">
	                                <div class="dash">
	                                    <span id="sris_name" class="name" style="cursor:pointer;" onclick=""></span>
	                                    <%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거
	                                    <span>
	                                        재생수 <em id="player_count"></em>
	                                    </span>--%>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <!-- //top-area -->
	                    
	                    <div class="videoAndListWrap">
	                        <!-- 동영상 영역 -->
	                        <div class="video-area">
	                            <div class="video-palyer">
	                                <div class="video" id="player"></div>
	                            </div>
	                        </div>
	                        <!-- //동영상 영역 -->
	                        
	                        <!-- 탭 wrap -->
	                        <div class="tab-area">
	                            <!-- tab wrap -->
	                            <div class="tabWrap">
	                                <!-- tap header -->
	                                <div class="head" style="padding:0 20px;">
	                                    <ul>
	                                        <li id="tab_sris" class="active" onclick="fncClickTab(this);"><span>시리즈 영상</span></li>
	                                        <li id="tab_tv" onclick="fncClickTab(this);"><span>추천 영상</span></li>
	                                    </ul>
	                                    <!-- APETQA-6030 210809 lju02 -->
                                        <div class="div-right hide_pc">
			                                <button class="btn-video-layer">영상정보</button> <!-- 버튼 클릭시 on 클래스 추가 -->
			                            </div>
			                            <!-- //APETQA-6030 210809 lju02 -->
	                                </div>
	                                <!-- //tab header -->
	                                <!-- tab content -->
	                                <div class="con">
	                                    <ul>
	                                    	<!-- 시리즈 영상(시즌) 영역 -->
	                                        <li>
	                                        	<!-- [시리즈명] 시즌명 -->
	                                            <div class="video-top" id="vdoTop">
	                                               	<p class="tit"><em id="video_list_title"></em></p>
	                                                <div class="paging" id="vdoTopPaging">
	                                                    <%--<strong id="nowNumber">2</strong>
	                                                    <em>/</em>
	                                                    <span id="totNumber">10</span>--%>
	                                                </div>
	                                            </div>
	                                            <!-- //[시리즈명] 시즌명 -->
	                                            <!-- 시리즈 영상(시즌) 목록 -->
	                                            <div class="tvSlid">
	                                                <div class="innerWrap" id="listSrisSesn">
	                                                </div>
	                                            </div>
	                                            <!-- //시리즈 영상(시즌) 목록 -->
	                                        </li>
	                                        <!-- //시리즈 영상(시즌) 영역 -->
	                                        
	                                        <!-- 추천 영상 영역 -->
	                                        <li class="k_overAuto_0420"><!-- 04.20 : 수정 -->
	                                        	<!-- 추천 영상 목록 -->
	                                            <div class="tvSlid"> 
	                                                <div class="innerWrap" id="listAdvice">
	                                                </div>
	                                            </div>
	                                            <!-- //추천 영상 목록 -->
	                                        </li>
	                                        <!-- //추천 영상 영역 -->
	                                    </ul>
	                                </div>
	                                <!-- //tab content -->
	                            </div>
	                            <!-- // tab wrap -->
	                        </div>
	                        <!-- tab-area -->
	                        
	                        <!-- 영상정보 레이아웃 -->
	                        <div class="div-right hide_mo">	<!-- APETQA-6030 210809 lju02 -->
	                            <button class="btn-video-layer">영상정보</button> <!-- 버튼 클릭시 on 클래스 추가 -->
	                        </div>
	                        <div class="tvVideoInfoBoth layer-detail">
	                        	<!-- 영상 상세정보 영역 -->
	                            <div id="video_detail">
	                            </div>
	                            <!-- //영상 상세정보 영역 -->
	                        </div>
	                        <!-- // 영상정보 레이아웃 -->
	                    </div>
					</div><!-- contents -->
				</div><!-- off-ly -->
            </div><!-- inr -->
            
            <!-- 하단바(좋아요, 댓글, 공유, 북마크 레이어) -->
            <div class="bottom-bar">
                <div class="inner">
                    <ul class="bar-btn-area">
                    	<li class="like_li">
                            <button id="video_like" class="btn-like" onclick="fncLike(this);" data-content="" data-url="fncLike(this);"></button>
                        </li>
                        <li class="comment_li">
                            <button id="video_reply" class="btn-comment" onclick="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'fncAplyContentFocus();' : 'fncAplyLayerOpen();' }"
                             data-url="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'fncAplyContentFocus();' : 'fncAplyLayerOpen();' }" data-content=""></button>
                        </li>
                        <li class="share_li">
                        	<c:choose>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
									<button class="btn-share" id="vdoClipboard" onclick="fncVdoShare('null', 'app');" data-content="" data-url="fncVdoShare('null', 'app');"><span>공유</span></button>
								</c:when>
								<c:otherwise>
                             		<button class="btn-share" id="vdoClipboard" data-message="링크가 복사되었어요"  data-clipboard-text="" onclick="fncVdoShare(this.id, 'web');" data-content="" data-url="fncVdoShare(this.id, 'web');"><span>공유</span></button>
								</c:otherwise>
							</c:choose>
                        </li>
                        <li class="bookmark_li">
                            <button id="video_mark" class="btn-bookmark" onclick="fncBookmark(this);" data-content="" data-url="fncBookmark(this);"><span>찜</span></button>
                        </li>
                    </ul>
                    <buttron class="tvConnectedTing" style="display:none;">연관상품</buttron>
                    <div class="btn-with-wrap" style="display:none;">
                        <button id="videoTing" class="btn-with-prd" data-content="" data-url="">
                            <strong id="goodsThums" style="background-image:url(../../_images/tv/@temp01.jpg);"></strong>
                        </button>
                        <span class="num" id="goodsNum">0</span>
                    </div>
                </div>
            </div>
            <!-- //하단바(좋아요, 댓글, 공유, 북마크 레이어) -->
            
            <!-- 연관상품 레이어-->
            <!-- // 연관상품 레이어-->
            
            <!-- 댓글 -->
           	<jsp:include page="./include/tvDetailReplyListView.jsp" />
            <!-- //댓글 -->
            
            <!-- 연관상품 장바구니 -->
            <!-- //연관상품 장바구니 -->
		            
        </main><!-- container -->
        
        <%--pc에서 상담톡 안보이도록 처리-2021.04.30
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>
        --%>
	</tiles:putAttribute>
	
	<%-- 
	Tiles popup put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="layerPop">
		<!-- popup 내용 부분입니다. -->
		<!-- s : 댓글 신고 팝업 -->
		<form name="tvDetailReplyRptpForm" id="tvDetailReplyRptpForm" method="post">
			<article class="popLayer a popSample1 pc_popSize_500" id="popReportPetTvReply">
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">신고 접수<button type="button" class="btnPopClose" onclick="fncReplyRptpPopClose();">닫기</button></h1>
						</div>
					</div>
					<div class="pct h_auto_p">
						<main class="poptents">
							<div class="lay-gray-box">
								신고접수 시 운영정책에 따라 검토 후 해당글이 삭제됩니다.<br />
								신고 관련된 자세한 사항은 고객센터로 연락주세요.
							</div>
							<div class="member-input">
								<ul class="list">
									<li>
										<strong class="tit mb18">신고 사유</strong>
										<div class="flex-wrap">
											<label class="radio"><input type="radio" name="rptpRsnCd" value="${frontConstants.RPTP_RSN_10 }"><span class="txt">혐오 콘텐츠</span></label>
										</div>
										<div class="flex-wrap">
											<label class="radio"><input type="radio" name="rptpRsnCd" value="${frontConstants.RPTP_RSN_20 }"><span class="txt">지적 재산권 위반</span></label>
										</div>
										<div class="flex-wrap">
											<label class="radio"><input type="radio" name="rptpRsnCd" value="${frontConstants.RPTP_RSN_30 }"><span class="txt">기타</span></label>
										</div>
									</li>
								</ul>
							</div>
							<div class="textarea m"><textarea name="rptpContent" id="rptpContent" placeholder="신고사유를 입력해주세요. 선택사항입니다." style="height:260px;"></textarea></div>
							<div class="log_btnWrap">
								<a href="javascript:fncReplyRptpPopClose();" class="btn lg onWeb_if">취소</a>
								<a href="javascript:fncTvDetailReplyRptp();" class="btn a lg disabled" id="petTvReplyRptpBtn" style="pointer-events: auto;"
								 data-url="/tv/reply/insertTvDetailReplyRptp" data-content="">완료</a>
							</div>
						</main>
					</div>
				</div>
			</article>
		</form>
		<!-- e : 댓글 신고 팝업 -->
	</tiles:putAttribute>
</tiles:insertDefinition>