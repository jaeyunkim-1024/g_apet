/*
 * 입력 데이터
 */

// 회원가입 : onUserRegister
var onUserRegisterData = {
	func : 'onUserRegister',	// 호출 함수명
	SignUpChnnel : null,		// Kakao:1, Naver:2, Line:3, Google:4, Facebook:5, Twitter:6, WhatsApp:7, QQChnnel:8, WeChat:9, 유저아이디(보안진단 처리 - 주석으로 된 시스템 주요 정보 삭제):10, ETC:11, SKT:12, AppleId:13
	eventAttrs : {				// 필요 key, value 입력
	}
}

// 상품보기 : onProductView
var onProductViewData = {
	func : 'onProductView',		// 호출 함수명
	productModels : {			// 상품 정보
		productId : null,		// 상품아이디
		productName : null, 	// 상품명
		price : null,			// 상품단가
		quantity : null,		// 구매수량
		discount : null,		// 할인
		currency : null,		// KRW:1, USD:2, JPY:3, EUR:4, GBP:5, CNY:6, TWD:7, HKD:8, IDR:9, INR:10, RUB:11, THB:12, VND:13, MYR:14
		categorys : [			// [배열]카테고리 
		],
		productDetailAttrs : {	// 이벤트 정보를 추가로 보내는 경우 사용
		}
	},
	eventAttrs : {				// 필요 key, value 입력
	}
}

// 상품검색 : onSearch
var onSearchData = {
	func : 'onSearch',			// 호출 함수명
	keyword : null,			//
	productModels : [		// [배열]상품 정보
		{
			productId : null,	// 
			productName : null, // 
			price : null,		// 
			quantity : null,// 
			discount : null,// 
			currency : null,// KRW:1, USD:2, JPY:3, EUR:4, GBP:5, CNY:6, TWD:7, HKD:8, IDR:9, INR:10, RUB:11, THB:12, VND:13, MYR:14
			categorys : [// 카테고리 배열
			],
			productDetailAttrs : {	// 이벤트 정보를 추가로 보내는 경우 사용
			}
		}
	],
	eventAttrs : {
	}
}

// 장바구니 담기 : onAddToCart
var onAddToCartData = {
	func : 'onAddToCart',			// 호출 함수명
	productModels : [		// [배열]상품 정보
		{
			productId : null,	// 
			productName : null, // 
			price : null,		// 
			quantity : null,// 
			discount : null,// 
			currency : null,// KRW:1, USD:2, JPY:3, EUR:4, GBP:5, CNY:6, TWD:7, HKD:8, IDR:9, INR:10, RUB:11, THB:12, VND:13, MYR:14
			categorys : [// 카테고리 배열
			],
			productDetailAttrs : {	// 이벤트 정보를 추가로 보내는 경우 사용
			}
		}
	],
	eventAttrs : {			// 필요 key, value 입력
	}
}

// 최초결제 완료 : onFirstPurchase
var onFirstPurchaseData = {
	func : 'onFirstPurchase',			// 호출 함수명
	eventAttrs : {			// 필요 key, value 입력
	}
}

// 결제완료 : onPurchase
var onPurchaseData = {
	func : 'onPurchase',			// 호출 함수명
	orderAttrs : {
		orderId : null,
		orderSales : null,
		discount : null,
		deliveryCharge : null,
		paymentMethod : null
	},
	productModels : [		// [배열]상품 정보
		{
			productId : null,	// 
			productName : null, // 
			price : null,		// 
			quantity : null,// 
			discount : null,// 
			currency : null,// KRW:1, USD:2, JPY:3, EUR:4, GBP:5, CNY:6, TWD:7, HKD:8, IDR:9, INR:10, RUB:11, THB:12, VND:13, MYR:14
			categorys : [// 카테고리 배열
			],
			productDetailAttrs : {	// 이벤트 정보를 추가로 보내는 경우 사용
			}
		}
	],
	eventAttrs : {			// 필요 key, value 입력
	}
}

// Custom Adbrix 이벤트 : onAdbrixCustomEvent
var onAdbrixCustomEventData = {
	func : 'onAdbrixCustomEvent',			// 호출 함수명
	eventName : null,		// 이벤트 명칭
	eventAttrs : {			// 필요 key, value 입력
	}
}

var onUserRegisterDataReset = JSON.parse(JSON.stringify(onUserRegisterData));
var onProductViewDataReset = JSON.parse(JSON.stringify(onProductViewData));
var onSearchDataReset = JSON.parse(JSON.stringify(onSearchData));
var onAddToCartDataReset = JSON.parse(JSON.stringify(onAddToCartData));
var onFirstPurchaseDataReset = JSON.parse(JSON.stringify(onFirstPurchaseData));
var onPurchaseDataReset = JSON.parse(JSON.stringify(onPurchaseData));
var onAdbrixCustomEventDataReset = JSON.parse(JSON.stringify(onAdbrixCustomEventData));

/*
 * app 함수 호출
 */
function toNativeAdbrix(funcData) {
	if(navigator.userAgent.indexOf('Android') > -1){
		switch (funcData.func)
	    {
	    	case 'onUserRegister': // 회원가입
				window.AppJSInterface.onUserRegister(JSON.stringify(funcData));
		    	break;
		    	
	    	case 'onProductView': // 상품보기
    			window.AppJSInterface.onProductView(JSON.stringify(funcData));
	    		break;
	    		
	    	case 'onSearch': // 상품검색
    			window.AppJSInterface.onSearch(JSON.stringify(funcData));
	    		break;
	    		
	    	case 'onAddToCart': // 장바구니 담기
    			window.AppJSInterface.onAddToCart(JSON.stringify(funcData));
	    		break;
	    		
	    	case 'onFirstPurchase': // 최초결제 완료
    			window.AppJSInterface.onFirstPurchase(JSON.stringify(funcData));
	    		break;
	    		
	    	case 'onPurchase': // 결제완료
    			window.AppJSInterface.onPurchase(JSON.stringify(funcData));
	    		break;

	    	case 'onAdbrixCustomEvent': // Custom Adbrix 이벤트
    			window.AppJSInterface.onAdbrixCustomEvent(JSON.stringify(funcData));
	    		break;
	    }
	}else{
		window.webkit.messageHandlers.AppJSInterface.postMessage(funcData);
	}
	funcData = JSON.parse(JSON.stringify(eval(funcData.func+"DataReset")));
}
