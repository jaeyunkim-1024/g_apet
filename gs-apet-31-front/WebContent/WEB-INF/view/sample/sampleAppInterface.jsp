<%--	
   - Class Name	: /sample/sampleAppInterface.jsp
   - Description: app interface 샘플 화면
   - Since		: 2021.02.16
   - Author		: KKB
   --%>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="content">
		<style type="text/css">
			table {
		  		border: 1px solid #ecedef;
		  		border-collapse: collapse;
			}
			th, td {
				  border: 1px solid #ecedef;
				  padding: 10px;
			}
		</style>
      	<script type="text/javascript">
			$(document).ready(function(){
				$("#appDataForm tr").hide();
				$(".all").show();
				$("#fileIdsArea").html(addFileIdHtml());
			});
	    
		    function testCallBack(result) {
				console.log("result",result);
		  		alert(result);
		    }
	    
			function dataReset(){
				$("#appDataForm tr").hide();
				$(".all").show();
				$("#appDataForm").trigger("reset");
			}
	    
	    
			function addFileIdHtml(){
				var addhtml = '<div class="fileIdDiv lastAddedDiv" style="display: block;" >';
				addhtml += '<input name="fileIds" type="text" placeholder="fileIds">';
				addhtml += '<button type="button" onclick="delFileId(this);" class="btn">-</button>';
				addhtml += '<button type="button" onclick="addFileId(this);" class="btn">+</button>';
				addhtml += '</div>';
				return addhtml;
	 		}
	    
	    	function delFileId(obj) {
				if($(".fileIdDiv").length > 1){
					$(obj).parent("div").remove();
				}				
			};
			
		 	function addFileId(obj) {
				$('.fileIdDiv').removeClass('lastAddedDiv');
				$(obj).parents(".fileIdDiv").after(addFileIdHtml());				
			};
	    
			// 호출 방법
			function callFunc() {
				toNativeData = JSON.parse(JSON.stringify(resetData));
				let funcNm = $("#func").val();
				if(funcNm == 'onOpenGallery'){ // 갤러리 열기
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.useCamera = $("select[name=useCamera]").val();
					toNativeData.galleryType = $("select[name=galleryType]").val();
					toNativeData.usePhotoEdit = $("select[name=usePhotoEdit]").val();
					toNativeData.editType = $("select[name=editType]").val();
					toNativeData.title = $("input[name=title]").val();
					let fileIds = new Array();
					let fileIdDivs = $("input[name=fileIds]");
					fileIdDivs.each(function(i, v) {
						fileIds[i] = $(this).val();
					})
					toNativeData.fileIds = fileIds;
					toNativeData.maxCount = $("input[name=maxCount]").val();
					toNativeData.previewWidth = $("input[name=previewWidth]").val();
					toNativeData.previewHeight = $("input[name=previewHeight]").val();
					toNativeData.callbackDelete = $("input[name=callbackDelete]").val();
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onImageEdit'){ // 편집 할 이미지(base64)를 받아서 편집 처리
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.image = $("input[name=image]").val();
					toNativeData.fileId = $("input[name=fileId]").val();
					toNativeData.editType = $("select[name=editType]").val();
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.fileId = $("input[name=fileId]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onNewPage'){ // 새로운 페이지 열기
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.type = $("select[name=type]").val();
					toNativeData.url = $("select[name=url]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onShowPIP'){ // PIP 전환
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.width = $("input[name=width]").val();
					toNativeData.height = $("input[name=height]").val();
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onMainPage'){ // 메인 페이지 셋팅
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.type = $("select[name=type]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onCurrentLoc'){ // 현재 위치 정보 요청
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onNetworkStatus'){ // 네트워크 상태 정보
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
	  			}else if(funcNm == 'onSettingInfos'){ // 설정 정보 요청
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
	  			}else if(funcNm == 'onShare'){ // 공유
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.image = $("input[name=image]").val();
					toNativeData.subject = $("input[name=subject]").val();
					toNativeData.link = $("input[name=link]").val();
					toNativeData.content = $("input[name=content]").val();
					// 호출
					toNative(toNativeData);
	  			}else if(funcNm == 'onFileUpload'){ // 파일 업로드
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.prefixPath = $("input[name=prefixPath]").val();
					toNativeData.channel_id = $("input[name=channel_id]").val();
					toNativeData.playlist_id = $("input[name=playlist_id]").val();
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onClose'){ // 화면 닫기
					// 데이터 세팅
					toNativeData.func = funcNm;
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onPushToken'){ // 푸시 토큰 요청
					// 데이터 세팅
					toNativeData.func = funcNm;
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onAutoPlay'){ // 자동 재생 여부를 설정
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.type = $("select[name=type]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onIsAutoPlay'){ // 자동 플레이 여부를 반환
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onLogin'){ // 웹상에서 로그인 되면 호출
					// 데이터 세팅
					toNativeData.func = funcNm;
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onLogout'){ // 웹상에서 로그아웃 되면 호출
					// 데이터 세팅
					toNativeData.func = funcNm;
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onSnsLogin'){ // 간편 로그인을 사용하는 경우 해당 함수 호출
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.loginType = $("input[name=loginType]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onExtBrowser'){ // 외부 브라우저를 통해 페이지를 여는 경우 사용
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.url = $("input[name=url]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onOrderPage'){ // 새로운 페이지에서 웹페이지를 여는 경우
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.url = $("input[name=url]").val();
					toNativeData.title = $("input[name=title]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onShowPG'){ // 보여줄 결제 페이지
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.url = $("input[name=url]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onClosePG'){ // 결제 페이지를 닫으면서 파라미터 전달 시 사용
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.parameters = $("input[name=parameters]").val();
					toNativeData.callback = $("input[name=callback]").val();
					// 호출
					toNative(toNativeData);
				}else if(funcNm == 'onCloseMovePage'){ // 결제 페이지를 닫으면서 파라미터 전달 시 사용
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.moveUrl = $("input[name=moveUrl]").val();
					// 호출
					toNative(toNativeData);
				}
			}
			
			function testCallback(resultJson) {
				console.log("resultJson", resultJson);
				alert("resultJson : "+resultJson);
			}
			
			function testCallback2(resultJson) {
				console.log("resultJson2", resultJson);
				alert("resultJson2 : "+resultJson);
			}
		    $(document).on("change", "#func",function() {
		  	  let funcNm = $("#func").val();
		  	  $("#appDataForm").trigger("reset");
		  	  if(funcNm != ""){    		 
		      	  $("#func").val(funcNm);
		  		  $("#appDataForm tr").hide();
		  		  $(".all").show();
		  		  $("."+funcNm).show();
		  		  $("."+funcNm+" .type select option").hide();
		  		  $("."+funcNm+" .type select ."+funcNm).show();
		  	  }
			});
		</script>
	
      <main class="container page" id="container">
         <div class="inr">
            <!-- 본문 -->
            <div class="contents" id="contents">
           	 	<div class="pageHeadMo">
					<div class="hdt" style=";">
						<h3 class="tit">[ APP INTERFACE 설명]</h3>
					</div>
					<br/>
				</div>
            	<p>1. app-interface.js 의 toNativeData 에 선언된 하위 항목중 필요 항목 값을 입력합니다.</p>
            	<p>2. toNative(toNativeData) 호출합니다.</p>
            
               	<br/>
               	<div class="pageHeadMo">
					<div class="hdt" style=";">
						<h3 class="tit">[ APP INTERFACE TEST]</h3>
					</div>
					<br/>
				</div>
				<form id="appDataForm">
					<table style="border: #ecedef solid 1px; border-collapse: collapse;">
						<caption>APP INTERFACE 데이터</caption>
						<colgroup>
							<col width="10%">
							<col width="20%">
							<col width="30%">
							<col width="40%">
						</colgroup>
						<tr class="all">
							<th>항목명</th>
							<th>입력값</th>
							<th>사용 함수명</th>
							<th>비고</th>
						</tr>
						<tr class="all">
							<th>func</th>
							<td>
								<select name="func" id="func">
									<option value="">호출 함수 선택</option>
									<option value="onOpenGallery">[onOpenGallery]갤러리 열기</option>
									<option value="onImageEdit">[onImageEdit]편집 할 이미지(base64)를 받아서 편집 처리</option>
									<option value="onDeleteImage">[onDeleteImage]미리보기 썸네일 삭제</option>
									<option value="onNewPage">[onNewPage]새로운 페이지 열기</option>
									<option value="onShowPIP">[onShowPIP]PIP 전환</option>
									<option value="onMainPage">[onMainPage]메인 페이지 셋팅</option>
									<option value="onCurrentLoc">[onCurrentLoc]현재 위치 정보 요청</option>
									<option value="onNetworkStatus">[onNetworkStatus]네트워크 상태 정보</option>
									<option value="onSettingInfos">[onSettingInfos]설정 정보 요청</option>
									<option value="onShare">[onShare]공유</option>
									<option value="onFileUpload">[onFileUpload]파일 업로드</option>
									<option value="onClose">[onClose]화면 닫기</option>
									<option value="onPushToken">[onPushToken]푸시 토큰 요청</option>
									<option value="onAutoPlay">[onAutoPlay]자동 재생 여부를 설정</option>
									<option value="onIsAutoPlay">[onIsAutoPlay]자동 플레이 여부를 반환</option>
									<option value="onLogin">[onLogin]웹상에서 로그인 되면 호출</option>
									<option value="onLogout">[onLogout]웹상에서 로그아웃 되면 호출</option>
									<option value="onSnsLogin">[onSnsLogin]간편 로그인을 사용하는 경우 해당 함수 호출</option>
									<option value="onExtBrowser">[onExtBrowser]외부 브라우저를 통해 페이지를 여는 경우 사용</option>
									<option value="onOrderPage">[onOrderPage]새로운 페이지에서 웹페이지를 여는 경우</option>
									<option value="onShowPG">[onShowPG]결제 페이지를 여는 경우 사용</option>
									<option value="onClosePG">[onClosePG]결제 페이지를 닫으면서 파라미터 전달 시 사용</option>
									<option value="onCloseMovePage">[onCloseMovePage] 화면을 닫고 이동할. URL 주소(FULL URL 주소)</option>
								</select>
							</td>
							<td>
								<p>공통</p>
							</td>
							<td>
								<p>호출 함수명</p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>useCamera</th>
							<td>
								<select name="useCamera">
									<option value="">선택</option>
									<option value="P">P : 사진만 촬영</option>
									<option value="PV">PV : 사진 + 영상 촬영</option>
									<option value="N">N : 사용안함(Default : N)</option>
								</select>
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>(P : 사진만 촬영 / PV : 사진 + 영상 촬영 / N : 사용안함)(Default : N)</p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>usePhotoEdit</th>
							<td>
								<select name="usePhotoEdit">
									<option value="">선택</option>
									<option value="Y">사용</option>
									<option value="N">미사용</option>
								</select>
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>사진 편집 여부(Y : 사용 / N : 사용안함)(Default : N), 편집을 사용하는 경우 선택 가능한 사진 갯수는 1로 고정 </p>
							</td>
						</tr>
						<tr class="onOpenGallery onImageEdit">
							<th>editType</th>
							<td>
								<select name="editType">
									<option value="">선택</option>
									<option value="R">R(3:4)</option>
									<option value="S">S(1:1)</option>
								</select>
							</td>
							<td>
								<p>onOpenGallery, onImageEdit</p>
							</td>
							<td>
								<p>R(3:4), S(1:1)로 편집(usePhotoEdit 값이 Y 인경우에만 처리함) </p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>galleryType</th>
							<td>
								<select name="galleryType">
									<option value="">선택</option>
									<option value="P">P : 사진(Default)</option>
									<option value="PV">PV : 사진 + 영상</option>
									<option value="V">V : 영상</option>
								</select>
							</td>
							<td>
								<p>onOpenGallery, onImageEdit</p>
							</td>
							<td>
								<p>R(3:4), S(1:1)로 편집(usePhotoEdit 값이 Y 인경우에만 처리함) </p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>fileIds</th>
							<td id="fileIdsArea">
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>[배열!!] 선택한 사진이 있는 경우 해당 함수 호출시 fileId를 넘겨줘야 앨범이랑 정보 연동 가능(null 가능) </p>
							</td>
						</tr>
						<tr class="onShowPIP">
							<th>width</th>
							<td>
								<input name="width" type="text" placeholder="width">
							</td>
							<td>
								<p>onShowPIP</p>
							</td>
							<td>
								<p>PIP 가로 사이즈</p>
							</td>
						</tr>
						<tr class="onShowPIP">
							<th>height</th>
							<td>
								<input name="height" type="text" placeholder="height">
							</td>
							<td>
								<p>onShowPIP</p>
							</td>
							<td>
								<p>PIP 세로 사이즈</p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>maxCount</th>
							<td>
								<input name="maxCount" type="text" placeholder="동시에 선택 가능한 사진 갯수">
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>동시에 선택 가능한 사진 갯수(1 ~ xx)(Default : 1) </p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>previewWidth</th>
							<td>
								<input name="previewWidth" type="text" placeholder="가로 사이즈">
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>미리보기 가로 사이즈(Default : 200)</p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>previewHeight</th>
							<td>
								<input name="previewHeight" type="text" placeholder="세로 사이즈">
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>미리보기 세로 사이즈(Default : 300)</p>
							</td>
						</tr>
						<tr class="onOpenGallery">
							<th>callbackDelete</th>
							<td>
								<input name="callbackDelete" type="text" placeholder="callback 함수명" value="testCallback2">
							</td>
							<td>
								<p>onOpenGallery</p>
							</td>
							<td>
								<p>앨범에서 이미지 선택이 해제되면 호출된다.appDeletePreviewImage 함수 대신 사용 할 함수(문자열)명을 전달하면 된다.</p>
							</td>
						</tr>
						<tr class="onDeleteImage onImageEdit">
							<th>fileId</th>
							<td>
								<input name="fileId" type="text" placeholder="fileId">
							</td>
							<td>
								<p>onDeleteImage, onImageEdit</p>
							</td>
							<td>
								<p>onOpenGallery에서 넘겨받은 선택 한 사진에 대한 fileId</p>
							</td>
						</tr>
						<tr class="onNewPage onMainPage onAutoPlay">
							<th>type</th>
							<td class="type">
								<select name="type">
									<option  value="">선택</option>
									<option class="onNewPage onMainPage" value="TV">TV(펫 TV)</option>
									<option class="onNewPage" value="LIVE">LIVE(라이브 영상)</option>
									<option class="onMainPage" value="LOG">LOG(펫 로그)</option>
									<option class="onMainPage" value="SHOP">SHOP(펫 샵)</option>
									<option class="onAutoPlay" value="MW">MW(모바일 + Wi-Fi)</option>
									<option class="onAutoPlay" value="W">W(Wi-Fi)</option>
									<option class="onAutoPlay" value="N">N(사용안함)</option>
								</select>
							</td>
							<td>
								<p>onNewPage, onMainPage, onAutoPlay</p>
							</td>
							<td>
								<p>[onNewPage] TV(펫 TV), LIVE(라이브 영상) // [onMainPage] TV(펫 TV), LOG(펫 로그), SHOP(펫 샵) // [onAutoPlay] MW(모바일 + Wi-Fi), W(Wi-Fi), N(사용안함)</p>
							</td>
						</tr>
						<tr class="onNewPage onExtBrowser onOrderPage onShowPG">
							<th>url</th>
							<td>
								<input name="url" type="text" placeholder="url">
							</td>
							<td>
								<p>onNewPage, onExtBrowser, onOrderPage, onShowPG</p>
							</td>
							<td>
								<p>이동할 주소(http or https 까지 붙은 Full Url 주소)</p>
							</td>
						</tr>
						<tr class="onShare onImageEdit">
							<th>image</th>
							<td>
								<input name="image" type="text" placeholder="image">
							</td>
							<td>
								<p>onShare</p>
							</td>
							<td>
								<p>base64 인코딩된 문자열</p>
							</td>
						</tr>
						<tr class="onShare">
							<th>subject</th>
							<td>
								<input name="subject" type="text" placeholder="subject">
							</td>
							<td>
								<p>onShare</p>
							</td>
							<td>
								<p>제목</p>
							</td>
						</tr>
						<tr class="onShare">
							<th>link</th>
							<td>
								<input name="link" type="text" placeholder="link">
							</td>
							<td>
								<p>onShare</p>
							</td>
							<td>
								<p>링크</p>
							</td>
						</tr>
						<tr class="onFileUpload">
							<th>prefixPath</th>
							<td>
								<input name="prefixPath" type="text" placeholder="prefixPath">
							</td>
							<td>
								<p>prefixPath</p>
							</td>
							<td>
								<p>업로드경로(파일 업로드에서 저장할 경로, 타입 값 또는 경로 값, 내려 받은 값 그대로 api 전송)</p>
							</td>
						</tr>
						<tr class="onFileUpload">
							<th>channel_id</th>
							<td>
								<input name="channel_id" type="text" placeholder="channel_id">
							</td>
							<td>
								<p>channel_id</p>
							</td>
							<td>
								<p>영상 업로드시 사용되는 채널 아이디</p>
							</td>
						</tr>
						<tr class="onFileUpload">
							<th>playlist_id</th>
							<td>
								<input name="playlist_id" type="text" placeholder="playlist_id">
							</td>
							<td>
								<p>playlist_id</p>
							</td>
							<td>
								<p>영상 업로드시 사용되는 VOD 그룹 아이디</p>
							</td>
						</tr>
						<tr class="onSnsLogin">
							<th>loginType</th>
							<td>
								<input name="loginType" type="text" placeholder="N(Naver), K(Kakao)" value="">
							</td>
							<td>
								<p>onSnsLogin</p>
							</td>
							<td>
								<p>N(Naver), K(Kakao)</p>
							</td>
						</tr>
						<tr class="onOrderPage onOpenGallery">
							<th>title</th>
							<td>
								<input name="title" type="text" placeholder="상단에 보여줄 타이틀" value="">
							</td>
							<td>
								<p>onOrderPage, onOpenGallery</p>
							</td>
							<td>
								<p>상단에 보여줄 타이틀</p>
							</td>
						</tr>
						<tr class="onClosePG">
							<th>parameters</th>
							<td>
								<input name="parameters" type="text" placeholder="부모뷰에 전달할 결제 성공 또는 에러 정보 값" value="">
							</td>
							<td>
								<p>onClosePG</p>
							</td>
							<td>
								<p> { parameters : 넘길 데이터(json string) }</p>
							</td>
						</tr>	
						<tr class="onCloseMovePage">
							<th>moveUrl</th>
							<td>
								<input name="moveUrl" type="text" placeholder="URL 주소(FULL URL 주소)" value="">
							</td>
							<td>
								<p>onCloseMovePage</p>
							</td>
							<td>
								<p>화면을 닫고 이동할. URL 주소(FULL URL 주소)</p>
							</td>
						</tr>				
						<tr class="onOpenGallery onCurrentLoc onNetworkStatus onSettingInfos onFileUpload onPushToken onShowPIP onIsAutoPlay onImageEdit onClosePG">
							<th>callback</th>
							<td>
								<input name="callback" type="text" placeholder="callback 함수명" value="testCallback">
							</td>
							<td>
								<p>onOpenGallery, onCurrentLoc, onNetworkStatus, onSettingInfos, onFileUpload, onPushToken, onShowPIP, onIsAutoPlay, onImageEdit, onClosePG</p>
							</td>
							<td>
								<p>callback 함수명(샘플 callback함수 명은 "testCallback"입니다.)</p>
							</td>
						</tr>
					</table>
				</form>
				<button type="button" class="btn sm b" onclick="dataReset();">초기화</button>
				<button type="button" class="btn sm b" onclick="callFunc();">호출</button>
            </div>
         </div>
      </main>
 
   </tiles:putAttribute>
</tiles:insertDefinition>