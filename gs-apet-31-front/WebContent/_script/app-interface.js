// 입력 데이터
var toNativeData = {			// [사용 함수명]   	설명
	func : null, 				// [공통]			호출 함수명
	useCamera : null,			// [onOpenGallery] 	카메라 사용 여부(Y : 사용 / N : 사용안함)(Default : N)
	galleryType : null,			// [onOpenGallery]	(P : 사진 / PV : 사진 + 영상 / V : 영상)(Default : P)
	usePhotoEdit : null, 		// [onOpenGallery] 	사진 편집 여부(Y : 사용 / N : 사용안함)(Default : N), 편집을 사용하는 경우 선택 가능한 사진 갯수는 1로 고정 
	editType : null,			// [onOpenGallery, onImageEdit]  R(3:4), S(1:1)로 편집(usePhotoEdit 값이 Y 인경우에만 처리함)
	fileIds : [],				// [onOpenGallery] 	(배열!!) 선택한 사진이 있는 경우 해당 함수 호출시 fileId를 넘겨줘야 앨범이랑 정보 연동 가능(null 가능)
	maxCount : null,			// [onOpenGallery] 	동시에 선택 가능한 사진 갯수(1 ~ xx)(Default : 1)
	previewWidth : null,  		// [onOpenGallery] 	미리보기 가로 사이즈(Default : 200)
	previewHeight : null, 		// [onOpenGallery]	미리보기 세로 사이즈(Default : 300)
	title : null,				// [onOrderPage, onOpenGallery, onTitleBarHidden] 	상단에 보여줄 타이틀
	callback : null,			// [onOpenGallery, onCurrentLoc, onNetworkStatus, onSettingInfos, onFileUpload, onPushToken, onImageEdit, onIsAutoPlay, onClosePassingData, onBackSelected, onEnableKeyboardEvent, onLoadData, onCallMainScript] callback 함수명
	callbackDelete : null,  	// [onOpenGallery]  앨범에서 이미지 선택이 해제되면 호출된다. appDeletePreviewImage 함수 대신 사용 할 함수(문자열)명을 전달하면 된다.
	image : null, 				// [onImageEdit, onShare]	base64 인코딩된 문자열
	fileId : null,				// [onImageEdit, onDeleteImage] 	onOpenGallery에서 넘겨받은 선택 한 사진에 대한 fileId
	type : null,				// [onNewPage] 		TV(펫 TV), LIVE(라이브 영상)
								// [onMainPage] 	TV(펫 TV), LOG(펫 로그), SHOP(펫 샵)
								// [onAutoPlay]		MW(모바일 + Wi-Fi), W(Wi-Fi), N(사용안함)
	url : null,					// [onNewPage, onExtBrowser, onOrderPage, onShowPG, onHistoryBack, onAddHistory, onReplaceHistory, onShowWebChat] 		이동할 주소(Full Address)
	width : null,				// [onShowPIP]		PIP 가로 사이즈
	height : null,				// [onShowPIP]		PIP 세로 사이즈
	deniedMessage : null,		// [onCurrentLoc]	Y : (권한이 거부 된 경우 설정 이동 알럿 표시 [기본값]) , N : (권한이 거부 된 경우 무시)
	subject : null,				// [onShare] 		제목
	link : null,				// [onShare] 		링크
	prefixPath : null,			// [onFileUpload]	업로드경로(파일 업로드에서 저장할 경로, 타입 값 또는 경로 값, 내려 받은 값 그대로 api 전송)
	channel_id : null,			// [onFileUpload]	영상 업로드시 사용되는 채널 아이디
	playlist_id : null, 		// [onFileUpload]	영상 업로드시 사용되는 VOD 그룹 아이디
	uploadWithProgress : null, 	// [onFileUpload]	Y : 프로그레스 바 표시 N : 로딩 화면 표시(기본값)
	loginType : null,			// [onSnsLogin] 	N : 네이버, K : 카카오톡
	parameters : null,			// [onClosePG, onClosePassingData]	부모뷰에 전달할 결제 성공 또는 에러 정보 값
	moveUrl : null,				// [onCloseMovePage] 화면을 닫고 이동할. URL 주소(FULL URL 주소)
	hidden : null,				// [onTitleBarHidden]	Y (화면 숨김), N (화면 보임)
	color : null,				// [onColorChange]	white(하얀색), black(검은색)
	playYn : null,				// [onSGRPlayer] Y: (재생 시작됨), N : (멈춤 상태)
	isLive : null,				// [onPushActivation] Y: (라이브 예고 알림 호출 -> 기본 값), N : (이외 화면에서 호출)
	isIntercepter : null,		// [onBackSelected] Y: 웹에서 백기능 처리, N: 앱에서 처리
	videoID : null,				// [onPetLogUploadComplete] 업로드 완료한 videoID
	key : null,					// [onSaveData, onLoadData] 로드할 때 사용할 Key 값, 저장할 때 사용한 Key 값
	value : null,				// [onSaveData] Json 형태로 이루어진 String 데이터
	data : null					// [onCallMainScript] Json 형태로 이루어진 String 데이터
}
var resetData = JSON.parse(JSON.stringify(toNativeData));
// app 함수 호출
function toNative(toNativeData) {
	// 미사용 항목 삭제
	for(key in toNativeData){
		if(toNativeData[key] == null || toNativeData[key] == ""){
			delete toNativeData[key];
		}
	}
	console.log("sendData",toNativeData);
	// 함수 호출
	if(navigator.userAgent.indexOf('Android') > -1){
		try {
			switch (toNativeData.func)
		    {
		    	case 'onOpenGallery': // 갤러리 열기
					window.AppJSInterface.onOpenGallery(JSON.stringify(toNativeData));
			    	break;

				case 'onImageEdit': //편집 할 이미지(base64)를 받아서 편집 처리
		    		window.AppJSInterface.onImageEdit(JSON.stringify(toNativeData));
		    		break;
			    	
		    	case 'onDeleteImage': // 미리보기 썸네일 삭제
	    			window.AppJSInterface.onDeleteImage(JSON.stringify(toNativeData));
		    		break;
		    	
		    	case 'onNewPage': // 새로운 페이지 열기
	    			window.AppJSInterface.onNewPage(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onShowPIP': // PIP 전환
	    			window.AppJSInterface.onShowPIP(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onMainPage': // 메인 페이지 셋팅
	    			window.AppJSInterface.onMainPage(JSON.stringify(toNativeData));
		    		break;
		    	
		    	case 'onCurrentLoc': // 현재 위치 정보 요청
	    			window.AppJSInterface.onCurrentLoc(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onNetworkStatus': // 네트워크 상태 정보
	    			window.AppJSInterface.onNetworkStatus(JSON.stringify(toNativeData));
		    		break;	
		    		
		    	case 'onSettingInfos': // 설정 정보 요청
	    			window.AppJSInterface.onSettingInfos(JSON.stringify(toNativeData));
		    		break;	
		    		
		    	case 'onShare': // 공유
	    			window.AppJSInterface.onShare(JSON.stringify(toNativeData));
		    		break;	
		    		
		    	case 'onFileUpload': // 파일 업로드
	    			window.AppJSInterface.onFileUpload(JSON.stringify(toNativeData));
		    		break;	
		    		
		    	case 'onClose': // 화면 닫기
	    			window.AppJSInterface.onClose();
		    		break;
		    
		    	case 'onPushToken': //푸시 토큰 요청
		    		window.AppJSInterface.onPushToken(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onAutoPlay': //자동 재생 여부를 설정
		    		window.AppJSInterface.onAutoPlay(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onIsAutoPlay': //자동 플레이 여부를 반환
		    		window.AppJSInterface.onIsAutoPlay(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onLogin': //웹상에서 로그인 되면 호출
		    		window.AppJSInterface.onLogin();
		    		break;
		    		
		    	case 'onLogout': //웹상에서 로그아웃 되면 호출
		    		window.AppJSInterface.onLogout();
		    		break;
		    		
		    	case 'onSnsLogin': //app에서 sns(네이버, 카카오톡) 호출시 
		    		window.AppJSInterface.onSnsLogin(JSON.stringify(toNativeData));
		    		break;
	
		    	case 'onExtBrowser': //외부 브라우저를 통해 페이지를 여는 경우 사용
		    		window.AppJSInterface.onExtBrowser(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onOrderPage': //새로운 페이지에서 웹페이지를 여는 경우
		    		window.AppJSInterface.onOrderPage(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onShowPG': //결제 페이지를 여는 경우 사용
		    		window.AppJSInterface.onShowPG(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onClosePG': //결제 페이지를 닫으면서 파라미터 전달 시 사용
		    		window.AppJSInterface.onClosePG(JSON.stringify(toNativeData));
		    		break;
	
		    	case 'onCloseMovePage': //현재 보이고 있는 화면을 닫고 페이지를 이동
		    		window.AppJSInterface.onCloseMovePage(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onClosePassingData': //데이터 전달에 사용
		    		window.AppJSInterface.onClosePassingData(JSON.stringify(toNativeData));
		    		break;
		    	
		    	case 'onTitleBarHidden': //상단 타이틀바 숨김/보임 처리
		    		window.AppJSInterface.onTitleBarHidden(JSON.stringify(toNativeData));
		    		break;
	
		    	case 'onFirstLaunch': //app 설치 후 최초로그인 여부 체크
		    		window.AppJSInterface.onFirstLaunch(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onColorChange': //앱 화면 상, 하단 색상 변경
		    		window.AppJSInterface.onColorChange(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onSGRPlayer': //플레이어 재생 중 여부[Y: (재생 시작됨), N : (멈춤 상태)]
		    		window.AppJSInterface.onSGRPlayer(JSON.stringify(toNativeData));
		    		break;	
		    		
		    	case 'onPushActivation': //사용자에게 푸쉬 활성화 팝업을 표시
		    		window.AppJSInterface.onPushActivation(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onBackSelected': //디바이스 백 버튼 기능을 웹에서 처리 하는 경우 사용
		    		window.AppJSInterface.onBackSelected(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onClosePIP': //중간에 웹에서 PIP 창을 닫는 경우에 호출
		    		window.AppJSInterface.onClosePIP();
		    		break;
		    		
		    	case 'onPetLogUploadComplete': //펫로그 영상 업로드가 완료되면 호출
		    		window.AppJSInterface.onPetLogUploadComplete(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onPetLogEncodingCheck': //인코딩이 완료되었는지 체크
		    		window.AppJSInterface.onPetLogEncodingCheck(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onIbrixClick': // 아이브릭스 액션로그 이벤트
		    		window.AppJSInterface.onIbrixClick(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onHistoryBack': // [모바일 < 버튼] 뒤로가기시 전송
		    		window.AppJSInterface.onHistoryBack(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onAddHistory': //  [모바일 < 버튼] history 전송
		    		window.AppJSInterface.onAddHistory(JSON.stringify(toNativeData));
		    		break;
		    		
		    	case 'onClearHistory': // [모바일 < 버튼] history clear
		    		window.AppJSInterface.onClearHistory();
		    		break;
		    		
		    	case 'onReplaceHistory': // [모바일 < 버튼] replace / pop
		    		window.AppJSInterface.onReplaceHistory(JSON.stringify(toNativeData));
		    		break;

				case 'onShowWebChat': // 웹챗을 보여준다
		    		window.AppJSInterface.onShowWebChat(JSON.stringify(toNativeData));
		    		break;

				case 'onHideWebChat': // 웹챗 화면을 숨긴다
		    		window.AppJSInterface.onHideWebChat();
		    		break;

				case 'onCloseWebChat': // 웹챗을 닫아준다.
		    		window.AppJSInterface.onCloseWebChat();
		    		break;

		    	case 'onEnableKeyboardEvent': // 키패드 높이 관련 정보
		    		window.AppJSInterface.onEnableKeyboardEvent(JSON.stringify(toNativeData));
		    		break;

		    	case 'onDisableKeyboardEvent': // 키패드 높이 관련 정보
		    		window.AppJSInterface.onDisableKeyboardEvent();
		    		break;

				case 'onSaveData': // 임시로 저장할 데이터
		    		window.AppJSInterface.onSaveData(JSON.stringify(toNativeData));
		    		break;

				case 'onLoadData': // 임시로 저장된 데이터를 로드한다.
		    		window.AppJSInterface.onLoadData(JSON.stringify(toNativeData));
		    		break;

				case 'onCallMainScript': // 메인화면 데이터 갱신이 필요한 경우
		    		window.AppJSInterface.onCallMainScript(JSON.stringify(toNativeData));
		    		break;
		    }
		} catch (err) {
		}
	}else{
		window.webkit.messageHandlers.AppJSInterface.postMessage(toNativeData);
	}
	
	// 데이터 초기화
	toNativeData = JSON.parse(JSON.stringify(resetData));
}

// app history 정보 전달
function appHistoryBack() {
	let lastUrl = {
		backUrl : document.referrer
	}
	window.AppJSInterface.onHitoryBack(JSON.stringify(lastUrl));
}

//app에서 sns로그인후 userdata로 로그인 호출
function appSnsLogin(jsonData) {
	createFormSubmit("appSnsLogin", "/callback/snsAppLogin/", JSON.parse(jsonData));	
}

//app에서 로그인시 이력등록
function appInsertLoginInfo(jsonData) {
	/*if(jsonData == null || jsonData ==""){
	            jsonData ='{"deviceToken":"asdasd","deviceType":"10"}';
	}*/
	
	var options = {
		url : "/insertLoginInfoInApp",
		data : JSON.parse(jsonData),
		done : function(data){
			if(data != "S") location.href= decodeURIComponent(data);
		}
	};
	ajax.call(options);
}